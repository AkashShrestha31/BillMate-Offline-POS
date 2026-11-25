// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payroll_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PayrollListResponseModelImpl _$$PayrollListResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PayrollListResponseModelImpl(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      summary: json['summary'] as Map<String, dynamic>?,
      filtersApplied: json['filters_applied'] as Map<String, dynamic>?,
      payrollRecords: (json['payroll_records'] as List<dynamic>)
          .map((e) => PayrollModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PayrollListResponseModelImplToJson(
        _$PayrollListResponseModelImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'summary': instance.summary,
      'filters_applied': instance.filtersApplied,
      'payroll_records': instance.payrollRecords,
    };
