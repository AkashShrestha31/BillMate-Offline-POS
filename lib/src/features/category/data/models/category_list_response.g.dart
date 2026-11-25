// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryListResponse _$CategoryListResponseFromJson(
        Map<String, dynamic> json) =>
    CategoryListResponse(
      success: json['success'] as bool,
      count: (json['count'] as num?)?.toInt(),
      filtersApplied: json['filters_applied'] as Map<String, dynamic>?,
      data: (json['data'] as List<dynamic>)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryListResponseToJson(
        CategoryListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'filters_applied': instance.filtersApplied,
      'data': instance.data,
    };
