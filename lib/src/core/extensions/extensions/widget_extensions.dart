import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

extension WidgetX on Widget {
  Padding px(double padding) => Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: this,
      );

  Padding py(double padding) => Padding(
        padding: EdgeInsets.symmetric(vertical: padding),
        child: this,
      );

  Padding padSymmetric({required double hPadding, required double vPadding}) =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
        child: this,
      );

  Padding pOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      Padding(
        padding:
            EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
        child: this,
      );

  Padding padAll(double value) => Padding(
        padding: EdgeInsets.all(value),
        child: this,
      );

  Widget shimmer({bool show = true}) => show
      ? Skeletonizer.zone(
          child: Skeletonizer(
            enabled: true,
            justifyMultiLineText: true,
            child: this,
          ),
        )
      : this;
}
