import 'package:hotel/src/core/helpers/utility.dart';
import 'package:hotel/src/core/services/currency/app_currency_catalog.dart';
import 'package:hotel/src/core/services/display_precision/app_money_format.dart';

/// App-wide currency display (updated from [AppCurrencyService]).
abstract final class AppCurrencyFormatter {
  static String code = AppCurrencyCatalog.defaultCode;
  static String symbol = AppCurrencyCatalog.symbolFor(AppCurrencyCatalog.defaultCode);

  /// ISO → symbol from books DB / currency seed (covers party currencies like FJD → $).
  static final Map<String, String> _symbolsByCode = <String, String>{
    ...AppCurrencyCatalog.symbols,
  };

  static void apply({required String newCode, required String newSymbol}) {
    code = newCode.trim().toUpperCase();
    final trimmedSymbol = newSymbol.trim();
    symbol = trimmedSymbol.isNotEmpty
        ? trimmedSymbol
        : AppCurrencyCatalog.symbolFor(code);
    registerSymbol(code, symbol);
  }

  /// Cache symbols from [Currency] table / seed so party currencies resolve correctly.
  static void registerSymbols(Map<String, String> symbols) {
    for (final entry in symbols.entries) {
      registerSymbol(entry.key, entry.value);
    }
  }

  static void registerSymbol(String currencyCode, String currencySymbol) {
    final key = currencyCode.trim().toUpperCase();
    final value = currencySymbol.trim();
    if (key.isEmpty || value.isEmpty) return;
    _symbolsByCode[key] = value;
  }

  /// e.g. `रू 1,23,456` or `$ 99.50`
  static String format(
    num amount, {
    int? decimals,
    bool useIndianGrouping = true,
    bool includeSymbol = true,
    /// When set, format with that party's/org ISO code instead of reporting currency.
    String? currencyCode,
  }) {
    final negative = amount < 0;
    final absValue = amount.abs();
    final fractionDigits = decimals ?? AppMoneyFormat.displayPrecision;
    final displaySymbol = _resolveSymbol(currencyCode);

    final String body;
    if (fractionDigits > 0) {
      body = absValue.toStringAsFixed(fractionDigits);
    } else if (useIndianGrouping) {
      final asInt = absValue is int ? absValue : absValue.round();
      body = Utility.formatIndianNumber(asInt);
    } else {
      body = absValue.toStringAsFixed(0);
    }

    if (!includeSymbol) return negative ? '-$body' : body;

    final text = '$displaySymbol $body';
    return negative ? '-$text' : text;
  }

  static String _resolveSymbol(String? currencyCode) {
    final resolved = currencyCode?.trim().toUpperCase();
    if (resolved == null || resolved.isEmpty) return symbol;
    if (resolved == code) return symbol;
    final registered = _symbolsByCode[resolved];
    if (registered != null && registered.isNotEmpty) return registered;
    return AppCurrencyCatalog.symbolFor(resolved);
  }

  /// Symbol for a party/org currency code, falling back to reporting symbol.
  static String symbolForCode(String? currencyCode) =>
      _resolveSymbol(currencyCode);

  /// ASCII symbol for PDF / Helvetica (e.g. `रू` → `Rs`).
  static String pdfSymbol() => pdfSymbolForCode(code);

  /// ASCII-safe symbol for [currencyCode], falling back to reporting currency.
  static String pdfSymbolForCode(String? currencyCode) {
    final resolved = (currencyCode?.trim().isNotEmpty == true)
        ? currencyCode!.trim().toUpperCase()
        : code;
    final s = symbolForCode(resolved).trim();
    if (s.isNotEmpty && s.runes.every((r) => r < 128)) return s;
    return switch (resolved) {
      'NPR' => 'Rs',
      'INR' => 'Rs',
      'USD' => r'$',
      'EUR' => 'EUR',
      'GBP' => 'GBP',
      _ => resolved.isNotEmpty ? resolved : 'Rs',
    };
  }

  /// Money string safe for PDF built-in fonts.
  static String pdfMoney(num amount, {int? decimals, String? currencyCode}) {
    final negative = amount < 0;
    final body = amount.abs().toStringAsFixed(
          decimals ?? AppMoneyFormat.displayPrecision,
        );
    final text = '${pdfSymbolForCode(currencyCode)} $body';
    return negative ? '-$text' : text;
  }

  static String formatCompact(double amount) {
    final abs = amount.abs();
    if (abs >= 100000) {
      return '${format(amount / 100000, decimals: 1)}L';
    }
    if (abs >= 1000) {
      return '${format(amount / 1000, decimals: 1)}K';
    }
    return format(amount);
  }
}

extension AppCurrencyFormatExtension on num {
  String toCurrency({int? decimals}) =>
      AppCurrencyFormatter.format(this, decimals: decimals);
}
