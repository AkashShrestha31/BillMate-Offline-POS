// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartyRequestParams _$PartyRequestParamsFromJson(Map<String, dynamic> json) =>
    PartyRequestParams(
      page: (json['page'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt() ?? 10,
      partyType: json['party_type'] as String?,
      partyRoles: (json['party_roles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      status: (json['status'] as num?)?.toInt(),
      search: json['search'] as String?,
      sortBy: json['sort_by'] as String? ?? 'name',
      sortOrder: json['sort_order'] as String? ?? 'asc',
    );

Map<String, dynamic> _$PartyRequestParamsToJson(PartyRequestParams instance) =>
    <String, dynamic>{
      'page': instance.page,
      'per_page': instance.perPage,
      'party_type': instance.partyType,
      'party_roles': instance.partyRoles,
      'status': instance.status,
      'search': instance.search,
      'sort_by': instance.sortBy,
      'sort_order': instance.sortOrder,
    };
