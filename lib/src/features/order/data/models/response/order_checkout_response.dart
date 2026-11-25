/// `POST /api/order/orders/{name}/checkout/` response body.

double? _doubleFromJson(dynamic v) {
  if (v == null) return null;
  if (v is num) return v.toDouble();
  return double.tryParse(v.toString());
}

int? _intFromJson(dynamic v) {
  if (v == null) return null;
  if (v is num) return v.toInt();
  return int.tryParse(v.toString());
}

class OrderCheckoutPaymentRow {
  const OrderCheckoutPaymentRow({
    this.paymentName,
    this.amount,
    this.paymentMethod,
    this.referenceId,
  });

  final String? paymentName;
  final double? amount;
  final String? paymentMethod;
  final String? referenceId;

  factory OrderCheckoutPaymentRow.fromJson(Map<String, dynamic> json) {
    return OrderCheckoutPaymentRow(
      paymentName: json['payment_name'] as String?,
      amount: _doubleFromJson(json['amount']),
      paymentMethod: json['payment_method'] as String?,
      referenceId: json['reference_id'] as String?,
    );
  }
}

class OrderCheckoutResponse {
  const OrderCheckoutResponse({
    this.message,
    this.name,
    this.orderStatus,
    this.invoiceStatus,
    this.salesInvoiceName,
    this.netTotal,
    this.discountAmount,
    this.party,
    this.partyTransferred,
    this.outstandingAmount,
    this.paymentsCreated,
    this.totalPaid,
    this.payments,
  });

  final String? message;
  final String? name;
  final String? orderStatus;
  final String? invoiceStatus;
  final String? salesInvoiceName;
  final double? netTotal;
  final double? discountAmount;
  final String? party;
  final bool? partyTransferred;
  final double? outstandingAmount;
  final int? paymentsCreated;
  final double? totalPaid;
  final List<OrderCheckoutPaymentRow>? payments;

  factory OrderCheckoutResponse.fromJson(Map<String, dynamic> json) {
    List<OrderCheckoutPaymentRow>? payList;
    final raw = json['payments'];
    if (raw is List) {
      payList = raw
          .map((e) => OrderCheckoutPaymentRow.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    }
    return OrderCheckoutResponse(
      message: json['message'] as String?,
      name: json['name'] as String?,
      orderStatus: json['order_status'] as String?,
      invoiceStatus: json['invoice_status'] as String?,
      salesInvoiceName: json['sales_invoice_name'] as String?,
      netTotal: _doubleFromJson(json['net_total']),
      discountAmount: _doubleFromJson(json['discount_amount']),
      party: json['party'] as String?,
      partyTransferred: json['party_transferred'] as bool?,
      outstandingAmount: _doubleFromJson(json['outstanding_amount']),
      paymentsCreated: _intFromJson(json['payments_created']),
      totalPaid: _doubleFromJson(json['total_paid']),
      payments: payList,
    );
  }
}
