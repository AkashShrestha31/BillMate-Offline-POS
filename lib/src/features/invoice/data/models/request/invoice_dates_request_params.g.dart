// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_dates_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceDatesRequestParams _$InvoiceDatesRequestParamsFromJson(
        Map<String, dynamic> json) =>
    InvoiceDatesRequestParams(
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      invoiceType: json['invoice_type'] as String?,
      month: json['month'] as String?,
    );

Map<String, dynamic> _$InvoiceDatesRequestParamsToJson(
        InvoiceDatesRequestParams instance) =>
    <String, dynamic>{
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'invoice_type': instance.invoiceType,
      'month': instance.month,
    };
