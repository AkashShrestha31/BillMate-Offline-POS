// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merge_items_bulk_operation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MergeItemsBulkOperationResponseImpl
    _$$MergeItemsBulkOperationResponseImplFromJson(Map<String, dynamic> json) =>
        _$MergeItemsBulkOperationResponseImpl(
          success: json['success'] as bool,
          message: json['message'] as String,
          sourceItem: json['source_item'] as String?,
          targetItem: json['target_item'] as String?,
          mergedData: json['merged_data'] as Map<String, dynamic>?,
        );

Map<String, dynamic> _$$MergeItemsBulkOperationResponseImplToJson(
        _$MergeItemsBulkOperationResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'source_item': instance.sourceItem,
      'target_item': instance.targetItem,
      'merged_data': instance.mergedData,
    };
