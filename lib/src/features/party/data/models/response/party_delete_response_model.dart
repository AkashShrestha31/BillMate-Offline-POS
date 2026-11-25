import 'package:freezed_annotation/freezed_annotation.dart';
import 'party_model.dart';

part 'party_delete_response_model.freezed.dart';
part 'party_delete_response_model.g.dart';

@freezed
class AuditLogModel with _$AuditLogModel {
  const factory AuditLogModel({
    required String action,
    @JsonKey(name: 'party_name') required String partyName,
    @JsonKey(name: 'party_details') required Map<String, dynamic> partyDetails,
    @JsonKey(name: 'deleted_by') required String deletedBy,
    @JsonKey(name: 'deleted_at') required String deletedAt,
    @JsonKey(name: 'records_deleted') required int recordsDeleted,
    @JsonKey(name: 'records_modified') int? recordsModified,
    @JsonKey(name: 'transactions_deleted') required bool transactionsDeleted,
  }) = _AuditLogModel;

  factory AuditLogModel.fromJson(Map<String, dynamic> json) =>
      _$AuditLogModelFromJson(json);
}

@freezed
class PartyDeleteResponseModel with _$PartyDeleteResponseModel {
  const factory PartyDeleteResponseModel({
    required bool success,
    required String message,
    @JsonKey(name: 'total_records_deleted') int? totalRecordsDeleted,
    @JsonKey(name: 'total_records_modified') int? totalRecordsModified,
    @JsonKey(name: 'deletion_summary') Map<String, dynamic>? deletionSummary,
    @JsonKey(name: 'deleted_party') PartyModel? deletedParty,
    @JsonKey(name: 'audit_log') AuditLogModel? auditLog,
    String? warning,
  }) = _PartyDeleteResponseModel;

  factory PartyDeleteResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PartyDeleteResponseModelFromJson(json);
}
