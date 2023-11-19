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
  Future<Either<String, Failure>> sendCodeOtpMail({required String email, required String otpCode});
  Future<Either<String, Failure>> verifyCodeOtpMail({required String email, required String otpCode});
  Future<Either<String, Failure>> changeNewPassword({required String oldPassword, required String newPassword});
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

  @override
  Future<Either<String, Failure>> sendCodeOtpMail({required String email, required String otpCode}) async {
    return await authRepository.sendCodeOtpMail(email: email, otpCode: otpCode);
  }

  @override
  Future<Either<String, Failure>> verifyCodeOtpMail({required String email, required String otpCode}) async {
    return await authRepository.verifyCodeOtpMail(email: email, otpCode: otpCode);
  }

  @override
  Future<Either<String, Failure>> changeNewPassword({required String oldPassword, required String newPassword}) async {
    return await authRepository.changeNewPassword(oldPassword: oldPassword, newPassword: newPassword);
  }
}
