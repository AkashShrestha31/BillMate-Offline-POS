// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceListResponseModelImpl _$$AttendanceListResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendanceListResponseModelImpl(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      summary: json['summary'] as Map<String, dynamic>?,
      filtersApplied: json['filters_applied'] as Map<String, dynamic>?,
      attendanceRecords: (json['attendance_records'] as List<dynamic>)
          .map((e) => AttendanceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AttendanceListResponseModelImplToJson(
        _$AttendanceListResponseModelImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'summary': instance.summary,
      'filters_applied': instance.filtersApplied,
      'attendance_records': instance.attendanceRecords,
    };
