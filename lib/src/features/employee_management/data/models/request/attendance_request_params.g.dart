// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceRequestParamsImpl _$$AttendanceRequestParamsImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendanceRequestParamsImpl(
      employeeId: (json['employee_id'] as num).toInt(),
      attendanceDate: json['attendance_date'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      checkInTime: json['check_in_time'] as String?,
      checkOutTime: json['check_out_time'] as String?,
      breakStartTime: json['break_start_time'] as String?,
      breakEndTime: json['break_end_time'] as String?,
      attendanceStatus: json['attendance_status'] as String,
      location: json['location'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$AttendanceRequestParamsImplToJson(
        _$AttendanceRequestParamsImpl instance) =>
    <String, dynamic>{
      'employee_id': instance.employeeId,
      'attendance_date': instance.attendanceDate,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'check_in_time': instance.checkInTime,
      'check_out_time': instance.checkOutTime,
      'break_start_time': instance.breakStartTime,
      'break_end_time': instance.breakEndTime,
      'attendance_status': instance.attendanceStatus,
      'location': instance.location,
      'notes': instance.notes,
    };
