import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Icon? icon;
  final Color? primary;
  final VoidCallback? onPressed;

  const CircleButton({
    super.key,
    required this.icon,
    required this.primary,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(15.0),
        backgroundColor: primary,
        shape: const CircleBorder(),
      ),
      child: icon,
    );
  }
}
