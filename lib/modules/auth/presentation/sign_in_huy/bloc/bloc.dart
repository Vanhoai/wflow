

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'event.dart';
import 'state.dart';




class SignInBloc extends Bloc<SignInEvent,SignInState>{
  SignInBloc() : super(const SignInState()){
    on<OnChangeEmailEvent>(onChangeEmail);
    on<OnChangePasswordEvent>(onChangePassword);
    on<SignInSubmittedEvent>(signInSubmitted);
    on<RememberPassEvent>(rememberPass);
  }

  FutureOr<void> onChangeEmail(OnChangeEmailEvent event, Emitter<SignInState> emit) {
    bool emailValid = RegExp(r"^[a-zA-Z\d.a-zA-Z\d.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+")
        .hasMatch(event.email);
    emit(state.copyWith(email: event.email,regex: emailValid));

  }

  FutureOr<void> onChangePassword(OnChangePasswordEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(password: event.password));
  }
  FutureOr<void> rememberPass(RememberPassEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(isRemember: event.isRemember));
  }

  FutureOr<void> signInSubmitted(SignInSubmittedEvent event, Emitter<SignInState> emit) {

    if (kDebugMode) {
      print(state.email);
      print(state.password);
      print(state.regex);
      print(state.isRemember);
    }


    emit(SignInSuccess());
  }


}