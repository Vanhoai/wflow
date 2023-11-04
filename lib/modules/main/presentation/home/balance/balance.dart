import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/widgets/shared/shared.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return CommonScaffold(
      appBar: const AppHeader(
        text: 'Balance',
        actions: [],
      ),
      isSafe: true,
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
              child: Stack(
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
                                    onTap: () {},
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
                      '92837434 VND',
                      style: themeData.textTheme.displayLarge!.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 40.h,
                    left: 20,
                    child: Text(
                      'Trần Văn Hoài',
                      style: themeData.textTheme.displayLarge!.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20.h,
                    left: 20,
                    child: Text(
                      '#6011000000000',
                      style: themeData.textTheme.displayLarge!.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
