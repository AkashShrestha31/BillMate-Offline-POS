// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_recent_activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PartyRecentActivityModelImpl _$$PartyRecentActivityModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PartyRecentActivityModelImpl(
      salesLast30Days: (json['sales_last_30_days'] as num?)?.toInt(),
      purchasesLast30Days: (json['purchases_last_30_days'] as num?)?.toInt(),
      paymentsLast30Days: (json['payments_last_30_days'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PartyRecentActivityModelImplToJson(
        _$PartyRecentActivityModelImpl instance) =>
    <String, dynamic>{
      'sales_last_30_days': instance.salesLast30Days,
      'purchases_last_30_days': instance.purchasesLast30Days,
      'payments_last_30_days': instance.paymentsLast30Days,
    };
