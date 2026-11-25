// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_payroll_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GeneratePayrollRequestImpl _$$GeneratePayrollRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$GeneratePayrollRequestImpl(
      employeeId: (json['employee_id'] as num).toInt(),
      addBonusDay: json['add_bonus_day'] as bool,
      payrollMonth: json['payroll_month'] as String,
      bonus: (json['bonus'] as num?)?.toDouble(),
      additionalAllowances: (json['additional_allowances'] as num?)?.toDouble(),
      additionalDeductions: (json['additional_deductions'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$GeneratePayrollRequestImplToJson(
        _$GeneratePayrollRequestImpl instance) =>
    <String, dynamic>{
      'employee_id': instance.employeeId,
      'add_bonus_day': instance.addBonusDay,
      'payroll_month': instance.payrollMonth,
      'bonus': instance.bonus,
      'additional_allowances': instance.additionalAllowances,
      'additional_deductions': instance.additionalDeductions,
    };
