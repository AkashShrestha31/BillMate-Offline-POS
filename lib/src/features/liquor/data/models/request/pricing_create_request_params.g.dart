// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricing_create_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PricingCreateRequestParams _$PricingCreateRequestParamsFromJson(
        Map<String, dynamic> json) =>
    PricingCreateRequestParams(
      itemName: json['item_name'] as String,
      purchasePrice: (json['purchase_price'] as num).toDouble(),
      sellingPrice: (json['selling_price'] as num).toDouble(),
      effectiveFrom: json['effective_from'] as String,
      location: json['location'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$PricingCreateRequestParamsToJson(
        PricingCreateRequestParams instance) =>
    <String, dynamic>{
      'item_name': instance.itemName,
      'purchase_price': instance.purchasePrice,
      'selling_price': instance.sellingPrice,
      'effective_from': instance.effectiveFrom,
      'location': instance.location,
      'notes': instance.notes,
    };
