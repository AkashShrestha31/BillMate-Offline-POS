// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EditSummaryModelImpl _$$EditSummaryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EditSummaryModelImpl(
      totalRequested: (json['total_requested'] as num).toInt(),
      successfullyUpdated: (json['successfully_updated'] as num).toInt(),
      failed: (json['failed'] as num).toInt(),
    );

Map<String, dynamic> _$$EditSummaryModelImplToJson(
        _$EditSummaryModelImpl instance) =>
    <String, dynamic>{
      'total_requested': instance.totalRequested,
      'successfully_updated': instance.successfullyUpdated,
      'failed': instance.failed,
    };
