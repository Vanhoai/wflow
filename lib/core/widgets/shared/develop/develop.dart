import 'package:flutter/material.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';

class DevelopeScreen extends StatefulWidget {
  const DevelopeScreen({super.key});

  @override
  State<DevelopeScreen> createState() => _DevelopeScreenState();
}

class _DevelopeScreenState extends State<DevelopeScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return CommonScaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: TextGradient(
                label: 'The feature is being developed, please wait for the next update',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                colors: const [
                  AppColors.primary,
                  AppColors.redColor,
                  AppColors.greenColor,
                ],
              ),
            ),
            LottieAnimation(
              animation: AppConstants.developAnim,
              height: size.width * 0.7,
              width: size.width * 0.7,
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PrimaryButton(
                label: 'Go Back',
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
