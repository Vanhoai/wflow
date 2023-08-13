import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/core/http/failure.dart';
import 'package:wflow/modules/auth/domain/auth_entity.dart';
import 'package:wflow/modules/auth/domain/auth_usecase.dart';

part 'event.dart';
part 'state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthUseCase authUseCase;

  SignInBloc({required this.authUseCase}) : super(SignInState()) {
    on<SignInSubmitEvent>(onSignInSubmit);
  }

  FutureOr<void> onSignInSubmit(SignInSubmitEvent event, Emitter<SignInState> emit) async {
    try {
      final response = await authUseCase.signIn(event.email, event.password);
      response.fold(
        (AuthEntity authEntity) => print(authEntity),
        (Failure failure) => print(failure),
      );
    } catch (error) {
      print(error);
    }
  }
}
