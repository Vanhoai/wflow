import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/contract/model/request_apply_model.dart';
import 'package:wflow/modules/main/data/contract/model/request_model.dart';
import 'package:wflow/modules/main/domain/contract/entities/candidate_entity.dart';
import 'package:wflow/modules/main/domain/contract/entities/contract_entity.dart';
import 'package:wflow/modules/main/domain/task/entities/task_entity.dart';

abstract class ContractRepository {
  Future<HttpResponseWithPagination<CandidateEntity>> getCandidateApplied(
      num id, GetCandidateApplied request);
  Future<Either<String, Failure>> applyPost(ApplyPostRequest request);
  Future<Either<ContractEntity, Failure>> candidateAppliedDetail(String id);
  Future<Either<String, Failure>> createContract(CreateContractModel request);
  Future<HttpResponseWithPagination<ContractEntity>> findContractAcceptedOfUser(
      GetContractOfUserAndBusiness request);
  Future<HttpResponseWithPagination<ContractEntity>> findContractWaitingSign(
      GetContractWaitingSign request);
  Future<Either<String, Failure>> workerSignContract(int id);
  Future<Either<String, Failure>> businessSignContract(int id);

  Future<Either<HttpResponseWithPagination<ContractEntity>, Failure>>
      getContractApplies(RequestApplyModel requestApplyModel);
  Future<HttpResponseWithPagination<ContractEntity>> findContractSigned(
      GetContractSigned request);
  Future<Either<String, Failure>> checkContractAndTransfer(int id);
  Future<Either<HttpResponseWithPagination<ContractEntity>, Failure>>
      getContractCompleted(GetContractSigned req);
  Future<Either<String, Failure>> findContractById(int id);
  Future<Either<List<TaskEntity>, Failure>> uploadFileAddToContact(RequestAddTaskExcel request);
  Future<Either<String, Failure>> workerCancelContract(int id);
}
