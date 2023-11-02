import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/authentication/model/request_model.dart';
import 'package:wflow/modules/main/domain/authentication/authentication_entity.dart';
import 'package:wflow/modules/main/domain/authentication/authentication_repository.dart';
import 'package:wflow/core/http/response.http.dart';

abstract class AuthenticationUseCase {
  Future<Either<AuthenticationEntity<FrontID>, Failure>> getFrontID(File file);
  Future<Either<AuthenticationEntity<BackID>, Failure>> getBackID(File file);
  Future<Either<HttpResponse, Failure>> faceMatch(RequestFaceMatch requestFaceMatch);
}

class AuthenticationUseCaseImpl extends AuthenticationUseCase {
  final AuthenticationRepository authenticationRepository;

  AuthenticationUseCaseImpl({required this.authenticationRepository});

  @override
  Future<Either<AuthenticationEntity<BackID>, Failure>> getBackID(File file) async {
    return authenticationRepository.getBackID(file);
  }

  @override
  Future<Either<AuthenticationEntity<FrontID>, Failure>> getFrontID(File file) async {
    return authenticationRepository.getFrontID(file);
  }

  @override
  Future<Either<HttpResponse, Failure>> faceMatch(RequestFaceMatch requestFaceMatch) async {
    return authenticationRepository.faceMatch(requestFaceMatch);
  }
}
