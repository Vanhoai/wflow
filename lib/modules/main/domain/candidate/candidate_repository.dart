import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/candidate/model/request_model.dart';
import 'package:wflow/modules/main/domain/candidate/candidate_entity.dart';

abstract class CandidateRepository {
  Future<HttpResponseWithPagination<CandidateEntity>> getCandidateApplied(num id, GetCandidateApplied request);
}
