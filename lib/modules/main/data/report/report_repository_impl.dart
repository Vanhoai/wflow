import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/report/models/request_model.dart';
import 'package:wflow/modules/main/data/report/report_service.dart';
import 'package:wflow/modules/main/domain/report/entities/report_entity.dart';
import 'package:wflow/modules/main/domain/report/report_repository.dart';

class ReportRepositoryImpl implements ReportRepository {
  final ReportService reportService;

  ReportRepositoryImpl({required this.reportService});

  @override
  Future<Either<ReportEntity, Failure>> createReport(RequestReportModel request) async {
    try {
      final response = await reportService.createReport(request);
      return Left(response);
    } catch (exception) {
      return const Right(ServerFailure());
    }
  }
}
