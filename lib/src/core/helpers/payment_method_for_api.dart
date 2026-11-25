/// Maps payment UI labels to API `payment_method` values (create invoice, order checkout, partial payment).
String normalizePaymentMethodForApi(String uiLabel) {
  switch (uiLabel.trim()) {
    case 'Transfer':
      return 'Transfer';
    case 'Bank Transfer':
    case 'Bank':
      return 'Transfer';
    case 'Cash':
      return 'Cash';
    case 'Fonepay':
      return 'Fonepay';
    default:
      return uiLabel.trim();
  }
}
