// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_adjustment_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockAdjustmentResponseModel _$StockAdjustmentResponseModelFromJson(
        Map<String, dynamic> json) =>
    StockAdjustmentResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      adjustmentsMade: (json['adjustments_made'] as num).toInt(),
      totalVarianceCorrected: (json['total_variance_corrected'] as num).toInt(),
      adjustmentRecords: (json['adjustment_records'] as List<dynamic>)
          .map((e) => AdjustmentRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      adjustmentDate: json['adjustment_date'] as String,
    );

Map<String, dynamic> _$StockAdjustmentResponseModelToJson(
        StockAdjustmentResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'adjustments_made': instance.adjustmentsMade,
      'total_variance_corrected': instance.totalVarianceCorrected,
      'adjustment_records': instance.adjustmentRecords,
      'adjustment_date': instance.adjustmentDate,
    };

AdjustmentRecord _$AdjustmentRecordFromJson(Map<String, dynamic> json) =>
    AdjustmentRecord(
      item: json['item'] as String,
      location: json['location'] as String,
      batchNumber: json['batch_number'] as String,
      previousQuantity: (json['previous_quantity'] as num).toInt(),
      adjustedQuantity: (json['adjusted_quantity'] as num).toInt(),
      variance: (json['variance'] as num).toInt(),
      adjustmentValue: (json['adjustment_value'] as num).toDouble(),
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$AdjustmentRecordToJson(AdjustmentRecord instance) =>
    <String, dynamic>{
      'item': instance.item,
      'location': instance.location,
      'batch_number': instance.batchNumber,
      'previous_quantity': instance.previousQuantity,
      'adjusted_quantity': instance.adjustedQuantity,
      'variance': instance.variance,
      'adjustment_value': instance.adjustmentValue,
      'reason': instance.reason,
    };
