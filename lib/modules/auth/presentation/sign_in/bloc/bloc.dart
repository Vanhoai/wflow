import 'dart:async';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/libs/libs.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/core/utils/utils.dart';
import 'package:wflow/modules/auth/data/models/auth_google_model.dart';
import 'package:wflow/modules/auth/data/models/request_model.dart';
import 'package:wflow/modules/auth/domain/auth_entity.dart';
import 'package:wflow/modules/auth/domain/auth_usecase.dart';
import 'package:wflow/modules/main/domain/user/user_usecase.dart';

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

  FutureOr<void> onSignInCheckRemember(SignInCheckRememberEvent event, Emitter<SignInState> emit) async {
    final rememberMe = instance.get<AppBloc>().state.rememberMe;
    if (rememberMe) {
      final username = await instance.get<SecureStorage>().read(AppConstants.usernameKey);
      final password = await instance.get<SecureStorage>().read(AppConstants.passwordKey);

      if (username != null && password != null) {
        await signIn(username, password, emit);
      }
    }
  }

  FutureOr<void> onChangeEmail(OnChangeEmailEvent event, Emitter<SignInState> emit) {
    bool emailValid = false;
    if (double.tryParse(event.email) != null && event.email.length == 10 || event.email.length == 12) {
      emailValid = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%\d]').hasMatch(event.email);
    } else {
      emailValid = RegExp(r"^[a-zA-Z\d.a-zA-Z\d.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+").hasMatch(event.email);
    }
    emit(state.copyWith(email: event.email, regex: emailValid));
  }

  FutureOr<void> onChangePassword(OnChangePasswordEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(password: event.password));
  }

  FutureOr<void> rememberPass(RememberPassEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(isRemember: event.isRemember));
  }

  num verifyAccessToken(String accessToken) {
    final jwt = JWT.verify(accessToken, SecretKey(EnvironmentConfiguration.accessTokenSecret));
    final role = jwt.payload['role'];
    return role;
  }

  Future<void> signIn(String username, String password, Emitter<SignInState> emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());

    final String? deviceToken = await FirebaseMessagingService.getDeviceToken();

    print('DEVICE TOKEN $deviceToken');

    if (deviceToken == null || deviceToken.isEmpty) {
      AlertUtils.showMessage('Thông báo', 'Ứng dụng không thể lấy được địa chỉ thiết bị của bạn');
      instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
      return;
    }

    final response = await authUseCase.signIn(
      AuthNormalRequest(username: username, password: password, deviceToken: deviceToken),
    );

    response.fold(
      (AuthEntity authEntity) {
        final role = verifyAccessToken(authEntity.accessToken);
        instance.get<AppBloc>().add(AppChangeAuth(authEntity: authEntity, rememberMe: state.isRemember, role: role));
        emit(SignInSuccess());
      },
      (Failure right) {
        emit(SignInFailure(message: right.message));
        emit(const SignInState());
      },
    );

    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }

  FutureOr<void> signInSubmitted(SignInSubmittedEvent event, Emitter<SignInState> emit) async {
    await signIn(event.email, event.password, emit);
    if (event.isRemember) {
      instance.get<SecureStorage>().write(AppConstants.usernameKey, event.email);
      instance.get<SecureStorage>().write(AppConstants.passwordKey, event.password);
    } else {
      instance.get<SecureStorage>().delete(AppConstants.usernameKey);
      instance.get<SecureStorage>().delete(AppConstants.passwordKey);
    }
  }

  FutureOr<void> signInWithGoogle(SignInWithGoogleEvent event, Emitter<SignInState> emit) async {
    String idToken = await FirebaseAuthService.signInWithGoogle();
    String? deviceToken = await FirebaseMessagingService.getDeviceToken();
    if (idToken.isEmpty || deviceToken == null) {
      AlertUtils.showMessage('Thông báo', 'Ứng dụng không thể lấy được địa chỉ thiết bị của bạn');
      return;
    }

    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());
    final response = await authUseCase.signInWithGoogle(
      request: AuthWithGoogleModel(idToken: idToken, deviceToken: deviceToken, type: 'sign-in'),
    );

    response.fold(
      (AuthEntity authEntity) {
        final role = verifyAccessToken(authEntity.accessToken);
        instance.get<AppBloc>().add(AppChangeAuth(authEntity: authEntity, rememberMe: state.isRemember, role: role));
        emit(SignInSuccess());
      },
      (Failure failure) {
        emit(SignInFailure(message: failure.message));
        emit(const SignInState());
      },
    );

    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }
}
