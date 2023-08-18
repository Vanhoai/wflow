import 'package:dartz/dartz.dart';

import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/auth/domain/auth.entity.dart';
import 'package:wflow/modules/auth/domain/auth.repository.dart';

abstract class AuthUseCase {
  Future<Either<AuthEntity, Failure>> signIn(String email, String password);
  Future<Either<AuthEntity, Failure>> signUpWithEmail(String email, String password);
}

class AuthUseCaseImpl implements AuthUseCase {
  final AuthRepository authRepository;

  AuthUseCaseImpl({required this.authRepository});

  @override
  Future<Either<AuthEntity, Failure>> signIn(String email, String password) async {
    return await authRepository.signIn(email, password);
  }

  @override
  Future<Either<AuthEntity, Failure>> signUpWithEmail(String email, String password) {
    return authRepository.signUpWithEmail(email, password);
  }
}
