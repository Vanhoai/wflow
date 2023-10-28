import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/contract/contract_service.dart';
import 'package:wflow/modules/main/data/contract/model/request_model.dart';
import 'package:wflow/modules/main/domain/contract/contract_entity.dart';
import 'package:wflow/modules/main/domain/contract/contract_repository.dart';

class ContractRepositoryImpl implements ContractRepository {
  final ContractService contactService;

  ContractRepositoryImpl({required this.contactService});
  @override
  Future<Either<String, Failure>> applyPost(ApplyPostRequest request) async {
    try {
      final messageRespond = await contactService.applyPost(request);
      return Left(messageRespond);
    } catch (exception) {
      return const Right(ServerFailure());
    }
  }

  @override
  Future<Either<ContractEntity, Failure>> candidateAppliedDetail(String id) async {
    try {
      final candidateDetail = await contactService.candidateAppliedDetail(id);
      return Left(candidateDetail);
    } catch (exception) {
      return const Right(ServerFailure());
    }
  }

  @override
  Future<HttpResponseWithPagination<CandidateEntity>> getCandidateApplied(num id, GetCandidateApplied request) async {
    try {
      final response = await contactService.getCandidateApplied(id, request);
      return response;
    } catch (exception) {
      return HttpResponseWithPagination.empty();
    }
  }
}
