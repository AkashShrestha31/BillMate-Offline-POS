// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_creation_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileCreationDetails _$FileCreationDetailsFromJson(Map<String, dynamic> json) =>
    FileCreationDetails(
      success: json['success'] as bool,
      method: json['method'] as String,
      fileInfo: FileInfo.fromJson(json['file_info'] as Map<String, dynamic>),
      creationInfo:
          CreationInfo.fromJson(json['creation_info'] as Map<String, dynamic>),
      timestamps:
          Timestamps.fromJson(json['timestamps'] as Map<String, dynamic>),
      fileDetails:
          FileDetails.fromJson(json['file_details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FileCreationDetailsToJson(
        FileCreationDetails instance) =>
    <String, dynamic>{
      'success': instance.success,
      'method': instance.method,
      'file_info': instance.fileInfo,
      'creation_info': instance.creationInfo,
      'timestamps': instance.timestamps,
      'file_details': instance.fileDetails,
    };

FileInfo _$FileInfoFromJson(Map<String, dynamic> json) => FileInfo(
      filePath: json['file_path'] as String,
      fileName: json['file_name'] as String,
      fileExtension: json['file_extension'] as String,
      exists: json['exists'] as bool,
      isFile: json['is_file'] as bool,
      isDirectory: json['is_directory'] as bool,
    );

Map<String, dynamic> _$FileInfoToJson(FileInfo instance) => <String, dynamic>{
      'file_path': instance.filePath,
      'file_name': instance.fileName,
      'file_extension': instance.fileExtension,
      'exists': instance.exists,
      'is_file': instance.isFile,
      'is_directory': instance.isDirectory,
    };

CreationInfo _$CreationInfoFromJson(Map<String, dynamic> json) => CreationInfo(
      createdDatetime: json['created_datetime'] as String,
      timezone: json['timezone'] as String,
      systemType: json['system_type'] as String,
      note: json['note'] as String,
      createdDatetimeFormatted: json['created_datetime_formatted'] as String,
    );

Map<String, dynamic> _$CreationInfoToJson(CreationInfo instance) =>
    <String, dynamic>{
      'created_datetime': instance.createdDatetime,
      'timezone': instance.timezone,
      'system_type': instance.systemType,
      'note': instance.note,
      'created_datetime_formatted': instance.createdDatetimeFormatted,
    };

Timestamps _$TimestampsFromJson(Map<String, dynamic> json) => Timestamps(
      lastModified: json['last_modified'] as String,
      lastAccessed: json['last_accessed'] as String,
      created: json['created'] as String,
      timezone: json['timezone'] as String,
      formatted: FormattedTimestamps.fromJson(
          json['formatted'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TimestampsToJson(Timestamps instance) =>
    <String, dynamic>{
      'last_modified': instance.lastModified,
      'last_accessed': instance.lastAccessed,
      'created': instance.created,
      'timezone': instance.timezone,
      'formatted': instance.formatted,
    };

FormattedTimestamps _$FormattedTimestampsFromJson(Map<String, dynamic> json) =>
    FormattedTimestamps(
      lastModified: json['last_modified'] as String,
      lastAccessed: json['last_accessed'] as String,
      created: json['created'] as String,
    );

Map<String, dynamic> _$FormattedTimestampsToJson(
        FormattedTimestamps instance) =>
    <String, dynamic>{
      'last_modified': instance.lastModified,
      'last_accessed': instance.lastAccessed,
      'created': instance.created,
    };

FileDetails _$FileDetailsFromJson(Map<String, dynamic> json) => FileDetails(
      sizeBytes: (json['size_bytes'] as num).toInt(),
      sizeHumanReadable: json['size_human_readable'] as String,
      permissions: json['permissions'] as String,
      readable: json['readable'] as bool,
      writable: json['writable'] as bool,
    );

Map<String, dynamic> _$FileDetailsToJson(FileDetails instance) =>
    <String, dynamic>{
      'size_bytes': instance.sizeBytes,
      'size_human_readable': instance.sizeHumanReadable,
      'permissions': instance.permissions,
      'readable': instance.readable,
      'writable': instance.writable,
    };
