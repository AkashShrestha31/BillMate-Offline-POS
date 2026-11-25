import 'package:hotel/src/features/invoice/data/models/response/invoice_sales_response_model.dart';

/// Unpaid sales/purchase invoice (submitted or explicit status).
bool isInvoiceUnpaid(InvoiceItem invoice) {
  final st = invoice.status?.toLowerCase().trim() ?? '';
  if (st == 'unpaid') return true;
  if (invoice.submitted == 1) {
    final out = invoice.outstandingAmount;
    if (out != null && out > 0) return true;
  }
  return false;
}

/// Edit is allowed only for **not submitted** drafts; never for unpaid or paid.
bool canShowEditInvoice(InvoiceItem invoice) {
  if (invoice.submitted != 0) return false;
  if (isInvoiceUnpaid(invoice)) return false;
  final st = invoice.status?.toLowerCase().trim() ?? '';
  if (st == 'paid') return false;
  return true;
}
