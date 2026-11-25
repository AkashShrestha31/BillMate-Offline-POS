// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_invoice_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitInvoiceResponseModel _$SubmitInvoiceResponseModelFromJson(
        Map<String, dynamic> json) =>
    SubmitInvoiceResponseModel(
      message: json['message'] as String,
      invoiceName: json['invoice_name'] as String,
      action: json['action'] as String,
    );

Map<String, dynamic> _$SubmitInvoiceResponseModelToJson(
        SubmitInvoiceResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'invoice_name': instance.invoiceName,
      'action': instance.action,
    };
