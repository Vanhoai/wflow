import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/auth/data/models/request_model.dart';
import 'package:wflow/modules/auth/data/models/response_model.dart';

abstract class AuthService {
  Future<AuthSignInResponse> signIn(AuthNormalRequest request);
}

class AuthServiceImpl implements AuthService {
  final Agent agent;

  const AuthServiceImpl({required this.agent});

  @override
  Future<AuthSignInResponse> signIn(AuthNormalRequest request) async {
    try {
      final json =
          await agent.dio.post('/auth/sign-in', data: request.toJson());
      final HttpResponse httpResponse = HttpResponse.fromJson(json.data);

      if (httpResponse.statusCode != 200) {
        throw Exception(httpResponse.message);
      } else {
        return AuthSignInResponse.fromJson(httpResponse.data);
      }
    } catch (exception) {
      throw Exception(exception);
    }
  }
}
