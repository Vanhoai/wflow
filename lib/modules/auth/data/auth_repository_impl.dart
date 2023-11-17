import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/auth/data/auth_service.dart';
import 'package:wflow/modules/auth/data/models/auth_google_model.dart';
import 'package:wflow/modules/auth/data/models/request_model.dart';
import 'package:wflow/modules/auth/domain/auth_entity.dart';
import 'package:wflow/modules/auth/domain/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;

  const AuthRepositoryImpl({required this.authService});

  @override
  Future<Either<AuthEntity, Failure>> signIn(AuthNormalRequest request) async {
    try {
      final authResponse = await authService.signIn(request);
      final AuthEntity authEntity = AuthEntity(
        accessToken: authResponse.accessToken,
        refreshToken: authResponse.refreshToken,
        stringeeToken: authResponse.stringeeToken,
        isSignIn: true,
      );

      return Left(authEntity);
    } catch (exception) {
      print(exception.toString());
      return Right(ServerFailure(message: exception.toString()));
    }
  }

  @override
  Future<Either<String, Failure>> register(AuthNormalRegisterRequest request) async {
    try {
      final response = await authService.register(request);
      return Left(response);
    } catch (exception) {
      if (exception is ServerFailure) {
        return Right(ServerFailure(message: exception.message));
      } else {
        return const Right(ServerFailure());
      }
    }
  }

  @override
  Future<Either<String, Failure>> registerWithGoogle({required AuthWithGoogleModel request}) async {
    try {
      final response = await authService.registerWithGoogle(request: request);
      return Left(response);
    } catch (exception) {
      return Right(ServerFailure(message: exception.toString()));
    }
  }

  @override
  Future<Either<AuthEntity, Failure>> signInWithGoogle({required AuthWithGoogleModel request}) async {
    try {
      final authResponse = await authService.signInWithGoogle(request: request);
      final AuthEntity authEntity = AuthEntity(
        accessToken: authResponse.accessToken,
        refreshToken: authResponse.refreshToken,
        stringeeToken: authResponse.stringeeToken,
        isSignIn: true,
      );

      return Left(authEntity);
    } catch (exception) {
      return Right(ServerFailure(message: exception.toString()));
    }
  }
}
