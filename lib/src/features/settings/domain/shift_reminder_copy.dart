import 'package:flutter/material.dart';
import 'package:hotel/l10n/app_localizations.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/l10n/app_locale_service.dart';

/// Shared opening / closing reminder text for push notifications and in-app dialogs.
abstract final class ShiftReminderCopy {
  static AppLocalizations _l10n() {
    final code = getIt<AppLocaleService>().languageCode;
    return lookupAppLocalizations(Locale(code));
  }

  static String get openingNotificationTitle =>
      _l10n().shiftReminderOpeningNotificationTitle;

  static String get openingNotificationBody =>
      _l10n().shiftReminderOpeningNotificationBody;

  static String get closingNotificationTitle =>
      _l10n().shiftReminderClosingNotificationTitle;

  static String get closingNotificationBody =>
      _l10n().shiftReminderClosingNotificationBody;

  static String get openingDialogTitle => _l10n().shiftReminderOpeningTitle;

  static String get openingDialogMessage => _l10n().shiftReminderOpeningMessage;

  static String get openingProceedLabel => _l10n().shiftReminderOpeningProceed;

  static String get closingDialogTitle => _l10n().shiftReminderClosingTitle;

  static String get closingDialogMessage => _l10n().shiftReminderClosingMessage;

  static String get closingProceedLabel => _l10n().shiftReminderClosingProceed;
}
