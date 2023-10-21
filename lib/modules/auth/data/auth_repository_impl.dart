import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/auth/data/auth_service.dart';
import 'package:wflow/modules/auth/data/models/request_model.dart';
import 'package:wflow/modules/auth/domain/auth_entity.dart';
import 'package:wflow/modules/auth/domain/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;

  const AuthRepositoryImpl({required this.authService});

  @override
  Future<Either<AuthEntity, Failure>> signIn(AuthNormalRequest request) async {
    try {
      final authResponse = await authService.signIn(request);
      final AuthEntity authEntity = AuthEntity(
        accessToken: authResponse.accessToken,
        refreshToken: authResponse.refreshToken,
        isSignIn: true,
        user: authResponse.user,
      );

      return Left(authEntity);
    } catch (exception) {
      return const Right(ServerFailure());
    }
  }
}
