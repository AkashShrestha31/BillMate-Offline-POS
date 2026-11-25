// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_counter_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemCounterResponseModelImpl _$$ItemCounterResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ItemCounterResponseModelImpl(
      itemCounts: (json['item_counts'] as List<dynamic>)
          .map((e) => ItemCount.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ItemCounterResponseModelImplToJson(
        _$ItemCounterResponseModelImpl instance) =>
    <String, dynamic>{
      'item_counts': instance.itemCounts,
    };

_$ItemCountImpl _$$ItemCountImplFromJson(Map<String, dynamic> json) =>
    _$ItemCountImpl(
      item: json['item'] as String,
      totalSold: (json['total_sold'] as num).toInt(),
      totalPurchased: (json['total_purchased'] as num).toInt(),
    );

Map<String, dynamic> _$$ItemCountImplToJson(_$ItemCountImpl instance) =>
    <String, dynamic>{
      'item': instance.item,
      'total_sold': instance.totalSold,
      'total_purchased': instance.totalPurchased,
    };
