import 'package:hotel/src/features/invoice/data/models/request/create_invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invoice_sales_response_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class InvoiceSalesResponseModel {
  final List<InvoiceItem>? data;
  final Pagination pagination;
  final int? total_quantity;

  @JsonKey(fromJson: _intToDouble)
  final double? total_grand_total;

  @JsonKey(fromJson: _intToDouble)
  final double? total_outstanding_amount;

  @JsonKey(fromJson: _intToDouble)
  final double? total_discount;

  @JsonKey(fromJson: _intToDouble)
  final double? total_not_submitted;

  final GrandPaymentTotals? grand_payment_totals;

  InvoiceSalesResponseModel({
    this.data,
    required this.pagination,
    this.total_quantity,
    this.total_grand_total,
    this.total_outstanding_amount,
    this.total_not_submitted,
    this.total_discount,
    this.grand_payment_totals,
  });

  factory InvoiceSalesResponseModel.fromJson(Map<String, dynamic> json) => _$InvoiceSalesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceSalesResponseModelToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class InvoiceItem {
  final String? parent;

  @JsonKey(name: 'invoice_name')
  final String? invoiceName;

  final String? party;

  @JsonKey(name: 'grand_total', fromJson: _stringToDouble)
  final double? grandTotal;

  final String? date;
  final String? status;
  final String? modifiedBy;
  final String? action;
  final int? submitted;
  final int? cancelled;
  @JsonKey(includeToJson: false)
  final InvoiceType? invoiceType;

  @JsonKey(name: 'outstanding_amount', fromJson: _stringToDouble)
  final double? outstandingAmount;
  @JsonKey(name: 'previous_outstanding', fromJson: _stringToDouble)
  final double? previousOutstanding;

  final List<ItemDetails>? items;
  final List<PaymentDetails>? payment;
  final Map<String, dynamic>? paymentTotals;

  @JsonKey(name: 'total_discount', fromJson: _stringToDouble)
  final double? totalDiscount;

  @JsonKey(name: 'setDiscountAmount')
  final int? setDiscountAmount;

  /// Sales: `discount_amount`. Purchase list may use `discountAmount`.
  @JsonKey(name: 'discount_amount', readValue: _readJsonDiscountAmount, fromJson: _stringToDouble)
  final double? discountAmount;

  @JsonKey(name: 'discount_percent', fromJson: _stringToDouble)
  final double? discountPercent;

  @JsonKey(name: 'net_total', fromJson: _stringToDouble)
  final double? netTotal;

  @JsonKey(name: 'base_grand_total', fromJson: _stringToDouble)
  final double? baseGrandTotal;

  @JsonKey(name: 'net_payable', fromJson: _stringToDouble)
  final double? netPayable;

  @JsonKey(name: 'paid_amount', fromJson: _stringToDouble)
  final double? paidAmount;

  @JsonKey(name: 'total_item_discount', fromJson: _stringToDouble)
  final double? totalItemDiscount;

  @JsonKey(name: 'invoice_discount', fromJson: _stringToDouble)
  final double? invoiceDiscount;

  /// Purchase summaries only (supplier credit after returns).
  @JsonKey(name: 'supplier_credit_owed', fromJson: _stringToDouble)
  final double? supplierCreditOwed;

  /// API may send `is_returned` or `isReturned`.
  @JsonKey(name: 'is_returned', readValue: _readJsonIsReturned)
  final int? isReturned;

  /// API may send `return_against` or `returnAgainst`.
  @JsonKey(name: 'return_against', readValue: _readJsonReturnAgainst)
  final String? returnAgainst;

  @JsonKey(name: 'total_returned_against', fromJson: _stringToDouble)
  final double? totalReturnedAgainst;

  @JsonKey(name: 'fully_returned', fromJson: _jsonToBoolNullable)
  final bool? fullyReturned;

  @JsonKey(name: 'refund_owed', fromJson: _stringToDouble)
  final double? refundOwed;

  @JsonKey(name: 'return_invoices')
  final List<ReturnInvoiceRef>? returnInvoices;

  /// Sales PUT only — encoded via [toSalesUpdateJson] (not from API JSON).
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool? paymentModeForUpdate;

  /// Sales PUT only — payment rows like POST create.
  @JsonKey(includeFromJson: false, includeToJson: false)
  final List<CreateInvoicePaymentLine>? updatePaymentLines;

  InvoiceItem(
      {this.parent,
      this.invoiceName,
      this.party,
      this.submitted,
      this.cancelled,
      this.grandTotal,
      this.date,
      this.status,
      this.action,
      this.modifiedBy,
      this.outstandingAmount,
      this.previousOutstanding,
      this.items,
      this.payment,
      this.paymentTotals,
      this.totalDiscount,
      this.setDiscountAmount,
      this.discountAmount,
      this.discountPercent,
      this.netTotal,
      this.baseGrandTotal,
      this.netPayable,
      this.paidAmount,
      this.totalItemDiscount,
      this.invoiceDiscount,
      this.supplierCreditOwed,
      this.isReturned,
      this.returnAgainst,
      this.totalReturnedAgainst,
      this.fullyReturned,
      this.refundOwed,
      this.returnInvoices,
      this.paymentModeForUpdate,
      this.updatePaymentLines,
      required this.invoiceType});

  factory InvoiceItem.fromJson(Map<String, dynamic> json) => _$InvoiceItemFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceItemToJson(this);
}

