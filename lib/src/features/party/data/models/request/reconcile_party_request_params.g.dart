// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reconcile_party_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReconcilePartyRequestParamsImpl _$$ReconcilePartyRequestParamsImplFromJson(
        Map<String, dynamic> json) =>
    _$ReconcilePartyRequestParamsImpl(
      partyName: json['party_name'] as String,
      partyType: json['party_type'] as String,
      autoFix: json['auto_fix'] as bool,
    );

Map<String, dynamic> _$$ReconcilePartyRequestParamsImplToJson(
        _$ReconcilePartyRequestParamsImpl instance) =>
    <String, dynamic>{
      'party_name': instance.partyName,
      'party_type': instance.partyType,
      'auto_fix': instance.autoFix,
    };
