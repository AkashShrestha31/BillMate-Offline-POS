// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_item_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateItemRequest _$UpdateItemRequestFromJson(Map<String, dynamic> json) =>
    UpdateItemRequest(
      oldName: json['old_name'] as String,
      newName: json['new_name'] as String,
    );

Map<String, dynamic> _$UpdateItemRequestToJson(UpdateItemRequest instance) =>
    <String, dynamic>{
      'old_name': instance.oldName,
      'new_name': instance.newName,
    };
