// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payroll_query_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PayrollQueryParamsImpl _$$PayrollQueryParamsImplFromJson(
        Map<String, dynamic> json) =>
    _$PayrollQueryParamsImpl(
      employeeId: (json['employee_id'] as num?)?.toInt(),
      payrollMonth: json['payroll_month'] as String?,
      paymentStatus: json['payment_status'] as String?,
      year: (json['year'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PayrollQueryParamsImplToJson(
        _$PayrollQueryParamsImpl instance) =>
    <String, dynamic>{
      'employee_id': instance.employeeId,
      'payroll_month': instance.payrollMonth,
      'payment_status': instance.paymentStatus,
      'year': instance.year,
      'page': instance.page,
      'per_page': instance.perPage,
    };
