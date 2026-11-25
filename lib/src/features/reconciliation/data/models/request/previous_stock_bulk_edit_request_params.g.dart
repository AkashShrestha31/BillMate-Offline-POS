// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'previous_stock_bulk_edit_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PreviousStockBulkEditRequestParamsImpl
    _$$PreviousStockBulkEditRequestParamsImplFromJson(
            Map<String, dynamic> json) =>
        _$PreviousStockBulkEditRequestParamsImpl(
          stockItems: (json['stock_items'] as List<dynamic>)
              .map((e) => PreviousStockEditItemParams.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$PreviousStockBulkEditRequestParamsImplToJson(
        _$PreviousStockBulkEditRequestParamsImpl instance) =>
    <String, dynamic>{
      'stock_items': instance.stockItems,
    };
