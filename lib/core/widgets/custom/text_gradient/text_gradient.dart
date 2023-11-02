import 'package:flutter/material.dart';

class TextGradient extends StatefulWidget {
  const TextGradient({
    super.key,
    required this.label,
    required this.style,
    required this.colors,
    this.textAlign = TextAlign.center,
  });

  final String label;
  final TextStyle style;
  final List<Color> colors;
  final TextAlign textAlign;

  @override
  State<TextGradient> createState() => _TextGradientState();
}

class _TextGradientState extends State<TextGradient> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController)
      ..addListener(() {
        setState(() {});
      });

    animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    animation.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ShaderMask(
        child: Text(
          widget.label,
          style: widget.style,
          textAlign: widget.textAlign,
        ),
        shaderCallback: (rect) {
          return LinearGradient(
            stops: [animation.value - 0.5, animation.value, animation.value + 0.5],
            colors: widget.colors,
          ).createShader(rect);
        },
      ),
    );
  }
}
