import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/extensions/number.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/utils/utils.dart';
import 'package:wflow/core/widgets/custom/button/button.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/balance/balance_usecase.dart';
import 'package:wflow/modules/main/domain/tracking/entities/tracking_entity.dart';
import 'package:wflow/modules/main/domain/tracking/tracking_usecase.dart';
import 'package:wflow/modules/main/presentation/home/balance/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/contract/widgets/widget.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key, required this.balanceID});

  final String balanceID;

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  final MoneyMaskedTextController amountController = MoneyMaskedTextController(
      decimalSeparator: '',
      precision: 0,
      initialValue: 0,
      thousandSeparator: '.');

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  // 1: Top up
  // 2: Pay out
  void enterAmountModal(BuildContext parentContext, int option) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return FractionallySizedBox(
              heightFactor: 0.8,
              child: Container(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    topRight: Radius.circular(8.r),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      "Enter Amount to ${option == 1 ? 'Top Up' : 'Pay Out'}",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                    20.verticalSpace,
                    TextFieldHelper(
                      enabled: true,
                      controller: amountController,
                      minLines: 1,
                      maxLines: 1,
                      hintText: 'Enter amount',
                      keyboardType: TextInputType.number,
                    ),
                    24.verticalSpace,
                    PrimaryButton(
                      label: 'Confirm',
                      onPressed: () {
                        if (amountController.text.isNotEmpty) {
                          if (option == 1) {
                            parentContext.read<BalanceBloc>().add(
                                BalanceTopUpEvent(
                                    amountController.numberValue.toInt()));
                          } else {}
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocProvider(
      create: (_) => BalanceBloc(
        balanceUseCase: instance.get<BalanceUseCase>(),
        trackingUseCase: instance.get<TrackingUseCase>(),
      )
        ..add(BalanceEventFetch(id: widget.balanceID))
        ..add(TrackingEventFetch(id: widget.balanceID)),
      child: CommonScaffold(
        isSafe: true,
        appBar: AppHeader(
          text: Text(
            instance.get<AppLocalization>().translate('balance') ?? 'Balance',
            style: themeData.textTheme.displayLarge,
          ),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
                            child: Column(
                              children: [
                                Text(
                                  'WFlow',
                                  style: themeData.textTheme.displayLarge!
                                      .copyWith(
                                    color: Colors.white,
                                    fontSize: 26,
                                  ),
                                ),
                                12.verticalSpace,
                                SvgPicture.asset(
                                  AppConstants.ic_mastercard,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 20.h,
                            right: 20.w,
                            child: SizedBox(
                              child: Row(
                                children: [
                                  10.horizontalSpace,
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () =>
                                            enterAmountModal(context, 1),
                                        child: Row(
                                          children: [
                                            Text(
                                              instance
                                                      .get<AppLocalization>()
                                                      .translate('topUp') ??
                                                  'Top Up',
                                              style: themeData
                                                  .textTheme.displayLarge!
                                                  .copyWith(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                            8.horizontalSpace,
                                            SvgPicture.asset(
                                              AppConstants.ic_top_up,
                                              height: 24,
                                              width: 24,
                                            ),
                                          ],
                                        ),
                                      ),
                                      10.verticalSpace,
                                      InkWell(
                                        onTap: () =>
                                            enterAmountModal(context, 2),
                                        child: Row(
                                          children: [
                                            Text(
                                              instance
                                                      .get<AppLocalization>()
                                                      .translate('payOut') ??
                                                  'Pay Out',
                                              style: themeData
                                                  .textTheme.displayLarge!
                                                  .copyWith(
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
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 24.h,
                            right: 20.w,
                            child: SvgPicture.asset(
                              AppConstants.ic_balancew,
                            ),
                          ),
                          BlocBuilder<AppBloc, AppState>(
                            bloc: instance.get<AppBloc>(),
                            builder: (context, state) {
                              return Positioned(
                                bottom: 30.h,
                                left: 20.w,
                                child: Text(
                                  state.userEntity.name,
                                  style: themeData.textTheme.displayLarge!
                                      .copyWith(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            bottom: 10.h,
                            left: 20.w,
                            child: Text(
                              '#${state.balanceEntity.customerID}',
                              style: themeData.textTheme.displayLarge!.copyWith(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10.h,
                            right: 20.w,
                            child: Text(
                              state.balanceEntity.amount.toVND(),
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Text(
                      instance
                              .get<AppLocalization>()
                              .translate('transactionHistory') ??
                          'Transaction History',
                      style: themeData.textTheme.displayMedium,
                    ),
                  ],
                ),
              ),
              20.verticalSpace,
              BlocBuilder<BalanceBloc, BalanceState>(
                buildWhen: (previous, current) =>
                    previous.isLoading != current.isLoading ||
                    previous.trackingEntities != current.trackingEntities,
                builder: (context, state) => Visibility(
                  visible: !state.isLoading,
                  replacement: Expanded(
                    child: Shimmer.fromColors(
                      baseColor:
                          themeData.colorScheme.onBackground.withOpacity(0.1),
                      highlightColor:
                          themeData.colorScheme.onBackground.withOpacity(0.05),
                      child: ListView.separated(
                        itemCount: 10,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 2.h),
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => 12.verticalSpace,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: themeData.colorScheme.background,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 40.w,
                                  width: 40.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color:
                                        AppColors.greenColor.withOpacity(0.2),
                                  ),
                                  child: SvgPicture.asset(
                                    AppConstants.transaction,
                                    height: 24.w,
                                    width: 24.w,
                                  ),
                                ),
                                12.horizontalSpace,
                                Container(
                                  height: 12,
                                  width: 12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppColors.greenColor,
                                  ),
                                ),
                                12.horizontalSpace,
                                Container(
                                  height: 12,
                                  width: 12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppColors.greenColor,
                                  ),
                                ),
                                12.horizontalSpace,
                                Container(
                                  height: 12,
                                  width: 12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppColors.greenColor,
                                  ),
                                ),
                                12.horizontalSpace,
                                Container(
                                  height: 12,
                                  width: 12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppColors.greenColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: state.trackingEntities.length,
                      padding: EdgeInsets.only(top: 2.h, bottom: 20),
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final TrackingEntity trackingEntity =
                            state.trackingEntities[index];
                        final date = DateFormat('dd/MM/yyyy').format(
                            DateTime.parse(
                                trackingEntity.createdAt.toString()));
                        final time = DateFormat('HH:mm:ss').format(
                            DateTime.parse(
                                trackingEntity.createdAt.toString()));

                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 4.h),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: themeData.colorScheme.background,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 40.w,
                                width: 40.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: trackingEntity.action == 'TOP_UP'
                                      ? AppColors.greenColor.withOpacity(0.2)
                                      : AppColors.redColor.withOpacity(0.2),
                                ),
                                child: SvgPicture.asset(
                                  AppConstants.transaction,
                                  height: 24.w,
                                  width: 24.w,
                                  colorFilter: ColorFilter.mode(
                                    trackingEntity.action == 'TOP_UP'
                                        ? AppColors.greenColor.withOpacity(0.8)
                                        : AppColors.redColor.withOpacity(0.8),
                                    BlendMode.srcATop,
                                  ),
                                ),
                              ),
                              12.horizontalSpace,
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    if (trackingEntity.action == 'TOP_UP') ...[
                                      Text(instance
                                              .get<AppLocalization>()
                                              .translate('topUp') ??
                                          'Top Up')
                                    ] else ...[
                                      Text(instance
                                              .get<AppLocalization>()
                                              .translate('payOut') ??
                                          'Pay Out')
                                    ],
                                    Text(
                                      trackingEntity.state == 'SUCCESS'
                                          ? instance
                                                  .get<AppLocalization>()
                                                  .translate('Success') ??
                                              'Success'
                                          : instance
                                                  .get<AppLocalization>()
                                                  .translate('Failed') ??
                                              'Failed',
                                      style: TextStyle(
                                        color: trackingEntity.action == 'TOP_UP'
                                            ? AppColors.greenColor
                                            : AppColors.redColor,
                                      ),
                                    ),
                                    Text(
                                        '${StringsUtil.parseMoney(trackingEntity.amount.toString())} VND')
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(date,
                                      style:
                                          themeData.textTheme.displayMedium!),
                                  4.verticalSpace,
                                  Text(time,
                                      style:
                                          themeData.textTheme.displayMedium!),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
