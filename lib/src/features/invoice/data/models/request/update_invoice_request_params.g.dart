// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_invoice_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateInvoiceRequestParams _$UpdateInvoiceRequestParamsFromJson(
        Map<String, dynamic> json) =>
    UpdateInvoiceRequestParams(
      invoiceName: json['invoice_name'] as String,
      action: json['action'] as String? ?? "update",
      modifiedBy: json['modified_by'] as String,
      party: json['party'] as String?,
      account: json['account'] as String?,
      submitted: (json['submitted'] as num?)?.toInt(),
      date: json['date'] as String?,
      currency: json['currency'] as String?,
      exchangeRate: (json['exchange_rate'] as num?)?.toDouble(),
      priceList: json['price_list'] as String?,
      setDiscountAmount: json['set_discount_amount'] as bool?,
      discountAmount: (json['discount_amount'] as num?)?.toDouble(),
      discountPercent: (json['discount_percent'] as num?)?.toDouble(),
      terms: json['terms'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => UpdateInvoiceItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UpdateInvoiceRequestParamsToJson(
        UpdateInvoiceRequestParams instance) =>
    <String, dynamic>{
      'invoice_name': instance.invoiceName,
      'action': instance.action,
      'modified_by': instance.modifiedBy,
      if (instance.party case final value?) 'party': value,
      if (instance.account case final value?) 'account': value,
      if (instance.date case final value?) 'date': value,
      if (instance.currency case final value?) 'currency': value,
      if (instance.submitted case final value?) 'submitted': value,
      if (instance.exchangeRate case final value?) 'exchange_rate': value,
      if (instance.priceList case final value?) 'price_list': value,
      if (instance.setDiscountAmount case final value?)
        'set_discount_amount': value,
      if (instance.discountAmount case final value?) 'discount_amount': value,
      if (instance.discountPercent case final value?) 'discount_percent': value,
      if (instance.terms case final value?) 'terms': value,
      if (instance.items case final value?) 'items': value,
    };

UpdateInvoiceItem _$UpdateInvoiceItemFromJson(Map<String, dynamic> json) =>
    UpdateInvoiceItem(
      action: json['action'] as String,
      itemId: json['item_id'] as String?,
      item: json['item'] as String?,
      rate: (json['rate'] as num?)?.toDouble(),
      quantity: (json['quantity'] as num?)?.toDouble(),
      account: json['account'] as String?,
      description: json['description'] as String?,
      unit: json['unit'] as String?,
      setItemDiscountAmount: json['set_item_discount_amount'] as bool?,
      itemDiscountAmount: (json['item_discount_amount'] as num?)?.toDouble(),
      itemDiscountPercent: (json['item_discount_percent'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UpdateInvoiceItemToJson(UpdateInvoiceItem instance) =>
    <String, dynamic>{
      'action': instance.action,
      if (instance.itemId case final value?) 'item_id': value,
      if (instance.item case final value?) 'item': value,
      if (instance.rate case final value?) 'rate': value,
      if (instance.quantity case final value?) 'quantity': value,
      if (instance.account case final value?) 'account': value,
      if (instance.description case final value?) 'description': value,
      if (instance.unit case final value?) 'unit': value,
      if (instance.setItemDiscountAmount case final value?)
        'set_item_discount_amount': value,
      if (instance.itemDiscountAmount case final value?)
        'item_discount_amount': value,
      if (instance.itemDiscountPercent case final value?)
        'item_discount_percent': value,
    };
