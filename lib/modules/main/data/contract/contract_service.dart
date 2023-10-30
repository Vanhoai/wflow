import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/exception.http.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/contract/model/request_model.dart';
import 'package:wflow/modules/main/domain/contract/entities/candidate_entity.dart';
import 'package:wflow/modules/main/domain/contract/entities/contract_entity.dart';

abstract class ContractService {
  Future<HttpResponseWithPagination<CandidateEntity>> getCandidateApplied(num id, GetCandidateApplied request);
  Future<String> applyPost(ApplyPostRequest request);
  Future<ContractEntity> candidateAppliedDetail(String id);
  Future<String> createContract(CreateContractModel request);
}

class ContractServiceImpl implements ContractService {
  final Agent agent;
  ContractServiceImpl({required this.agent});

  @override
  Future<String> applyPost(ApplyPostRequest request) async {
    try {
      final response = await agent.dio.post('/contract/apply-post', data: request.toJson());
      final HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      return httpResponse.message;
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<ContractEntity> candidateAppliedDetail(String id) async {
    try {
      final response = await agent.dio.get('/contract/candidate-applied-detail/$id');
      final HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      return ContractEntity.fromJson(httpResponse.data);
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<HttpResponseWithPagination<CandidateEntity>> getCandidateApplied(num id, request) async {
    try {
      final response = await agent.dio.get(
        '/contract/candidate-applied/$id',
        queryParameters: {
          'page': request.page,
          'pageSize': request.pageSize,
          'search': request.search,
        },
      );

      HttpResponseWithPagination<dynamic> httpResponse = HttpResponseWithPagination.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      List<CandidateEntity> posts = httpResponse.data.map((e) => CandidateEntity.fromJson(e)).toList();
      return HttpResponseWithPagination(
        statusCode: httpResponse.statusCode,
        message: httpResponse.message,
        meta: httpResponse.meta,
        data: posts,
      );
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<String> createContract(CreateContractModel request) async {
    try {
      final response = await agent.dio.put(
        '/add-tasks-update-contract',
        data: request.toJson(),
      );

      final HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      return httpResponse.message;
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }
}