extension InvoiceItemDuplicateSnapshot on InvoiceItem {
  /// Fresh copy with line items cloned so duplicate/create never shares mutable lists with the list UI.
  InvoiceItem snapshotForDuplicate(InvoiceType fallbackType) {
    final lines = items;
    return InvoiceItem(
      parent: parent,
      invoiceName: invoiceName,
      party: party,
      submitted: submitted,
      cancelled: cancelled,
      grandTotal: grandTotal,
      date: date,
      status: status,
      action: action,
      modifiedBy: modifiedBy,
      outstandingAmount: outstandingAmount,
      previousOutstanding: previousOutstanding,
      items: lines == null
          ? null
          : lines
              .map(
                (e) => ItemDetails(
                  item: e.item,
                  action: e.action,
                  rate: e.rate,
                  itemId: null,
                  quantity: e.quantity,
                  amount: e.amount,
                  itemDiscountAmount: e.itemDiscountAmount,
                ),
              )
              .toList(),
      payment: payment,
      paymentTotals: paymentTotals,
      totalDiscount: totalDiscount,
      setDiscountAmount: setDiscountAmount,
      discountAmount: discountAmount,
      discountPercent: discountPercent,
      netTotal: netTotal,
      baseGrandTotal: baseGrandTotal,
      netPayable: netPayable,
      paidAmount: paidAmount,
      totalItemDiscount: totalItemDiscount,
      invoiceDiscount: invoiceDiscount,
      supplierCreditOwed: supplierCreditOwed,
      isReturned: isReturned,
      returnAgainst: returnAgainst,
      totalReturnedAgainst: totalReturnedAgainst,
      fullyReturned: fullyReturned,
      refundOwed: refundOwed,
      returnInvoices: returnInvoices,
      invoiceType: invoiceType ?? fallbackType,
    );
  }
}

@JsonSerializable(includeIfNull: false)
class ReturnInvoiceRef {
  final String? name;

  @JsonKey(name: 'return_amount', fromJson: _stringToDouble)
  final double? returnAmount;

  final String? date;
  final String? status;

  @JsonKey(name: 'refund_status')
  final String? refundStatus;

  final ReturnRefundInfo? refund;

  final List<ReturnInvoiceLineItem>? items;

  ReturnInvoiceRef({
    this.name,
    this.returnAmount,
    this.date,
    this.status,
    this.refundStatus,
    this.refund,
    this.items,
  });

