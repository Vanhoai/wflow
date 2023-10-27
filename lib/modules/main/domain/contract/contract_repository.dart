import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/contract/model/request_model.dart';
import 'package:wflow/modules/main/domain/contract/contract_entity.dart';

abstract class ContractRepository {
  Future<Either<String, Failure>> applyPost(ApplyPostRequest request);
  Future<Either<ContractEntity, Failure>> candidateAppliedDetail(String id);
}
