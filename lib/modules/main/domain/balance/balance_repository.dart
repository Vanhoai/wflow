import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/balance/models/create_payment_rqst.dart';
import 'package:wflow/modules/main/data/balance/models/create_payment_rsp.dart';
import 'package:wflow/modules/main/data/balance/models/update_balance_rqst.dart';
import 'package:wflow/modules/main/domain/balance/entities/balance_entity.dart';

abstract class BalanceRepository {
  Future<Either<CreatePaymentSheetResponse, Failure>> createPaymentSheet({required CreatePaymentSheetRequest request});
  Future<Either<BalanceEntity, Failure>> getMyBalance();
  Future<Either<BalanceEntity, Failure>> topUpBalance({required UpdateBalanceRequest request});
  Future<Either<BalanceEntity, Failure>> findBalance({required String id});
}
