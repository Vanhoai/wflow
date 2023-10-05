import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'event.dart';
import 'state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(const SignInState()) {
    on<OnChangeEmailEvent>(onChangeEmail);
    on<OnChangePasswordEvent>(onChangePassword);
    on<SignInSubmittedEvent>(signInSubmitted);
    on<RememberPassEvent>(rememberPass);
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

  FutureOr<void> signInSubmitted(SignInSubmittedEvent event, Emitter<SignInState> emit) {
    emit(SignInSuccess());
  }
}