  factory ReturnInvoiceRef.fromJson(Map<String, dynamic> json) => _$ReturnInvoiceRefFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnInvoiceRefToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ReturnInvoiceLineItem {
  final String? item;

  @JsonKey(fromJson: _stringToDouble)
  final double? quantity;

  @JsonKey(fromJson: _nullableDoubleFromJson)
  final double? rate;

  @JsonKey(fromJson: _stringToDouble)
  final double? amount;

  ReturnInvoiceLineItem({
    this.item,
    this.quantity,
    this.rate,
    this.amount,
  });

  factory ReturnInvoiceLineItem.fromJson(Map<String, dynamic> json) =>
      _$ReturnInvoiceLineItemFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnInvoiceLineItemToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ReturnRefundInfo {
  @JsonKey(name: 'payment_name')
  final String? paymentName;

  @JsonKey(name: 'refund_amount', fromJson: _stringToDouble)
  final double? refundAmount;

  @JsonKey(name: 'payment_method')
  final String? paymentMethod;

  final String? status;
  final String? date;

  ReturnRefundInfo({
    this.paymentName,
    this.refundAmount,
    this.paymentMethod,
    this.status,
    this.date,
  });

  factory ReturnRefundInfo.fromJson(Map<String, dynamic> json) => _$ReturnRefundInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnRefundInfoToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ItemDetails {
  final String? item;
  final String? action;
  final double? rate;
  final String? itemId;
  final double? quantity;

  /// Line id for returns (`original_item_name` on POST).
  final String? name;

  @JsonKey(fromJson: _stringToDouble)
  final double? amount;

  @JsonKey(fromJson: _stringToDouble)
  final double? itemDiscountAmount;

  @JsonKey(name: 'already_returned_quantity', fromJson: _stringToDouble)
  final double? alreadyReturnedQuantity;

  @JsonKey(name: 'available_return_quantity', fromJson: _stringToDouble)
  final double? availableReturnQuantity;

  @JsonKey(name: 'can_return', fromJson: _jsonToBoolNullable)
  final bool? canReturn;

  ItemDetails({
    this.item,
    this.action,
    this.rate,
    this.itemId,
    this.quantity,
    this.name,
    this.amount,
    this.itemDiscountAmount,
    this.alreadyReturnedQuantity,
    this.availableReturnQuantity,
    this.canReturn,
  });

  factory ItemDetails.fromJson(Map<String, dynamic> json) => _$ItemDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemDetailsToJson(this);
}

@JsonSerializable(includeIfNull: false)
class GrandPaymentTotals {
  @JsonKey(name: 'Cash', fromJson: _stringToDouble)
  final double? cash;

  @JsonKey(name: 'Transfer', fromJson: _stringToDouble)
  final double? transfer;

  GrandPaymentTotals({
    this.cash,
    this.transfer,
  });

  factory GrandPaymentTotals.fromJson(Map<String, dynamic> json) => _$GrandPaymentTotalsFromJson(json);

  Map<String, dynamic> toJson() => _$GrandPaymentTotalsToJson(this);
}

@JsonSerializable(includeIfNull: false)
class PaymentDetails {
  final String? paymentId;
  final String? referenceId;
  final String? paymentMethod;
  final DateTime? date;

  @JsonKey(fromJson: _stringToDouble)
  final double? amount;

  PaymentDetails({this.paymentId, this.paymentMethod, this.amount, this.date, this.referenceId});

  factory PaymentDetails.fromJson(Map<String, dynamic> json) => _$PaymentDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentDetailsToJson(this);
}

@JsonSerializable(includeIfNull: false)
class Pagination {
  final int? current_page;
  final int? per_page;
  final int? total_pages;
  final int? total_groups;

  Pagination({
    this.current_page,
    this.per_page,
    this.total_pages,
    this.total_groups,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}

Object? _readJsonIsReturned(Map json, String key) => json['is_returned'] ?? json['isReturned'];

Object? _readJsonReturnAgainst(Map json, String key) => json['return_against'] ?? json['returnAgainst'];

Object? _readJsonDiscountAmount(Map json, String key) => json['discount_amount'] ?? json['discountAmount'];

double? _nullableDoubleFromJson(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString());
}

// Helper methods for parsing

double _stringToDouble(dynamic value) {
  if (value == null) return 0.0;
  return double.tryParse(value.toString()) ?? 0.0;
}

double _intToDouble(dynamic value) {
  if (value == null) return 0.0;
  return value is int ? value.toDouble() : (value as double? ?? 0.0);
}

bool? _jsonToBoolNullable(dynamic value) {
  if (value == null) return null;
  if (value is bool) return value;
  if (value is num) return value != 0;
  final s = value.toString().toLowerCase().trim();
  if (s == 'true' || s == '1') return true;
  if (s == 'false' || s == '0') return false;
  return null;
}
