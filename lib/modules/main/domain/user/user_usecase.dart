import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/user/models/request/get_user_not_business_model.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';
import 'package:wflow/modules/main/domain/user/user_repository.dart';

abstract class UserUseCase {
  Future<Either<UserEntity, Failure>> myProfile();
  Future<Either<List<UserEntity>, Failure>> getUsersNotBusiness(
      GetUserNotBusinessModel getUserNotBusinessModel);
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
}
