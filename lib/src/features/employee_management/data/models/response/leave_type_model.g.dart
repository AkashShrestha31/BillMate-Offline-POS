// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaveTypeModelImpl _$$LeaveTypeModelImplFromJson(Map<String, dynamic> json) =>
    _$LeaveTypeModelImpl(
      id: (json['id'] as num).toInt(),
      leaveTypeName: json['leave_type_name'] as String,
      description: json['description'] as String?,
      maxDaysPerYear: (json['max_days_per_year'] as num).toInt(),
      carryForwardAllowed: json['carry_forward_allowed'] as bool,
      maxCarryForwardDays: (json['max_carry_forward_days'] as num?)?.toInt(),
      requiresApproval: json['requires_approval'] as bool,
      advanceNoticeDays: (json['advance_notice_days'] as num?)?.toInt(),
      isPaid: json['is_paid'] as bool,
      genderSpecific: json['gender_specific'] as String?,
      isActive: json['is_active'] as bool,
      created: json['created'] as String?,
      modified: json['modified'] as String?,
    );

Map<String, dynamic> _$$LeaveTypeModelImplToJson(
        _$LeaveTypeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'leave_type_name': instance.leaveTypeName,
      'description': instance.description,
      'max_days_per_year': instance.maxDaysPerYear,
      'carry_forward_allowed': instance.carryForwardAllowed,
      'max_carry_forward_days': instance.maxCarryForwardDays,
      'requires_approval': instance.requiresApproval,
      'advance_notice_days': instance.advanceNoticeDays,
      'is_paid': instance.isPaid,
      'gender_specific': instance.genderSpecific,
      'is_active': instance.isActive,
      'created': instance.created,
      'modified': instance.modified,
    };
