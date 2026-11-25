// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_application_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaveApplicationModelImpl _$$LeaveApplicationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LeaveApplicationModelImpl(
      id: (json['id'] as num).toInt(),
      applicationNumber: json['application_number'] as String,
      employeeId: (json['employee_id'] as num).toInt(),
      employeeName: json['employee_name'] as String,
      employeeCode: json['employee_code'] as String,
      leaveTypeId: (json['leave_type_id'] as num).toInt(),
      leaveTypeName: json['leave_type_name'] as String,
      fromDate: json['from_date'] as String,
      toDate: json['to_date'] as String,
      totalDays: (json['total_days'] as num).toDouble(),
      reason: json['reason'] as String,
      emergencyContact: json['emergency_contact'] as String?,
      handoverNotes: json['handover_notes'] as String?,
      applicationDate: json['application_date'] as String,
      status: json['status'] as String,
      approvedBy: json['approved_by'] as String?,
      approvedDate: json['approved_date'] as String?,
      rejectionReason: json['rejection_reason'] as String?,
      managerComments: json['manager_comments'] as String?,
      hrComments: json['hr_comments'] as String?,
      attachment: json['attachment'] as String?,
      isEmergency: json['is_emergency'] as bool,
      isHalfDay: json['is_half_day'] as bool,
      halfDaySession: json['half_day_session'] as String?,
      substituteEmployeeId: (json['substitute_employee_id'] as num?)?.toInt(),
      substituteName: json['substitute_name'] as String?,
      created: json['created'] as String?,
      modified: json['modified'] as String?,
    );

Map<String, dynamic> _$$LeaveApplicationModelImplToJson(
        _$LeaveApplicationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'application_number': instance.applicationNumber,
      'employee_id': instance.employeeId,
      'employee_name': instance.employeeName,
      'employee_code': instance.employeeCode,
      'leave_type_id': instance.leaveTypeId,
      'leave_type_name': instance.leaveTypeName,
      'from_date': instance.fromDate,
      'to_date': instance.toDate,
      'total_days': instance.totalDays,
      'reason': instance.reason,
      'emergency_contact': instance.emergencyContact,
      'handover_notes': instance.handoverNotes,
      'application_date': instance.applicationDate,
      'status': instance.status,
      'approved_by': instance.approvedBy,
      'approved_date': instance.approvedDate,
      'rejection_reason': instance.rejectionReason,
      'manager_comments': instance.managerComments,
      'hr_comments': instance.hrComments,
      'attachment': instance.attachment,
      'is_emergency': instance.isEmergency,
      'is_half_day': instance.isHalfDay,
      'half_day_session': instance.halfDaySession,
      'substitute_employee_id': instance.substituteEmployeeId,
      'substitute_name': instance.substituteName,
      'created': instance.created,
      'modified': instance.modified,
    };
