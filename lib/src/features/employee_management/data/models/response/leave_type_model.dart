import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_type_model.freezed.dart';
part 'leave_type_model.g.dart';

@freezed
class LeaveTypeModel with _$LeaveTypeModel {
  const factory LeaveTypeModel({
    required int id,
    @JsonKey(name: 'leave_type_name') required String leaveTypeName,
    String? description,
    @JsonKey(name: 'max_days_per_year') required int maxDaysPerYear,
    @JsonKey(name: 'carry_forward_allowed') required bool carryForwardAllowed,
    @JsonKey(name: 'max_carry_forward_days') int? maxCarryForwardDays,
    @JsonKey(name: 'requires_approval') required bool requiresApproval,
    @JsonKey(name: 'advance_notice_days') int? advanceNoticeDays,
    @JsonKey(name: 'is_paid') required bool isPaid,
    @JsonKey(name: 'gender_specific') String? genderSpecific,
    @JsonKey(name: 'is_active') required bool isActive,
    String? created,
    String? modified,
  }) = _LeaveTypeModel;

  factory LeaveTypeModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveTypeModelFromJson(json);
}
