// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liquor_update_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiquorUpdateRequestParams _$LiquorUpdateRequestParamsFromJson(
        Map<String, dynamic> json) =>
    LiquorUpdateRequestParams(
      itemId: (json['itemId'] as num).toInt(),
      itemName: json['itemName'] as String,
      volume: json['volume'] as String,
      itemDescription: json['itemDescription'] as String?,
      itemCreated: json['itemCreated'] as String?,
      itemIsActive: (json['itemIsActive'] as num).toInt(),
      categoryId: (json['categoryId'] as num).toInt(),
      categoryName: json['categoryName'] as String,
      categoryDescription: json['categoryDescription'] as String?,
      categoryIsActive: (json['categoryIsActive'] as num?)?.toInt(),
      brandId: (json['brandId'] as num).toInt(),
      brandName: json['brandName'] as String,
      pricingId: (json['pricingId'] as num).toInt(),
      purchasePrice: (json['purchasePrice'] as num).toInt(),
      sellingPrice: (json['sellingPrice'] as num).toInt(),
      marginAmount: (json['marginAmount'] as num).toInt(),
      marginPercentage: (json['marginPercentage'] as num?)?.toDouble(),
      effectiveFrom: json['effectiveFrom'] as String?,
      effectiveTo: json['effectiveTo'] as String?,
      pricingLocation: json['pricingLocation'] as String?,
      pricingNotes: json['pricingNotes'] as String?,
      pricingIsActive: (json['pricingIsActive'] as num?)?.toInt(),
      pricingCreated: json['pricingCreated'] as String?,
    );

Map<String, dynamic> _$LiquorUpdateRequestParamsToJson(
        LiquorUpdateRequestParams instance) =>
    <String, dynamic>{
      'itemId': instance.itemId,
      'itemName': instance.itemName,
      'volume': instance.volume,
      if (instance.itemDescription case final value?) 'itemDescription': value,
      if (instance.itemCreated case final value?) 'itemCreated': value,
      'itemIsActive': instance.itemIsActive,
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      if (instance.categoryDescription case final value?)
        'categoryDescription': value,
      if (instance.categoryIsActive case final value?)
        'categoryIsActive': value,
      'brandId': instance.brandId,
      'brandName': instance.brandName,
      'pricingId': instance.pricingId,
      'purchasePrice': instance.purchasePrice,
      'sellingPrice': instance.sellingPrice,
      'marginAmount': instance.marginAmount,
      if (instance.marginPercentage case final value?)
        'marginPercentage': value,
      if (instance.effectiveFrom case final value?) 'effectiveFrom': value,
      if (instance.effectiveTo case final value?) 'effectiveTo': value,
      if (instance.pricingLocation case final value?) 'pricingLocation': value,
      if (instance.pricingNotes case final value?) 'pricingNotes': value,
      if (instance.pricingIsActive case final value?) 'pricingIsActive': value,
      if (instance.pricingCreated case final value?) 'pricingCreated': value,
    };
