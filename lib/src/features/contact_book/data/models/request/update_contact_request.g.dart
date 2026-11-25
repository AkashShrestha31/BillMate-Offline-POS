// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_contact_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateContactRequest _$UpdateContactRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateContactRequest(
      contactId: (json['contact_id'] as num).toInt(),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      category: json['category'] as String?,
      company: json['company'] as String?,
      notes: json['notes'] as String?,
      isFavorite: json['is_favorite'] as bool?,
      photoUrl: json['photo_url'] as String?,
    );

Map<String, dynamic> _$UpdateContactRequestToJson(
        UpdateContactRequest instance) =>
    <String, dynamic>{
      'contact_id': instance.contactId,
      if (instance.name case final value?) 'name': value,
      if (instance.phone case final value?) 'phone': value,
      if (instance.email case final value?) 'email': value,
      if (instance.address case final value?) 'address': value,
      if (instance.category case final value?) 'category': value,
      if (instance.company case final value?) 'company': value,
      if (instance.notes case final value?) 'notes': value,
      if (instance.isFavorite case final value?) 'is_favorite': value,
      if (instance.photoUrl case final value?) 'photo_url': value,
    };
