import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/contract/model/request_model.dart';
import 'package:wflow/modules/main/domain/contract/contract_repository.dart';

import 'contract_entity.dart';

abstract class ContractUseCase {
  Future<HttpResponseWithPagination<CandidateEntity>> getCandidateApplied(num id, GetCandidateApplied request);
  Future<Either<String, Failure>> applyPost(ApplyPostRequest request);
  Future<Either<ContractEntity, Failure>> candidateAppliedDetail(String id);
}

class ContractUseCaseImpl implements ContractUseCase {
  final ContractRepository contactRepository;

  ContractUseCaseImpl({required this.contactRepository});

  @override
  Future<HttpResponseWithPagination<CandidateEntity>> getCandidateApplied(num id, GetCandidateApplied request) async {
    return await contactRepository.getCandidateApplied(id, request);
  }

  @override
  Future<Either<String, Failure>> applyPost(ApplyPostRequest request) async {
    return await contactRepository.applyPost(request);
  }

  @override
  Future<Either<ContractEntity, Failure>> candidateAppliedDetail(String id) async {
    return await contactRepository.candidateAppliedDetail(id);
  }
}
