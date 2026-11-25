// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_update_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemUpdateResponseModel _$ItemUpdateResponseModelFromJson(
        Map<String, dynamic> json) =>
    ItemUpdateResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      item: json['item'] == null
          ? null
          : ItemModel.fromJson(json['item'] as Map<String, dynamic>),
      itemTableUpdates: json['itemTableUpdates'] == null
          ? null
          : ItemTableUpdates.fromJson(
              json['itemTableUpdates'] as Map<String, dynamic>),
      changes: (json['changes'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, ChangeDetail.fromJson(e as Map<String, dynamic>)),
      ),
      modifiedAt: json['modifiedAt'] as String?,
      modifiedBy: json['modifiedBy'] as String?,
    );

Map<String, dynamic> _$ItemUpdateResponseModelToJson(
        ItemUpdateResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      if (instance.item case final value?) 'item': value,
      if (instance.itemTableUpdates case final value?)
        'itemTableUpdates': value,
      if (instance.changes case final value?) 'changes': value,
      if (instance.modifiedAt case final value?) 'modifiedAt': value,
      if (instance.modifiedBy case final value?) 'modifiedBy': value,
    };

ItemTableUpdates _$ItemTableUpdatesFromJson(Map<String, dynamic> json) =>
    ItemTableUpdates(
      fieldsUpdated: (json['fieldsUpdated'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      updatedValues: json['updatedValues'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ItemTableUpdatesToJson(ItemTableUpdates instance) =>
    <String, dynamic>{
      if (instance.fieldsUpdated case final value?) 'fieldsUpdated': value,
      if (instance.updatedValues case final value?) 'updatedValues': value,
    };

ChangeDetail _$ChangeDetailFromJson(Map<String, dynamic> json) => ChangeDetail(
      old: json['old'],
      newValue: json['new'],
    );

Map<String, dynamic> _$ChangeDetailToJson(ChangeDetail instance) =>
    <String, dynamic>{
      if (instance.old case final value?) 'old': value,
      if (instance.newValue case final value?) 'new': value,
    };
