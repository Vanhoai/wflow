import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/exception.http.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/domain/cv/cv_entity.dart';

abstract class CVService {
  Future<List<CVEntity>> getMyCV();
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
        throw ServerException(message: httpResponse.message);
      }
      List<CVEntity> cvs = [];
      httpResponse.data.forEach((element) {
        cvs.add(CVEntity.fromJson(element));
      });

      return cvs;
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }
}
