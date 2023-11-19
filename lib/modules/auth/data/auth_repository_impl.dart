import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/http.dart';
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
    } on ServerException catch (exception) {
      print('ServerException: ${exception.message}');
      return Right(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<String, Failure>> register(AuthNormalRegisterRequest request) async {
    try {
      final response = await authService.register(request);
      return Left(response);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message.toString()));
    } catch (exception) {
      return const Right(ServerFailure());
    }
  }

  @override
  Future<Either<String, Failure>> registerWithGoogle({required AuthWithGoogleModel request}) async {
    try {
      final response = await authService.registerWithGoogle(request: request);
      return Left(response);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
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
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<String, Failure>> sendCodeOtpMail({required String email, required String otpCode}) async {
    try {
      final response = await authService.sendCodeOtpMail(email: email, otpCode: otpCode);
      return Left(response);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message.toString()));
    } catch (exception) {
      return const Right(ServerFailure());
    }
  }

  @override
  Future<Either<String, Failure>> verifyCodeOtpMail({required String email, required String otpCode}) async {
    try {
      final response = await authService.verifyCodeOtpMail(email: email, otpCode: otpCode);
      return Left(response);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message.toString()));
    } catch (exception) {
      return const Right(ServerFailure());
    }
  }

  @override
  Future<Either<String, Failure>> changeNewPassword({required String oldPassword, required String newPassword}) async {
    try {
      final response = await authService.changeNewPassword(oldPassword: oldPassword, newPassword: newPassword);
      return Left(response);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message.toString()));
    } catch (exception) {
      return const Right(ServerFailure());
    }
  }
}
