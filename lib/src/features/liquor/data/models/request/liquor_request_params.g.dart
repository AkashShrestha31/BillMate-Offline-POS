// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liquor_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiquorRequestParams _$LiquorRequestParamsFromJson(Map<String, dynamic> json) =>
    LiquorRequestParams(
      page: (json['page'] as num?)?.toInt() ?? 1,
      perPage: (json['per_page'] as num?)?.toInt() ?? 10,
      brand: json['brand'] as String?,
      category: json['category'] as String?,
      name: json['name'] as String?,
      location: json['location'] as String?,
      sortBy: json['sort_by'] as String?,
      sortOrder: json['sort_order'] as String? ?? 'desc',
      minPrice: (json['min_price'] as num?)?.toDouble(),
      maxPrice: (json['max_price'] as num?)?.toDouble(),
      minMargin: (json['min_margin'] as num?)?.toDouble(),
      maxMargin: (json['max_margin'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LiquorRequestParamsToJson(
        LiquorRequestParams instance) =>
    <String, dynamic>{
      'page': instance.page,
      'per_page': instance.perPage,
      'brand': instance.brand,
      'category': instance.category,
      'name': instance.name,
      'location': instance.location,
      'sort_by': instance.sortBy,
      'sort_order': instance.sortOrder,
      'min_price': instance.minPrice,
      'max_price': instance.maxPrice,
      'min_margin': instance.minMargin,
      'max_margin': instance.maxMargin,
    };
