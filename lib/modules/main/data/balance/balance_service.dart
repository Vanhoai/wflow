import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/main/data/balance/models/create_payment_rqst.dart';
import 'package:wflow/modules/main/data/balance/models/create_payment_rsp.dart';

class BalancePaths {
  static const String createPaymentSheet = '/balance/create-payment-sheet';
}

abstract class BalanceService {
  Future<CreatePaymentSheetResponse> createPaymentSheet({required CreatePaymentSheetRequest request});
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
}
