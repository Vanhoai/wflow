import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/auth/data/models/request_model.dart';
import 'package:wflow/modules/auth/domain/auth_entity.dart';
import 'package:wflow/modules/auth/domain/auth_repository.dart';

abstract class AuthUseCase {
  Future<Either<AuthEntity, Failure>> signIn(AuthNormalRequest request);
}

class AuthUseCaseImpl implements AuthUseCase {
  final AuthRepository authRepository;

  const AuthUseCaseImpl({required this.authRepository});

  @override
  Future<Either<AuthEntity, Failure>> signIn(AuthNormalRequest request) async {
    return await authRepository.signIn(request);
  }
}
