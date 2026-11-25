// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reconciliation_report_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReconciliationReportResponseImpl _$$ReconciliationReportResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ReconciliationReportResponseImpl(
      success: json['success'] as bool,
      reportDate: json['report_date'] as String,
      period: json['period'] as String,
      startingStockDate: json['starting_stock_date'] as String,
      currentStockDate: json['current_stock_date'] as String,
      reconciliationMethod: json['reconciliation_method'] as String,
      calculationExplanation: json['calculation_explanation'] as String,
      summary: ReconciliationReportSummary.fromJson(
          json['summary'] as Map<String, dynamic>),
      reconciliationDetails: (json['reconciliation_details'] as List<dynamic>)
          .map((e) =>
              ReconciliationReportDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      savedToDatabase: json['saved_to_database'] as bool,
    );

Map<String, dynamic> _$$ReconciliationReportResponseImplToJson(
        _$ReconciliationReportResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'report_date': instance.reportDate,
      'period': instance.period,
      'starting_stock_date': instance.startingStockDate,
      'current_stock_date': instance.currentStockDate,
      'reconciliation_method': instance.reconciliationMethod,
      'calculation_explanation': instance.calculationExplanation,
      'summary': instance.summary,
      'reconciliation_details': instance.reconciliationDetails,
      'saved_to_database': instance.savedToDatabase,
    };

_$ReconciliationReportSummaryImpl _$$ReconciliationReportSummaryImplFromJson(
        Map<String, dynamic> json) =>
    _$ReconciliationReportSummaryImpl(
      totalItems: (json['total_items'] as num).toInt(),
      overStockItems: (json['over_stock_items'] as num).toInt(),
      shortStockItems: (json['short_stock_items'] as num).toInt(),
      matchingItems: (json['matching_items'] as num).toInt(),
      totalVarianceValue: _stringToDouble(json['total_variance_value']),
      totalOverValue: _stringToDouble(json['total_over_value']),
      totalShortValue: _stringToDouble(json['total_short_value']),
    );

Map<String, dynamic> _$$ReconciliationReportSummaryImplToJson(
        _$ReconciliationReportSummaryImpl instance) =>
    <String, dynamic>{
      'total_items': instance.totalItems,
      'over_stock_items': instance.overStockItems,
      'short_stock_items': instance.shortStockItems,
      'matching_items': instance.matchingItems,
      'total_variance_value': instance.totalVarianceValue,
      'total_over_value': instance.totalOverValue,
      'total_short_value': instance.totalShortValue,
    };

_$ReconciliationReportDetailImpl _$$ReconciliationReportDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$ReconciliationReportDetailImpl(
      item: json['item'] as String,
      location: json['location'] as String,
      startingStock: (json['starting_stock'] as num).toInt(),
      totalPurchases: (json['total_purchases'] as num).toInt(),
      totalSales: (json['total_sales'] as num).toInt(),
      totalStockIn: (json['total_stock_in'] as num).toInt(),
      totalStockOut: (json['total_stock_out'] as num).toInt(),
      expectedStock: (json['expected_stock'] as num).toInt(),
      actualStock: (json['actual_stock'] as num).toInt(),
      variance: (json['variance'] as num).toInt(),
      varianceValue: _stringToDouble(json['variance_value']),
      itemRate: _stringToDouble(json['item_rate']),
      preciousStock: (json['precious_stock'] as List<dynamic>?)
          ?.map((e) => StockRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentStock: (json['current_stock'] as List<dynamic>?)
          ?.map((e) => StockRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
      calculationFormula: json['calculation_formula'] as String,
    );

Map<String, dynamic> _$$ReconciliationReportDetailImplToJson(
        _$ReconciliationReportDetailImpl instance) =>
    <String, dynamic>{
      'item': instance.item,
      'location': instance.location,
      'starting_stock': instance.startingStock,
      'total_purchases': instance.totalPurchases,
      'total_sales': instance.totalSales,
      'total_stock_in': instance.totalStockIn,
      'total_stock_out': instance.totalStockOut,
      'expected_stock': instance.expectedStock,
      'actual_stock': instance.actualStock,
      'variance': instance.variance,
      'variance_value': instance.varianceValue,
      'item_rate': instance.itemRate,
      'precious_stock': instance.preciousStock,
      'current_stock': instance.currentStock,
      'status': instance.status,
      'calculation_formula': instance.calculationFormula,
    };

_$StockRecordImpl _$$StockRecordImplFromJson(Map<String, dynamic> json) =>
    _$StockRecordImpl(
      name: json['name'] as String,
      item: json['item'] as String,
      location: json['location'] as String,
      previousQuantity: (json['previousQuantity'] as num).toInt(),
      reportingDate: json['reportingDate'] as String,
      uploadDate: json['uploadDate'] as String,
      uploadedBy: json['uploadedBy'] as String,
      batchNumber: json['batchNumber'] as String,
      expiryDate: json['expiryDate'] as String,
      rate: (json['rate'] as num).toInt(),
      value: (json['value'] as num).toInt(),
      notes: json['notes'] as String,
      isActive: (json['isActive'] as num).toInt(),
      createdBy: json['createdBy'] as String,
      modifiedBy: json['modifiedBy'] as String,
      created: json['created'] as String,
      modified: json['modified'] as String,
    );

Map<String, dynamic> _$$StockRecordImplToJson(_$StockRecordImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'item': instance.item,
      'location': instance.location,
      'previousQuantity': instance.previousQuantity,
      'reportingDate': instance.reportingDate,
      'uploadDate': instance.uploadDate,
      'uploadedBy': instance.uploadedBy,
      'batchNumber': instance.batchNumber,
      'expiryDate': instance.expiryDate,
      'rate': instance.rate,
      'value': instance.value,
      'notes': instance.notes,
      'isActive': instance.isActive,
      'createdBy': instance.createdBy,
      'modifiedBy': instance.modifiedBy,
      'created': instance.created,
      'modified': instance.modified,
    };
