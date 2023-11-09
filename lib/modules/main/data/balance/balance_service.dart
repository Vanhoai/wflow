import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/main/data/balance/models/create_payment_rqst.dart';
import 'package:wflow/modules/main/data/balance/models/create_payment_rsp.dart';
import 'package:wflow/modules/main/data/balance/models/update_balance_rqst.dart';
import 'package:wflow/modules/main/domain/balance/entities/balance_entity.dart';

class BalancePaths {
  static const String createPaymentSheet = '/balance/create-payment-sheet';
  static const String getMyBalance = '/user/my-balance';
  static const String topUpBalance = '/balance/top-up-balance';
}

abstract class BalanceService {
  Future<CreatePaymentSheetResponse> createPaymentSheet({required CreatePaymentSheetRequest request});
  Future<BalanceEntity> getMyBalance();
  Future<BalanceEntity> topUpBalance({required UpdateBalanceRequest request});
}

class BalanceServiceImpl implements BalanceService {
  final Agent agent;
  BalanceServiceImpl({required this.agent});

  @override
  Future<CreatePaymentSheetResponse> createPaymentSheet({required CreatePaymentSheetRequest request}) async {
    try {
      final response = await agent.dio.post(
        BalancePaths.createPaymentSheet,
        data: request.toJson(),
      );

      HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      return CreatePaymentSheetResponse.fromJson(httpResponse.data);
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<BalanceEntity> getMyBalance() async {
    try {
      final response = await agent.dio.get(
        BalancePaths.getMyBalance,
      );

      HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      return BalanceEntity.fromJson(httpResponse.data);
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<BalanceEntity> topUpBalance({required UpdateBalanceRequest request}) async {
    try {
      final response = await agent.dio.post(
        BalancePaths.topUpBalance,
        data: request.toJson(),
      );

      HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      return BalanceEntity.fromJson(httpResponse.data);
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }
}
