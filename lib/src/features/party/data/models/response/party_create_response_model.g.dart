// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_create_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PartyCreateResponseModelImpl _$$PartyCreateResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PartyCreateResponseModelImpl(
      success: json['success'] as bool,
      message: json['message'] as String,
      party: PartyModel.fromJson(json['party'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PartyCreateResponseModelImplToJson(
        _$PartyCreateResponseModelImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'party': instance.party,
    };
