// reconciliation_upload_request.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dio/dio.dart';
import 'dart:io';

part 'reconciliation_upload_request.freezed.dart';
part 'reconciliation_upload_request.g.dart';

@freezed
class ReconciliationUploadRequest with _$ReconciliationUploadRequest {
  const factory ReconciliationUploadRequest({
    @JsonKey(name: 'reporting_date') required String reportingDate,
    @JsonKey(name: 'uploaded_by') required String uploadedBy,
    @JsonKey(name: 'replace_existing') required bool replaceExisting,
    @JsonKey(name: 'create_missing_items') required bool createMissingItems,
    @JsonKey(includeFromJson: false, includeToJson: false) File? file,
  }) = _ReconciliationUploadRequest;

  factory ReconciliationUploadRequest.fromJson(Map<String, dynamic> json) =>
      _$ReconciliationUploadRequestFromJson(json);
}

extension ReconciliationUploadRequestExtension on ReconciliationUploadRequest {
  Future<FormData> toFormData() async {
    final formData = FormData();

    // Add file if provided
    if (file != null) {
      final fileName = file!.path.split('/').last;
      formData.files.add(
        MapEntry(
          'file',
          await MultipartFile.fromFile(
            file!.path,
            filename: fileName,
          ),
        ),
      );
    }

    // Add other parameters
    formData.fields.addAll([
      MapEntry('reporting_date', reportingDate),
      MapEntry('uploaded_by', uploadedBy),
      MapEntry('replace_existing', replaceExisting.toString()),
      MapEntry('create_missing_items', createMissingItems.toString()),
    ]);

    return formData;
  }

  Map<String, dynamic> toQueryParams() {
    return {
      'reporting_date': reportingDate,
      'uploaded_by': uploadedBy,
      'replace_existing': replaceExisting,
      'create_missing_items': createMissingItems,
    };
  }
}
