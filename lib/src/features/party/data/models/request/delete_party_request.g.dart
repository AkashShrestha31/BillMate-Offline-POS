// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_party_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeletePartyRequestImpl _$$DeletePartyRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$DeletePartyRequestImpl(
      name: json['name'] as String,
      confirmDelete: json['confirm_delete'] as bool?,
      forceDelete: json['force_delete'] as bool?,
      deleteTransactions: json['delete_transactions'] as bool?,
      deletedBy: json['deletedBy'] as String?,
    );

Map<String, dynamic> _$$DeletePartyRequestImplToJson(
        _$DeletePartyRequestImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'confirm_delete': instance.confirmDelete,
      'force_delete': instance.forceDelete,
      'delete_transactions': instance.deleteTransactions,
      'deletedBy': instance.deletedBy,
    };
