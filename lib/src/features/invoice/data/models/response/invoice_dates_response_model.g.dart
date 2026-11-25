// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_dates_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceDatesResponseModel _$InvoiceDatesResponseModelFromJson(
        Map<String, dynamic> json) =>
    InvoiceDatesResponseModel(
      success: json['success'] as bool,
      dates: (json['data'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$InvoiceDatesResponseModelToJson(
        InvoiceDatesResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.dates,
    };
