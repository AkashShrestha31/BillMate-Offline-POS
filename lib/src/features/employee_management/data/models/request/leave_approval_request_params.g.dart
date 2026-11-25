// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_approval_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaveApprovalRequestParamsImpl _$$LeaveApprovalRequestParamsImplFromJson(
        Map<String, dynamic> json) =>
    _$LeaveApprovalRequestParamsImpl(
      action: json['action'] as String,
      rejectionReason: json['rejection_reason'] as String?,
      managerComments: json['manager_comments'] as String?,
      hrComments: json['hr_comments'] as String?,
    );

Map<String, dynamic> _$$LeaveApprovalRequestParamsImplToJson(
        _$LeaveApprovalRequestParamsImpl instance) =>
    <String, dynamic>{
      'action': instance.action,
      'rejection_reason': instance.rejectionReason,
      'manager_comments': instance.managerComments,
      'hr_comments': instance.hrComments,
    };
