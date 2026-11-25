// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payroll_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PayrollListResponseImpl _$$PayrollListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$PayrollListResponseImpl(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      summary:
          PayrollSummaryModel.fromJson(json['summary'] as Map<String, dynamic>),
      filtersApplied: FiltersAppliedModel.fromJson(
          json['filters_applied'] as Map<String, dynamic>),
      payrollRecords: (json['payroll_records'] as List<dynamic>)
          .map((e) => PayrollModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PayrollListResponseImplToJson(
        _$PayrollListResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'summary': instance.summary,
      'filters_applied': instance.filtersApplied,
      'payroll_records': instance.payrollRecords,
    };
