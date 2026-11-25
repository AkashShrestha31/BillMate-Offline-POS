// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_invoice_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteInvoiceRequestParams _$DeleteInvoiceRequestParamsFromJson(
        Map<String, dynamic> json) =>
    DeleteInvoiceRequestParams(
      invoiceNames: (json['invoice_names'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      invoiceType:
          $enumDecodeNullable(_$InvoiceTypeEnumMap, json['invoice_type']),
      confirmDelete: json['confirm_delete'] as bool?,
      forceDelete: json['force_delete'] as bool?,
      deletedBy: json['deleted_by'] as String?,
    );

Map<String, dynamic> _$DeleteInvoiceRequestParamsToJson(
        DeleteInvoiceRequestParams instance) =>
    <String, dynamic>{
      'invoice_names': instance.invoiceNames,
      'confirm_delete': instance.confirmDelete,
      'force_delete': instance.forceDelete,
      'deleted_by': instance.deletedBy,
    };

const _$InvoiceTypeEnumMap = {
  InvoiceType.sales: 'sales',
  InvoiceType.purchase: 'purchase',
};
