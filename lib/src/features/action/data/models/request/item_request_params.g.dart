// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemRequestParams _$ItemRequestParamsFromJson(Map<String, dynamic> json) =>
    ItemRequestParams(
      acceptLanguage: json['accept_language'] as String?,
      category: json['category'] as String?,
      excludeZeroSales: json['exclude_zero_sales'] as bool? ?? false,
      forFilter: json['for_filter'] as String?,
      itemType: json['item_type'] as String?,
      page: (json['page'] as num?)?.toInt() ?? 1,
      perPage: (json['per_page'] as num?)?.toInt() ?? 10,
      search: json['search'] as String?,
      sortBy: json['sort_by'] as String? ?? 'name',
      sortOrder: json['sort_order'] as String? ?? 'asc',
      favoritesOnly: json['favorites_only'] as bool?,
      repeatedSales: json['repeated_sales'] as bool?,
    );

Map<String, dynamic> _$ItemRequestParamsToJson(ItemRequestParams instance) =>
    <String, dynamic>{
      'accept_language': instance.acceptLanguage,
      'category': instance.category,
      'exclude_zero_sales': instance.excludeZeroSales,
      'for_filter': instance.forFilter,
      'item_type': instance.itemType,
      'page': instance.page,
      'per_page': instance.perPage,
      'search': instance.search,
      'sort_by': instance.sortBy,
      'sort_order': instance.sortOrder,
      'favorites_only': instance.favoritesOnly,
      'repeated_sales': instance.repeatedSales,
    };
