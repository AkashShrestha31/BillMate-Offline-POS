import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_application_model.freezed.dart';
part 'leave_application_model.g.dart';

@freezed
class LeaveApplicationModel with _$LeaveApplicationModel {
  const factory LeaveApplicationModel({
    required int id,
    @JsonKey(name: 'application_number') required String applicationNumber,
    @JsonKey(name: 'employee_id') required int employeeId,
    @JsonKey(name: 'employee_name') required String employeeName,
    @JsonKey(name: 'employee_code') required String employeeCode,
    @JsonKey(name: 'leave_type_id') required int leaveTypeId,
    @JsonKey(name: 'leave_type_name') required String leaveTypeName,
    @JsonKey(name: 'from_date') required String fromDate,
    @JsonKey(name: 'to_date') required String toDate,
    @JsonKey(name: 'total_days') required double totalDays,
    required String reason,
    @JsonKey(name: 'emergency_contact') String? emergencyContact,
    @JsonKey(name: 'handover_notes') String? handoverNotes,
    @JsonKey(name: 'application_date') required String applicationDate,
    required String status,
    @JsonKey(name: 'approved_by') String? approvedBy,
    @JsonKey(name: 'approved_date') String? approvedDate,
    @JsonKey(name: 'rejection_reason') String? rejectionReason,
    @JsonKey(name: 'manager_comments') String? managerComments,
    @JsonKey(name: 'hr_comments') String? hrComments,
    String? attachment,
    @JsonKey(name: 'is_emergency') required bool isEmergency,
    @JsonKey(name: 'is_half_day') required bool isHalfDay,
    @JsonKey(name: 'half_day_session') String? halfDaySession,
    @JsonKey(name: 'substitute_employee_id') int? substituteEmployeeId,
    @JsonKey(name: 'substitute_name') String? substituteName,
    String? created,
    String? modified,
  }) = _LeaveApplicationModel;

  factory LeaveApplicationModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveApplicationModelFromJson(json);
}
