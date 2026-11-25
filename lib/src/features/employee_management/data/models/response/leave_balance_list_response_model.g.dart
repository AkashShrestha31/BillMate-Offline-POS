// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_balance_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaveBalanceListResponseModelImpl
    _$$LeaveBalanceListResponseModelImplFromJson(Map<String, dynamic> json) =>
        _$LeaveBalanceListResponseModelImpl(
          success: json['success'] as bool,
          count: (json['count'] as num).toInt(),
          filtersApplied: json['filters_applied'] as Map<String, dynamic>?,
          balances: (json['balances'] as List<dynamic>)
              .map((e) => LeaveBalanceModel.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$LeaveBalanceListResponseModelImplToJson(
        _$LeaveBalanceListResponseModelImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'filters_applied': instance.filtersApplied,
      'balances': instance.balances,
    };
