import 'package:hotel/src/core/helpers/dynamic_json_parse.dart';

class AccountingSettingsModel {
  const AccountingSettingsModel({this.enableInvoiceReturns = false});

  final bool enableInvoiceReturns;

  /// Mirrors React [`settingsApi.ts`] `getEnableInvoiceReturns`:
  /// `{ success, settings: { AccountingSettings: { enableInvoiceReturns } } }`
  factory AccountingSettingsModel.fromJson(Map<String, dynamic> json) {
    final settingsRaw = json['settings'];
    if (settingsRaw is Map) {
      final settings = Map<String, dynamic>.from(settingsRaw as Map);
      final flat = settings['enableInvoiceReturns'] ??
          settings['enable_invoice_returns'] ??
          settings['enable_invoice_return'];
      if (flat != null) {
        return AccountingSettingsModel(enableInvoiceReturns: _parseBool(flat));
      }
      final accRaw = settings['AccountingSettings'] ??
          settings['accountingSettings'] ??
          settings['accounting_settings'] ??
          settings['Accounting Settings'];
      if (accRaw is Map) {
        final acc = Map<String, dynamic>.from(accRaw as Map);
        final enabled =
            acc['enableInvoiceReturns'] ?? acc['enable_invoice_returns'] ?? acc['enable_invoice_return'];
        return AccountingSettingsModel(enableInvoiceReturns: _parseBool(enabled));
      }
    }

    final root = json['data'] is Map
        ? Map<String, dynamic>.from(json['data'] as Map)
        : json;
    final enabled = root['enableInvoiceReturns'] ??
        root['enable_invoice_returns'] ??
        root['enable_invoice_return'];
    return AccountingSettingsModel(
      enableInvoiceReturns: _parseBool(enabled),
    );
  }
}

bool _parseBool(Object? value) {
  if (value == null) return false;
  if (value is bool) return value;
  if (value is num) return value != 0;
  final s = value.toString().toLowerCase().trim();
  return s == 'true' || s == '1' || s == 'yes';
}
