import 'package:freezed_annotation/freezed_annotation.dart';
import 'leave_balance_model.dart';

part 'leave_balance_list_response_model.freezed.dart';
part 'leave_balance_list_response_model.g.dart';

@freezed
class LeaveBalanceListResponseModel with _$LeaveBalanceListResponseModel {
  const factory LeaveBalanceListResponseModel({
    required bool success,
    required int count,
    @JsonKey(name: 'filters_applied') Map<String, dynamic>? filtersApplied,
    required List<LeaveBalanceModel> balances,
  }) = _LeaveBalanceListResponseModel;

  factory LeaveBalanceListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveBalanceListResponseModelFromJson(json);
}
