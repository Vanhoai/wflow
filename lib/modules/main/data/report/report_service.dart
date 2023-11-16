import 'package:dio/dio.dart';
import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/exception.http.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/report/models/request_model.dart';
import 'package:wflow/modules/main/domain/report/entities/report_entity.dart';

abstract class ReportService {
  Future<ReportEntity> createReport(RequestReportModel request);
}

class ReportServiceImpl implements ReportService {
  final Agent agent;

  ReportServiceImpl({required this.agent});

  @override
  Future<ReportEntity> createReport(RequestReportModel request) async {
    var formData = FormData.fromMap({'content': request.content, 'target': request.target, 'type': request.type});
    if (request.files.isNotEmpty) {
      for (int i = 0; i < request.files.length; i++) {
        formData.files.addAll([MapEntry('files', await MultipartFile.fromFile(request.files[i].path))]);
      }
    }

    try {
      final response = await agent.dio.post('/report/', data: formData);
      final HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      return ReportEntity.fromJson(httpResponse.data);
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }
}
