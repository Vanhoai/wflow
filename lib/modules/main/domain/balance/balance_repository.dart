import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/balance/models/create_payment_rqst.dart';
import 'package:wflow/modules/main/data/balance/models/create_payment_rsp.dart';

abstract class BalanceRepository {
  Future<Either<CreatePaymentSheetResponse, Failure>> createPaymentSheet({required CreatePaymentSheetRequest request});
}
