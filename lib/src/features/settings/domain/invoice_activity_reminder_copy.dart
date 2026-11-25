import 'package:flutter/material.dart';
import 'package:hotel/l10n/app_localizations.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/l10n/app_locale_service.dart';

/// Shared sales/purchase activity reminder text for notifications and dialogs.
abstract final class InvoiceActivityReminderCopy {
  static AppLocalizations _l10n() {
    final code = getIt<AppLocaleService>().languageCode;
    return lookupAppLocalizations(Locale(code));
  }

  static String get notificationTitle =>
      _l10n().invoiceActivityReminderNotificationTitle;

  static String get notificationBody =>
      _l10n().invoiceActivityReminderNotificationBody;

  static String get dialogTitle => _l10n().invoiceActivityReminderTitle;

  static String get dialogMessage => _l10n().invoiceActivityReminderMessage;

  static String get proceedLabel => _l10n().invoiceActivityReminderProceed;

  static String get addSalesLabel => _l10n().invoiceActivityReminderAddSales;

  static String get addPurchaseLabel =>
      _l10n().invoiceActivityReminderAddPurchase;
}
