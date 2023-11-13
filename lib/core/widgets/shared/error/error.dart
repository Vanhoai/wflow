import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key, required this.onPressed});

  final Function onPressed;

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      isSafe: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        alignment: Alignment.center,
        color: Colors.white,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextGradient(
                  label: 'Có lỗi xảy ra !!',
                  style: TextStyle(
                    fontSize: 24.sp,
                  ),
                  colors: const [
                    AppColors.primary,
                    AppColors.greenColor,
                    AppColors.blueColor,
                  ],
                ),
                12.verticalSpace,
                Text(
                  'Chúng tôi sẽ cố gắng sớm khắc phục vấn đề của bạn !',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
                12.verticalSpace,
                LottieAnimation(
                  animation: AppConstants.errorAnim,
                  height: MediaQuery.of(context).size.width * 0.7,
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
              ],
            ),
            Positioned(
              bottom: 20.h,
              left: 0,
              right: 0,
              child: PrimaryButton(
                label: 'Trở về',
                onPressed: widget.onPressed,
              ),
            )
          ],
        ),
      ),
    );
  }
}
