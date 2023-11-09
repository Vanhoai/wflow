import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/balance/balance_service.dart';
import 'package:wflow/modules/main/data/balance/models/create_payment_rqst.dart';
import 'package:wflow/modules/main/data/balance/models/create_payment_rsp.dart';
import 'package:wflow/modules/main/domain/balance/balance_repository.dart';

class BalanceRepositoryImpl implements BalanceRepository {
  final BalanceService balanceService;
  BalanceRepositoryImpl({required this.balanceService});

  @override
  Future<Either<CreatePaymentSheetResponse, Failure>> createPaymentSheet(
      {required CreatePaymentSheetRequest request}) async {
    try {
      final response = await balanceService.createPaymentSheet(request: request);
      return Left(response);
    } catch (exception) {
      return Right(ServerFailure(message: exception.toString()));
    }
  }
}
