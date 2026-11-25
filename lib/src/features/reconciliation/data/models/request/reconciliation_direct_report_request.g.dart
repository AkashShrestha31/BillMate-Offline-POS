// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reconciliation_direct_report_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReconciliationDirectReportRequestImpl
    _$$ReconciliationDirectReportRequestImplFromJson(
            Map<String, dynamic> json) =>
        _$ReconciliationDirectReportRequestImpl(
          previousStock: (json['previous_stock'] as List<dynamic>)
              .map((e) => StockItem.fromJson(e as Map<String, dynamic>))
              .toList(),
          currentStock: (json['current_stock'] as List<dynamic>)
              .map((e) => StockItem.fromJson(e as Map<String, dynamic>))
              .toList(),
          startDate: json['start_date'] as String,
          endDate: json['end_date'] as String,
          includeTransactionDetails:
              json['include_transaction_details'] as bool,
          saveReport: json['save_report'] as bool,
          reportName: json['report_name'] as String,
        );

Map<String, dynamic> _$$ReconciliationDirectReportRequestImplToJson(
        _$ReconciliationDirectReportRequestImpl instance) =>
    <String, dynamic>{
      'previous_stock': instance.previousStock,
      'current_stock': instance.currentStock,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'include_transaction_details': instance.includeTransactionDetails,
      'save_report': instance.saveReport,
      'report_name': instance.reportName,
    };

_$StockItemImpl _$$StockItemImplFromJson(Map<String, dynamic> json) =>
    _$StockItemImpl(
      item: json['item'] as String,
      location: json['location'] as String,
      quantity: _numberToDouble(json['quantity']),
    );

Map<String, dynamic> _$$StockItemImplToJson(_$StockItemImpl instance) =>
    <String, dynamic>{
      'item': instance.item,
      'location': instance.location,
      'quantity': instance.quantity,
    };
