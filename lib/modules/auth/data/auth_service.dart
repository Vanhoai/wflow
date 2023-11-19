import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/auth/data/models/auth_google_model.dart';
import 'package:wflow/modules/auth/data/models/request_model.dart';
import 'package:wflow/modules/auth/data/models/response_model.dart';

class AuthPaths {
  static const String signIn = '/auth/sign-in';
  static const String register = '/auth/create-account';
  static const String authWithGoogle = '/auth/auth-with-google';
}

abstract class AuthService {
  Future<AuthSignInResponse> signIn(AuthNormalRequest request);
  Future<String> register(AuthNormalRegisterRequest request);
  Future<String> registerWithGoogle({required AuthWithGoogleModel request});
  Future<AuthSignInResponse> signInWithGoogle({required AuthWithGoogleModel request});
  Future<String> sendCodeOtpMail({required String email, required String otpCode});
  Future<String> verifyCodeOtpMail({required String email, required String otpCode});
}

class AuthServiceImpl implements AuthService {
  final Agent agent;

  const AuthServiceImpl({required this.agent});

  @override
  Future<AuthSignInResponse> signIn(AuthNormalRequest request) async {
    try {
      final json = await agent.dio.post(
        AuthPaths.signIn,
        data: request.toJson(),
      );
      final HttpResponse httpResponse = HttpResponse.fromJson(json.data);

      if (httpResponse.statusCode != 200) {
        throw ServerException(httpResponse.message);
      }

      return AuthSignInResponse.fromJson(httpResponse.data);
    } catch (exception) {
      throw ServerException(exception.toString());
    }
  }

  @override
  Future<String> register(AuthNormalRegisterRequest request) async {
    try {
      final json = await agent.dio.post(
        AuthPaths.register,
        data: request.toJson(),
      );
      final HttpResponse httpResponse = HttpResponse.fromJson(json.data);
      if (httpResponse.statusCode != 200) {
        return throw ServerException(httpResponse.message);
      }

      return httpResponse.message;
    } catch (exception) {
      throw ServerException(exception.toString());
    }
  }

  @override
  Future<String> registerWithGoogle({required AuthWithGoogleModel request}) async {
    try {
      final response = await agent.dio.post(
        AuthPaths.authWithGoogle,
        data: request.toJson(),
      );
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(httpResponse.message);
      }

      return httpResponse.message;
    } catch (exception) {
      throw ServerException(exception.toString());
    }
  }

  @override
  Future<AuthSignInResponse> signInWithGoogle({required AuthWithGoogleModel request}) async {
    try {
      final response = await agent.dio.post(
        AuthPaths.authWithGoogle,
        data: request.toJson(),
      );
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(httpResponse.message);
      }

      return AuthSignInResponse.fromJson(httpResponse.data);
    } catch (exception) {
      throw ServerException(exception.toString());
    }
  }

  @override
  Future<String> sendCodeOtpMail({required String email, required String otpCode}) async {
    try {
      final response = await agent.dio.post('/auth/send-code-otp-mail', data: {
        'email': email,
        'code': otpCode,
      });
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        return throw ServerException(httpResponse.message);
      }

      return httpResponse.message;
    } on ServerException catch (exception) {
      return throw ServerException(exception.message);
    } catch (exception) {
      return throw ServerException(exception.toString());
    }
  }

  @override
  Future<String> verifyCodeOtpMail({required String email, required String otpCode}) async {
    try {
      final response = await agent.dio.post('/auth/verify-code-otp-mail', data: {
        'email': email,
        'otp': otpCode,
      });
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        return throw ServerException(httpResponse.message);
      }

      return httpResponse.message;
    } on ServerException catch (exception) {
      return throw ServerException(exception.message);
    } catch (exception) {
      return throw ServerException(exception.toString());
    }
  }
}
