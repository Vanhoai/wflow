import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/exception.http.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/contract/model/request_model.dart';
import 'package:wflow/modules/main/domain/contract/contract_entity.dart';

abstract class ContractService {
  Future<String> applyPost(ApplyPostRequest request);
  Future<ContractEntity> candidateAppliedDetail(String id);
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
      print('errorr');
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
      print('errorr');
      throw ServerException(message: exception.toString());
    }
  }
}
