import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/navigation/root_navigator.dart';
import 'package:hotel/src/core/services/notifications/shift_notification_service.dart';
import 'package:hotel/src/features/settings/domain/invoice_activity_reminder_dismiss_storage.dart';
import 'package:hotel/src/features/settings/domain/invoice_activity_reminder_status.dart';
import 'package:hotel/src/features/settings/domain/shift_notification_settings_storage.dart';
import 'package:hotel/src/features/settings/domain/shift_reminder_dismiss_storage.dart';
import 'package:hotel/src/features/settings/domain/shift_reminder_status.dart';
import 'package:hotel/src/features/settings/presentation/widgets/invoice_activity_reminder_prompts.dart';
import 'package:hotel/src/features/settings/presentation/widgets/shift_reminder_prompts.dart';

/// Shows in-app opening / closing / activity prompts after the scheduled time.
class ShiftReminderMonitor {
  ShiftReminderMonitor();

  Timer? _periodicTimer;
  bool _promptVisible = false;
  bool _checkInFlight = false;
  bool _started = false;

  void start() {
    if (_started) return;
    _started = true;
    _periodicTimer?.cancel();
    _periodicTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      unawaited(checkAndPrompt());
    });
    Future<void>.delayed(const Duration(seconds: 1), checkAndPrompt);
  }

  void stop() {
    _periodicTimer?.cancel();
    _periodicTimer = null;
    _started = false;
  }

  void onAppResumed() {
    unawaited(checkAndPrompt());
  }

  Future<void> checkAndPrompt() async {
    if (_promptVisible || _checkInFlight) return;
    _checkInFlight = true;
    try {
      await _checkAndPromptLocked();
    } finally {
      _checkInFlight = false;
    }
  }

  Future<void> _checkAndPromptLocked() async {
    if (getIt<ShiftNotificationService>().shouldSuppressMonitorPrompt()) return;
    if (!await RootNavigator.canShowGlobalDialog()) return;

    final context = RootNavigator.context;
    if (context == null || !context.mounted) return;

    final settings = await ShiftNotificationSettingsStorage.load();
    final now = TimeOfDay.now();

    if (settings.openingEnabled && _isPastOrAt(now, settings.openingTime)) {
      if (!await ShiftReminderDismissStorage.isOpeningDismissedForToday()) {
        if (await ShiftReminderStatus.needsOpeningToday()) {
          if (!context.mounted) return;
          log('ShiftReminderMonitor: showing opening prompt');
          await _runPrompt(() => ShiftReminderPrompts.showOpening(context));
          return;
        }
      }
    }

    if (settings.closingEnabled && _isPastOrAt(now, settings.closingTime)) {
      if (!await ShiftReminderDismissStorage.isClosingDismissedForToday()) {
        if (await ShiftReminderStatus.needsClosingToday()) {
          if (!context.mounted) return;
          log('ShiftReminderMonitor: showing closing prompt');
          await _runPrompt(() => ShiftReminderPrompts.showClosing(context));
          return;
        }
      }
    }

    if (settings.activityEnabled && _isPastOrAt(now, settings.activityTime)) {
      if (!await InvoiceActivityReminderDismissStorage.isDismissedForToday()) {
        if (await InvoiceActivityReminderStatus.needsActivityToday()) {
          if (!context.mounted || _promptVisible) return;
          log('ShiftReminderMonitor: showing activity prompt');
          await _runPrompt(() => InvoiceActivityReminderPrompts.show(context));
        }
      }
    }
  }

  Future<void> _runPrompt(Future<void> Function() showPrompt) async {
    _promptVisible = true;
    try {
      await showPrompt();
    } finally {
      _promptVisible = false;
    }
  }

  static bool _isPastOrAt(TimeOfDay now, TimeOfDay scheduled) {
    final nowMinutes = now.hour * 60 + now.minute;
    final scheduledMinutes = scheduled.hour * 60 + scheduled.minute;
    return nowMinutes >= scheduledMinutes;
  }
}
