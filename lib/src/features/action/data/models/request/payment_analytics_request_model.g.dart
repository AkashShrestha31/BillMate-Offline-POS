// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_analytics_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentAnalyticsRequestModel _$PaymentAnalyticsRequestModelFromJson(
        Map<String, dynamic> json) =>
    PaymentAnalyticsRequestModel(
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      paymentType: json['payment_type'] as String?,
      reportType: json['report_type'] as String,
      referenceType: json['reference_type'] as String,
    );

Map<String, dynamic> _$PaymentAnalyticsRequestModelToJson(
        PaymentAnalyticsRequestModel instance) =>
    <String, dynamic>{
      if (instance.startDate case final value?) 'start_date': value,
      if (instance.endDate case final value?) 'end_date': value,
      if (instance.paymentType case final value?) 'payment_type': value,
      'report_type': instance.reportType,
      'reference_type': instance.referenceType,
    };
