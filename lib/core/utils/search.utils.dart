import 'dart:async';

import 'package:flutter/material.dart';

class Debounce {
  final Duration duration;

  Debounce({required this.duration});

  Timer? timer;

  void call(VoidCallback voidCallback) {
    if (timer?.isActive ?? false) timer?.cancel();
    timer = Timer(duration, voidCallback);
  }
}
