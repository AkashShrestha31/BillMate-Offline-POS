import 'package:hotel/src/features/invoice/data/models/request/create_invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_payment_payload.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_sales_response_model.dart';

extension InvoiceItemSalesUpdateJson on InvoiceItem {
  /// PUT sales invoice body: base fields plus optional [payment_mode] / [payment] like POST.
  Map<String, dynamic> toSalesUpdateJson({
    bool? paymentMode,
    List<CreateInvoicePaymentLine>? paymentLines,
  }) {
    final map = Map<String, dynamic>.from(toJson());

    if (setDiscountAmount != null) {
      map['setDiscountAmount'] = setDiscountAmount != 0;
    }

    final rawItems = map['items'];
    if (rawItems is List) {
      map['items'] = rawItems.map((entry) {
        final itemMap = Map<String, dynamic>.from(entry as Map);
        final id = itemMap.remove('itemId');
        if (id != null) {
          itemMap['item_id'] = id;
        }
        return itemMap;
      }).toList();
    }

    if (paymentMode != null) {
      applyInvoicePaymentToJson(
        map,
        paymentMode: paymentMode,
        payment: paymentLines,
      );
    }

    return map;
  }

  bool get isSalesUpdate => invoiceType == InvoiceType.sales;
}
