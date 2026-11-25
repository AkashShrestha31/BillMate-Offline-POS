// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deletion_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeletionSummaryModelImpl _$$DeletionSummaryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DeletionSummaryModelImpl(
      reportingDate: json['reporting_date'] as String,
      totalRecordsDeleted: (json['total_records_deleted'] as num).toInt(),
      uniqueItems: (json['unique_items'] as num).toInt(),
      uniqueLocations: (json['unique_locations'] as num).toInt(),
      totalQuantity: (json['total_quantity'] as num).toInt(),
      totalValue: (json['total_value'] as num).toDouble(),
      uploadedBy: json['uploaded_by'] as String,
      uploadTime: json['upload_time'] as String,
      sampleDeletedItems: (json['sample_deleted_items'] as List<dynamic>)
          .map((e) => DeletedStockItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DeletionSummaryModelImplToJson(
        _$DeletionSummaryModelImpl instance) =>
    <String, dynamic>{
      'reporting_date': instance.reportingDate,
      'total_records_deleted': instance.totalRecordsDeleted,
      'unique_items': instance.uniqueItems,
      'unique_locations': instance.uniqueLocations,
      'total_quantity': instance.totalQuantity,
      'total_value': instance.totalValue,
      'uploaded_by': instance.uploadedBy,
      'upload_time': instance.uploadTime,
      'sample_deleted_items': instance.sampleDeletedItems,
    };
