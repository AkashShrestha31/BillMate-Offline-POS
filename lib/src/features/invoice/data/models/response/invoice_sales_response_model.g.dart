// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_sales_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceSalesResponseModel _$InvoiceSalesResponseModelFromJson(
        Map<String, dynamic> json) =>
    InvoiceSalesResponseModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => InvoiceItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination:
          Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      total_quantity: (json['total_quantity'] as num?)?.toInt(),
      total_grand_total: _intToDouble(json['total_grand_total']),
      total_outstanding_amount: _intToDouble(json['total_outstanding_amount']),
      total_not_submitted: _intToDouble(json['total_not_submitted']),
      total_discount: _intToDouble(json['total_discount']),
      grand_payment_totals: json['grand_payment_totals'] == null
          ? null
          : GrandPaymentTotals.fromJson(
              json['grand_payment_totals'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InvoiceSalesResponseModelToJson(
        InvoiceSalesResponseModel instance) =>
    <String, dynamic>{
      if (instance.data?.map((e) => e.toJson()).toList() case final value?)
        'data': value,
      'pagination': instance.pagination.toJson(),
      if (instance.total_quantity case final value?) 'total_quantity': value,
      if (instance.total_grand_total case final value?)
        'total_grand_total': value,
      if (instance.total_outstanding_amount case final value?)
        'total_outstanding_amount': value,
      if (instance.total_discount case final value?) 'total_discount': value,
      if (instance.total_not_submitted case final value?)
        'total_not_submitted': value,
      if (instance.grand_payment_totals?.toJson() case final value?)
        'grand_payment_totals': value,
    };

InvoiceItem _$InvoiceItemFromJson(Map<String, dynamic> json) => InvoiceItem(
      parent: json['parent'] as String?,
      invoiceName: json['invoice_name'] as String?,
      party: json['party'] as String?,
      submitted: (json['submitted'] as num?)?.toInt(),
      cancelled: (json['cancelled'] as num?)?.toInt(),
      grandTotal: _stringToDouble(json['grand_total']),
      date: json['date'] as String?,
      status: json['status'] as String?,
      action: json['action'] as String?,
      modifiedBy: json['modifiedBy'] as String?,
      outstandingAmount: _stringToDouble(json['outstanding_amount']),
      previousOutstanding: _stringToDouble(json['previous_outstanding']),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ItemDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      payment: (json['payment'] as List<dynamic>?)
          ?.map((e) => PaymentDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      paymentTotals: json['paymentTotals'] as Map<String, dynamic>?,
      totalDiscount: _stringToDouble(json['total_discount']),
      setDiscountAmount: (json['setDiscountAmount'] as num?)?.toInt(),
      discountAmount:
          _stringToDouble(_readJsonDiscountAmount(json, 'discount_amount')),
      discountPercent: _stringToDouble(json['discount_percent']),
      netTotal: _stringToDouble(json['net_total']),
      baseGrandTotal: _stringToDouble(json['base_grand_total']),
      netPayable: _stringToDouble(json['net_payable']),
      paidAmount: _stringToDouble(json['paid_amount']),
      totalItemDiscount: _stringToDouble(json['total_item_discount']),
      invoiceDiscount: _stringToDouble(json['invoice_discount']),
      supplierCreditOwed: _stringToDouble(json['supplier_credit_owed']),
      isReturned: (_readJsonIsReturned(json, 'is_returned') as num?)?.toInt(),
      returnAgainst: _readJsonReturnAgainst(json, 'return_against') as String?,
      totalReturnedAgainst: _stringToDouble(json['total_returned_against']),
      fullyReturned: _jsonToBoolNullable(json['fully_returned']),
      refundOwed: _stringToDouble(json['refund_owed']),
      returnInvoices: (json['return_invoices'] as List<dynamic>?)
          ?.map((e) => ReturnInvoiceRef.fromJson(e as Map<String, dynamic>))
          .toList(),
      invoiceType:
          $enumDecodeNullable(_$InvoiceTypeEnumMap, json['invoiceType']),
    );

Map<String, dynamic> _$InvoiceItemToJson(InvoiceItem instance) =>
    <String, dynamic>{
      if (instance.parent case final value?) 'parent': value,
      if (instance.invoiceName case final value?) 'invoice_name': value,
      if (instance.party case final value?) 'party': value,
      if (instance.grandTotal case final value?) 'grand_total': value,
      if (instance.date case final value?) 'date': value,
      if (instance.status case final value?) 'status': value,
      if (instance.modifiedBy case final value?) 'modifiedBy': value,
      if (instance.action case final value?) 'action': value,
      if (instance.submitted case final value?) 'submitted': value,
      if (instance.cancelled case final value?) 'cancelled': value,
      if (instance.outstandingAmount case final value?)
        'outstanding_amount': value,
      if (instance.previousOutstanding case final value?)
        'previous_outstanding': value,
      if (instance.items?.map((e) => e.toJson()).toList() case final value?)
        'items': value,
      if (instance.payment?.map((e) => e.toJson()).toList() case final value?)
        'payment': value,
      if (instance.paymentTotals case final value?) 'paymentTotals': value,
      if (instance.totalDiscount case final value?) 'total_discount': value,
      if (instance.setDiscountAmount case final value?)
        'setDiscountAmount': value,
      if (instance.discountAmount case final value?) 'discount_amount': value,
      if (instance.discountPercent case final value?) 'discount_percent': value,
      if (instance.netTotal case final value?) 'net_total': value,
      if (instance.baseGrandTotal case final value?) 'base_grand_total': value,
      if (instance.netPayable case final value?) 'net_payable': value,
      if (instance.paidAmount case final value?) 'paid_amount': value,
      if (instance.totalItemDiscount case final value?)
        'total_item_discount': value,
      if (instance.invoiceDiscount case final value?) 'invoice_discount': value,
      if (instance.supplierCreditOwed case final value?)
        'supplier_credit_owed': value,
      if (instance.isReturned case final value?) 'is_returned': value,
      if (instance.returnAgainst case final value?) 'return_against': value,
      if (instance.totalReturnedAgainst case final value?)
        'total_returned_against': value,
      if (instance.fullyReturned case final value?) 'fully_returned': value,
      if (instance.refundOwed case final value?) 'refund_owed': value,
      if (instance.returnInvoices?.map((e) => e.toJson()).toList()
          case final value?)
        'return_invoices': value,
    };

const _$InvoiceTypeEnumMap = {
  InvoiceType.sales: 'sales',
  InvoiceType.purchase: 'purchase',
};

ReturnInvoiceRef _$ReturnInvoiceRefFromJson(Map<String, dynamic> json) =>
    ReturnInvoiceRef(
      name: json['name'] as String?,
      returnAmount: _stringToDouble(json['return_amount']),
      date: json['date'] as String?,
      status: json['status'] as String?,
      refundStatus: json['refund_status'] as String?,
      refund: json['refund'] == null
          ? null
          : ReturnRefundInfo.fromJson(json['refund'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map(
              (e) => ReturnInvoiceLineItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReturnInvoiceRefToJson(ReturnInvoiceRef instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'name': value,
      if (instance.returnAmount case final value?) 'return_amount': value,
      if (instance.date case final value?) 'date': value,
      if (instance.status case final value?) 'status': value,
      if (instance.refundStatus case final value?) 'refund_status': value,
      if (instance.refund case final value?) 'refund': value,
      if (instance.items case final value?) 'items': value,
    };

ReturnInvoiceLineItem _$ReturnInvoiceLineItemFromJson(
        Map<String, dynamic> json) =>
    ReturnInvoiceLineItem(
      item: json['item'] as String?,
      quantity: _stringToDouble(json['quantity']),
      rate: _nullableDoubleFromJson(json['rate']),
      amount: _stringToDouble(json['amount']),
    );

Map<String, dynamic> _$ReturnInvoiceLineItemToJson(
        ReturnInvoiceLineItem instance) =>
    <String, dynamic>{
      if (instance.item case final value?) 'item': value,
      if (instance.quantity case final value?) 'quantity': value,
      if (instance.rate case final value?) 'rate': value,
      if (instance.amount case final value?) 'amount': value,
    };

ReturnRefundInfo _$ReturnRefundInfoFromJson(Map<String, dynamic> json) =>
    ReturnRefundInfo(
      paymentName: json['payment_name'] as String?,
      refundAmount: _stringToDouble(json['refund_amount']),
      paymentMethod: json['payment_method'] as String?,
      status: json['status'] as String?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$ReturnRefundInfoToJson(ReturnRefundInfo instance) =>
    <String, dynamic>{
      if (instance.paymentName case final value?) 'payment_name': value,
      if (instance.refundAmount case final value?) 'refund_amount': value,
      if (instance.paymentMethod case final value?) 'payment_method': value,
      if (instance.status case final value?) 'status': value,
      if (instance.date case final value?) 'date': value,
    };

ItemDetails _$ItemDetailsFromJson(Map<String, dynamic> json) => ItemDetails(
      item: json['item'] as String?,
      action: json['action'] as String?,
      rate: (json['rate'] as num?)?.toDouble(),
      itemId: json['itemId'] as String?,
      quantity: (json['quantity'] as num?)?.toDouble(),
      name: json['name'] as String?,
      amount: _stringToDouble(json['amount']),
      itemDiscountAmount: _stringToDouble(json['itemDiscountAmount']),
      alreadyReturnedQuantity:
          _stringToDouble(json['already_returned_quantity']),
      availableReturnQuantity:
          _stringToDouble(json['available_return_quantity']),
      canReturn: _jsonToBoolNullable(json['can_return']),
    );

Map<String, dynamic> _$ItemDetailsToJson(ItemDetails instance) =>
    <String, dynamic>{
      if (instance.item case final value?) 'item': value,
      if (instance.action case final value?) 'action': value,
      if (instance.rate case final value?) 'rate': value,
      if (instance.itemId case final value?) 'itemId': value,
      if (instance.quantity case final value?) 'quantity': value,
      if (instance.name case final value?) 'name': value,
      if (instance.amount case final value?) 'amount': value,
      if (instance.itemDiscountAmount case final value?)
        'itemDiscountAmount': value,
      if (instance.alreadyReturnedQuantity case final value?)
        'already_returned_quantity': value,
      if (instance.availableReturnQuantity case final value?)
        'available_return_quantity': value,
      if (instance.canReturn case final value?) 'can_return': value,
    };

GrandPaymentTotals _$GrandPaymentTotalsFromJson(Map<String, dynamic> json) =>
    GrandPaymentTotals(
      cash: _stringToDouble(json['Cash']),
      transfer: _stringToDouble(json['Transfer']),
    );

Map<String, dynamic> _$GrandPaymentTotalsToJson(GrandPaymentTotals instance) =>
    <String, dynamic>{
      if (instance.cash case final value?) 'Cash': value,
      if (instance.transfer case final value?) 'Transfer': value,
    };

PaymentDetails _$PaymentDetailsFromJson(Map<String, dynamic> json) =>
    PaymentDetails(
      paymentId: json['paymentId'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      amount: _stringToDouble(json['amount']),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      referenceId: json['referenceId'] as String?,
    );

Map<String, dynamic> _$PaymentDetailsToJson(PaymentDetails instance) =>
    <String, dynamic>{
      if (instance.paymentId case final value?) 'paymentId': value,
      if (instance.referenceId case final value?) 'referenceId': value,
      if (instance.paymentMethod case final value?) 'paymentMethod': value,
      if (instance.date?.toIso8601String() case final value?) 'date': value,
      if (instance.amount case final value?) 'amount': value,
    };

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      current_page: (json['current_page'] as num?)?.toInt(),
      per_page: (json['per_page'] as num?)?.toInt(),
      total_pages: (json['total_pages'] as num?)?.toInt(),
      total_groups: (json['total_groups'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      if (instance.current_page case final value?) 'current_page': value,
      if (instance.per_page case final value?) 'per_page': value,
      if (instance.total_pages case final value?) 'total_pages': value,
      if (instance.total_groups case final value?) 'total_groups': value,
    };
