import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/contract/model/request_model.dart';

abstract class ContactRepository {
  Future<Either<String, Failure>> applyPost(ApplyPostRequest request);
}
