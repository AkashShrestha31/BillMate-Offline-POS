// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceRequestParams _$InvoiceRequestParamsFromJson(
        Map<String, dynamic> json) =>
    InvoiceRequestParams(
      page: (json['page'] as num?)?.toInt() ?? 1,
      perPage: (json['perPage'] as num?)?.toInt() ?? 100,
      party: json['party'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
      itemName: json['itemName'] as String?,
      invoiceType:
          $enumDecodeNullable(_$InvoiceTypeEnumMap, json['invoiceType']),
      sortOrder: json['sortOrder'] as String? ?? "desc",
    );

Map<String, dynamic> _$InvoiceRequestParamsToJson(
        InvoiceRequestParams instance) =>
    <String, dynamic>{
      'page': instance.page,
      'perPage': instance.perPage,
      'party': instance.party,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'itemName': instance.itemName,
      'paymentStatus': instance.paymentStatus,
      'sortOrder': instance.sortOrder,
      'invoiceType': _$InvoiceTypeEnumMap[instance.invoiceType],
    };

const _$InvoiceTypeEnumMap = {
  InvoiceType.sales: 'sales',
  InvoiceType.purchase: 'purchase',
};
