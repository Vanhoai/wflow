import 'package:flutter/material.dart';

class CommonScaffold extends StatelessWidget {
  const CommonScaffold({
    required this.body,
    this.isSafe = false,
    this.hideKeyboardWhenTouchOutside = false,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
    super.key,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final bool isSafe;
  final bool hideKeyboardWhenTouchOutside;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

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
                appBar: appBar,
                bottomNavigationBar: bottomNavigationBar,
              ),
            )
          : Scaffold(
              body: body,
              appBar: appBar,
              floatingActionButton: floatingActionButton,
              bottomNavigationBar: bottomNavigationBar,
            ),
    );
  }
}
