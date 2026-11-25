// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_payroll_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GeneratePayrollResponseImpl _$$GeneratePayrollResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GeneratePayrollResponseImpl(
      success: json['success'] as bool,
      message: json['message'] as String,
      payroll: PayrollModel.fromJson(json['payroll'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GeneratePayrollResponseImplToJson(
        _$GeneratePayrollResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'payroll': instance.payroll,
    };
