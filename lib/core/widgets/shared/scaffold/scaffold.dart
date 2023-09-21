import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonScaffold extends StatelessWidget {
  const CommonScaffold({
    required this.body,
    this.isSafe = false,
    this.hideKeyboardWhenTouchOutside = false,
    super.key,
  });

  final Widget body;
  final bool isSafe;
  final bool hideKeyboardWhenTouchOutside;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        if (hideKeyboardWhenTouchOutside) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: isSafe
          ? SafeArea(
              child: Scaffold(
                body: body,
              ),
            )
          : Scaffold(
              body: body,
            ),
    );
  }
}
