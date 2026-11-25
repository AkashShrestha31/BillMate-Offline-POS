import 'package:hotel/src/core/l10n/localized_digits_x.dart';
import 'package:hotel/src/features/org/domain/system_settings_service.dart';
import 'package:intl/intl.dart';

/// App-wide money display precision (updated from [AppDisplayPrecisionService]).
abstract final class AppMoneyFormat {
  static int displayPrecision = SystemSettingsService.defaultDisplayPrecision;

  static void apply(int precision) {
    displayPrecision = precision.clamp(
      SystemSettingsService.minDisplayPrecision,
      SystemSettingsService.maxDisplayPrecision,
    );
  }

  static String formatAmount(num value, {int? fractionDigits}) {
    if (value.isNaN || value.isInfinite) return value.toString();
    final digits = fractionDigits ?? displayPrecision;
    return value.toStringAsFixed(digits);
  }

  /// Input fields: whole numbers when exact, otherwise respect display precision.
  static String formatAmountForField(double value) {
    final digits = displayPrecision;
    if (digits == 0 || value == value.roundToDouble()) {
      return value.round().toString();
    }
    return trimMoneyAmount(value, maxDecimals: digits);
  }

  static NumberFormat currency(String symbol) {
    final trimmed = symbol.trim();
    final prefix = trimmed.isEmpty ? '' : '$trimmed ';
    return NumberFormat.currency(
      symbol: prefix,
      decimalDigits: displayPrecision,
    );
  }
}
