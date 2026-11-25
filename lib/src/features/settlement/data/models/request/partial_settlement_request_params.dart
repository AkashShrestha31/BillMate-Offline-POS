/// One row in the `payment` payload (single object or array element).
class PartialSettlementPaymentLine {
  const PartialSettlementPaymentLine({
    required this.paymentMethod,
    required this.amount,
    this.account,
    this.referenceId,
    this.referenceDate,
    this.clearanceDate,
  });

  final String paymentMethod;
  final double amount;
  final String? account;
  final String? referenceId;
  final String? referenceDate;
  final String? clearanceDate;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'payment_method': paymentMethod,
      'amount': amount,
      if (account != null && account!.trim().isNotEmpty) 'account': account!.trim(),
      if (referenceId != null && referenceId!.trim().isNotEmpty) 'reference_id': referenceId!.trim(),
      if (referenceDate != null && referenceDate!.trim().isNotEmpty) 'reference_date': referenceDate!.trim(),
      if (clearanceDate != null && clearanceDate!.trim().isNotEmpty) 'clearance_date': clearanceDate!.trim(),
    };
  }
}

/// Party partial settlement — matches `PartyPartialPaymentSettlementView` API.
///
/// Exactly one of [partyName], [salesInvoiceName], [purchaseInvoiceName] must be non-null/non-empty.
/// [invoiceType] is only sent for party-wide mode (`party_name`): `sales`, `purchase`, or `both`.
/// [discountAmount] / [discountPercent] apply only when [salesInvoiceName] is set (`discount_amount` wins).
class PartialSettlementRequestParams {
  PartialSettlementRequestParams({
    this.partyName,
    this.salesInvoiceName,
    this.purchaseInvoiceName,
    required this.payment,
    required this.paymentDate,
    this.invoiceType,
    this.notes = 'Partial settlement...',
    this.createdBy = 'hotelroyalrestro@gmail.com',
    this.discountAmount,
    this.discountPercent,
  }) : assert(payment.isNotEmpty, 'payment must contain at least one line');

  final String? partyName;
  final String? salesInvoiceName;
  final String? purchaseInvoiceName;

  final List<PartialSettlementPaymentLine> payment;

  final String paymentDate;

  /// Party-wide settlement only; omit for single-invoice settlement.
  final String? invoiceType;

  final String? notes;
  final String createdBy;

  final double? discountAmount;
  final double? discountPercent;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    if (partyName != null && partyName!.trim().isNotEmpty) {
      json['party_name'] = partyName!.trim();
    }
    if (salesInvoiceName != null && salesInvoiceName!.trim().isNotEmpty) {
      json['sales_invoice_name'] = salesInvoiceName!.trim();
    }
    if (purchaseInvoiceName != null && purchaseInvoiceName!.trim().isNotEmpty) {
      json['purchase_invoice_name'] = purchaseInvoiceName!.trim();
    }

    if (payment.length == 1) {
      json['payment'] = payment.single.toJson();
    } else {
      json['payment'] = payment.map((e) => e.toJson()).toList();
    }

    json['payment_date'] = paymentDate;

    if (invoiceType != null && invoiceType!.trim().isNotEmpty) {
      json['invoice_type'] = invoiceType!.trim();
    }

    if (notes != null && notes!.trim().isNotEmpty) {
      json['notes'] = notes!.trim();
    }

    json['created_by'] = createdBy;

    if (discountAmount != null) {
      json['discount_amount'] = discountAmount;
    } else if (discountPercent != null) {
      json['discount_percent'] = discountPercent;
    }

    json.removeWhere((key, value) => value is String && value.isEmpty);
    return json;
  }
}
