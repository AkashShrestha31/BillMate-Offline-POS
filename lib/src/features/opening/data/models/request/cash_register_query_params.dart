import 'package:freezed_annotation/freezed_annotation.dart';

part 'cash_register_query_params.freezed.dart';
part 'cash_register_query_params.g.dart';

@freezed
class CashRegisterQueryParams with _$CashRegisterQueryParams {
  const factory CashRegisterQueryParams({
    @JsonKey(name: 'register_id') int? registerId,
    @JsonKey(name: 'register_name') String? registerName,
    @JsonKey(name: 'shift_date') String? shiftDate,
    String? status,
    @JsonKey(name: 'date_from') String? dateFrom,
    @JsonKey(name: 'date_to') String? dateTo,
  }) = _CashRegisterQueryParams;

  factory CashRegisterQueryParams.fromJson(Map<String, dynamic> json) =>
      _$CashRegisterQueryParamsFromJson(json);
}
