enum TaxMode { exclusive, inclusive }

extension TaxModeX on TaxMode {
  String get storageValue => switch (this) {
        TaxMode.exclusive => 'exclusive',
        TaxMode.inclusive => 'inclusive',
      };

  String get segmentLabel => switch (this) {
        TaxMode.exclusive => 'Exclusive — added',
        TaxMode.inclusive => 'Inclusive — extracted',
      };

  static TaxMode parse(String? raw) {
    switch (raw?.trim().toLowerCase()) {
      case 'inclusive':
        return TaxMode.inclusive;
      case 'exclusive':
      default:
        return TaxMode.exclusive;
    }
  }
}

/// Tax calculation helpers (amounts in major currency units).
abstract final class TaxMath {
  static double exclusiveTax(double net, double ratePercent) {
    if (net <= 0 || ratePercent <= 0) return 0;
    return net * ratePercent / 100;
  }

  static double inclusiveTax(double gross, double ratePercent) {
    if (gross <= 0 || ratePercent <= 0) return 0;
    return gross * ratePercent / (100 + ratePercent);
  }

  static String formatRate(double rate) {
    if (rate == rate.roundToDouble()) return '${rate.toStringAsFixed(0)}%';
    final s = rate.toStringAsFixed(2);
    return '${s.replaceFirst(RegExp(r'\.?0+$'), '')}%';
  }
}

class SalesInvoiceTaxBreakdown {
  const SalesInvoiceTaxBreakdown({
    required this.subtotal,
    required this.discount,
    required this.taxable,
    required this.tax,
    required this.total,
  });

  final double subtotal;
  final double discount;
  final double taxable;
  final double tax;
  final double total;
}

class SalesInvoiceTaxCalculator {
  const SalesInvoiceTaxCalculator({
    required this.ratePercent,
    this.mode = TaxMode.exclusive,
  });

  final double ratePercent;
  final TaxMode mode;

  SalesInvoiceTaxBreakdown calculate({
    required double subtotal,
    required double discount,
  }) {
    final afterDiscount =
        (subtotal - discount).clamp(0, double.infinity).toDouble();
    if (ratePercent <= 0) {
      return SalesInvoiceTaxBreakdown(
        subtotal: subtotal,
        discount: discount,
        taxable: afterDiscount,
        tax: 0,
        total: afterDiscount,
      );
    }
    if (mode == TaxMode.inclusive) {
      final tax = TaxMath.inclusiveTax(afterDiscount, ratePercent);
      return SalesInvoiceTaxBreakdown(
        subtotal: subtotal,
        discount: discount,
        taxable: afterDiscount - tax,
        tax: tax,
        total: afterDiscount,
      );
    }
    final tax = TaxMath.exclusiveTax(afterDiscount, ratePercent);
    return SalesInvoiceTaxBreakdown(
      subtotal: subtotal,
      discount: discount,
      taxable: afterDiscount,
      tax: tax,
      total: afterDiscount + tax,
    );
  }
}
