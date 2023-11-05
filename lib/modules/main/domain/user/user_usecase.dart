import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/user/models/request/get_user_not_business_model.dart';
import 'package:wflow/modules/main/data/user/models/request/add_collaborator_model.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';
import 'package:wflow/modules/main/domain/user/user_repository.dart';

abstract class UserUseCase {
  Future<Either<UserEntity, Failure>> myProfile();
  Future<List<UserEntity>> getUsersNotBusiness(
      GetUserNotBusinessModel getUserNotBusinessModel);
  Future<bool> addCollaborator(AddCollaboratorModel addCollaboratorModel);
}

class UserUseCaseImpl implements UserUseCase {
  final UserRepository userRepository;

  const UserUseCaseImpl({required this.userRepository});

  @override
  Future<Either<UserEntity, Failure>> myProfile() async {
    return await userRepository.myProfile();
  }

  @override
  Future<List<UserEntity>> getUsersNotBusiness(
      GetUserNotBusinessModel getUserNotBusinessModel) async {
    return await userRepository.getUsersNotBusiness(getUserNotBusinessModel);
  }

  @override
  Future<bool> addCollaborator(
      AddCollaboratorModel addCollaboratorModel) async {
    return await userRepository.addCollaborator(addCollaboratorModel);
  }
}
