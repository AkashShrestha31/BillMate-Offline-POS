// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PartyRequestParamsImpl _$$PartyRequestParamsImplFromJson(
        Map<String, dynamic> json) =>
    _$PartyRequestParamsImpl(
      page: (json['page'] as num?)?.toInt(),
      pageSize: (json['page_size'] as num?)?.toInt(),
      search: json['search'] as String?,
      role: json['role'] as String?,
      status: (json['status'] as num?)?.toInt(),
      hasOutstanding: json['has_outstanding'] as bool?,
      currency: json['currency'] as String?,
      loyaltyProgram: json['loyaltyProgram'] as String?,
      sortBy: json['sort_by'] as String?,
      sortOrder: json['sort_order'] as String?,
      excludeZeroTransactions: json['exclude_zero_transactions'] as bool?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$PartyRequestParamsImplToJson(
        _$PartyRequestParamsImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'page_size': instance.pageSize,
      'search': instance.search,
      'role': instance.role,
      'status': instance.status,
      'has_outstanding': instance.hasOutstanding,
      'currency': instance.currency,
      'loyaltyProgram': instance.loyaltyProgram,
      'sort_by': instance.sortBy,
      'sort_order': instance.sortOrder,
      'exclude_zero_transactions': instance.excludeZeroTransactions,
      'name': instance.name,
    };
