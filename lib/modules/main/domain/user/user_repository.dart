import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<UserEntity, Failure>> myProfile();
}
