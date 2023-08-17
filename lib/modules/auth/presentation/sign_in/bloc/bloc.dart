import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/http/failure.dart';
import 'package:wflow/core/utils/secure_storage.dart';
import 'package:wflow/modules/auth/domain/auth_entity.dart';
import 'package:wflow/modules/auth/domain/auth_usecase.dart';

part 'event.dart';
part 'state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthUseCase authUseCase;
  final SecureStorage secureStorage;

  SignInBloc({required this.authUseCase, required this.secureStorage}) : super(SignInState()) {
    on<SignInSubmitted>(onSignInSubmitted);
  }

  FutureOr<void> onSignInSubmitted(SignInSubmitted event, Emitter<SignInState> emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());
    final response = await authUseCase.signIn("hoaitv241223@gmail.com", "hoaitv241223");
    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
    response.fold(
      (AuthEntity authEntity) {
        print("Auth Entity ${authEntity.accessToken}");
        secureStorage.write(AppConstants.accessTokenKey, authEntity.accessToken);
        secureStorage.write(AppConstants.refreshTokenKey, authEntity.refreshToken);
        emit(SignInSuccess());
      },
      (Failure failure) {},
    );
  }
}
