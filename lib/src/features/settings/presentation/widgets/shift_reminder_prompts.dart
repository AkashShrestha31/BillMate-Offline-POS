import 'package:flutter/material.dart';
import 'package:hotel/src/features/opening/presentation/helpers/shift_opening_dialog_helper.dart';
import 'package:hotel/src/features/settings/domain/shift_reminder_copy.dart';
import 'package:hotel/src/features/settings/domain/shift_reminder_dismiss_storage.dart';
import 'package:hotel/src/features/settings/presentation/widgets/shift_reminder_dialog.dart';

/// Opening / closing reminder prompts with [Skip for today], [Cancel], and proceed actions.
abstract final class ShiftReminderPrompts {
  static Future<void> showOpening(BuildContext context) async {
    final action = await showShiftReminderDialog(
      context,
      title: ShiftReminderCopy.openingDialogTitle,
      message: ShiftReminderCopy.openingDialogMessage,
      proceedLabel: ShiftReminderCopy.openingProceedLabel,
      icon: Icons.wb_sunny_rounded,
      iconTint: Theme.of(context).colorScheme.primary,
    );

    if (!context.mounted) return;

    switch (action) {
      case ShiftReminderDialogAction.dismissToday:
        await ShiftReminderDismissStorage.dismissOpeningForToday();
      case ShiftReminderDialogAction.proceed:
        await ShiftOpeningDialogHelper.showOpenDialog(context);
      case ShiftReminderDialogAction.cancel:
      case null:
        break;
    }
  }

  static Future<void> showClosing(BuildContext context) async {
    final action = await showShiftReminderDialog(
      context,
      title: ShiftReminderCopy.closingDialogTitle,
      message: ShiftReminderCopy.closingDialogMessage,
      proceedLabel: ShiftReminderCopy.closingProceedLabel,
      icon: Icons.nightlight_round,
      iconTint: Theme.of(context).colorScheme.primary,
    );

    if (!context.mounted) return;

    switch (action) {
      case ShiftReminderDialogAction.dismissToday:
        await ShiftReminderDismissStorage.dismissClosingForToday();
      case ShiftReminderDialogAction.proceed:
        await ShiftOpeningDialogHelper.showCloseDialog(context);
      case ShiftReminderDialogAction.cancel:
      case null:
        break;
    }
  }
}
