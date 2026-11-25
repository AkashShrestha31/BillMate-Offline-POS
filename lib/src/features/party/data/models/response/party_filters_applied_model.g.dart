// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_filters_applied_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PartyFiltersAppliedModelImpl _$$PartyFiltersAppliedModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PartyFiltersAppliedModelImpl(
      search: json['search'] as String?,
      role: json['role'] as String?,
      hasOutstanding: json['has_outstanding'] as bool?,
      currency: json['currency'] as String?,
      loyaltyProgram: json['loyaltyProgram'] as String?,
      excludeZeroTransactions: json['exclude_zero_transactions'] as bool?,
      sortBy: json['sort_by'] as String?,
      sortOrder: json['sort_order'] as String?,
    );

Map<String, dynamic> _$$PartyFiltersAppliedModelImplToJson(
        _$PartyFiltersAppliedModelImpl instance) =>
    <String, dynamic>{
      'search': instance.search,
      'role': instance.role,
      'has_outstanding': instance.hasOutstanding,
      'currency': instance.currency,
      'loyaltyProgram': instance.loyaltyProgram,
      'exclude_zero_transactions': instance.excludeZeroTransactions,
      'sort_by': instance.sortBy,
      'sort_order': instance.sortOrder,
    };
