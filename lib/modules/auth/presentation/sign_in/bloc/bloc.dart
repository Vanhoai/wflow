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

  SignInBloc({required this.authUseCase}) : super(const SignInState()) {
    on<SignInSubmitEvent>(onSignInSubmit);
    on<ChangeEmailEvent>(onChangeEmail);
    on<SignInSearchingEvent>(onSignInSearching);
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

  FutureOr<void> onChangeEmail(ChangeEmailEvent event, Emitter<SignInState> emit) async {
    final SignInState builder = SignInBuilder(state: state).data(email: event.email).build();
    print(builder);
    emit(builder);
  }

  FutureOr<void> onSignInSearching(SignInSearchingEvent event, Emitter<SignInState> emit) async {
    final SignInState builder = SignInBuilder(state: state).search(event.search).build();
    emit(builder);
  }
}
