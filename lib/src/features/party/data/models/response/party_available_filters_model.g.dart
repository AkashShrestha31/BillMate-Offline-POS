// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_available_filters_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PartyAvailableFiltersModelImpl _$$PartyAvailableFiltersModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PartyAvailableFiltersModelImpl(
      roleOptions: (json['role_options'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      currencyOptions: (json['currency_options'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      loyaltyProgramOptions: (json['loyalty_program_options'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$PartyAvailableFiltersModelImplToJson(
        _$PartyAvailableFiltersModelImpl instance) =>
    <String, dynamic>{
      'role_options': instance.roleOptions,
      'currency_options': instance.currencyOptions,
      'loyalty_program_options': instance.loyaltyProgramOptions,
    };
