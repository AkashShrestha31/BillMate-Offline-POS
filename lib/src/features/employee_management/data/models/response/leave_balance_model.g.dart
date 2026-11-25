// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_balance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaveBalanceModelImpl _$$LeaveBalanceModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LeaveBalanceModelImpl(
      id: (json['id'] as num).toInt(),
      employeeId: (json['employee_id'] as num).toInt(),
      employeeName: json['employee_name'] as String,
      employeeCode: json['employee_code'] as String,
      leaveTypeId: (json['leave_type_id'] as num).toInt(),
      leaveTypeName: json['leave_type_name'] as String,
      year: (json['year'] as num).toInt(),
      totalAllocated: (json['total_allocated'] as num).toInt(),
      totalUsed: (json['total_used'] as num).toInt(),
      totalPending: (json['total_pending'] as num).toInt(),
      balanceRemaining: (json['balance_remaining'] as num).toInt(),
      carryForwardFromPrevious:
          (json['carry_forward_from_previous'] as num?)?.toInt(),
      utilizationPercentage:
          (json['utilization_percentage'] as num?)?.toDouble(),
      lastUpdated: json['last_updated'] as String?,
      created: json['created'] as String?,
      modified: json['modified'] as String?,
    );

Map<String, dynamic> _$$LeaveBalanceModelImplToJson(
        _$LeaveBalanceModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employee_id': instance.employeeId,
      'employee_name': instance.employeeName,
      'employee_code': instance.employeeCode,
      'leave_type_id': instance.leaveTypeId,
      'leave_type_name': instance.leaveTypeName,
      'year': instance.year,
      'total_allocated': instance.totalAllocated,
      'total_used': instance.totalUsed,
      'total_pending': instance.totalPending,
      'balance_remaining': instance.balanceRemaining,
      'carry_forward_from_previous': instance.carryForwardFromPrevious,
      'utilization_percentage': instance.utilizationPercentage,
      'last_updated': instance.lastUpdated,
      'created': instance.created,
      'modified': instance.modified,
    };
