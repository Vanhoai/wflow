import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/balance/models/create_payment_rqst.dart';
import 'package:wflow/modules/main/data/balance/models/create_payment_rsp.dart';
import 'package:wflow/modules/main/data/balance/models/update_balance_rqst.dart';
import 'package:wflow/modules/main/domain/balance/balance_repository.dart';
import 'package:wflow/modules/main/domain/balance/entities/balance_entity.dart';

abstract class BalanceUseCase {
  Future<Either<CreatePaymentSheetResponse, Failure>> createPaymentSheet({required CreatePaymentSheetRequest request});
  Future<Either<BalanceEntity, Failure>> getMyBalance();
  Future<Either<BalanceEntity, Failure>> topUpBalance({required UpdateBalanceRequest request});
  Future<Either<BalanceEntity, Failure>> findBalance({required String id});
}

class BalanceUseCaseImpl implements BalanceUseCase {
  final BalanceRepository balanceRepository;
  BalanceUseCaseImpl({required this.balanceRepository});

  @override
  Future<Either<CreatePaymentSheetResponse, Failure>> createPaymentSheet(
      {required CreatePaymentSheetRequest request}) async {
    return await balanceRepository.createPaymentSheet(request: request);
  }

  @override
  Future<Either<BalanceEntity, Failure>> getMyBalance() async {
    return await balanceRepository.getMyBalance();
  }

  @override
  Future<Either<BalanceEntity, Failure>> topUpBalance({required UpdateBalanceRequest request}) async {
    return await balanceRepository.topUpBalance(request: request);
  }

  @override
  Future<Either<BalanceEntity, Failure>> findBalance({required String id}) async {
    return await balanceRepository.findBalance(id: id);
  }
}
