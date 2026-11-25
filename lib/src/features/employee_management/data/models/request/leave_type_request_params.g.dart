// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_type_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaveTypeRequestParamsImpl _$$LeaveTypeRequestParamsImplFromJson(
        Map<String, dynamic> json) =>
    _$LeaveTypeRequestParamsImpl(
      leaveTypeName: json['leave_type_name'] as String,
      description: json['description'] as String?,
      maxDaysPerYear: (json['max_days_per_year'] as num).toInt(),
      carryForwardAllowed: json['carry_forward_allowed'] as bool?,
      maxCarryForwardDays: (json['max_carry_forward_days'] as num?)?.toInt(),
      requiresApproval: json['requires_approval'] as bool?,
      advanceNoticeDays: (json['advance_notice_days'] as num?)?.toInt(),
      isPaid: json['is_paid'] as bool?,
      genderSpecific: json['gender_specific'] as String?,
    );

Map<String, dynamic> _$$LeaveTypeRequestParamsImplToJson(
        _$LeaveTypeRequestParamsImpl instance) =>
    <String, dynamic>{
      'leave_type_name': instance.leaveTypeName,
      'description': instance.description,
      'max_days_per_year': instance.maxDaysPerYear,
      'carry_forward_allowed': instance.carryForwardAllowed,
      'max_carry_forward_days': instance.maxCarryForwardDays,
      'requires_approval': instance.requiresApproval,
      'advance_notice_days': instance.advanceNoticeDays,
      'is_paid': instance.isPaid,
      'gender_specific': instance.genderSpecific,
    };
