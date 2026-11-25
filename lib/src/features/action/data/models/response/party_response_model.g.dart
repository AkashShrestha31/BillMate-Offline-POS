// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PartyResponseModelImpl _$$PartyResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PartyResponseModelImpl(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PartyItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination:
          Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PartyResponseModelImplToJson(
        _$PartyResponseModelImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'pagination': instance.pagination,
    };

_$PartyItemImpl _$$PartyItemImplFromJson(Map<String, dynamic> json) =>
    _$PartyItemImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      outstandingAmount: _stringToDouble(json['outstandingAmount']),
      role: json['role'] as String?,
      currency: json['currency'] as String?,
      employeeDetails:
          _partyItemEmployeeDetailsFromJson(json['employeeDetails']),
    );

Map<String, dynamic> _$$PartyItemImplToJson(_$PartyItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'outstandingAmount': instance.outstandingAmount,
      'role': instance.role,
      'currency': instance.currency,
    };

_$PaginationImpl _$$PaginationImplFromJson(Map<String, dynamic> json) =>
    _$PaginationImpl(
      current_page: (json['current_page'] as num?)?.toInt(),
      per_page: (json['per_page'] as num?)?.toInt(),
      total_pages: (json['total_pages'] as num?)?.toInt(),
      total_rows: (json['total_rows'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PaginationImplToJson(_$PaginationImpl instance) =>
    <String, dynamic>{
      'current_page': instance.current_page,
      'per_page': instance.per_page,
      'total_pages': instance.total_pages,
      'total_rows': instance.total_rows,
    };
