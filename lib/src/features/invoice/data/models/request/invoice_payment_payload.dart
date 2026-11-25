import 'package:hotel/src/features/invoice/data/models/request/create_invoice_request_params.dart';

/// Merges [payment_mode] and [payment] into an update/create map (same rules as POST).
void applyInvoicePaymentToJson(
  Map<String, dynamic> map, {
  required bool paymentMode,
  List<CreateInvoicePaymentLine>? payment,
}) {
  map['payment_mode'] = paymentMode;
  if (!paymentMode) {
    map['payment'] = null;
    return;
  }
  final lines = payment;
  if (lines == null || lines.isEmpty) {
    map['payment'] = null;
  } else if (lines.length == 1) {
    map['payment'] = lines.first.toJson();
  } else {
    map['payment'] = lines.map((e) => e.toJson()).toList();
  }
}
