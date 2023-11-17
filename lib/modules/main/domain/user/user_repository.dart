import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/user/models/request/add_collaborator_model.dart';
import 'package:wflow/modules/main/data/user/models/request/get_all_collaborator_model.dart';
import 'package:wflow/modules/main/data/user/models/request/get_user_not_business_model.dart';
import 'package:wflow/modules/main/data/user/models/request/remove_collaborator_model.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<UserEntity, Failure>> myProfile();
  Future<Either<HttpResponseWithPagination<UserEntity>, Failure>> getUsersNotBusiness({
    required GetUserNotBusinessModel getUserNotBusinessModel,
  });
  Future<Either<String, Failure>> addCollaborator(AddCollaboratorModel addCollaboratorModel);
  Future<Either<HttpResponseWithPagination<UserEntity>, Failure>> getAllCollaborator(
    GetAllCollaboratorModel getAllCollaboratorModel,
  );
  Future<Either<String, Failure>> removeCollaborator(RemoveCollaboratorModel removeCollaboratorModel);
  Future<Either<UserEntity, Failure>> findUserByID({required String id});
}
