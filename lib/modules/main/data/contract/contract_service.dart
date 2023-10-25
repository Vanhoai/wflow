import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/exception.http.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/contract/model/request_model.dart';

abstract class ContactService {
  Future<String> applyPost(ApplyPostRequest request);
}

class ContactServiceImpl implements ContactService {
  final Agent agent;

  ContactServiceImpl({required this.agent});

  @override
  Future<String> applyPost(ApplyPostRequest request) async {
    try {
      final response = await agent.dio.post('/contract/apply-post', data: request.toJson());
      final HttpResponse httpResponse = HttpResponse.fromJson(response.data);

      if (httpResponse.statusCode != 200) {
        throw Exception(httpResponse.message);
      } else {
        return httpResponse.message;
      }
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }
}
