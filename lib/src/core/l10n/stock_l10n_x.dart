import 'package:hotel/l10n/app_localizations.dart';
import 'package:hotel/src/core/helpers/utility.dart';
import 'package:hotel/src/core/l10n/app_localizations_x.dart';
import 'package:hotel/src/core/l10n/invoice_l10n_x.dart';
import 'package:hotel/src/core/l10n/localized_digits_x.dart';

extension StockL10nX on AppLocalizations {
  String _weekdayLabel(DateTime date) => invoiceWeekdayLabels[date.weekday % 7];

  /// e.g. Saturday, Jun 07, 2026
  String stockLongDateLabel(DateTime date) => localizeDigits(
        '${_weekdayLabel(date)}, ${shortMonthLabels[date.month - 1]} ${date.day.toString().padLeft(2, '0')}, ${date.year}',
      );

  /// e.g. Sat, Jun 7, 2026
  String stockShortDateLabel(DateTime date) => localizeDigits(
        '${_weekdayLabel(date)}, ${shortMonthLabels[date.month - 1]} ${date.day}, ${date.year}',
      );

  String stockFormatIndianNumber(num value) =>
      localizeDigits(Utility.formatIndianNumber(value.round()));

  String stockQtyChipLabel(num qty) => stockQtyLabel(stockFormatIndianNumber(qty));

  String stockMoneyChipLabel(String currencySymbol, num value) =>
      formatCurrency('$currencySymbol ${stockFormatIndianNumber(value)}');
}
