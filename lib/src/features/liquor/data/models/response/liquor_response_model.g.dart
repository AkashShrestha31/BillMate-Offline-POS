// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liquor_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiquorItem _$LiquorItemFromJson(Map<String, dynamic> json) => LiquorItem(
      id: (json['itemId'] as num).toInt(),
      name: json['itemName'] as String,
      category: json['categoryName'] as String,
      brand: json['brandName'] as String,
      volume: json['volume'] as String,
      description: json['itemDescription'] as String?,
      created: json['itemCreated'] as String,
      pricingId: (json['pricingId'] as num).toInt(),
      purchasePrice: (json['purchasePrice'] as num).toDouble(),
      sellingPrice: (json['sellingPrice'] as num).toDouble(),
      marginAmount: (json['marginAmount'] as num).toDouble(),
      marginPercentage: (json['marginPercentage'] as num).toDouble(),
      effectiveFrom: json['effectiveFrom'] as String,
      location: json['pricingLocation'] as String,
      itemIsActive: (json['itemIsActive'] as num).toInt(),
      categoryId: (json['categoryId'] as num).toInt(),
      categoryDescription: json['categoryDescription'] as String?,
      categoryIsActive: (json['categoryIsActive'] as num).toInt(),
      brandId: (json['brandId'] as num).toInt(),
      effectiveTo: json['effectiveTo'] as String?,
      pricingNotes: json['pricingNotes'] as String?,
      pricingIsActive: (json['pricingIsActive'] as num).toInt(),
      pricingCreated: json['pricingCreated'] as String,
    );

Map<String, dynamic> _$LiquorItemToJson(LiquorItem instance) =>
    <String, dynamic>{
      'itemId': instance.id,
      'itemName': instance.name,
      'categoryName': instance.category,
      'brandName': instance.brand,
      'volume': instance.volume,
      'itemDescription': instance.description,
      'itemCreated': instance.created,
      'pricingId': instance.pricingId,
      'purchasePrice': instance.purchasePrice,
      'sellingPrice': instance.sellingPrice,
      'marginAmount': instance.marginAmount,
      'marginPercentage': instance.marginPercentage,
      'effectiveFrom': instance.effectiveFrom,
      'pricingLocation': instance.location,
      'itemIsActive': instance.itemIsActive,
      'categoryId': instance.categoryId,
      'categoryDescription': instance.categoryDescription,
      'categoryIsActive': instance.categoryIsActive,
      'brandId': instance.brandId,
      'effectiveTo': instance.effectiveTo,
      'pricingNotes': instance.pricingNotes,
      'pricingIsActive': instance.pricingIsActive,
      'pricingCreated': instance.pricingCreated,
    };

LiquorResponseModel _$LiquorResponseModelFromJson(Map<String, dynamic> json) =>
    LiquorResponseModel(
      items: (json['items'] as List<dynamic>)
          .map((e) => LiquorItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$LiquorResponseModelToJson(
        LiquorResponseModel instance) =>
    <String, dynamic>{
      'items': instance.items,
      'count': instance.count,
    };
