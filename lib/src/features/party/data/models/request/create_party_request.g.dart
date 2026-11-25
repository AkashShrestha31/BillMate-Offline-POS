// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_party_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreatePartyRequestImpl _$$CreatePartyRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreatePartyRequestImpl(
      name: json['name'] as String,
      role: json['role'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      currency: json['currency'] as String?,
      loyaltyProgram: json['loyaltyProgram'] as String?,
      loyaltyPoints: (json['loyaltyPoints'] as num?)?.toInt(),
      outstandingAmount: json['outstandingAmount'] as String?,
      defaultAccount: json['defaultAccount'] as String?,
      fromLead: json['fromLead'] as String?,
      createdBy: json['createdBy'] as String?,
    );

Map<String, dynamic> _$$CreatePartyRequestImplToJson(
        _$CreatePartyRequestImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
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
      'createdBy': instance.createdBy,
    };
