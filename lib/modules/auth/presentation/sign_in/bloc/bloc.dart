import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/modules/auth/domain/auth_usecase.dart';

part 'event.dart';
part 'state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthUseCase authUseCase;

  SignInBloc({required this.authUseCase}) : super(SignInState()) {
    on<SignInSubmitEvent>(onSignInSubmit);
    on<RedirectEvent>(onRedirect);
  }

  FutureOr<void> onSignInSubmit(SignInSubmitEvent event, Emitter<SignInState> emit) {
    Timer(const Duration(milliseconds: 2020), () {
      print("Redirect 1");
    });
  }

  FutureOr<void> onRedirect(RedirectEvent event, Emitter<SignInState> emit) {
    Timer(const Duration(milliseconds: 2010), () {
      print("Redirect 2");
    });
  }
}
