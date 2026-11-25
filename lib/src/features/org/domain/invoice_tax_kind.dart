/// Sales invoice tax type from country reference (VAT/GST, corporate, personal/PIT).
enum InvoiceTaxKind {
  vat,
  corporate,
  personal,
}

extension InvoiceTaxKindX on InvoiceTaxKind {
  String get storageValue => switch (this) {
        InvoiceTaxKind.vat => 'vat',
        InvoiceTaxKind.corporate => 'corporate',
        InvoiceTaxKind.personal => 'personal',
      };

  static InvoiceTaxKind parse(String? raw) {
    switch (raw?.trim().toLowerCase()) {
      case 'corporate':
        return InvoiceTaxKind.corporate;
      case 'personal':
      case 'pit':
        return InvoiceTaxKind.personal;
      case 'vat':
      case 'gst':
      case 'sales tax':
      default:
        return InvoiceTaxKind.vat;
    }
  }
}
