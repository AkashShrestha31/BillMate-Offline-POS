import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_application_request_params.freezed.dart';
part 'leave_application_request_params.g.dart';

@freezed
class LeaveApplicationRequestParams with _$LeaveApplicationRequestParams {
  const factory LeaveApplicationRequestParams({
    @JsonKey(name: 'employee_id') required int employeeId,
    @JsonKey(name: 'leave_type_id') required int leaveTypeId,
    @JsonKey(name: 'from_date') required String fromDate,
    @JsonKey(name: 'to_date') required String toDate,
    required String reason,
    @JsonKey(name: 'emergency_contact') String? emergencyContact,
    @JsonKey(name: 'handover_notes') String? handoverNotes,
    @JsonKey(name: 'substitute_employee_id') int? substituteEmployeeId,
    @JsonKey(name: 'is_emergency') bool? isEmergency,
    @JsonKey(name: 'is_half_day') bool? isHalfDay,
    @JsonKey(name: 'half_day_session') String? halfDaySession,
  }) = _LeaveApplicationRequestParams;

  factory LeaveApplicationRequestParams.fromJson(Map<String, dynamic> json) =>
      _$LeaveApplicationRequestParamsFromJson(json);
}
