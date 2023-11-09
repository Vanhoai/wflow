import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/core/utils/utils.dart';
import 'package:wflow/modules/main/data/balance/models/create_payment_rqst.dart';
import 'package:wflow/modules/main/data/balance/models/create_payment_rsp.dart';
import 'package:wflow/modules/main/domain/balance/balance_usecase.dart';
import 'package:wflow/modules/main/domain/balance/entities/balance_entity.dart';

part 'event.dart';
part 'state.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  final BalanceUseCase balanceUseCase;

  BalanceBloc({required this.balanceUseCase})
      : super(
          BalanceState(
            balanceEntity: BalanceEntity.empty(),
            isLoading: false,
          ),
        ) {
    on<BalanceEventFetch>(onFetch);
    on<BalanceTopUpEvent>(onTopUp);
  }

  FutureOr<void> onFetch(BalanceEventFetch event, Emitter<BalanceState> emit) async {
    emit(state.copyWith(isLoading: true));

    final response = await balanceUseCase.getMyBalance();
    response.fold(
      (BalanceEntity l) {
        emit(state.copyWith(balanceEntity: l));
      },
      (Failure r) {
        AlertUtils.showMessage('Notification', r.message);
      },
    );

    emit(state.copyWith(isLoading: false));
  }

  FutureOr<void> onTopUp(BalanceTopUpEvent event, Emitter<BalanceState> emit) async {
    try {
      final response = await balanceUseCase.createPaymentSheet(
        request: CreatePaymentSheetRequest(customer: state.balanceEntity.customerID, amount: event.amount),
      );
      response.fold(
        (CreatePaymentSheetResponse createPaymentSheetResponse) {
          initPaymentSheet(createPaymentSheetResponse);
        },
        (Failure failure) {
          AlertUtils.showMessage('Notification', failure.message);
        },
      );
    } on StripeException catch (exception) {
      print('exception: $exception');
      AlertUtils.showMessage('Notification', exception.toString());
    } catch (exception) {
      AlertUtils.showMessage('Notification', exception.toString());
    }
  }

  Future<void> initPaymentSheet(CreatePaymentSheetResponse createPaymentSheetResponse) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          customFlow: false,
          merchantDisplayName: 'DepFow Top Up Balance',
          paymentIntentClientSecret: createPaymentSheetResponse.paymentIntent,
          customerEphemeralKeySecret: createPaymentSheetResponse.ephemeralKey,
          customerId: createPaymentSheetResponse.customer,
          allowsDelayedPaymentMethods: true,
        ),
      );

      final response = await Stripe.instance.presentPaymentSheet();
      print('response: $response');
    } on StripeException catch (exception) {
      print('exception: $exception');
      AlertUtils.showMessage('Notification', exception.toString());
    } catch (exception) {
      print('exception: $exception');
      AlertUtils.showMessage('Notification', exception.toString());
    }
  }

  Future<void> cancelPaymentSheet() async {}
}
