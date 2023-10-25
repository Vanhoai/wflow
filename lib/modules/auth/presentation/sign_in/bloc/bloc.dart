import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/libs/libs.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/auth/data/models/request_model.dart';
import 'package:wflow/modules/auth/domain/auth_entity.dart';
import 'package:wflow/modules/auth/domain/auth_usecase.dart';

import 'event.dart';
import 'state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthUseCase authUseCase;

  SignInBloc({required this.authUseCase}) : super(const SignInState()) {
    on<OnChangeEmailEvent>(onChangeEmail);
    on<OnChangePasswordEvent>(onChangePassword);
    on<SignInSubmittedEvent>(signInSubmitted);
    on<RememberPassEvent>(rememberPass);
    on<SignInWithGoogleEvent>(signInWithGoogle);
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

  FutureOr<void> signInSubmitted(SignInSubmittedEvent event, Emitter<SignInState> emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());

    final String? deviceToken = await FirebaseMessagingService.getDeviceToken();
    if (deviceToken == null || deviceToken.isEmpty) {
      emit(const SignInFailure(message: "Can't get device token"));
      instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
    }

    final response = await authUseCase
        .signIn(AuthNormalRequest(username: event.email, password: event.password, deviceToken: deviceToken!));

    response.fold(
      (AuthEntity left) {
        instance.get<AppBloc>().add(AppChangeAuth(authEntity: left));
        emit(SignInSuccess());
      },
      (Failure right) {
        emit(const SignInFailure(message: 'Something went wrong when sign in, please try again!'));
        emit(const SignInState());
      },
    );

    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }

  FutureOr<void> signInWithGoogle(SignInWithGoogleEvent event, Emitter<SignInState> emit) async {
    String idToken = await FirebaseAuthService.signInWithGoogle();
    if (idToken.isNotEmpty) {
      print('IDToken: $idToken');
    }
  }
}
