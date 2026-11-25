// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'previous_stock_details_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PreviousStockDetailsResponseModelImpl
    _$$PreviousStockDetailsResponseModelImplFromJson(
            Map<String, dynamic> json) =>
        _$PreviousStockDetailsResponseModelImpl(
          success: json['success'] as bool,
          stockItems: (json['stock_items'] as List<dynamic>)
              .map((e) =>
                  PreviousStockItemModel.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$PreviousStockDetailsResponseModelImplToJson(
        _$PreviousStockDetailsResponseModelImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'stock_items': instance.stockItems,
    };
