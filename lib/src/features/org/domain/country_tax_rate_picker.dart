import 'package:hotel/src/features/org/domain/country_tax_profile.dart';
import 'package:hotel/src/features/org/domain/invoice_tax_kind.dart';

extension CountryTaxProfileRates on CountryTaxProfile {
  String get consumptionTaxName {
    if (country == 'United States') return 'Sales tax';
    const gst = {'India', 'Australia', 'New Zealand', 'Singapore', 'Canada'};
    if (gst.contains(country)) return 'GST';
    if (country == 'Malaysia') return 'SST';
    return 'VAT';
  }

  List<double> ratesFor(InvoiceTaxKind kind) {
    switch (kind) {
      case InvoiceTaxKind.vat:
        return vatRateOptions;
      case InvoiceTaxKind.corporate:
        return corporateRateOptions;
      case InvoiceTaxKind.personal:
        return pitRateOptions;
    }
  }

  /// First listed rate is the default, including explicit 0% (Gulf PIT, Bahamas
  /// corp, Estonia retained earnings). Empty lists mean 0, not VAT fallback.
  double primaryRateFor(InvoiceTaxKind kind) {
    final rates = ratesFor(kind);
    return rates.isEmpty ? 0 : rates.first;
  }

  String formatRate(double rate) => rate == rate.roundToDouble()
      ? rate.toStringAsFixed(0)
      : rate.toStringAsFixed(2);

  /// TIN labels for the selected tax kind.
  List<String> tinLabelsFor(InvoiceTaxKind kind) {
    switch (kind) {
      case InvoiceTaxKind.vat:
        if (vatTinLabels.isNotEmpty) return vatTinLabels;
        return entityTinLabels.isNotEmpty ? entityTinLabels : const ['TIN'];
      case InvoiceTaxKind.corporate:
        return entityTinLabels.isNotEmpty ? entityTinLabels : const ['TIN'];
      case InvoiceTaxKind.personal:
        if (individualTinLabels.isNotEmpty) return individualTinLabels;
        return entityTinLabels.isNotEmpty ? entityTinLabels : const ['TIN'];
    }
  }

  String primaryTinLabelFor(InvoiceTaxKind kind) => tinLabelsFor(kind).first;

  String labelForKind(InvoiceTaxKind kind) {
    switch (kind) {
      case InvoiceTaxKind.vat:
        return consumptionTaxName;
      case InvoiceTaxKind.corporate:
        return 'Corporate';
      case InvoiceTaxKind.personal:
        return 'Personal';
    }
  }

  /// Preset rates for the selected kind (includes 0 so invoices can opt out).
  List<double> presetRatesFor(InvoiceTaxKind kind) {
    final rates = <double>{0.0, ...ratesFor(kind)}.toList()..sort();
    return rates;
  }

  bool get hasAnyTaxPresets =>
      vatRateOptions.any((r) => r > 0) ||
      corporateRateOptions.any((r) => r > 0) ||
      pitRateOptions.any((r) => r > 0);
}
