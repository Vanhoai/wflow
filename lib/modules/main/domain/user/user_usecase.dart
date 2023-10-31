import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';
import 'package:wflow/modules/main/domain/user/user_repository.dart';

abstract class UserUseCase {
  Future<Either<UserEntity, Failure>> myProfile();
}

class UserUseCaseImpl implements UserUseCase {
  final UserRepository userRepository;

  const UserUseCaseImpl({required this.userRepository});

  @override
  Future<Either<UserEntity, Failure>> myProfile() async {
    return await userRepository.myProfile();
  }
}
