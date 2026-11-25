// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricing_update_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PricingUpdateRequestParams _$PricingUpdateRequestParamsFromJson(
        Map<String, dynamic> json) =>
    PricingUpdateRequestParams(
      id: (json['id'] as num).toInt(),
      purchasePrice: (json['purchase_price'] as num?)?.toDouble(),
      sellingPrice: (json['selling_price'] as num?)?.toDouble(),
      location: json['location'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$PricingUpdateRequestParamsToJson(
        PricingUpdateRequestParams instance) =>
    <String, dynamic>{
      'id': instance.id,
      'purchase_price': instance.purchasePrice,
      'selling_price': instance.sellingPrice,
      'location': instance.location,
      'notes': instance.notes,
    };
