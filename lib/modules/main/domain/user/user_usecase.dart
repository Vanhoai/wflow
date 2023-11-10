import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/user/models/request/get_all_collaborator_model.dart';
import 'package:wflow/modules/main/data/user/models/request/get_user_not_business_model.dart';
import 'package:wflow/modules/main/data/user/models/request/add_collaborator_model.dart';
import 'package:wflow/modules/main/data/user/models/request/remove_collaborator_model.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';
import 'package:wflow/modules/main/domain/user/user_repository.dart';

abstract class UserUseCase {
  Future<Either<UserEntity, Failure>> myProfile();
  Future<Either<List<UserEntity>, Failure>> getUsersNotBusiness(
      GetUserNotBusinessModel getUserNotBusinessModel);
  Future<bool> addCollaborator(AddCollaboratorModel addCollaboratorModel);
  Future<Either<List<UserEntity>, Failure>> getAllCollaborator(
      GetAllCollaboratorModel getAllCollaboratorModel);
  Future<bool> removeCollaborator(
      RemoveCollaboratorModel removeCollaboratorModel);
}

class UserUseCaseImpl implements UserUseCase {
  final UserRepository userRepository;

  const UserUseCaseImpl({required this.userRepository});

  @override
  Future<Either<UserEntity, Failure>> myProfile() async {
    return await userRepository.myProfile();
  }

  @override
  Future<Either<List<UserEntity>, Failure>> getUsersNotBusiness(
      GetUserNotBusinessModel getUserNotBusinessModel) async {
    return await userRepository.getUsersNotBusiness(getUserNotBusinessModel);
  }

  @override
  Future<bool> addCollaborator(
      AddCollaboratorModel addCollaboratorModel) async {
    return await userRepository.addCollaborator(addCollaboratorModel);
  }

  @override
  Future<Either<List<UserEntity>, Failure>> getAllCollaborator(
      GetAllCollaboratorModel getAllCollaboratorModel) async {
    return await userRepository.getAllCollaborator(getAllCollaboratorModel);
  }

  @override
  Future<bool> removeCollaborator(
      RemoveCollaboratorModel removeCollaboratorModel) async {
    return await userRepository.removeCollaborator(removeCollaboratorModel);
  }
}
