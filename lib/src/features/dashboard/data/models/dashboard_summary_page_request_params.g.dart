// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_summary_page_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardSummaryPageRequestParams _$DashboardSummaryPageRequestParamsFromJson(
        Map<String, dynamic> json) =>
    DashboardSummaryPageRequestParams(
      acceptLanguage: json['accept_language'] as String? ?? 'en',
      dailyMonth: json['daily_month'] as String?,
    );

Map<String, dynamic> _$DashboardSummaryPageRequestParamsToJson(
        DashboardSummaryPageRequestParams instance) =>
    <String, dynamic>{
      'accept_language': instance.acceptLanguage,
      'daily_month': instance.dailyMonth,
    };
