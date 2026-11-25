// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_analytics_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentAnalyticsResponseModel _$PaymentAnalyticsResponseModelFromJson(
        Map<String, dynamic> json) =>
    PaymentAnalyticsResponseModel(
      reportType: json['report_type'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => PaymentDayData.fromJson(e as Map<String, dynamic>))
          .toList(),
      filters: PaymentFilters.fromJson(json['filters'] as Map<String, dynamic>),
      summary: PaymentSummary.fromJson(json['summary'] as Map<String, dynamic>),
      note: json['note'] as String,
    );

Map<String, dynamic> _$PaymentAnalyticsResponseModelToJson(
        PaymentAnalyticsResponseModel instance) =>
    <String, dynamic>{
      'report_type': instance.reportType,
      'data': instance.data,
      'filters': instance.filters,
      'summary': instance.summary,
      'note': instance.note,
    };

PaymentDayData _$PaymentDayDataFromJson(Map<String, dynamic> json) =>
    PaymentDayData(
      reportDate: json['report_date'] as String,
      paymentCount: (json['payment_count'] as num).toInt(),
      totalPayments: PaymentDayData._doubleFromJson(json['total_payments']),
      averageAmount: PaymentDayData._doubleFromJson(json['average_amount']),
      paymentBreakdown: PaymentBreakdown.fromJson(
          json['payment_breakdown'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentDayDataToJson(PaymentDayData instance) =>
    <String, dynamic>{
      'report_date': instance.reportDate,
      'payment_count': instance.paymentCount,
      'total_payments': instance.totalPayments,
      'average_amount': instance.averageAmount,
      'payment_breakdown': instance.paymentBreakdown,
    };

PaymentBreakdown _$PaymentBreakdownFromJson(Map<String, dynamic> json) =>
    PaymentBreakdown(
      cashPayment: PaymentBreakdown._doubleFromJson(json['cash_payment']),
      transferPayment:
          PaymentBreakdown._doubleFromJson(json['transfer_payment']),
      bankPayment: PaymentBreakdown._doubleFromJson(json['bank_payment']),
      paymentDetails: (json['payment_details'] as List<dynamic>)
          .map((e) => PaymentDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentBreakdownToJson(PaymentBreakdown instance) =>
    <String, dynamic>{
      'cash_payment': instance.cashPayment,
      'transfer_payment': instance.transferPayment,
      'bank_payment': instance.bankPayment,
      'payment_details': instance.paymentDetails,
    };

PaymentDetail _$PaymentDetailFromJson(Map<String, dynamic> json) =>
    PaymentDetail(
      paymentName: json['payment_name'] as String?,
      method: json['method'] as String,
      amount: PaymentDetail._doubleFromJson(json['amount']),
      date: json['date'] as String,
      party: json['party'] as String?,
      paymentType: json['payment_type'] as String?,
      referenceId: json['reference_id'] as String?,
      paymentAccount: json['payment_account'] as String?,
      paymentForReferences: (json['payment_for_references'] as List<dynamic>)
          .map((e) => PaymentReference.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentDetailToJson(PaymentDetail instance) =>
    <String, dynamic>{
      if (instance.paymentName case final value?) 'payment_name': value,
      'method': instance.method,
      'amount': instance.amount,
      'date': instance.date,
      if (instance.party case final value?) 'party': value,
      if (instance.paymentType case final value?) 'payment_type': value,
      if (instance.referenceId case final value?) 'reference_id': value,
      if (instance.paymentAccount case final value?) 'payment_account': value,
      'payment_for_references': instance.paymentForReferences,
    };

PaymentReference _$PaymentReferenceFromJson(Map<String, dynamic> json) =>
    PaymentReference(
      referenceName: json['reference_name'] as String,
      referenceType: json['reference_type'] as String,
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$PaymentReferenceToJson(PaymentReference instance) =>
    <String, dynamic>{
      'reference_name': instance.referenceName,
      'reference_type': instance.referenceType,
      'amount': instance.amount,
    };

PaymentFilters _$PaymentFiltersFromJson(Map<String, dynamic> json) =>
    PaymentFilters(
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      paymentType: json['payment_type'] as String?,
    );

Map<String, dynamic> _$PaymentFiltersToJson(PaymentFilters instance) =>
    <String, dynamic>{
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'payment_type': instance.paymentType,
    };

PaymentSummary _$PaymentSummaryFromJson(Map<String, dynamic> json) =>
    PaymentSummary(
      totalPayments: (json['total_payments'] as num).toInt(),
      totalAmount: PaymentSummary._doubleFromJson(json['total_amount']),
      averageAmount: PaymentSummary._doubleFromJson(json['average_amount']),
      paymentMethodBreakdown: PaymentMethodBreakdown.fromJson(
          json['payment_method_breakdown'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentSummaryToJson(PaymentSummary instance) =>
    <String, dynamic>{
      'total_payments': instance.totalPayments,
      'total_amount': instance.totalAmount,
      'average_amount': instance.averageAmount,
      'payment_method_breakdown': instance.paymentMethodBreakdown,
    };

PaymentMethodBreakdown _$PaymentMethodBreakdownFromJson(
        Map<String, dynamic> json) =>
    PaymentMethodBreakdown(
      cashPayment: PaymentMethodBreakdown._doubleFromJson(json['cash_payment']),
      transferPayment:
          PaymentMethodBreakdown._doubleFromJson(json['transfer_payment']),
      bankPayment: PaymentMethodBreakdown._doubleFromJson(json['bank_payment']),
      methods: (json['methods'] as List<dynamic>)
          .map((e) => PaymentMethod.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentMethodBreakdownToJson(
        PaymentMethodBreakdown instance) =>
    <String, dynamic>{
      'cash_payment': instance.cashPayment,
      'transfer_payment': instance.transferPayment,
      'bank_payment': instance.bankPayment,
      'methods': instance.methods,
    };

PaymentMethod _$PaymentMethodFromJson(Map<String, dynamic> json) =>
    PaymentMethod(
      method: json['method'] as String,
      amount: PaymentMethod._doubleFromJson(json['amount']),
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$PaymentMethodToJson(PaymentMethod instance) =>
    <String, dynamic>{
      'method': instance.method,
      'amount': instance.amount,
      'count': instance.count,
    };
