// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'previous_stock_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PreviousStockItemModelImpl _$$PreviousStockItemModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PreviousStockItemModelImpl(
      name: json['name'] as String,
      item: json['item'] as String,
      location: json['location'] as String,
      reportingDate: json['reporting_date'] as String,
      previousQuantity: (json['previous_quantity'] as num).toInt(),
      rate: (json['rate'] as num).toDouble(),
      value: (json['value'] as num).toDouble(),
      batchNumber: json['batch_number'] as String,
      expiryDate: json['expiry_date'] as String,
      isActive: json['is_active'] as bool,
      uploadDate: json['upload_date'] as String,
      uploadedBy: json['uploaded_by'] as String,
      notes: json['notes'] as String,
      createdBy: json['created_by'] as String,
      modifiedBy: json['modified_by'] as String,
      created: json['created'] as String,
      modified: json['modified'] as String,
    );

Map<String, dynamic> _$$PreviousStockItemModelImplToJson(
        _$PreviousStockItemModelImpl instance) =>
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
      'is_active': instance.isActive,
      'upload_date': instance.uploadDate,
      'uploaded_by': instance.uploadedBy,
      'notes': instance.notes,
      'created_by': instance.createdBy,
      'modified_by': instance.modifiedBy,
      'created': instance.created,
      'modified': instance.modified,
    };
