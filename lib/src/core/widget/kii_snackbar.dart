import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/extensions/extensions/theme_extensions.dart';
import 'package:hotel/src/core/extensions/extensions/theme_getter_extension.dart';

/// [kiiSnackBar] class provides methods to create custom SnackBars for the Kiibank application.
///It has four main states.
///[success], [error], [warning], [info] and same states with icon.

class KiiSnackBar {
  /// Method to create a success SnackBar
  static SnackBar success(
          {required BuildContext context, required String message}) {
    final scheme = context.theme.colorScheme;
    return kiiSnackBar(
      context: context,
      message: message,
      backgroundColor: scheme.primary,
      textColor: scheme.onPrimary,
      showCloseIcon: true,
      showIcon: false,
    );
  }

  /// Method to create an error SnackBar
  static SnackBar error(
          {required BuildContext context, required String message}) {
    final scheme = context.theme.colorScheme;
    final isDark = scheme.brightness == Brightness.dark;
    return kiiSnackBar(
      context: context,
      message: message,
      backgroundColor: isDark ? scheme.errorContainer : scheme.error,
      textColor: isDark ? scheme.onErrorContainer : scheme.onError,
      showCloseIcon: true,
      showIcon: false,
    );
  }

  /// Method to create a warning SnackBar
  static SnackBar warning(
          {required BuildContext context, required String message}) =>
      kiiSnackBar(
        context: context,
        message: message,
        backgroundColor: context.theme.colorScheme.inverseSurface,
        textColor: context.theme.colorScheme.onInverseSurface,
        showCloseIcon: true,
        showIcon: false,
      );

  /// Method to create an info SnackBar
  static SnackBar info(
          {required BuildContext context, required String message}) =>
      kiiSnackBar(
        context: context,
        message: message,
        backgroundColor: context.theme.colorScheme.inverseSurface,
        textColor: context.theme.colorScheme.onInverseSurface,
        showCloseIcon: true,
        showIcon: false,
      );

  /// Method to create a custom SnackBar
  static kiiSnackBar({
    required BuildContext context,
    required String? message,
    bool showIcon = false,
    bool showCloseIcon = true,
    required Color backgroundColor,
    Color? textColor,
    Color? foregroundColor,
    Color? iconBackgroundColor,
    Widget? prefixIcon,
    SnackBarBehavior? snackBarBehavior,
    DismissDirection? dismissDirection,
    Duration? duration,
  }) {
    final resolvedTextColor =
        textColor ?? foregroundColor ?? context.theme.colorScheme.onInverseSurface;
    final iconColor = foregroundColor ?? resolvedTextColor;

    return SnackBar(
        backgroundColor: backgroundColor,
        behavior: snackBarBehavior ?? SnackBarBehavior.floating,
        dismissDirection: dismissDirection ?? DismissDirection.horizontal,
        showCloseIcon: showCloseIcon,
        closeIconColor: resolvedTextColor,
        duration: duration ?? const Duration(seconds: 3),
        margin: EdgeInsets.only(
            left: context.theme.appTheme.spacing8,
            right: context.theme.appTheme.spacing8,
            bottom: context.theme.appTheme.spacing8),
        padding: const EdgeInsets.all(0),
        content: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              showIcon
                  ? Expanded(
                      flex: 2,
                      child: Container(
                        height: context.theme.appTheme.spacing48,
                        color: iconBackgroundColor,
                        child: prefixIcon ??
                            Icon(
                              Icons.check_circle_outlined,
                              color: iconColor,
                            ),
                      ),
                    )
                  : const SizedBox(),
              10.horizontalSpace,
              Expanded(
                flex: 9,
                child: Text(
                  "$message",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(
                    color: resolvedTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
