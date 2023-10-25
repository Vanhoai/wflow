import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/exception.http.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/contract/model/request_model.dart';

abstract class ContractService {
  Future<String> applyPost(ApplyPostRequest request);
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
}
