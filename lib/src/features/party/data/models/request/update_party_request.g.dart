// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_party_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdatePartyRequestImpl _$$UpdatePartyRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdatePartyRequestImpl(
      name: json['name'] as String,
      newName: json['new_name'] as String?,
      role: json['role'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      currency: json['currency'] as String?,
      loyaltyProgram: json['loyaltyProgram'] as String?,
      loyaltyPoints: (json['loyaltyPoints'] as num?)?.toInt(),
      outstandingAmount: json['outstandingAmount'] as String?,
      defaultAccount: json['defaultAccount'] as String?,
      fromLead: json['fromLead'] as String?,
      modifiedBy: json['modifiedBy'] as String?,
    );

Map<String, dynamic> _$$UpdatePartyRequestImplToJson(
        _$UpdatePartyRequestImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'new_name': instance.newName,
      'role': instance.role,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'currency': instance.currency,
      'loyaltyProgram': instance.loyaltyProgram,
      'loyaltyPoints': instance.loyaltyPoints,
      'outstandingAmount': instance.outstandingAmount,
      'defaultAccount': instance.defaultAccount,
      'fromLead': instance.fromLead,
      'modifiedBy': instance.modifiedBy,
    };
