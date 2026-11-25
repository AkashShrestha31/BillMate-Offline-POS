// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reconciliation_upload_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReconciliationUploadResponseImpl _$$ReconciliationUploadResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ReconciliationUploadResponseImpl(
      success: json['success'] as bool,
      message: json['message'] as String,
      successfulUploads: (json['successful_uploads'] as num).toInt(),
      failedUploads: (json['failed_uploads'] as num).toInt(),
      failedRecords: json['failed_records'] as List<dynamic>,
      reportingDate: json['reporting_date'] as String,
      uploadBatch: json['upload_batch'] as String,
      uploadType: json['upload_type'] as String,
      note: json['note'] as String,
    );

Map<String, dynamic> _$$ReconciliationUploadResponseImplToJson(
        _$ReconciliationUploadResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'successful_uploads': instance.successfulUploads,
      'failed_uploads': instance.failedUploads,
      'failed_records': instance.failedRecords,
      'reporting_date': instance.reportingDate,
      'upload_batch': instance.uploadBatch,
      'upload_type': instance.uploadType,
      'note': instance.note,
    };
