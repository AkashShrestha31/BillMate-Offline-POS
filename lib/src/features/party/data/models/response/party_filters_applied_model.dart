import 'package:freezed_annotation/freezed_annotation.dart';

part 'party_filters_applied_model.freezed.dart';
part 'party_filters_applied_model.g.dart';

@freezed
class PartyFiltersAppliedModel with _$PartyFiltersAppliedModel {
  const factory PartyFiltersAppliedModel({
    String? search,
    String? role,
    @JsonKey(name: 'has_outstanding') bool? hasOutstanding,
    String? currency,
    String? loyaltyProgram,
    @JsonKey(name: 'exclude_zero_transactions') bool? excludeZeroTransactions,
    @JsonKey(name: 'sort_by') String? sortBy,
    @JsonKey(name: 'sort_order') String? sortOrder,
  }) = _PartyFiltersAppliedModel;

  factory PartyFiltersAppliedModel.fromJson(Map<String, dynamic> json) =>
      _$PartyFiltersAppliedModelFromJson(json);
}
