import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/report/models/request_model.dart';
import 'package:wflow/modules/main/domain/report/entities/report_entity.dart';
import 'package:wflow/modules/main/domain/report/report_repository.dart';

abstract class ReportUseCase {
  Future<Either<ReportEntity, Failure>> createReport(RequestReportModel request);
}

class ReportUseCaseImpl implements ReportUseCase {
  final ReportRepository reportRepository;

  ReportUseCaseImpl({required this.reportRepository});

  @override
  Future<Either<ReportEntity, Failure>> createReport(RequestReportModel request) async {
    return await reportRepository.createReport(request);
  }
}
