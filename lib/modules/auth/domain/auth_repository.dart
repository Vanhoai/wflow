import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/auth/data/models/auth_google_model.dart';
import 'package:wflow/modules/auth/data/models/request_model.dart';
import 'package:wflow/modules/auth/domain/auth_entity.dart';

abstract class AuthRepository {
  Future<Either<AuthEntity, Failure>> signIn(AuthNormalRequest request);
  Future<Either<String, Failure>> register(AuthNormalRegisterRequest request);
  Future<Either<String, Failure>> registerWithGoogle({required AuthWithGoogleModel request});
  Future<Either<AuthEntity, Failure>> signInWithGoogle({required AuthWithGoogleModel request});
  Future<Either<String, Failure>> sendCodeOtpMail({required String email, required String otpCode});
  Future<Either<String, Failure>> verifyCodeOtpMail({required String email, required String otpCode});
  Future<Either<String, Failure>> changeNewPassword({required String oldPassword, required String newPassword});
  Future<Either<String, Failure>> resetPassword(
      {required String username, required String password, required String type});
}
