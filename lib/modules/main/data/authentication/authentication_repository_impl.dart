import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/authentication/authentication_service.dart';
import 'package:wflow/modules/main/data/authentication/model/request_model.dart';
import 'package:wflow/modules/main/domain/authentication/authentication_entity.dart';
import 'package:wflow/modules/main/domain/authentication/authentication_repository.dart';
import 'package:wflow/core/http/response.http.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationService authenticationService;

  AuthenticationRepositoryImpl({required this.authenticationService});
  @override
  Future<Either<AuthenticationEntity<BackID>, Failure>> getBackID(File file) async {
    try {
      final response = await authenticationService.getBackID(file);

      return Left(response);
    } catch (exception) {
      return const Right(ServerFailure());
    }
  }

  @override
  Future<Either<AuthenticationEntity<FrontID>, Failure>> getFrontID(File file) async {
    try {
      final response = await authenticationService.getFrontID(file);

      return Left(response);
    } catch (exception) {
      return const Right(ServerFailure());
    }
  }

  @override
  Future<Either<HttpResponse, Failure>> faceMatch(RequestFaceMatch requestFaceMatch) async {
    try {
      final response = await authenticationService.faceMatch(requestFaceMatch);

      return Left(response);
    } catch (exception) {
      return const Right(ServerFailure());
    }
  }
}
