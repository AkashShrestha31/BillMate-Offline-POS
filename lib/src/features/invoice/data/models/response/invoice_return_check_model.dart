import 'package:hotel/src/core/helpers/dynamic_json_parse.dart';

/// GET sales-return / purchase-return check response.
class InvoiceReturnCheckData {
  const InvoiceReturnCheckData({
    required this.success,
    this.invoice,
    this.items = const [],
    this.returnInvoices = const [],
    this.message,
  });

  final bool success;
  final InvoiceReturnSummary? invoice;
  final List<InvoiceReturnLine> items;
  final List<InvoiceReturnHistoryEntry> returnInvoices;
  final String? message;

  factory InvoiceReturnCheckData.fromJson(Map<String, dynamic> json) {
    final success = json['success'] != false;
    final invRaw = json['invoice'];
    return InvoiceReturnCheckData(
      success: success,
      invoice: invRaw is Map
          ? InvoiceReturnSummary.fromJson(Map<String, dynamic>.from(invRaw))
          : null,
      items: safeMapList(json['items'])
          .map(InvoiceReturnLine.fromJson)
          .toList(),
      returnInvoices: safeMapList(json['return_invoices'] ?? json['returnInvoices'])
          .map(InvoiceReturnHistoryEntry.fromJson)
          .toList(),
      message: safeText(json['message'], fallback: ''),
    );
  }

  void validateReturnable() {
    if (items.isEmpty) {
      throw const InvoiceReturnValidationException('No returnable lines on this invoice.');
    }
    if (!items.any((it) => it.canReturn && it.maxReturnQty > 0.005)) {
      throw const InvoiceReturnValidationException('Nothing left to return on this invoice.');
    }
  }
}

class InvoiceReturnValidationException implements Exception {
  const InvoiceReturnValidationException(this.message);
  final String message;

  @override
  String toString() => message;
}

class InvoiceReturnSummary {
  const InvoiceReturnSummary({
    required this.name,
    this.party,
    this.date,
    this.currency,
    this.grandTotal = 0,
    this.outstandingAmount = 0,
    this.paidAmount = 0,
    this.alreadyReturnedAmount = 0,
    this.remainingReturnable = 0,
    this.paymentStatus,
  });

  final String name;
  final String? party;
  final String? date;
  final String? currency;
  final double grandTotal;
  final double outstandingAmount;
  final double paidAmount;
  final double alreadyReturnedAmount;
  final double remainingReturnable;
  final String? paymentStatus;

  bool get invoiceUnpaid => outstandingAmount > 0.005;

  factory InvoiceReturnSummary.fromJson(Map<String, dynamic> json) => InvoiceReturnSummary(
        name: safeText(json['name'] ?? json['invoice_name']),
        party: safeText(json['party']),
        date: safeText(json['date'] ?? json['invoice_date']),
        currency: safeText(json['currency'], fallback: 'NPR'),
        grandTotal: safeDouble(json['grand_total'] ?? json['grandTotal']),
        outstandingAmount: safeDouble(json['outstanding_amount'] ?? json['outstandingAmount']),
        paidAmount: safeDouble(json['paid_amount'] ?? json['paidAmount']),
        alreadyReturnedAmount:
            safeDouble(json['already_returned_amount'] ?? json['alreadyReturnedAmount']),
        remainingReturnable:
            safeDouble(json['remaining_returnable'] ?? json['remainingReturnable']),
        paymentStatus: safeText(json['payment_status'] ?? json['paymentStatus']),
      );
}

class InvoiceReturnLine {
  InvoiceReturnLine({
    required this.lineId,
    required this.displayName,
    required this.quantity,
    required this.alreadyReturnedQty,
    required this.maxReturnQty,
    required this.rate,
    required this.amount,
    required this.unit,
    required this.canReturn,
    this.returnQty = 0,
  });

  final String lineId;
  final String displayName;
  final double quantity;
  final double alreadyReturnedQty;
  final double maxReturnQty;
  final double rate;
  final double amount;
  final String unit;
  final bool canReturn;
  double returnQty;

  factory InvoiceReturnLine.fromJson(Map<String, dynamic> json) => InvoiceReturnLine(
        lineId: safeText(
          json['name'] ?? json['item_id'] ?? json['original_item_name'] ?? json['item'],
        ),
        displayName: safeText(json['item'] ?? json['item_name'] ?? json['name'], fallback: '—'),
        quantity: safeDouble(json['quantity'] ?? json['qty']),
        alreadyReturnedQty:
            safeDouble(json['already_returned_quantity'] ?? json['alreadyReturnedQuantity']),
        maxReturnQty:
            safeDouble(json['available_return_quantity'] ?? json['availableReturnQuantity']),
        rate: safeDouble(json['rate'] ?? json['price']),
        amount: safeDouble(json['amount'] ?? json['line_total']),
        unit: safeText(json['unit'] ?? json['uom'], fallback: 'Unit'),
        canReturn: _parseCanReturn(json),
      );

