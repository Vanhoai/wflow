import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/authentication/model/request_model.dart';
import 'package:wflow/modules/main/domain/authentication/authentication_entity.dart';

abstract class AuthenticationRepository {
  Future<Either<AuthenticationEntity<FrontID>, Failure>> getFrontID(File file);
  Future<Either<AuthenticationEntity<BackID>, Failure>> getBackID(File file);
  Future<Either<HttpResponse, Failure>> faceMatch(RequestFaceMatch requestFaceMatch);
}
