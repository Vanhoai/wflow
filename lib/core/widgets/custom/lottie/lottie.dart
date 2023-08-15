import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimation extends StatefulWidget {
  const LottieAnimation({super.key, required this.animation, required this.height, required this.width});

  final String animation;
  final double height;
  final double width;

  @override
  State<LottieAnimation> createState() => _LottieAnimationState();
}

class _LottieAnimationState extends State<LottieAnimation> {
  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(
      widget.animation,
      height: widget.height,
      width: widget.width,
      animate: true,
      repeat: true,
    );
  }
}
