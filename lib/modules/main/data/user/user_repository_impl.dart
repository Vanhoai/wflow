import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/user/models/request/get_user_not_business_model.dart';
import 'package:wflow/modules/main/data/user/models/user_model.dart';
import 'package:wflow/modules/main/data/user/user_service.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';
import 'package:wflow/modules/main/domain/user/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserService userService;

  UserRepositoryImpl({required this.userService});

  @override
  Future<Either<UserEntity, Failure>> myProfile() async {
    try {
      final UserModel userModel = await userService.myProfile();
      return Left(UserEntity.fromJson(userModel.toJson()));
    } catch (exception) {
      return Right(ServerFailure(message: exception.toString()));
    }
  }

  @override
  Future<Either<List<UserEntity>, Failure>> getUsersNotBusiness(GetUserNotBusinessModel getUserNotBusinessModel) async {
    try {
      final List<UserEntity> users = await userService.getUsersNotBusiness(getUserNotBusinessModel);
      return Left(users);
    } catch (exception) {
      return Right(ServerFailure(message: exception.toString()));
    }
  }
}
