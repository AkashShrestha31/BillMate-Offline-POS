// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'previous_stock_bulk_edit_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PreviousStockBulkEditResponseModelImpl
    _$$PreviousStockBulkEditResponseModelImplFromJson(
            Map<String, dynamic> json) =>
        _$PreviousStockBulkEditResponseModelImpl(
          success: json['success'] as bool,
          message: json['message'] as String,
          summary: EditSummaryModel.fromJson(
              json['summary'] as Map<String, dynamic>),
          updatedItems: (json['updated_items'] as List<dynamic>)
              .map((e) =>
                  UpdatedStockItemModel.fromJson(e as Map<String, dynamic>))
              .toList(),
          failedItems: (json['failed_items'] as List<dynamic>)
              .map((e) =>
                  FailedStockItemModel.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$PreviousStockBulkEditResponseModelImplToJson(
        _$PreviousStockBulkEditResponseModelImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'summary': instance.summary,
      'updated_items': instance.updatedItems,
      'failed_items': instance.failedItems,
    };
