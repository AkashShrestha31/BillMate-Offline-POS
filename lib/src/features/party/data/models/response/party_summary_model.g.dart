// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PartySummaryModelImpl _$$PartySummaryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PartySummaryModelImpl(
      totalParties: (json['total_parties'] as num?)?.toInt(),
      partiesWithSales: (json['parties_with_sales'] as num?)?.toInt(),
      partiesWithPurchases: (json['parties_with_purchases'] as num?)?.toInt(),
      totalOutstanding: (json['total_outstanding'] as num?)?.toDouble(),
      partiesWithOutstanding:
          (json['parties_with_outstanding'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PartySummaryModelImplToJson(
        _$PartySummaryModelImpl instance) =>
    <String, dynamic>{
      'total_parties': instance.totalParties,
      'parties_with_sales': instance.partiesWithSales,
      'parties_with_purchases': instance.partiesWithPurchases,
      'total_outstanding': instance.totalOutstanding,
      'parties_with_outstanding': instance.partiesWithOutstanding,
    };
