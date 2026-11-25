// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_types_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaveTypesListResponseModelImpl _$$LeaveTypesListResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LeaveTypesListResponseModelImpl(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      leaveTypes: (json['leave_types'] as List<dynamic>)
          .map((e) => LeaveTypeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$LeaveTypesListResponseModelImplToJson(
        _$LeaveTypesListResponseModelImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'leave_types': instance.leaveTypes,
    };
