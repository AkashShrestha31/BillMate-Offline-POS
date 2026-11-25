import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_approval_request_params.freezed.dart';
part 'leave_approval_request_params.g.dart';

@freezed
class LeaveApprovalRequestParams with _$LeaveApprovalRequestParams {
  const factory LeaveApprovalRequestParams({
    required String action, // APPROVE or REJECT
    @JsonKey(name: 'rejection_reason') String? rejectionReason,
    @JsonKey(name: 'manager_comments') String? managerComments,
    @JsonKey(name: 'hr_comments') String? hrComments,
  }) = _LeaveApprovalRequestParams;

  factory LeaveApprovalRequestParams.fromJson(Map<String, dynamic> json) =>
      _$LeaveApprovalRequestParamsFromJson(json);
}