  static bool _parseCanReturn(Map<String, dynamic> json) {
    final v = json['can_return'] ?? json['canReturn'];
    if (v == null) return true;
    if (v is bool) return v;
    if (v is num) return v != 0;
    return v.toString().toLowerCase() == 'true';
  }
}

class InvoiceReturnHistoryLine {
  const InvoiceReturnHistoryLine({
    required this.item,
    required this.quantity,
    required this.rate,
    this.unit = 'Unit',
  });

  final String item;
  final double quantity;
  final double rate;
  final String unit;

  double get amount => quantity * rate;

  factory InvoiceReturnHistoryLine.fromJson(Map<String, dynamic> json) =>
      InvoiceReturnHistoryLine(
        item: safeText(json['item'] ?? json['item_name'], fallback: '—'),
        quantity: safeDouble(json['quantity'] ?? json['return_quantity'] ?? json['qty']),
        rate: safeDouble(json['rate'] ?? json['price']),
        unit: safeText(json['unit'] ?? json['uom'], fallback: 'Unit'),
      );
}

class InvoiceReturnHistoryEntry {
  const InvoiceReturnHistoryEntry({
    required this.name,
    this.returnAmount = 0,
    this.date,
    this.status,
    this.refundStatus,
    this.refund,
    this.items = const [],
  });

  final String name;
  final double returnAmount;
  final String? date;
  final String? status;
  final String? refundStatus;
  final InvoiceReturnRefundInfo? refund;
  final List<InvoiceReturnHistoryLine> items;

  factory InvoiceReturnHistoryEntry.fromJson(Map<String, dynamic> json) =>
      InvoiceReturnHistoryEntry(
        name: safeText(json['name']),
        returnAmount: safeDouble(json['return_amount'] ?? json['returnAmount']),
        date: safeText(json['date']),
        status: safeText(json['status']),
        refundStatus: safeText(json['refund_status'] ?? json['refundStatus']),
        refund: json['refund'] is Map
            ? InvoiceReturnRefundInfo.fromJson(Map<String, dynamic>.from(json['refund'] as Map))
            : null,
        items: safeMapList(json['items'] ?? json['lines'])
            .map(InvoiceReturnHistoryLine.fromJson)
            .toList(),
      );
}

class InvoiceReturnRefundInfo {
  const InvoiceReturnRefundInfo({
    this.refundAmount = 0,
    this.paymentMethod,
    this.status,
    this.date,
  });

  final double refundAmount;
  final String? paymentMethod;
  final String? status;
  final String? date;

  factory InvoiceReturnRefundInfo.fromJson(Map<String, dynamic> json) =>
      InvoiceReturnRefundInfo(
        refundAmount: safeDouble(json['refund_amount'] ?? json['refundAmount']),
        paymentMethod: safeText(json['payment_method'] ?? json['paymentMethod']),
        status: safeText(json['status']),
        date: safeText(json['date']),
      );
}

class CreateInvoiceReturnRequest {
  CreateInvoiceReturnRequest({
    required this.invoiceName,
    required this.returnDate,
    required this.reason,
    required this.createdBy,
    required this.refundMethod,
    this.refundPaymentMethod,
    required this.items,
  });

  final String invoiceName;
  final String returnDate;
  final String reason;
  final String createdBy;
  final String refundMethod;
  final String? refundPaymentMethod;
  final List<CreateInvoiceReturnLine> items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'invoice_name': invoiceName,
      'return_date': returnDate,
      'reason': reason,
      'created_by': createdBy,
      'refund_method': refundMethod,
      'items': items.map((e) => e.toJson()).toList(),
    };
    if (refundMethod == 'cash' && refundPaymentMethod != null) {
      map['refund_payment_method'] = refundPaymentMethod;
    }
    return map;
  }
}

class CreateInvoiceReturnLine {
  const CreateInvoiceReturnLine({
    required this.originalItemName,
    required this.item,
    required this.returnQuantity,
    required this.rate,
    required this.unit,
  });

  final String originalItemName;
  final String item;
  final double returnQuantity;
  final double rate;
  final String unit;

  Map<String, dynamic> toJson() => {
        'original_item_name': originalItemName,
        'item': item,
        'return_quantity': returnQuantity,
        'rate': rate,
        'unit': unit,
      };
}

String parseInvoiceReturnApiError(Object? data) {
  if (data is! Map) return 'Request failed';
  final map = Map<String, dynamic>.from(data);
  final detail = map['detail'];
  if (detail is String && detail.isNotEmpty) return detail;
  if (detail is List && detail.isNotEmpty) return detail.first.toString();
  final message = map['message'];
  if (message is String && message.isNotEmpty) return message;
  final error = map['error'];
  if (error is String && error.isNotEmpty) return error;
  final nonField = map['non_field_errors'];
  if (nonField is List && nonField.isNotEmpty) return nonField.first.toString();
  return 'Request failed';
}
