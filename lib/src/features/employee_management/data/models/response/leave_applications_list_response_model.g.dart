// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_applications_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaveApplicationsListResponseModelImpl
    _$$LeaveApplicationsListResponseModelImplFromJson(
            Map<String, dynamic> json) =>
        _$LeaveApplicationsListResponseModelImpl(
          success: json['success'] as bool,
          count: (json['count'] as num).toInt(),
          summary: json['summary'] as Map<String, dynamic>?,
          filtersApplied: json['filters_applied'] as Map<String, dynamic>?,
          applications: (json['applications'] as List<dynamic>)
              .map((e) =>
                  LeaveApplicationModel.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$LeaveApplicationsListResponseModelImplToJson(
        _$LeaveApplicationsListResponseModelImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'summary': instance.summary,
      'filters_applied': instance.filtersApplied,
      'applications': instance.applications,
    };
