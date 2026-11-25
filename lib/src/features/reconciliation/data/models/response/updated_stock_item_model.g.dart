// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'updated_stock_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdatedStockItemModelImpl _$$UpdatedStockItemModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdatedStockItemModelImpl(
      name: json['name'] as String,
      item: json['item'] as String,
      location: json['location'] as String,
      reportingDate: json['reporting_date'] as String,
      previousQuantity: (json['previous_quantity'] as num).toDouble(),
      rate: (json['rate'] as num).toDouble(),
      value: (json['value'] as num).toDouble(),
      batchNumber: json['batch_number'] as String,
      expiryDate: json['expiry_date'] as String,
      notes: json['notes'] as String?,
      isActive: json['is_active'] as bool,
      modifiedBy: json['modified_by'] as String,
      modified: json['modified'] as String,
    );

Map<String, dynamic> _$$UpdatedStockItemModelImplToJson(
        _$UpdatedStockItemModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'item': instance.item,
      'location': instance.location,
      'reporting_date': instance.reportingDate,
      'previous_quantity': instance.previousQuantity,
      'rate': instance.rate,
      'value': instance.value,
      'batch_number': instance.batchNumber,
      'expiry_date': instance.expiryDate,
      'notes': instance.notes,
      'is_active': instance.isActive,
      'modified_by': instance.modifiedBy,
      'modified': instance.modified,
    };
