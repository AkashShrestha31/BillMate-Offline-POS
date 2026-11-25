// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_update_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PartyUpdateRequestParamsImpl _$$PartyUpdateRequestParamsImplFromJson(
        Map<String, dynamic> json) =>
    _$PartyUpdateRequestParamsImpl(
      oldName: json['old_name'] as String,
      newName: json['new_name'] as String,
      updateAllReferences: json['update_all_references'] as bool,
      modifiedBy: json['modifiedBy'] as String,
    );

Map<String, dynamic> _$$PartyUpdateRequestParamsImplToJson(
        _$PartyUpdateRequestParamsImpl instance) =>
    <String, dynamic>{
      'old_name': instance.oldName,
      'new_name': instance.newName,
      'update_all_references': instance.updateAllReferences,
      'modifiedBy': instance.modifiedBy,
    };
