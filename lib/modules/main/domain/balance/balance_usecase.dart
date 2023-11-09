import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/balance/models/create_payment_rqst.dart';
import 'package:wflow/modules/main/data/balance/models/create_payment_rsp.dart';
import 'package:wflow/modules/main/domain/balance/balance_repository.dart';

abstract class BalanceUseCase {
  Future<Either<CreatePaymentSheetResponse, Failure>> createPaymentSheet({required CreatePaymentSheetRequest request});
}

class BalanceUseCaseImpl implements BalanceUseCase {
  final BalanceRepository balanceRepository;
  BalanceUseCaseImpl({required this.balanceRepository});

  @override
  Future<Either<CreatePaymentSheetResponse, Failure>> createPaymentSheet(
      {required CreatePaymentSheetRequest request}) async {
    return await balanceRepository.createPaymentSheet(request: request);
  }
}
