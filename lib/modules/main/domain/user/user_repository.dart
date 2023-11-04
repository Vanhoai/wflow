import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/user/models/request/get_user_not_business_model.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<UserEntity, Failure>> myProfile();
  Future<Either<List<UserEntity>, Failure>> getUsersNotBusiness(GetUserNotBusinessModel getUserNotBusinessModel);
}
