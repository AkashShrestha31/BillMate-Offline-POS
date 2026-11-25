// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settlement_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettlementResponseModel _$SettlementResponseModelFromJson(
        Map<String, dynamic> json) =>
    SettlementResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      summary: json['summary'] == null
          ? null
          : SettlementSummary.fromJson(json['summary'] as Map<String, dynamic>),
      results: json['results'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$SettlementResponseModelToJson(
        SettlementResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'summary': instance.summary,
      'results': instance.results,
    };

SettlementSummary _$SettlementSummaryFromJson(Map<String, dynamic> json) =>
    SettlementSummary(
      totalPartiesProcessed: (json['total_parties_processed'] as num).toInt(),
      successfulSettlements: (json['successful_settlements'] as num).toInt(),
      failedSettlements: (json['failed_settlements'] as num).toInt(),
      totalAmountSettled: (json['total_amount_settled'] as num).toDouble(),
    );

Map<String, dynamic> _$SettlementSummaryToJson(SettlementSummary instance) =>
    <String, dynamic>{
      'total_parties_processed': instance.totalPartiesProcessed,
      'successful_settlements': instance.successfulSettlements,
      'failed_settlements': instance.failedSettlements,
      'total_amount_settled': instance.totalAmountSettled,
    };
