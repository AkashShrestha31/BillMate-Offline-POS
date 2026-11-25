// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'previous_stock_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreviousStockRequestParams _$PreviousStockRequestParamsFromJson(
        Map<String, dynamic> json) =>
    PreviousStockRequestParams(
      acceptLanguage: json['accept_language'] as String? ?? 'en',
      endDate: json['end_date'] as String?,
      items: json['items'] as String?,
      limit: (json['limit'] as num?)?.toInt(),
      locations: json['locations'] as String?,
      onlyActive: json['only_active'] as bool? ?? true,
      sortOrder: json['sort_order'] as String? ?? 'desc',
      startDate: json['start_date'] as String?,
    );

Map<String, dynamic> _$PreviousStockRequestParamsToJson(
        PreviousStockRequestParams instance) =>
    <String, dynamic>{
      'accept_language': instance.acceptLanguage,
      'end_date': instance.endDate,
      'items': instance.items,
      'limit': instance.limit,
      'locations': instance.locations,
      'only_active': instance.onlyActive,
      'sort_order': instance.sortOrder,
      'start_date': instance.startDate,
    };
