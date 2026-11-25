// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filters_applied_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FiltersAppliedModelImpl _$$FiltersAppliedModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FiltersAppliedModelImpl(
      employeeId: (json['employee_id'] as num?)?.toInt(),
      payrollMonth: json['payroll_month'] as String?,
      paymentStatus: json['payment_status'] as String?,
      year: (json['year'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$FiltersAppliedModelImplToJson(
        _$FiltersAppliedModelImpl instance) =>
    <String, dynamic>{
      'employee_id': instance.employeeId,
      'payroll_month': instance.payrollMonth,
      'payment_status': instance.paymentStatus,
      'year': instance.year,
    };
