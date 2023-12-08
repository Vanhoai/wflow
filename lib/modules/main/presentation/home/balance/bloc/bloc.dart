import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/core/utils/utils.dart';
import 'package:wflow/modules/main/data/balance/models/create_payment_rqst.dart';
import 'package:wflow/modules/main/data/balance/models/create_payment_rsp.dart';
import 'package:wflow/modules/main/data/balance/models/update_balance_rqst.dart';
import 'package:wflow/modules/main/domain/balance/balance_usecase.dart';
import 'package:wflow/modules/main/domain/balance/entities/balance_entity.dart';
import 'package:wflow/modules/main/domain/tracking/entities/tracking_entity.dart';
import 'package:wflow/modules/main/domain/tracking/tracking_usecase.dart';

part 'event.dart';
part 'state.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  final BalanceUseCase balanceUseCase;
  final TrackingUseCase trackingUseCase;

  BalanceBloc({required this.balanceUseCase, required this.trackingUseCase})
      : super(
          BalanceState(
            balanceEntity: BalanceEntity.empty(),
            isLoading: false,
            trackingEntities: const [],
          ),
        ) {
    on<BalanceEventFetch>(onFetch);
    on<BalanceTopUpEvent>((event, emit) async {
      await onTopUp(event, emit);
    });
    on<BalancePayOutEvent>((event, emit) async {
      await onPayOut(event, emit);
    });
    on<TrackingEventFetch>(getTrackingList);
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
          await initPaymentSheet(createPaymentSheetResponse, event.amount, emit, 1);
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

  FutureOr<void> onPayOut(BalancePayOutEvent event, Emitter<BalanceState> emit) async {
    try {
      final response = await balanceUseCase.createPaymentSheet(
        request: CreatePaymentSheetRequest(customer: state.balanceEntity.customerID, amount: event.amount),
      );

      await response.fold(
        (CreatePaymentSheetResponse createPaymentSheetResponse) async {
          await initPaymentSheet(createPaymentSheetResponse, event.amount, emit, 2);
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
      CreatePaymentSheetResponse createPaymentSheetResponse, num amount, Emitter<BalanceState> emit, int type) async {
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
      // 1: Top up
      // 2: Pay out
      await checkPaymentStatus(emit,
          amount: amount,
          balanceID: state.balanceEntity.id,
          paymentIntentID: createPaymentSheetResponse.paymentIntentID,
          type: type);
    }
  }

  Future<void> checkPaymentStatus(Emitter<BalanceState> emit,
      {required num amount, required num balanceID, required String paymentIntentID, required int type}) async {
    // 1: Top up
    // 2: Pay out
    var response;
    if (type == 1) {
      response = await balanceUseCase.topUpBalance(
        request: UpdateBalanceRequest(amount: amount, balanceID: balanceID, paymentIntentID: paymentIntentID),
      );
    }else {
      response = await balanceUseCase.payOutBalance(
        request: UpdateBalanceRequest(amount: amount, balanceID: balanceID, paymentIntentID: paymentIntentID),
      );
    }

    print('Response: $response');

    await response.fold(
      (BalanceEntity l) async {
        print('BalanceEntity: $l');
        emit(state.copyWith(balanceEntity: l));
        AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), instance.get<AppLocalization>().translate('paymentSucces'),
            callback: () {
          // instance.get<NavigationService>().pop();
        });
        add(TrackingEventFetch(id: '${l.id}'));
      },
      (Failure r) async {
        print('Failure: $r');
        AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), r.message);
      },
    );
  }

  Future getTrackingList(TrackingEventFetch event, Emitter<BalanceState> emit) async {
    emit(state.copyWith(isLoading: true));

    instance.call<AppLoadingBloc>().add(AppShowLoadingEvent());

    final response = await trackingUseCase.findTrackingInBalance(id: event.id);
    response.fold(
      (List<TrackingEntity> l) {
        emit(state.copyWith(trackingEntities: l));
      },
      (Failure r) {
        emit(state.copyWith(trackingEntities: []));
      },
    );

    emit(state.copyWith(isLoading: false));
    instance.call<AppLoadingBloc>().add(AppHideLoadingEvent());
  }
}
