// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'previous_stock_edit_item_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PreviousStockEditItemParamsImpl _$$PreviousStockEditItemParamsImplFromJson(
        Map<String, dynamic> json) =>
    _$PreviousStockEditItemParamsImpl(
      name: json['name'] as String,
      previousQuantity: (json['previousQuantity'] as num?)?.toDouble(),
      rate: (json['rate'] as num?)?.toDouble(),
      value: (json['value'] as num?)?.toDouble(),
      batchNumber: json['batchNumber'] as String?,
      expiryDate: json['expiryDate'] as String?,
      notes: json['notes'] as String?,
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$$PreviousStockEditItemParamsImplToJson(
        _$PreviousStockEditItemParamsImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      if (instance.previousQuantity case final value?)
        'previousQuantity': value,
      if (instance.rate case final value?) 'rate': value,
      if (instance.value case final value?) 'value': value,
      if (instance.batchNumber case final value?) 'batchNumber': value,
      if (instance.expiryDate case final value?) 'expiryDate': value,
      if (instance.notes case final value?) 'notes': value,
      if (instance.isActive case final value?) 'isActive': value,
    };
