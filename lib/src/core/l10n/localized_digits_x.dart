import 'package:hotel/l10n/app_localizations.dart';
import 'package:hotel/src/core/services/display_precision/app_money_format.dart';

/// Up to [maxDecimals] fraction digits; trims trailing zeros (and a trailing dot).
String trimMoneyAmount(double value, {int maxDecimals = 15}) {
  if (value.isNaN || value.isInfinite) return value.toString();
  final fixed = value.toStringAsFixed(maxDecimals);
  if (!fixed.contains('.')) return fixed;
  var trimmed = fixed.replaceFirst(RegExp(r'0+$'), '');
  if (trimmed.endsWith('.')) {
    trimmed = trimmed.substring(0, trimmed.length - 1);
  }
  return trimmed.isEmpty ? '0' : trimmed;
}

/// Converts Western digits to Devanagari (०–९) when UI locale is Nepali.
extension LocalizedDigitsX on AppLocalizations {
  static const _western = '0123456789';
  static const _devanagari = '०१२३४५६७८९';

  bool get usesDevanagariDigits => localeName == 'ne';

  String localizeDigits(String input) {
    if (!usesDevanagariDigits) return input;
    final buffer = StringBuffer();
    for (final codeUnit in input.codeUnits) {
      final ch = String.fromCharCode(codeUnit);
      final index = _western.indexOf(ch);
      buffer.write(index >= 0 ? _devanagari[index] : ch);
    }
    return buffer.toString();
  }

  String formatCount(num value) => localizeDigits(value.toString());

  String formatDecimal(num value, {int? fractionDigits}) => localizeDigits(
        AppMoneyFormat.formatAmount(value, fractionDigits: fractionDigits),
      );

  String formatCurrency(String formatted) => localizeDigits(formatted);

  String formatMoneyWithSymbol(
    String currencySymbol,
    double value, {
    int? maxDecimals,
  }) =>
      formatCurrency(
        '$currencySymbol ${AppMoneyFormat.formatAmount(value, fractionDigits: maxDecimals)}',
      );

  String localizeMessage(String message) => localizeDigits(message);

  /// Converts Devanagari digits back to Western for parsing/submission.
  String westernizeDigits(String input) {
    if (!usesDevanagariDigits) return input;
    final buffer = StringBuffer();
    for (final codeUnit in input.codeUnits) {
      final ch = String.fromCharCode(codeUnit);
      final index = _devanagari.indexOf(ch);
      buffer.write(index >= 0 ? _western[index] : ch);
    }
    return buffer.toString();
  }
}
