// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_party_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePartyRequest _$UpdatePartyRequestFromJson(Map<String, dynamic> json) =>
    UpdatePartyRequest(
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      partyType: json['party_type'] as String?,
      gstNumber: json['gst_number'] as String?,
      panNumber: json['pan_number'] as String?,
    );

Map<String, dynamic> _$UpdatePartyRequestToJson(UpdatePartyRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'party_type': instance.partyType,
      'gst_number': instance.gstNumber,
      'pan_number': instance.panNumber,
    };
