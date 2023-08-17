import 'package:flutter/material.dart';

/// This class is used to create custom animation for page transition
/// You can add your custom animation here and use it
/// Example: slideLeftToRight
/// Usage: Navigator.of(context).push(TransitionPageAnimation.slideLeftToRight(YourPage()));

class TransitionPageAnimation {
  static Route slideLeftToRight(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  // add custom animation for you
}
