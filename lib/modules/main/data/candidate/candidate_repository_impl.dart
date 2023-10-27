import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/candidate/candidate_service.dart';
import 'package:wflow/modules/main/data/candidate/model/request_model.dart';
import 'package:wflow/modules/main/domain/candidate/candidate_entity.dart';
import 'package:wflow/modules/main/domain/candidate/candidate_repository.dart';

class CandidateRepositoryImpl implements CandidateRepository {
  final CandidateService candidateService;

  CandidateRepositoryImpl({required this.candidateService});

  @override
  Future<HttpResponseWithPagination<CandidateEntity>> getCandidateApplied(num id, GetCandidateApplied request) async {
    try {
      final response = await candidateService.getCandidateApplied(id, request);
      return response;
    } catch (exception) {
      return HttpResponseWithPagination.empty();
    }
  }
}
