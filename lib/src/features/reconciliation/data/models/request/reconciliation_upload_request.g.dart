// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reconciliation_upload_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReconciliationUploadRequestImpl _$$ReconciliationUploadRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ReconciliationUploadRequestImpl(
      reportingDate: json['reporting_date'] as String,
      uploadedBy: json['uploaded_by'] as String,
      replaceExisting: json['replace_existing'] as bool,
      createMissingItems: json['create_missing_items'] as bool,
    );

Map<String, dynamic> _$$ReconciliationUploadRequestImplToJson(
        _$ReconciliationUploadRequestImpl instance) =>
    <String, dynamic>{
      'reporting_date': instance.reportingDate,
      'uploaded_by': instance.uploadedBy,
      'replace_existing': instance.replaceExisting,
      'create_missing_items': instance.createMissingItems,
    };
