// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_invoice_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitInvoiceRequestParams _$SubmitInvoiceRequestParamsFromJson(
        Map<String, dynamic> json) =>
    SubmitInvoiceRequestParams(
      invoiceName: json['invoice_name'] as String,
      action: json['action'] as String? ?? "submit",
      modifiedBy: json['modified_by'] as String,
    );

Map<String, dynamic> _$SubmitInvoiceRequestParamsToJson(
        SubmitInvoiceRequestParams instance) =>
    <String, dynamic>{
      'invoice_name': instance.invoiceName,
      'action': instance.action,
      'modified_by': instance.modifiedBy,
    };
