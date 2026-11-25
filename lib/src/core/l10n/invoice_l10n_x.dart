import 'package:hotel/l10n/app_localizations.dart';
import 'package:hotel/src/core/l10n/app_localizations_x.dart';
import 'package:hotel/src/core/l10n/localized_digits_x.dart';

extension InvoiceL10nX on AppLocalizations {
  List<String> get invoiceWeekdayLabels => [
        invoiceWeekdaySun,
        invoiceWeekdayMon,
        invoiceWeekdayTue,
        invoiceWeekdayWed,
        invoiceWeekdayThu,
        invoiceWeekdayFri,
        invoiceWeekdaySat,
      ];

  String invoiceMonthYearLabel(DateTime date) => localizeDigits(
        '${shortMonthLabels[date.month - 1]} ${date.year}',
      );

  String invoiceDayMonthYearLabel(DateTime date) => localizeDigits(
        '${shortMonthLabels[date.month - 1]} ${date.day}, ${date.year}',
      );

  String invoiceMonthDayLabel(DateTime date) => localizeDigits(
        '${shortMonthLabels[date.month - 1]} ${date.day}',
      );

  String invoiceDateRangeScopeLabel(DateTime start, DateTime end) {
    final sameMonth =
        start.year == end.year && start.month == end.month;
    if (sameMonth) {
      return '${invoiceMonthDayLabel(start)} - ${formatCount(end.day)}, ${formatCount(end.year)}';
    }
    return '${invoiceDayMonthYearLabel(start)} - ${invoiceDayMonthYearLabel(end)}';
  }
}
