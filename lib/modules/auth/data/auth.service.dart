import 'dart:convert';

import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/http.dart';

abstract class AuthService {
  Future<dynamic> signIn(String email, String password);
  Future<dynamic> createAccount(String email, String password);
}

class AuthServiceImpl implements AuthService {
  final Agent agent;

  AuthServiceImpl({required this.agent});

  @override
  Future createAccount(String email, String password) async {}

  @override
  Future<dynamic> signIn(String email, String password) async {
    try {
      final response = await agent.dio.post(
        "/auth/sign-in",
        data: json.encode({
          "email": email,
          "password": password,
        }),
      );

      return response.data;
    } catch (error) {
      throw ServerException();
    }
  }
}