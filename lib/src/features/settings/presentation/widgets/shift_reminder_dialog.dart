import 'package:flutter/material.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

enum ShiftReminderDialogAction { cancel, dismissToday, proceed }

/// Styled shift opening / closing reminder dialog.
Future<ShiftReminderDialogAction?> showShiftReminderDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String proceedLabel,
  required IconData icon,
  Color? iconTint,
}) {
  final theme = Theme.of(context);
  final tint = iconTint ?? theme.colorScheme.primary;
  final l10n = context.l10n;

  return showDialog<ShiftReminderDialogAction>(
    context: context,
    useRootNavigator: true,
    barrierDismissible: false,
    barrierColor: Colors.black.withValues(alpha: 0.45),
    builder: (ctx) {
      return Dialog(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(horizontal: 28),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: tint.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: tint, size: 32),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 28),
              CustomButtonWidget(
                width: double.infinity,
                title: proceedLabel,
                onPressed: () => Navigator.pop(ctx, ShiftReminderDialogAction.proceed),
              ),
              const SizedBox(height: 10),
              CustomButtonWidget.outlined(
                width: double.infinity,
                title: l10n.shiftReminderSkipToday,
                onPressed: () => Navigator.pop(ctx, ShiftReminderDialogAction.dismissToday),
              ),
              const SizedBox(height: 4),
              TextButton(
                onPressed: () => Navigator.pop(ctx, ShiftReminderDialogAction.cancel),
                style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.onSurfaceVariant,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                child: Text(
                  l10n.cancel,
                  style: AppFonts.interStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
