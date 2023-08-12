import 'package:dartz/dartz.dart';

import 'package:wfow/core/http/http.dart';
import 'package:wfow/modules/auth/domain/auth_entity.dart';
import 'package:wfow/modules/auth/domain/auth_repository.dart';

abstract class AuthUseCase {
  Future<Either<AuthEntity, Failure>> signIn(String email, String password);
  Future<Either<AuthEntity, Failure>> signUp(String email, String password);
}

class AuthUseCaseImpl implements AuthUseCase {
  final AuthRepository authRepository;

  AuthUseCaseImpl({required this.authRepository});

  @override
  Future<Either<AuthEntity, Failure>> signIn(String email, String password) async {
    return await authRepository.signIn(email, password);
  }

  @override
  Future<Either<AuthEntity, Failure>> signUp(String email, String password) {
    return authRepository.signUp(email, password);
  }
}
