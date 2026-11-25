// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'previous_stock_delete_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PreviousStockDeleteResponseModelImpl
    _$$PreviousStockDeleteResponseModelImplFromJson(
            Map<String, dynamic> json) =>
        _$PreviousStockDeleteResponseModelImpl(
          success: json['success'] as bool,
          message: json['message'] as String,
          deletionSummary: DeletionSummaryModel.fromJson(
              json['deletion_summary'] as Map<String, dynamic>),
          deletedCount: (json['deleted_count'] as num).toInt(),
          deletedAt: json['deleted_at'] as String,
          deletedBy: json['deleted_by'] as String,
        );

Map<String, dynamic> _$$PreviousStockDeleteResponseModelImplToJson(
        _$PreviousStockDeleteResponseModelImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'deletion_summary': instance.deletionSummary,
      'deleted_count': instance.deletedCount,
      'deleted_at': instance.deletedAt,
      'deleted_by': instance.deletedBy,
    };
