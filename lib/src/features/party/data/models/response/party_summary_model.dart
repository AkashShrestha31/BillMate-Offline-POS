import 'package:freezed_annotation/freezed_annotation.dart';

part 'party_summary_model.freezed.dart';
part 'party_summary_model.g.dart';

@freezed
class PartySummaryModel with _$PartySummaryModel {
  const factory PartySummaryModel({
    @JsonKey(name: 'total_parties') int? totalParties,
    @JsonKey(name: 'parties_with_sales') int? partiesWithSales,
    @JsonKey(name: 'parties_with_purchases') int? partiesWithPurchases,
    @JsonKey(name: 'total_outstanding') double? totalOutstanding,
    @JsonKey(name: 'parties_with_outstanding') int? partiesWithOutstanding,
  }) = _PartySummaryModel;

  factory PartySummaryModel.fromJson(Map<String, dynamic> json) =>
      _$PartySummaryModelFromJson(json);
}
