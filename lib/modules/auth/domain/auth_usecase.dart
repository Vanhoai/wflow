import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/auth/data/models/auth_google_model.dart';
import 'package:wflow/modules/auth/data/models/request_model.dart';
import 'package:wflow/modules/auth/domain/auth_entity.dart';
import 'package:wflow/modules/auth/domain/auth_repository.dart';

abstract class AuthUseCase {
  Future<Either<AuthEntity, Failure>> signIn(AuthNormalRequest request);
  Future<Either<String, Failure>> register(AuthNormalRegisterRequest request);
  Future<Either<String, Failure>> registerWithGoogle({required AuthWithGoogleModel request});
  Future<Either<AuthEntity, Failure>> signInWithGoogle({required AuthWithGoogleModel request});
}

class AuthUseCaseImpl implements AuthUseCase {
  final AuthRepository authRepository;

  const AuthUseCaseImpl({required this.authRepository});

  @override
  Future<Either<AuthEntity, Failure>> signIn(AuthNormalRequest request) async {
    return await authRepository.signIn(request);
  }

  @override
  Future<Either<String, Failure>> register(AuthNormalRegisterRequest request) async {
    return await authRepository.register(request);
  }

  @override
  Future<Either<String, Failure>> registerWithGoogle({required AuthWithGoogleModel request}) async {
    return await authRepository.registerWithGoogle(request: request);
  }

  @override
  Future<Either<AuthEntity, Failure>> signInWithGoogle({required AuthWithGoogleModel request}) async {
    return await authRepository.signInWithGoogle(request: request);
  }
}
