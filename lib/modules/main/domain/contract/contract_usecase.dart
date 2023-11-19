import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/contract/model/request_apply_model.dart';
import 'package:wflow/modules/main/data/contract/model/request_model.dart';
import 'package:wflow/modules/main/domain/contract/contract_repository.dart';
import 'package:wflow/modules/main/domain/contract/entities/candidate_entity.dart';
import 'package:wflow/modules/main/domain/contract/entities/contract_entity.dart';

abstract class ContractUseCase {
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
      getContractApplies(
    RequestApplyModel requestApplyModel,
  );
  Future<HttpResponseWithPagination<ContractEntity>> findContractSigned(
      GetContractSigned request);
  Future<Either<String, Failure>> checkContractAndTransfer(int id);
  Future<Either<HttpResponseWithPagination<ContractEntity>, Failure>>
      getContractCompleted(GetContractSigned req);
}

class ContractUseCaseImpl implements ContractUseCase {
  final ContractRepository contactRepository;

  ContractUseCaseImpl({required this.contactRepository});

  @override
  Future<HttpResponseWithPagination<CandidateEntity>> getCandidateApplied(
      num id, GetCandidateApplied request) async {
    return await contactRepository.getCandidateApplied(id, request);
  }

  @override
  Future<Either<String, Failure>> applyPost(ApplyPostRequest request) async {
    return await contactRepository.applyPost(request);
  }

  @override
  Future<Either<ContractEntity, Failure>> candidateAppliedDetail(
      String id) async {
    return await contactRepository.candidateAppliedDetail(id);
  }

  @override
  Future<Either<String, Failure>> createContract(
      CreateContractModel request) async {
    return await contactRepository.createContract(request);
  }

  @override
  Future<HttpResponseWithPagination<ContractEntity>> findContractAcceptedOfUser(
      GetContractOfUserAndBusiness request) async {
    return await contactRepository.findContractAcceptedOfUser(request);
  }

  @override
  Future<HttpResponseWithPagination<ContractEntity>> findContractWaitingSign(
      GetContractWaitingSign request) async {
    return await contactRepository.findContractWaitingSign(request);
  }

  @override
  Future<Either<String, Failure>> businessSignContract(int id) async {
    return await contactRepository.businessSignContract(id);
  }

  @override
  Future<Either<String, Failure>> workerSignContract(int id) async {
    return await contactRepository.workerSignContract(id);
  }

  @override
  Future<HttpResponseWithPagination<ContractEntity>> findContractSigned(
      GetContractSigned request) async {
    return await contactRepository.findContractSigned(request);
  }

  @override
  Future<Either<HttpResponseWithPagination<ContractEntity>, Failure>>
      getContractApplies(RequestApplyModel requestApplyModel) async {
    return await contactRepository.getContractApplies(requestApplyModel);
  }

  @override
  Future<Either<String, Failure>> checkContractAndTransfer(int id) async {
    return await contactRepository.checkContractAndTransfer(id);
  }

  @override
  Future<Either<HttpResponseWithPagination<ContractEntity>, Failure>>
      getContractCompleted(GetContractSigned req) async {
    return await contactRepository.getContractCompleted(req);
  }
}
