import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/extensions/number.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/utils/utils.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/data/balance/models/create_payment_rqst.dart';
import 'package:wflow/modules/main/data/balance/models/create_payment_rsp.dart';
import 'package:wflow/modules/main/domain/balance/balance_usecase.dart';
import 'package:wflow/modules/main/presentation/home/balance/bloc/bloc.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  late final BalanceUseCase balanceUseCase;

  @override
  initState() {
    balanceUseCase = instance.get<BalanceUseCase>();
    super.initState();
  }

  Future<void> createPaymentSheet() async {
    try {
      final customerID = instance.get<AppBloc>().state.userEntity.customerID;

      final response = await balanceUseCase.createPaymentSheet(
        request: CreatePaymentSheetRequest(customer: customerID, amount: 200000),
      );

      response.fold(
        (CreatePaymentSheetResponse createPaymentSheetResponse) {
          initPaymentSheet(createPaymentSheetResponse);
        },
        (Failure failure) {
          AlertUtils.showMessage('Notification', failure.message);
        },
      );
    } catch (exception) {
      AlertUtils.showMessage('Notification', exception.toString());
    }
  }

  Future<void> initPaymentSheet(CreatePaymentSheetResponse createPaymentSheetResponse) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        customFlow: false,
        merchantDisplayName: 'Flutter Stripe Store Demo',
        paymentIntentClientSecret: createPaymentSheetResponse.paymentIntent,
        customerEphemeralKeySecret: createPaymentSheetResponse.ephemeralKey,
        customerId: createPaymentSheetResponse.customer,
        allowsDelayedPaymentMethods: true,
      ),
    );

    await Stripe.instance.presentPaymentSheet();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocProvider(
      create: (_) => BalanceBloc(balanceUseCase: instance.get<BalanceUseCase>())..add(BalanceEventFetch()),
      child: CommonScaffold(
        isSafe: true,
        appBar: const AppHeader(
          text: 'Balance',
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                  height: 230,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromRGBO(0, 122, 192, 0.459),
                        Color.fromRGBO(37, 142, 0, 0.46),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: BlocBuilder<BalanceBloc, BalanceState>(
                    builder: (context, state) {
                      return Stack(
                        children: [
                          Positioned(
                            top: 20.h,
                            left: 20.w,
                            child: Text(
                              'WFlow',
                              style: themeData.textTheme.displayLarge!.copyWith(
                                color: Colors.white,
                                fontSize: 26,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20.h,
                            right: 20.w,
                            child: SizedBox(
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    AppConstants.ic_mastercard,
                                  ),
                                  10.horizontalSpace,
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Top Up',
                                            style: themeData.textTheme.displayLarge!.copyWith(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                          8.horizontalSpace,
                                          InkWell(
                                            onTap: () => Navigator.of(context).pushNamed(RouteKeys.stripeScreen),
                                            child: SvgPicture.asset(
                                              AppConstants.ic_top_up,
                                              height: 24,
                                              width: 24,
                                            ),
                                          ),
                                        ],
                                      ),
                                      10.verticalSpace,
                                      Row(
                                        children: [
                                          Text(
                                            'Pay Out',
                                            style: themeData.textTheme.displayLarge!.copyWith(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                          8.horizontalSpace,
                                          SvgPicture.asset(
                                            AppConstants.ic_pay_out,
                                            height: 24,
                                            width: 24,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 32.h,
                            right: 32.w,
                            child: SvgPicture.asset(AppConstants.ic_balancew),
                          ),
                          Positioned(
                            bottom: 20.h,
                            right: 20,
                            child: Text(
                              state.balanceEntity.amount.toVND(),
                              style: themeData.textTheme.displayLarge!.copyWith(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          BlocBuilder<AppBloc, AppState>(
                            bloc: instance.get<AppBloc>(),
                            builder: (context, state) {
                              return Positioned(
                                bottom: 40.h,
                                left: 20,
                                child: Text(
                                  state.userEntity.name,
                                  style: themeData.textTheme.displayLarge!.copyWith(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            bottom: 20.h,
                            left: 20,
                            child: Text(
                              '#${state.balanceEntity.customerID}',
                              style: themeData.textTheme.displayLarge!.copyWith(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  )),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
