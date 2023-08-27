import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/libs/libs.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/common/security/bloc.dart';
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
    on<SignInWithBiometrics>(onSignInWithBiometric);
    on<ResetSignInState>(onResetSignInState);
  }

  FutureOr<void> onResetSignInState(ResetSignInState event, Emitter<SignInState> emit) async {
    emit(SignInState());
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

  FutureOr<void> onSignInWithBiometric(SignInWithBiometrics event, Emitter<SignInState> emit) async {
    final isEnableTouchID = instance.get<SecurityBloc>().state.touchIDEnabled;
    if (isEnableTouchID) {
      final isAuth = await LocalAuth.signInWithBiometric();
      if (isAuth) {
        final String keySignInWithBiometric =
            await instance.get<SecureStorage>().read(AppConstants.keySignInWithBiometric);
        final String keyPasswordSignInWithBiometric =
            await instance.get<SecureStorage>().read(AppConstants.keyPasswordSignInWithBiometric);

        instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());
        final response = await authUseCase.signIn(keySignInWithBiometric, keyPasswordSignInWithBiometric);
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
      } else {
        emit(SignInFailure(failure: const CommonFailure(message: "Touch ID is not authenticated")));
      }
    } else {
      emit(SignInFailure(failure: const CommonFailure(message: "Touch ID is not enabled")));
    }
  }
}
