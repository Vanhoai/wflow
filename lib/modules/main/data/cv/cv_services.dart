import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/exception.http.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/cv/model/request_model.dart';
import 'package:wflow/modules/main/domain/cv/cv_entity.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';

abstract class CVService {
  Future<List<CVEntity>> getMyCV();
  Future<UserEntity> addCV(RequestAddCV requestAddCV);
}

class CVServiceImpl implements CVService {
  final Agent agent;

  CVServiceImpl({required this.agent});

  @override
  Future<List<CVEntity>> getMyCV() async {
    try {
      final response = await agent.dio.get('/user/my-cv');
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);

      if (httpResponse.statusCode != 200) {
        throw ServerException(httpResponse.message);
      }
      List<CVEntity> cvs = [];
      httpResponse.data.forEach((element) {
        cvs.add(CVEntity.fromJson(element));
      });

      return cvs;
    } catch (exception) {
      throw ServerException(exception.toString());
    }
  }

  @override
  Future<UserEntity> addCV(RequestAddCV requestAddCV) async {
    try {
      var formData = FormData.fromMap({
        'cv': await MultipartFile.fromFile(requestAddCV.cv.path, contentType: MediaType.parse('application/pdf')),
        'title': requestAddCV.title,
        'content': requestAddCV.title,
      });

      final response = await agent.dio.put('/user/add-cv', data: formData);
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(httpResponse.message);
      }

      return UserEntity.fromJson(httpResponse.data);
    } catch (exception) {
      throw ServerException(exception.toString());
    }
  }
}
