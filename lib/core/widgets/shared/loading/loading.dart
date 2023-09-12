import 'package:flutter/material.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/widgets/custom/custom.dart';

class Loading extends StatefulWidget {
  const Loading({super.key, this.height, this.width});

  final double? height;
  final double? width;

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height,
      width: mediaQuery.size.width,
      color: Colors.transparent,
      child: LottieAnimation(
        animation: AppConstants.lottieLoading,
        height: widget.height ?? mediaQuery.size.height,
        width: widget.width ?? mediaQuery.size.width,
      ),
    );
  }
}

class GlobalLoading extends StatelessWidget {
  const GlobalLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.transparent,
      child: const Center(
        child: LottieAnimation(
          animation: AppConstants.lottieLoading,
          height: 40,
          width: 40,
        ),
      ),
    );
  }
}
