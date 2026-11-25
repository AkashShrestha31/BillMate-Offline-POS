import 'package:flutter/material.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/themes/app_colors.dart';
import 'package:hotel/src/core/themes/app_theme.dart';

/// A utility class that provides common decoration styles such as box shadows
/// and box decorations.
///
/// This class is designed to encapsulate reusable styles for containers, cards,
/// and other UI elements in the app, ensuring a consistent look and feel.
class CustomDecorations {
  /// A private constructor to prevent instantiation.
  ///
  /// This class is meant to be used statically.
  CustomDecorations._();

  /// Creates a reusable [BoxShadow] for container decorations.
  ///
  /// The shadow has a default blur radius of 6 and uses the color specified by
  /// the app's light theme. You can override the color by providing a [color]
  /// parameter.
  ///
  /// Example:
  /// ```dart
  /// BoxShadow shadow = CustomDecorations.containerBoxShadow(color: Colors.grey);
  /// ```
  static BoxShadow containerBoxShadow({Color? color}) => BoxShadow(
        blurRadius: 6,
        color: color ?? AppTheme.lightThemeData.colorScheme.shadow,
      );

  static Border allBorder(
          {required BuildContext context, Color? color, double? width}) =>
      Border.all(
        color: color ?? context.colorScheme.outlineVariant,
        width: width ?? 1,
      );

  static List<BoxShadow> uploadDocContainerBoxShadow(
          {required BuildContext context, Color? color}) =>
      [
        BoxShadow(
          color: color ?? context.colorScheme.shadow.withOpacity(0.15),
          blurRadius: 3,
          spreadRadius: 1,
          offset: Offset(0, 1),
        ),
        BoxShadow(
          color: color ?? context.colorScheme.shadow.withOpacity(0.3),
          blurRadius: 2,
          spreadRadius: 0,
          offset: Offset(0, 1),
        )
      ];

  /// Creates a reusable [BoxDecoration] for card-like UI components.
  ///
  /// This decoration includes:
  /// - A background color (default: [AppColors.whiteColor]).
  /// - A border radius of 16 pixels for rounded corners.
  /// - A shadow using [containerBoxShadow].
  ///
  /// Example:
  /// ```dart
  /// BoxDecoration cardDecoration = CustomDecorations.cardBoxDecoration(
  ///   backgroundColor: Colors.blue,
  /// );
  /// ```
  ///
  /// Parameters:
  /// - [backgroundColor]: The background color of the decoration. Defaults to [AppColors.whiteColor].
  static BoxDecoration cardBoxDecoration(
          {Color? backgroundColor = AppColors.whiteColor,
          BorderRadius? radius = allRadiusLarge}) =>
      BoxDecoration(
        boxShadow: [containerBoxShadow()],
        color: backgroundColor,
        borderRadius: radius,
      );
}
