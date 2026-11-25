// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_cash_summary_query_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyCashSummaryQueryParams _$DailyCashSummaryQueryParamsFromJson(
        Map<String, dynamic> json) =>
    DailyCashSummaryQueryParams(
      date: json['date'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      limit: (json['limit'] as num?)?.toInt() ?? 50,
      offset: (json['offset'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$DailyCashSummaryQueryParamsToJson(
        DailyCashSummaryQueryParams instance) =>
    <String, dynamic>{
      'date': instance.date,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'limit': instance.limit,
      'offset': instance.offset,
    };
