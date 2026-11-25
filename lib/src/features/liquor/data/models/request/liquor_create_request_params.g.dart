// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liquor_create_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PricingInfo _$PricingInfoFromJson(Map<String, dynamic> json) => PricingInfo(
      purchasePrice: (json['purchasePrice'] as num).toInt(),
      sellingPrice: (json['sellingPrice'] as num).toInt(),
      effectiveFrom: json['effectiveFrom'] as String,
      effectiveTo: json['effectiveTo'] as String,
      location: json['location'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$PricingInfoToJson(PricingInfo instance) =>
    <String, dynamic>{
      'purchasePrice': instance.purchasePrice,
      'sellingPrice': instance.sellingPrice,
      'effectiveFrom': instance.effectiveFrom,
      'effectiveTo': instance.effectiveTo,
      'location': instance.location,
      'notes': instance.notes,
    };

LiquorCreateRequestParams _$LiquorCreateRequestParamsFromJson(
        Map<String, dynamic> json) =>
    LiquorCreateRequestParams(
      name: json['name'] as String,
      category: json['category'] as String,
      categoryDescription: json['categoryDescription'] as String?,
      brand: json['brand'] as String,
      volume: json['volume'] as String,
      description: json['description'] as String?,
      pricing: PricingInfo.fromJson(json['pricing'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LiquorCreateRequestParamsToJson(
        LiquorCreateRequestParams instance) =>
    <String, dynamic>{
      'name': instance.name,
      'category': instance.category,
      if (instance.categoryDescription case final value?)
        'categoryDescription': value,
      'brand': instance.brand,
      'volume': instance.volume,
      if (instance.description case final value?) 'description': value,
      'pricing': instance.pricing,
    };
