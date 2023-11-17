import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/main/data/balance/balance_service.dart';
import 'package:wflow/modules/main/data/balance/models/create_payment_rqst.dart';
import 'package:wflow/modules/main/data/balance/models/create_payment_rsp.dart';
import 'package:wflow/modules/main/data/balance/models/update_balance_rqst.dart';
import 'package:wflow/modules/main/domain/balance/balance_repository.dart';
import 'package:wflow/modules/main/domain/balance/entities/balance_entity.dart';

class BalanceRepositoryImpl implements BalanceRepository {
  final BalanceService balanceService;
  BalanceRepositoryImpl({required this.balanceService});

  @override
  Future<Either<CreatePaymentSheetResponse, Failure>> createPaymentSheet({
    required CreatePaymentSheetRequest request,
  }) async {
    try {
      final response = await balanceService.createPaymentSheet(request: request);
      return Left(response);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<BalanceEntity, Failure>> getMyBalance() async {
    try {
      final response = await balanceService.getMyBalance();
      return Left(response);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<BalanceEntity, Failure>> topUpBalance({required UpdateBalanceRequest request}) async {
    try {
      final response = await balanceService.topUpBalance(request: request);
      return Left(response);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<BalanceEntity, Failure>> findBalance({required String id}) async {
    try {
      final response = await balanceService.findBalance(id: id);
      return Left(response);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }
}
