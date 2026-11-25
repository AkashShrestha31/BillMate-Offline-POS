import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';

/// SnackBars on the page [Scaffold] sit under modal sheets. This paints on the
/// root [Overlay] so the toast stays visible.
class AboveSheetSnack {
  static OverlayEntry? _entry;
  static Timer? _timer;

  static void hide() {
    _timer?.cancel();
    _timer = null;
    _entry?.remove();
    _entry = null;
  }

  static void showSuccess(BuildContext context, String message) {
    final scheme = Theme.of(context).colorScheme;
    _show(
      context,
      message: message,
      backgroundColor: scheme.primary,
      textColor: scheme.onPrimary,
    );
  }

  static void showError(BuildContext context, String message) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = scheme.brightness == Brightness.dark;
    _show(
      context,
      message: message,
      backgroundColor: isDark ? scheme.errorContainer : scheme.error,
      textColor: isDark ? scheme.onErrorContainer : scheme.onError,
    );
  }

  static void showWarning(BuildContext context, String message) {
    final scheme = Theme.of(context).colorScheme;
    _show(
      context,
      message: message,
      backgroundColor: scheme.inverseSurface,
      textColor: scheme.onInverseSurface,
    );
  }

  static void _show(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
    required Color textColor,
  }) {
    hide();
    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (overlay == null) {
      if (context.mounted) context.showKiiSnackBarError(message);
      return;
    }

    _entry = OverlayEntry(
      builder: (overlayContext) {
        final bottom = MediaQuery.paddingOf(overlayContext).bottom;
        return Positioned(
          left: 8,
          right: 8,
          bottom: bottom + 8,
          child: Material(
            color: backgroundColor,
            elevation: 6,
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 4, 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      message,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    icon: Icon(Icons.close, color: textColor),
                    onPressed: hide,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    overlay.insert(_entry!);
    _timer = Timer(const Duration(seconds: 3), hide);
  }
}
