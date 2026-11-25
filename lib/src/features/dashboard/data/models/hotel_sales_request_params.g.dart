// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel_sales_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HotelSalesRequestParamsImpl _$$HotelSalesRequestParamsImplFromJson(
        Map<String, dynamic> json) =>
    _$HotelSalesRequestParamsImpl(
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      page: (json['page'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$HotelSalesRequestParamsImplToJson(
        _$HotelSalesRequestParamsImpl instance) =>
    <String, dynamic>{
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'page': instance.page,
      'pageSize': instance.pageSize,
    };
