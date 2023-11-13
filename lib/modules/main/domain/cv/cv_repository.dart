import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/cv/model/request_model.dart';
import 'package:wflow/modules/main/domain/cv/cv_entity.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';

abstract class CVRepository {
  Future<List<CVEntity>> getMyCV();
  Future<Either<UserEntity, Failure>> addCV(RequestAddCV requestAddCV);
}
