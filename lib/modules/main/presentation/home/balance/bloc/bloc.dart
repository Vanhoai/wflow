import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/core/utils/utils.dart';
import 'package:wflow/modules/main/data/balance/models/create_payment_rqst.dart';
import 'package:wflow/modules/main/data/balance/models/create_payment_rsp.dart';
import 'package:wflow/modules/main/data/balance/models/update_balance_rqst.dart';
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
    on<BalanceTopUpEvent>((event, emit) async {
      await onTopUp(event, emit);
    });
  }

  FutureOr<void> onFetch(BalanceEventFetch event, Emitter<BalanceState> emit) async {
    emit(state.copyWith(isLoading: true));

    final response = await balanceUseCase.findBalance(id: event.id);
    response.fold(
      (BalanceEntity l) {
        emit(state.copyWith(balanceEntity: l));
      },
      (Failure r) {
        AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), r.message);
      },
    );

    emit(state.copyWith(isLoading: false));
  }

  FutureOr<void> onTopUp(BalanceTopUpEvent event, Emitter<BalanceState> emit) async {
    try {
      final response = await balanceUseCase.createPaymentSheet(
        request: CreatePaymentSheetRequest(customer: state.balanceEntity.customerID, amount: event.amount),
      );

      await response.fold(
        (CreatePaymentSheetResponse createPaymentSheetResponse) async {
          await initPaymentSheet(createPaymentSheetResponse, event.amount, emit);
        },
        (Failure failure) async {
          AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), failure.message);
        },
      );
    } on StripeException catch (exception) {
      print('exception: $exception');
      AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), exception.toString());
    } catch (exception) {
      AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), exception.toString());
    }
  }

  Future<void> initPaymentSheet(
      CreatePaymentSheetResponse createPaymentSheetResponse, num amount, Emitter<BalanceState> emit) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          customFlow: false,
          merchantDisplayName: 'DepFow Top Up Balance',
          paymentIntentClientSecret: createPaymentSheetResponse.paymentIntentSecret,
          customerEphemeralKeySecret: createPaymentSheetResponse.ephemeralKey,
          customerId: createPaymentSheetResponse.customer,
          allowsDelayedPaymentMethods: true,
        ),
      );

      await Stripe.instance.presentPaymentSheet();
    } catch (exception) {
      AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), exception.toString());
    } finally {
      await checkPaymentStatus(
        emit,
        amount: amount,
        balanceID: state.balanceEntity.id,
        paymentIntentID: createPaymentSheetResponse.paymentIntentID,
      );
    }
  }

  Future<void> checkPaymentStatus(
    Emitter<BalanceState> emit, {
    required num amount,
    required num balanceID,
    required String paymentIntentID,
  }) async {
    final response = await balanceUseCase.topUpBalance(
      request: UpdateBalanceRequest(amount: amount, balanceID: balanceID, paymentIntentID: paymentIntentID),
    );

    print('Response: $response');

    await response.fold(
      (BalanceEntity l) async {
        print('BalanceEntity: $l');
        emit(state.copyWith(balanceEntity: l));
        AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), 'Top up success',
            callback: () {
          // instance.get<NavigationService>().pop();
        });
      },
      (Failure r) async {
        print('Failure: $r');
        AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), r.message);
      },
    );
  }
}
