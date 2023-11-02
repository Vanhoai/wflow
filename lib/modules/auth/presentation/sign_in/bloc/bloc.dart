import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/libs/libs.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/core/utils/secure.util.dart';
import 'package:wflow/modules/auth/data/models/request_model.dart';
import 'package:wflow/modules/auth/domain/auth_entity.dart';
import 'package:wflow/modules/auth/domain/auth_usecase.dart';
import 'package:wflow/modules/main/domain/user/user_usecase.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import 'event.dart';
import 'state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthUseCase authUseCase;
  final UserUseCase userUseCase;

  SignInBloc({
    required this.authUseCase,
    required this.userUseCase,
  }) : super(const SignInState()) {
    on<OnChangeEmailEvent>(onChangeEmail);
    on<OnChangePasswordEvent>(onChangePassword);
    on<SignInSubmittedEvent>(signInSubmitted);
    on<RememberPassEvent>(rememberPass);
    on<SignInWithGoogleEvent>(signInWithGoogle);
    on<SignInCheckRememberEvent>(onSignInCheckRemember);
  }

  FutureOr<void> onSignInCheckRemember(
      SignInCheckRememberEvent event, Emitter<SignInState> emit) async {
    final rememberMe = instance.get<AppBloc>().state.rememberMe;
    if (rememberMe) {
      final username =
          await instance.get<SecureStorage>().read(AppConstants.usernameKey);
      final password =
          await instance.get<SecureStorage>().read(AppConstants.passwordKey);

      if (username != null && password != null) {
        await signIn(username, password, emit);
      }
    }
  }

  FutureOr<void> onChangeEmail(
      OnChangeEmailEvent event, Emitter<SignInState> emit) {
    bool emailValid = false;
    if (double.tryParse(event.email) != null && event.email.length == 10 ||
        event.email.length == 12) {
      emailValid =
          RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%\d]').hasMatch(event.email);
    } else {
      emailValid = RegExp(
              r"^[a-zA-Z\d.a-zA-Z\d.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+")
          .hasMatch(event.email);
    }
    emit(state.copyWith(email: event.email, regex: emailValid));
  }

  FutureOr<void> onChangePassword(
      OnChangePasswordEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(password: event.password));
  }

  FutureOr<void> rememberPass(
      RememberPassEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(isRemember: event.isRemember));
  }

  Future<void> subscribeToTopic(String topic) async {
    await FirebaseMessagingService.subscribeToTopic(topic);
  }

  num verifyAccessToken(String accessToken) {
    final jwt = JWT.verify(
        accessToken, SecretKey(EnvironmentConfiguration.accessTokenSecret));
    final role = jwt.payload['role'];

    if (role != 1) {
      final topic = jwt.payload['business'];
      subscribeToTopic(topic);
    }
    return role;
  }

  Future<void> signIn(
      String username, String password, Emitter<SignInState> emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());
    final String? deviceToken = await FirebaseMessagingService.getDeviceToken();
    if (deviceToken == null || deviceToken.isEmpty) {
      emit(const SignInFailure(message: "Can't get device token"));
      emit(const SignInState());
      instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
    }

    final response = await authUseCase.signIn(AuthNormalRequest(
        username: username, password: password, deviceToken: deviceToken!));

    response.fold(
      (AuthEntity authEntity) {
        final role = verifyAccessToken(authEntity.accessToken);
        instance.get<AppBloc>().add(
              AppChangeAuth(
                authEntity: authEntity,
                rememberMe: state.isRemember,
                role: role,
              ),
            );
        emit(SignInSuccess());
      },
      (Failure right) {
        emit(const SignInFailure(
            message: 'Something went wrong when sign in, please try again!'));
        emit(const SignInState());
      },
    );
    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }

  Future<void> getUserProfile(
      AuthEntity authEntity, Emitter<SignInState> emit) async {}

  FutureOr<void> signInSubmitted(
      SignInSubmittedEvent event, Emitter<SignInState> emit) async {
    await signIn(event.email, event.password, emit);
    if (event.isRemember) {
      instance
          .get<SecureStorage>()
          .write(AppConstants.usernameKey, event.email);
      instance
          .get<SecureStorage>()
          .write(AppConstants.passwordKey, event.password);
    } else {
      instance.get<SecureStorage>().delete(AppConstants.usernameKey);
      instance.get<SecureStorage>().delete(AppConstants.passwordKey);
    }
  }

  FutureOr<void> signInWithGoogle(
      SignInWithGoogleEvent event, Emitter<SignInState> emit) async {
    String idToken = await FirebaseAuthService.signInWithGoogle();
    if (idToken.isNotEmpty) {}
  }
}
