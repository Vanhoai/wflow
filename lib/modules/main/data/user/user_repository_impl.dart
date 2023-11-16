import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/main/data/user/models/request/add_collaborator_model.dart';
import 'package:wflow/modules/main/data/user/models/request/get_all_collaborator_model.dart';
import 'package:wflow/modules/main/data/user/models/request/get_user_not_business_model.dart';
import 'package:wflow/modules/main/data/user/models/request/remove_collaborator_model.dart';
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
      final List<UserModel> users = await userService.getUsersNotBusiness(getUserNotBusinessModel);
      return Left([...users.map((e) => UserEntity.fromJson(e.toJson()))]);
    } catch (e) {
      if (e is CommonFailure) {
        return Right(CommonFailure(message: e.message, statusCode: e.statusCode));
      } else if (e is ServerFailure) {
        return Right(ServerFailure(message: e.message, statusCode: e.statusCode));
      } else {
        return const Right(ServerFailure());
      }
    }
  }

  @override
  Future<bool> addCollaborator(AddCollaboratorModel addCollaboratorModel) async {
    try {
      return await userService.addCollaborator(addCollaboratorModel);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either<List<UserEntity>, Failure>> getAllCollaborator(GetAllCollaboratorModel getAllCollaboratorModel) async {
    try {
      final List<UserModel> users = await userService.getAllCollaborator(getAllCollaboratorModel);

      return Left([...users.map((e) => UserEntity.fromJson(e.toJson()))]);
    } catch (e) {
      if (e is CommonFailure) {
        return Right(CommonFailure(message: e.message, statusCode: e.statusCode));
      } else if (e is ServerFailure) {
        return Right(ServerFailure(message: e.message, statusCode: e.statusCode));
      } else {
        return const Right(ServerFailure());
      }
    }
  }

  @override
  Future<bool> removeCollaborator(RemoveCollaboratorModel removeCollaboratorModel) async {
    try {
      return await userService.removeCollaborator(removeCollaboratorModel);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either<UserEntity, Failure>> findUserByID({required String id}) async {
    try {
      final UserModel userModel = await userService.findUserByID(id: id);
      return Left(UserEntity.fromJson(userModel.toJson()));
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    } catch (exception) {
      return Right(CommonFailure(message: exception.toString()));
    }
  }
}
