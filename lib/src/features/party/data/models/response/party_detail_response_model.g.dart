// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_detail_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PartyDetailResponseModelImpl _$$PartyDetailResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PartyDetailResponseModelImpl(
      success: json['success'] as bool,
      party: PartyModel.fromJson(json['party'] as Map<String, dynamic>),
      transactionSummary: json['transaction_summary'] == null
          ? null
          : PartyTransactionSummaryModel.fromJson(
              json['transaction_summary'] as Map<String, dynamic>),
      recentActivity: json['recent_activity'] == null
          ? null
          : PartyRecentActivityModel.fromJson(
              json['recent_activity'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PartyDetailResponseModelImplToJson(
        _$PartyDetailResponseModelImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'party': instance.party,
      'transaction_summary': instance.transactionSummary,
      'recent_activity': instance.recentActivity,
    };
