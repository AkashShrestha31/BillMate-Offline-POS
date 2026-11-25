import 'package:flutter/widgets.dart';
import 'package:hotel/l10n/app_localizations.dart';
export 'package:hotel/src/core/l10n/app_localizations_x.dart';
export 'package:hotel/src/core/l10n/invoice_l10n_x.dart';
export 'package:hotel/src/core/l10n/localized_digits_x.dart';
export 'package:hotel/src/core/l10n/stock_l10n_x.dart';
export 'package:hotel/src/core/l10n/item_l10n_x.dart';
export 'package:hotel/src/core/l10n/payment_l10n_x.dart';
export 'package:hotel/src/core/l10n/closing_l10n_x.dart';

extension LocalizationExtension on BuildContext {
  /// Provides access to the AppLocalizations instance.
  AppLocalizations get l10n => AppLocalizations.of(this)!;
  Size get dynamicSize => MediaQuery.of(this).size;
}
