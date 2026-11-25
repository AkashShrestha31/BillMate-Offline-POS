// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payroll_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PayrollRequestParamsImpl _$$PayrollRequestParamsImplFromJson(
        Map<String, dynamic> json) =>
    _$PayrollRequestParamsImpl(
      employeeId: (json['employee_id'] as num).toInt(),
      payrollMonth: json['payroll_month'] as String,
      bonus: (json['bonus'] as num?)?.toDouble(),
      additionalAllowances: (json['additional_allowances'] as num?)?.toDouble(),
      additionalDeductions: (json['additional_deductions'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$PayrollRequestParamsImplToJson(
        _$PayrollRequestParamsImpl instance) =>
    <String, dynamic>{
      'employee_id': instance.employeeId,
      'payroll_month': instance.payrollMonth,
      'bonus': instance.bonus,
      'additional_allowances': instance.additionalAllowances,
      'additional_deductions': instance.additionalDeductions,
    };
