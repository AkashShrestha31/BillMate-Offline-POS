import 'package:freezed_annotation/freezed_annotation.dart';

part 'party_recent_activity_model.freezed.dart';
part 'party_recent_activity_model.g.dart';

@freezed
class PartyRecentActivityModel with _$PartyRecentActivityModel {
  const factory PartyRecentActivityModel({
    @JsonKey(name: 'sales_last_30_days') int? salesLast30Days,
    @JsonKey(name: 'purchases_last_30_days') int? purchasesLast30Days,
    @JsonKey(name: 'payments_last_30_days') int? paymentsLast30Days,
  }) = _PartyRecentActivityModel;

  factory PartyRecentActivityModel.fromJson(Map<String, dynamic> json) =>
      _$PartyRecentActivityModelFromJson(json);
}
