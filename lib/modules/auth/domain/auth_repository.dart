import 'package:dartz/dartz.dart';

import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/auth/domain/auth_entity.dart';

abstract class AuthRepository {
  Future<Either<AuthEntity, Failure>> signIn(String email, String password);
  Future<Either<AuthEntity, Failure>> signUp(String email, String password);
}
