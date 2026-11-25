import 'dart:async';

import 'package:flutter/material.dart';

class DeBouncer {
  final int milliseconds;
  VoidCallback? _action;
  Timer? _timer;

  DeBouncer({required this.milliseconds});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
