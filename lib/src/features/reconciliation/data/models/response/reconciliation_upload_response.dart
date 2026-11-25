// reconciliation_upload_response.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reconciliation_upload_response.freezed.dart';
part 'reconciliation_upload_response.g.dart';

@freezed
class ReconciliationUploadResponse with _$ReconciliationUploadResponse {
  const factory ReconciliationUploadResponse({
    required bool success,
    required String message,
    @JsonKey(name: 'successful_uploads') required int successfulUploads,
    @JsonKey(name: 'failed_uploads') required int failedUploads,
    @JsonKey(name: 'failed_records') required List<dynamic> failedRecords,
    @JsonKey(name: 'reporting_date') required String reportingDate,
    @JsonKey(name: 'upload_batch') required String uploadBatch,
    @JsonKey(name: 'upload_type') required String uploadType,
    required String note,
  }) = _ReconciliationUploadResponse;

  factory ReconciliationUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$ReconciliationUploadResponseFromJson(json);
}
