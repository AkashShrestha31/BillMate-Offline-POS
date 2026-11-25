import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_type_request_params.freezed.dart';
part 'leave_type_request_params.g.dart';

@freezed
class LeaveTypeRequestParams with _$LeaveTypeRequestParams {
  const factory LeaveTypeRequestParams({
    @JsonKey(name: 'leave_type_name') required String leaveTypeName,
    String? description,
    @JsonKey(name: 'max_days_per_year') required int maxDaysPerYear,
    @JsonKey(name: 'carry_forward_allowed') bool? carryForwardAllowed,
    @JsonKey(name: 'max_carry_forward_days') int? maxCarryForwardDays,
    @JsonKey(name: 'requires_approval') bool? requiresApproval,
    @JsonKey(name: 'advance_notice_days') int? advanceNoticeDays,
    @JsonKey(name: 'is_paid') bool? isPaid,
    @JsonKey(name: 'gender_specific') String? genderSpecific,
  }) = _LeaveTypeRequestParams;

  factory LeaveTypeRequestParams.fromJson(Map<String, dynamic> json) =>
      _$LeaveTypeRequestParamsFromJson(json);
}
