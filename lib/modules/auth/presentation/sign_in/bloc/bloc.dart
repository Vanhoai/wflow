import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/core/utils/secure.util.dart';
import 'package:wflow/modules/auth/domain/auth.entity.dart';
import 'package:wflow/modules/auth/domain/auth.usecase.dart';

part 'event.dart';
part 'state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthUseCase authUseCase;

  SignInBloc({required this.authUseCase}) : super(SignInState()) {
    on<SignInSubmitted>(onSignInSubmitted);
  }

  FutureOr<void> onSignInSubmitted(SignInSubmitted event, Emitter<SignInState> emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());
    final response = await authUseCase.signIn("hoaitv241223@gmail.com", "hoaitv241223");
    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());

    response.fold(
      (AuthEntity authEntity) {
        instance.get<SecureStorage>().write(AppConstants.accessTokenKey, authEntity.accessToken);
        instance.get<SecureStorage>().write(AppConstants.refreshTokenKey, authEntity.refreshToken);
        emit(SignInSuccess());
      },
      (Failure failure) {
        emit(SignInFailure(failure: failure));
      },
    );
  }
}
