import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/user/models/user_model.dart';
import 'package:wflow/modules/main/data/user/user_service.dart';
import 'package:wflow/modules/main/domain/user/user_entity.dart';
import 'package:wflow/modules/main/domain/user/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserService userService;

  UserRepositoryImpl({required this.userService});

  @override
  Future<Either<UserEntity, Failure>> myProfile() async {
    try {
      final UserModel userModel = await userService.myProfile();
      return Left(UserEntity.fromJson(userModel.toJson()));
    } catch (e) {
      if (e is CommonFailure) {
        return Right(CommonFailure(message: e.message, statusCode: e.statusCode));
      } else if (e is ServerFailure) {
        return Right(ServerFailure(message: e.message, statusCode: e.statusCode));
      } else if (e is CacheFailure) {
        return Right(CacheFailure(message: e.message, statusCode: e.statusCode));
      } else {
        return const Right(ServerFailure());
      }
    }
  }
}
