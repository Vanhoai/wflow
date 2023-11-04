import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/auth/data/models/request_model.dart';
import 'package:wflow/modules/auth/domain/auth_entity.dart';

abstract class AuthRepository {
  Future<Either<AuthEntity, Failure>> signIn(AuthNormalRequest request);
  Future<Either<String, Failure>> register(AuthNormalRegisterRequest request);
}
