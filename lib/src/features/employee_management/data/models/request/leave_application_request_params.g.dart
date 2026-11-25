// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_application_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaveApplicationRequestParamsImpl
    _$$LeaveApplicationRequestParamsImplFromJson(Map<String, dynamic> json) =>
        _$LeaveApplicationRequestParamsImpl(
          employeeId: (json['employee_id'] as num).toInt(),
          leaveTypeId: (json['leave_type_id'] as num).toInt(),
          fromDate: json['from_date'] as String,
          toDate: json['to_date'] as String,
          reason: json['reason'] as String,
          emergencyContact: json['emergency_contact'] as String?,
          handoverNotes: json['handover_notes'] as String?,
          substituteEmployeeId:
              (json['substitute_employee_id'] as num?)?.toInt(),
          isEmergency: json['is_emergency'] as bool?,
          isHalfDay: json['is_half_day'] as bool?,
          halfDaySession: json['half_day_session'] as String?,
        );

Map<String, dynamic> _$$LeaveApplicationRequestParamsImplToJson(
        _$LeaveApplicationRequestParamsImpl instance) =>
    <String, dynamic>{
      'employee_id': instance.employeeId,
      'leave_type_id': instance.leaveTypeId,
      'from_date': instance.fromDate,
      'to_date': instance.toDate,
      'reason': instance.reason,
      'emergency_contact': instance.emergencyContact,
      'handover_notes': instance.handoverNotes,
      'substitute_employee_id': instance.substituteEmployeeId,
      'is_emergency': instance.isEmergency,
      'is_half_day': instance.isHalfDay,
      'half_day_session': instance.halfDaySession,
    };
