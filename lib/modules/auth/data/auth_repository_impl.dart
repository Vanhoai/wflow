import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/auth/data/auth_service.dart';
import 'package:wflow/modules/auth/domain/auth_entity.dart';
import 'package:wflow/modules/auth/domain/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;

  AuthRepositoryImpl({required this.authService});

  @override
  Future<Either<AuthEntity, Failure>> signIn(String email, String password) async {
    try {
      final response = await authService.signIn(email, password);
      HttpResponse httpResponse = HttpResponse.fromJson(response);
      final AuthEntity authEntity = AuthEntity.fromJson(httpResponse.data);
      return Left(authEntity);
    } catch (error) {
      return const Right(ServerFailure());
    }
  }

  @override
  Future<Either<AuthEntity, Failure>> signUpWithEmail(String email, String password) async {
    try {
      final response = await authService.signIn(email, password);
      HttpResponse httpResponse = HttpResponse.fromJson(response);
      final AuthEntity authEntity = AuthEntity.fromJson(httpResponse.data);
      return Left(authEntity);
    } catch (error) {
      return const Right(ServerFailure());
    }
  }
}
