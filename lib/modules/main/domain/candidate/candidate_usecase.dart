import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/candidate/model/request_model.dart';
import 'package:wflow/modules/main/domain/candidate/candidate_entity.dart';
import 'package:wflow/modules/main/domain/candidate/candidate_repository.dart';

abstract class CandidateUseCase {
  Future<HttpResponseWithPagination<CandidateEntity>> getCandidateApplied(num id, GetCandidateApplied request);
}

class CandidateUseCaseImpl implements CandidateUseCase {
  final CandidateRepository candidateRepository;

  CandidateUseCaseImpl({required this.candidateRepository});

  @override
  Future<HttpResponseWithPagination<CandidateEntity>> getCandidateApplied(num id, GetCandidateApplied request) async {
    return await candidateRepository.getCandidateApplied(id, request);
  }
}
