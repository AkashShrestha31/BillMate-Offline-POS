import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_balance_model.freezed.dart';
part 'leave_balance_model.g.dart';

@freezed
class LeaveBalanceModel with _$LeaveBalanceModel {
  const factory LeaveBalanceModel({
    required int id,
    @JsonKey(name: 'employee_id') required int employeeId,
    @JsonKey(name: 'employee_name') required String employeeName,
    @JsonKey(name: 'employee_code') required String employeeCode,
    @JsonKey(name: 'leave_type_id') required int leaveTypeId,
    @JsonKey(name: 'leave_type_name') required String leaveTypeName,
    required int year,
    @JsonKey(name: 'total_allocated') required int totalAllocated,
    @JsonKey(name: 'total_used') required int totalUsed,
    @JsonKey(name: 'total_pending') required int totalPending,
    @JsonKey(name: 'balance_remaining') required int balanceRemaining,
    @JsonKey(name: 'carry_forward_from_previous') int? carryForwardFromPrevious,
    @JsonKey(name: 'utilization_percentage') double? utilizationPercentage,
    @JsonKey(name: 'last_updated') String? lastUpdated,
    String? created,
    String? modified,
  }) = _LeaveBalanceModel;

  factory LeaveBalanceModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveBalanceModelFromJson(json);
}
