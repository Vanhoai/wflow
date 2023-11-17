import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/auth/data/models/auth_google_model.dart';
import 'package:wflow/modules/auth/data/models/request_model.dart';
import 'package:wflow/modules/auth/data/models/response_model.dart';

abstract class AuthService {
  Future<AuthSignInResponse> signIn(AuthNormalRequest request);
  Future<String> register(AuthNormalRegisterRequest request);
  Future<String> registerWithGoogle({required AuthWithGoogleModel request});
  Future<AuthSignInResponse> signInWithGoogle({required AuthWithGoogleModel request});
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
      if (httpResponse.statusCode > 300) {
        throw ServerException(message: httpResponse.message.toString());
      } else {
        return AuthSignInResponse.fromJson(httpResponse.data);
      }
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<String> register(AuthNormalRegisterRequest request) async {
    try {
      final json =
          await agent.dio.post('/auth/create-account', data: request.toJson());
      final HttpResponse httpResponse = HttpResponse.fromJson(json.data);
      if (httpResponse.statusCode != 200) {
        return throw ServerException(message: httpResponse.message.toString());
      } else {
        return httpResponse.message;
      }
    } on ServerException catch (exception) {
      return throw ServerException(message: exception.message.toString());
    } catch (exception) {
      return throw ServerException();
    }
  }

  @override
  Future<String> registerWithGoogle({required AuthWithGoogleModel request}) async {
    try {
      final response = await agent.dio.post(
        '/auth/auth-with-google',
        data: request.toJson(),
      );
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      return httpResponse.message;
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<AuthSignInResponse> signInWithGoogle({required AuthWithGoogleModel request}) async {
    try {
      final response = await agent.dio.post(
        '/auth/auth-with-google',
        data: request.toJson(),
      );
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      return AuthSignInResponse.fromJson(httpResponse.data);
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }
}
