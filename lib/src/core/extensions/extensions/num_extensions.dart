// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:hotel/src/core/services/display_precision/app_money_format.dart';

extension NumX on num {
  Duration get microSeconds => Duration(microseconds: toInt());

  Duration get milliSeconds => Duration(milliseconds: toInt());

  Duration get seconds => Duration(seconds: toInt());

  Duration get minutes => Duration(minutes: toInt());

  Duration get hour => Duration(hours: toInt());

  Future<dynamic> get delayedMicroSeconds async =>
      Future.delayed(toInt().microSeconds);

  Future<dynamic> get delayedMilliSeconds async =>
      Future.delayed(toInt().milliSeconds);

  Future<dynamic> get delayedSeconds async => Future.delayed(toInt().seconds);

  Future<dynamic> get delayedHour async => Future.delayed(toInt().hour);

  EdgeInsets get all => EdgeInsets.all(toDouble());

  Radius get circular => Radius.circular(toDouble());

  BorderRadiusGeometry get rounded => BorderRadius.circular(toDouble());

  // to currency
  String get toCurrency => AppMoneyFormat.formatAmount(toDouble());

  // isNumericOnly
  bool get isNumericOnly => RegExp(r'^-?[0-9]+$').hasMatch(toString());

  String doubleDigitOnTimer() {
    if (this < 10) {
      return '0$this';
    } else {
      return '$this';
    }
  }

  String timerToMinutesAndSeconds() {
    final Duration clockTimer = Duration(seconds: toInt());
    return this == 0
        ? '00:00'
        : '${clockTimer.inMinutes.remainder(60).toInt().doubleDigitOnTimer()}:${clockTimer.inSeconds.remainder(60).toInt().doubleDigitOnTimer()}';
  }
}
