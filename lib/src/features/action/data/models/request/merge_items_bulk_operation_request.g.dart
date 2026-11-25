// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merge_items_bulk_operation_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MergeItemsBulkOperationRequestImpl
    _$$MergeItemsBulkOperationRequestImplFromJson(Map<String, dynamic> json) =>
        _$MergeItemsBulkOperationRequestImpl(
          operation: json['operation'] as String,
          mergeData:
              MergeData.fromJson(json['merge_data'] as Map<String, dynamic>),
          modifiedBy: json['modifiedBy'] as String?,
        );

Map<String, dynamic> _$$MergeItemsBulkOperationRequestImplToJson(
        _$MergeItemsBulkOperationRequestImpl instance) =>
    <String, dynamic>{
      'operation': instance.operation,
      'merge_data': instance.mergeData,
      if (instance.modifiedBy case final value?) 'modifiedBy': value,
    };

_$MergeDataImpl _$$MergeDataImplFromJson(Map<String, dynamic> json) =>
    _$MergeDataImpl(
      sourceItem: json['source_item'] as String,
      targetItem: json['target_item'] as String,
    );

Map<String, dynamic> _$$MergeDataImplToJson(_$MergeDataImpl instance) =>
    <String, dynamic>{
      'source_item': instance.sourceItem,
      'target_item': instance.targetItem,
    };
