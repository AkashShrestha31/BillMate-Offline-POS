/// `PATCH /api/order/orders/<name>/status/` — body per order_api_documentation.docx.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_status_update_response.freezed.dart';
part 'order_status_update_response.g.dart';

double? _netTotalFromJson(dynamic v) {
  if (v == null) return null;
  if (v is num) return v.toDouble();
  return double.tryParse(v.toString());
}

@freezed
class OrderStatusUpdateResponse with _$OrderStatusUpdateResponse {
  const factory OrderStatusUpdateResponse({
    String? message,
    String? name,
    /// e.g. Accepted, Completed, Cancelled
    @JsonKey(name: 'order_status') String? orderStatus,
    @JsonKey(name: 'sales_invoice_name') String? salesInvoiceName,
    @JsonKey(name: 'net_total', fromJson: _netTotalFromJson) double? netTotal,
    /// e.g. draft SalesInvoice note when status is Completed
    String? note,
  }) = _OrderStatusUpdateResponse;

  factory OrderStatusUpdateResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusUpdateResponseFromJson(json);
}
