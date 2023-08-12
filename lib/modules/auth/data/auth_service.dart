import 'dart:convert';

import 'package:wfow/core/agent/agent.dart';
import 'package:wfow/core/http/http.dart';

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
  Future signIn(String email, String password) async {
    try {
      final response = await agent.dio.post(
        "/auth/login",
        data: json.encode({"username": "p3nhox98", "password": "123456", "device_token": "ksjdhfklasdhfjk"}),
      );

      return response.data;
    } catch (error) {
      throw ServerException();
    }
  }
}
