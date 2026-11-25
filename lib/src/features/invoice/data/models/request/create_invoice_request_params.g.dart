// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_invoice_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateInvoiceItem _$CreateInvoiceItemFromJson(Map<String, dynamic> json) =>
    CreateInvoiceItem(
      item: json['item'] as String,
      rate: (json['rate'] as num).toDouble(),
      quantity: (json['quantity'] as num?)?.toDouble(),
      account: json['account'] as String?,
      description: json['description'] as String?,
      unit: json['unit'] as String?,
      setItemDiscountAmount: json['setItemDiscountAmount'] as bool?,
      itemDiscountAmount: (json['itemDiscountAmount'] as num?)?.toDouble(),
      itemDiscountPercent: (json['itemDiscountPercent'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CreateInvoiceItemToJson(CreateInvoiceItem instance) =>
    <String, dynamic>{
      'item': instance.item,
      'rate': instance.rate,
      if (instance.quantity case final value?) 'quantity': value,
      if (instance.account case final value?) 'account': value,
      if (instance.description case final value?) 'description': value,
      if (instance.unit case final value?) 'unit': value,
      if (instance.setItemDiscountAmount case final value?)
        'setItemDiscountAmount': value,
      if (instance.itemDiscountAmount case final value?)
        'itemDiscountAmount': value,
      if (instance.itemDiscountPercent case final value?)
        'itemDiscountPercent': value,
    };

CreateInvoicePaymentLine _$CreateInvoicePaymentLineFromJson(
        Map<String, dynamic> json) =>
    CreateInvoicePaymentLine(
      amount: (json['amount'] as num).toDouble(),
      paymentMethod: json['payment_method'] as String,
      paymentDate: json['payment_date'] as String,
      referenceId: json['reference_id'] as String?,
      clearanceDate: json['clearance_date'] as String?,
    );

Map<String, dynamic> _$CreateInvoicePaymentLineToJson(
        CreateInvoicePaymentLine instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'payment_method': instance.paymentMethod,
      'payment_date': instance.paymentDate,
      if (instance.referenceId case final value?) 'reference_id': value,
      if (instance.clearanceDate case final value?) 'clearance_date': value,
    };
