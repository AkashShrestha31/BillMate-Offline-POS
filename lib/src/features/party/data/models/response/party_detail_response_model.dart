import 'package:freezed_annotation/freezed_annotation.dart';
import 'party_model.dart';
import 'party_transaction_summary_model.dart';
import 'party_recent_activity_model.dart';

part 'party_detail_response_model.freezed.dart';
part 'party_detail_response_model.g.dart';

@freezed
class PartyDetailResponseModel with _$PartyDetailResponseModel {
  const factory PartyDetailResponseModel({
    required bool success,
    required PartyModel party,
    @JsonKey(name: 'transaction_summary') PartyTransactionSummaryModel? transactionSummary,
    @JsonKey(name: 'recent_activity') PartyRecentActivityModel? recentActivity,
  }) = _PartyDetailResponseModel;

  factory PartyDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PartyDetailResponseModelFromJson(json);
}
