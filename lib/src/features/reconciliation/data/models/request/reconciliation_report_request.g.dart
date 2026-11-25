// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reconciliation_report_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReconciliationReportRequestImpl _$$ReconciliationReportRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ReconciliationReportRequestImpl(
      fromDate: json['from_date'] as String,
      toDate: json['to_date'] as String,
      currentStockDate: json['current_stock_date'] as String,
      previousStockDate: json['previous_stock_date'] as String,
      items: (json['items'] as List<dynamic>).map((e) => e as String).toList(),
      locations:
          (json['locations'] as List<dynamic>).map((e) => e as String).toList(),
      saveReport: json['save_report'] as bool,
    );

Map<String, dynamic> _$$ReconciliationReportRequestImplToJson(
        _$ReconciliationReportRequestImpl instance) =>
    <String, dynamic>{
      'from_date': instance.fromDate,
      'to_date': instance.toDate,
      'current_stock_date': instance.currentStockDate,
      'previous_stock_date': instance.previousStockDate,
      'items': instance.items,
      'locations': instance.locations,
      'save_report': instance.saveReport,
    };
