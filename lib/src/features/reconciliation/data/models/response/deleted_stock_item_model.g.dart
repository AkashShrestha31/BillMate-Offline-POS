// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deleted_stock_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeletedStockItemModelImpl _$$DeletedStockItemModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DeletedStockItemModelImpl(
      name: json['name'] as String,
      item: json['item'] as String,
      location: json['location'] as String,
      quantity: (json['quantity'] as num).toInt(),
      value: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$$DeletedStockItemModelImplToJson(
        _$DeletedStockItemModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'item': instance.item,
      'location': instance.location,
      'quantity': instance.quantity,
      'value': instance.value,
    };
