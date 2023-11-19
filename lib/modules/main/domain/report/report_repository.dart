import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/report/models/request_model.dart';
import 'package:wflow/modules/main/domain/report/entities/report_entity.dart';

abstract class ReportRepository {
  Future<Either<ReportEntity, Failure>> createReport(RequestReportModel request);
}
