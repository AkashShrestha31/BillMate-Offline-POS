// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_adjustment_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockAdjustmentRequestParams _$StockAdjustmentRequestParamsFromJson(
        Map<String, dynamic> json) =>
    StockAdjustmentRequestParams(
      adjustmentDate: json['adjustment_date'] as String,
      reason: json['reason'] as String?,
      notes: json['notes'] as String?,
      adjustments: (json['adjustments'] as List<dynamic>)
          .map((e) => AdjustmentItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StockAdjustmentRequestParamsToJson(
        StockAdjustmentRequestParams instance) =>
    <String, dynamic>{
      'adjustment_date': instance.adjustmentDate,
      'reason': instance.reason,
      'notes': instance.notes,
      'adjustments': instance.adjustments,
    };

AdjustmentItem _$AdjustmentItemFromJson(Map<String, dynamic> json) =>
    AdjustmentItem(
      item: json['item'] as String,
      location: json['location'] as String,
      batchNumber: json['batch_number'] as String,
      currentQuantity: (json['current_quantity'] as num).toInt(),
      adjustedQuantity: (json['adjusted_quantity'] as num).toInt(),
      rate: (json['rate'] as num).toDouble(),
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$AdjustmentItemToJson(AdjustmentItem instance) =>
    <String, dynamic>{
      'item': instance.item,
      'location': instance.location,
      'batch_number': instance.batchNumber,
      'current_quantity': instance.currentQuantity,
      'adjusted_quantity': instance.adjustedQuantity,
      'rate': instance.rate,
      'reason': instance.reason,
    };
