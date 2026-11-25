import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_request_params.freezed.dart';
part 'attendance_request_params.g.dart';

@freezed
class AttendanceRequestParams with _$AttendanceRequestParams {
  const factory AttendanceRequestParams({
    @JsonKey(name: 'employee_id') required int employeeId,
    /// Single date: use [attendanceDate]. Range: use [startDate] and [endDate] instead.
    @JsonKey(name: 'attendance_date') String? attendanceDate,
    @JsonKey(name: 'start_date') String? startDate,
    @JsonKey(name: 'end_date') String? endDate,
    @JsonKey(name: 'check_in_time') String? checkInTime,
    @JsonKey(name: 'check_out_time') String? checkOutTime,
    @JsonKey(name: 'break_start_time') String? breakStartTime,
    @JsonKey(name: 'break_end_time') String? breakEndTime,
    @JsonKey(name: 'attendance_status') required String attendanceStatus,
    String? location,
    String? notes,
  }) = _AttendanceRequestParams;

  factory AttendanceRequestParams.fromJson(Map<String, dynamic> json) =>
      _$AttendanceRequestParamsFromJson(json);
}
