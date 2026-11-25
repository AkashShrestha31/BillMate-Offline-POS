// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_delete_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuditLogModelImpl _$$AuditLogModelImplFromJson(Map<String, dynamic> json) =>
    _$AuditLogModelImpl(
      action: json['action'] as String,
      partyName: json['party_name'] as String,
      partyDetails: json['party_details'] as Map<String, dynamic>,
      deletedBy: json['deleted_by'] as String,
      deletedAt: json['deleted_at'] as String,
      recordsDeleted: (json['records_deleted'] as num).toInt(),
      recordsModified: (json['records_modified'] as num?)?.toInt(),
      transactionsDeleted: json['transactions_deleted'] as bool,
    );

Map<String, dynamic> _$$AuditLogModelImplToJson(_$AuditLogModelImpl instance) =>
    <String, dynamic>{
      'action': instance.action,
      'party_name': instance.partyName,
      'party_details': instance.partyDetails,
      'deleted_by': instance.deletedBy,
      'deleted_at': instance.deletedAt,
      'records_deleted': instance.recordsDeleted,
      'records_modified': instance.recordsModified,
      'transactions_deleted': instance.transactionsDeleted,
    };

_$PartyDeleteResponseModelImpl _$$PartyDeleteResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PartyDeleteResponseModelImpl(
      success: json['success'] as bool,
      message: json['message'] as String,
      totalRecordsDeleted: (json['total_records_deleted'] as num?)?.toInt(),
      totalRecordsModified: (json['total_records_modified'] as num?)?.toInt(),
      deletionSummary: json['deletion_summary'] as Map<String, dynamic>?,
      deletedParty: json['deleted_party'] == null
          ? null
          : PartyModel.fromJson(json['deleted_party'] as Map<String, dynamic>),
      auditLog: json['audit_log'] == null
          ? null
          : AuditLogModel.fromJson(json['audit_log'] as Map<String, dynamic>),
      warning: json['warning'] as String?,
    );

Map<String, dynamic> _$$PartyDeleteResponseModelImplToJson(
        _$PartyDeleteResponseModelImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'total_records_deleted': instance.totalRecordsDeleted,
      'total_records_modified': instance.totalRecordsModified,
      'deletion_summary': instance.deletionSummary,
      'deleted_party': instance.deletedParty,
      'audit_log': instance.auditLog,
      'warning': instance.warning,
    };
