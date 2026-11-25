// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_invoice_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateInvoiceResponseModel _$CreateInvoiceResponseModelFromJson(
        Map<String, dynamic> json) =>
    CreateInvoiceResponseModel(
      message: json['message'] as String,
      invoiceName: json['invoice_name'] as String,
      itemsCreated: (json['items_created'] as num).toInt(),
      netTotal: (json['net_total'] as num).toDouble(),
      grandTotal: (json['grand_total'] as num).toDouble(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$CreateInvoiceResponseModelToJson(
        CreateInvoiceResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'invoice_name': instance.invoiceName,
      'items_created': instance.itemsCreated,
      'net_total': instance.netTotal,
      'grand_total': instance.grandTotal,
      'status': instance.status,
    };
