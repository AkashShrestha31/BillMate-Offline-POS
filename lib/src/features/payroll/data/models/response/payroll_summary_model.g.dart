// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payroll_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PayrollSummaryModelImpl _$$PayrollSummaryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PayrollSummaryModelImpl(
      totalGrossPay: (json['total_gross_pay'] as num).toDouble(),
      totalNetPay: (json['total_net_pay'] as num).toDouble(),
      totalDeductions: (json['total_deductions'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$PayrollSummaryModelImplToJson(
        _$PayrollSummaryModelImpl instance) =>
    <String, dynamic>{
      'total_gross_pay': instance.totalGrossPay,
      'total_net_pay': instance.totalNetPay,
      'total_deductions': instance.totalDeductions,
    };
