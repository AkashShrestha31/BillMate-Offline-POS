import 'package:freezed_annotation/freezed_annotation.dart';

part 'party_request_params.freezed.dart';
part 'party_request_params.g.dart';

@freezed
class PartyRequestParams with _$PartyRequestParams {
  const factory PartyRequestParams({
    int? page,
    @JsonKey(name: 'page_size') int? pageSize,
    String? search,
    String? role,
    /// Active filter for list API, e.g. `1` with [role] `employee`.
    int? status,
    @JsonKey(name: 'has_outstanding') bool? hasOutstanding,
    String? currency,
    String? loyaltyProgram,
    @JsonKey(name: 'sort_by') String? sortBy,
    @JsonKey(name: 'sort_order') String? sortOrder,
    @JsonKey(name: 'exclude_zero_transactions') bool? excludeZeroTransactions,
    String? name, // For single party detail
  }) = _PartyRequestParams;

  factory PartyRequestParams.fromJson(Map<String, dynamic> json) =>
      _$PartyRequestParamsFromJson(json);
}
