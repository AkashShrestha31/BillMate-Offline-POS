// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceModelImpl _$$AttendanceModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendanceModelImpl(
      id: (json['id'] as num).toInt(),
      employeeId: (json['employee_id'] as num).toInt(),
      employeeName: json['employee_name'] as String,
      employeeCode: json['employee_code'] as String,
      attendanceDate: json['attendance_date'] as String,
      checkInTime: json['check_in_time'] as String?,
      checkOutTime: json['check_out_time'] as String?,
      breakStartTime: json['break_start_time'] as String?,
      breakEndTime: json['break_end_time'] as String?,
      totalHoursWorked: (json['total_hours_worked'] as num).toDouble(),
      totalBreakHours: (json['total_break_hours'] as num?)?.toDouble(),
      overtimeHours: (json['overtime_hours'] as num).toDouble(),
      attendanceStatus: json['attendance_status'] as String,
      lateArrivalMinutes: (json['late_arrival_minutes'] as num?)?.toInt(),
      earlyDepartureMinutes: (json['early_departure_minutes'] as num?)?.toInt(),
      location: json['location'] as String?,
      notes: json['notes'] as String?,
      approvedBy: json['approved_by'] as String?,
      isApproved: json['is_approved'] as bool,
      created: json['created'] as String?,
      modified: json['modified'] as String?,
    );

Map<String, dynamic> _$$AttendanceModelImplToJson(
        _$AttendanceModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employee_id': instance.employeeId,
      'employee_name': instance.employeeName,
      'employee_code': instance.employeeCode,
      'attendance_date': instance.attendanceDate,
      'check_in_time': instance.checkInTime,
      'check_out_time': instance.checkOutTime,
      'break_start_time': instance.breakStartTime,
      'break_end_time': instance.breakEndTime,
      'total_hours_worked': instance.totalHoursWorked,
      'total_break_hours': instance.totalBreakHours,
      'overtime_hours': instance.overtimeHours,
      'attendance_status': instance.attendanceStatus,
      'late_arrival_minutes': instance.lateArrivalMinutes,
      'early_departure_minutes': instance.earlyDepartureMinutes,
      'location': instance.location,
      'notes': instance.notes,
      'approved_by': instance.approvedBy,
      'is_approved': instance.isApproved,
      'created': instance.created,
      'modified': instance.modified,
    };
