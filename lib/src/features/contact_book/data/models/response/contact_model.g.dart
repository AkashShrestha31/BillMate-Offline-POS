// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContactModelImpl _$$ContactModelImplFromJson(Map<String, dynamic> json) =>
    _$ContactModelImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      category: json['category'] as String?,
      company: json['company'] as String?,
      notes: json['notes'] as String?,
      isFavorite: json['is_favorite'] as bool? ?? false,
      photoUrl: json['photo_url'] as String?,
      createdAt: json['created_at'] as String?,
      modifiedAt: json['modified_at'] as String?,
      createdBy: json['created_by'] as String?,
      modifiedBy: json['modified_by'] as String?,
    );

Map<String, dynamic> _$$ContactModelImplToJson(_$ContactModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'address': instance.address,
      'category': instance.category,
      'company': instance.company,
      'notes': instance.notes,
      'is_favorite': instance.isFavorite,
      'photo_url': instance.photoUrl,
      'created_at': instance.createdAt,
      'modified_at': instance.modifiedAt,
      'created_by': instance.createdBy,
      'modified_by': instance.modifiedBy,
    };

_$ContactListResponseImpl _$$ContactListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ContactListResponseImpl(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      filtersApplied: json['filters_applied'] as Map<String, dynamic>?,
      contacts: (json['contacts'] as List<dynamic>)
          .map((e) => ContactModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ContactListResponseImplToJson(
        _$ContactListResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'filters_applied': instance.filtersApplied,
      'contacts': instance.contacts,
    };

_$ContactSingleResponseImpl _$$ContactSingleResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ContactSingleResponseImpl(
      success: json['success'] as bool,
      contact: ContactModel.fromJson(json['contact'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ContactSingleResponseImplToJson(
        _$ContactSingleResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'contact': instance.contact,
    };

_$CreateContactResponseImpl _$$CreateContactResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateContactResponseImpl(
      success: json['success'] as bool,
      message: json['message'] as String?,
      contact: ContactModel.fromJson(json['contact'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CreateContactResponseImplToJson(
        _$CreateContactResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'contact': instance.contact,
    };

_$UpdateContactResponseImpl _$$UpdateContactResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateContactResponseImpl(
      success: json['success'] as bool,
      message: json['message'] as String?,
      contactId: (json['contact_id'] as num).toInt(),
    );

Map<String, dynamic> _$$UpdateContactResponseImplToJson(
        _$UpdateContactResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'contact_id': instance.contactId,
    };

_$DeleteContactResponseImpl _$$DeleteContactResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$DeleteContactResponseImpl(
      success: json['success'] as bool,
      message: json['message'] as String?,
      deletedContact: json['deleted_contact'] == null
          ? null
          : ContactModel.fromJson(
              json['deleted_contact'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DeleteContactResponseImplToJson(
        _$DeleteContactResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'deleted_contact': instance.deletedContact,
    };
