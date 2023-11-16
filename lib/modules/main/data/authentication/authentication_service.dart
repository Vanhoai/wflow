import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/exception.http.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/authentication/model/request_model.dart';
import 'package:wflow/modules/main/domain/authentication/authentication_entity.dart';

abstract class AuthenticationService {
  Future<AuthenticationEntity<FrontID>> getFrontID(File file);
  Future<AuthenticationEntity<BackID>> getBackID(File file);
  Future<HttpResponse> faceMatch(RequestFaceMatch requestFaceMatch);
}

class AuthenticationServiceImpl extends AuthenticationService {
  final Agent agent;

  AuthenticationServiceImpl({required this.agent});

  @override
  Future<AuthenticationEntity<BackID>> getBackID(File file) async {
    try {
      var formData = FormData.fromMap({'file': await MultipartFile.fromFile(file.path)});
      final response = await agent.dio.post('/fpt-ai/id-recognition', data: formData);
      final HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      List<dynamic> list = httpResponse.data['data'];
      List<BackID> backIDs = list.map((e) => BackID.fromJson(e)).toList();
      return AuthenticationEntity(
          errorCode: httpResponse.data['errorCode'], errorMessage: httpResponse.data['errorMessage'], data: backIDs);
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<AuthenticationEntity<FrontID>> getFrontID(File file) async {
    try {
      var formData = FormData.fromMap({'file': await MultipartFile.fromFile(file.path)});
      final response = await agent.dio.post('/fpt-ai/id-recognition', data: formData);
      final HttpResponse httpResponse = HttpResponse.fromJson(response.data);

      List<dynamic> list = httpResponse.data['data'];
      List<FrontID> fontIDs = list.map((e) => FrontID.fromJson(e)).toList();
      return AuthenticationEntity(
          errorCode: httpResponse.data['errorCode'], errorMessage: httpResponse.data['errorMessage'], data: fontIDs);
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<HttpResponse> faceMatch(RequestFaceMatch requestFaceMatch) async {
    try {
      var formData = FormData.fromMap({
        'face': await MultipartFile.fromFile(requestFaceMatch.face.path),
        'front': await MultipartFile.fromFile(requestFaceMatch.front.path),
        'back': await MultipartFile.fromFile(requestFaceMatch.back.path),
        'name': requestFaceMatch.name,
        'identifyCode': requestFaceMatch.identifyCode,
        'dob': requestFaceMatch.dob
      });
      final response = await agent.dio.post('/fpt-ai/face-match', data: formData);
      final HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      return httpResponse;
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }
}
