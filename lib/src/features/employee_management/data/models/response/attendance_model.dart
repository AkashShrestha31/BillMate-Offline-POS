import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_model.freezed.dart';
part 'attendance_model.g.dart';

@freezed
class AttendanceModel with _$AttendanceModel {
  const factory AttendanceModel({
    required int id,
    @JsonKey(name: 'employee_id') required int employeeId,
    @JsonKey(name: 'employee_name') required String employeeName,
    @JsonKey(name: 'employee_code') required String employeeCode,
    @JsonKey(name: 'attendance_date') required String attendanceDate,
    @JsonKey(name: 'check_in_time') String? checkInTime,
    @JsonKey(name: 'check_out_time') String? checkOutTime,
    @JsonKey(name: 'break_start_time') String? breakStartTime,
    @JsonKey(name: 'break_end_time') String? breakEndTime,
    @JsonKey(name: 'total_hours_worked') required double totalHoursWorked,
    @JsonKey(name: 'total_break_hours') double? totalBreakHours,
    @JsonKey(name: 'overtime_hours') required double overtimeHours,
    @JsonKey(name: 'attendance_status') required String attendanceStatus,
    @JsonKey(name: 'late_arrival_minutes') int? lateArrivalMinutes,
    @JsonKey(name: 'early_departure_minutes') int? earlyDepartureMinutes,
    String? location,
    String? notes,
    @JsonKey(name: 'approved_by') String? approvedBy,
    @JsonKey(name: 'is_approved') required bool isApproved,
    String? created,
    String? modified,
  }) = _AttendanceModel;

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceModelFromJson(json);
}
