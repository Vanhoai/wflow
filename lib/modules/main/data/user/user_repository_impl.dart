import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/main/data/user/models/request/add_collaborator_model.dart';
import 'package:wflow/modules/main/data/user/models/request/get_all_collaborator_model.dart';
import 'package:wflow/modules/main/data/user/models/request/get_user_not_business_model.dart';
import 'package:wflow/modules/main/data/user/models/request/remove_collaborator_model.dart';
import 'package:wflow/modules/main/data/user/models/request/update_profile.dart';
import 'package:wflow/modules/main/data/user/models/user_model.dart';
import 'package:wflow/modules/main/data/user/user_service.dart';
import 'package:wflow/modules/main/domain/user/entities/notification_entity.dart';
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
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<HttpResponseWithPagination<UserEntity>, Failure>> getUsersNotBusiness({
    required GetUserNotBusinessModel getUserNotBusinessModel,
  }) async {
    try {
      final response = await userService.getUsersNotBusiness(getUserNotBusinessModel: getUserNotBusinessModel);
      final List<UserEntity> users = [...response.data.map((e) => UserEntity.fromJson(e.toJson()))];
      return Left(
        HttpResponseWithPagination<UserEntity>(
          data: users,
          meta: response.meta,
          message: response.message,
          statusCode: response.statusCode,
        ),
      );
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<String, Failure>> addCollaborator(AddCollaboratorModel addCollaboratorModel) async {
    try {
      final String message = await userService.addCollaborator(addCollaboratorModel);
      return Left(message);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<HttpResponseWithPagination<UserEntity>, Failure>> getAllCollaborator(
    GetAllCollaboratorModel getAllCollaboratorModel,
  ) async {
    try {
      final response = await userService.getAllCollaborator(getAllCollaboratorModel);
      final List<UserEntity> users = [...response.data.map((e) => UserEntity.fromJson(e.toJson()))];
      return Left(
        HttpResponseWithPagination<UserEntity>(
          data: users,
          meta: response.meta,
          message: response.message,
          statusCode: response.statusCode,
        ),
      );
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<String, Failure>> removeCollaborator(RemoveCollaboratorModel removeCollaboratorModel) async {
    try {
      final String message = await userService.removeCollaborator(removeCollaboratorModel);
      return Left(message);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<UserEntity, Failure>> findUserByID({required String id}) async {
    try {
      final UserModel userModel = await userService.findUserByID(id: id);
      return Left(UserEntity.fromJson(userModel.toJson()));
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<String, Failure>> updateProfile({required RequestUpdateProfile request}) async {
    try {
      final response = await userService.updateProfile(request: request);
      return Left(response);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<HttpResponseWithPagination<NotificationEntity>, Failure>> notification(
      {required num page, required num pageSize, required String search}) async {
    try {
      final response = await userService.notification(page: page, pageSize: pageSize, search: search);
      final List<NotificationEntity> notifications = [
        ...response.data.map((e) => NotificationEntity.fromJson(e.toJson()))
      ];
      return Left(
        HttpResponseWithPagination<NotificationEntity>(
          data: notifications,
          meta: response.meta,
          message: response.message,
          statusCode: response.statusCode,
        ),
      );
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }
}
