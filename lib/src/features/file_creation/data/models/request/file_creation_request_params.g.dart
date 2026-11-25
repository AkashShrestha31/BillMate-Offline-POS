// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_creation_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileCreationRequestParams _$FileCreationRequestParamsFromJson(
        Map<String, dynamic> json) =>
    FileCreationRequestParams(
      filePath: json['file_path'] as String?,
      useDefaultDb: json['use_default_db'] as bool? ?? false,
      includeAllTimestamps: json['include_all_timestamps'] as bool? ?? true,
      formatTimestamps: json['format_timestamps'] as bool? ?? true,
      includeFileInfo: json['include_file_info'] as bool? ?? true,
      timezone: json['timezone'] as String? ?? "Asia/Kathmandu",
      includeUtc: json['include_utc'] as bool? ?? false,
    );

Map<String, dynamic> _$FileCreationRequestParamsToJson(
        FileCreationRequestParams instance) =>
    <String, dynamic>{
      'file_path': instance.filePath,
      'use_default_db': instance.useDefaultDb,
      'include_all_timestamps': instance.includeAllTimestamps,
      'format_timestamps': instance.formatTimestamps,
      'include_file_info': instance.includeFileInfo,
      'timezone': instance.timezone,
      'include_utc': instance.includeUtc,
    };
