import 'package:freezed_annotation/freezed_annotation.dart';

import 'cash_register_model.dart';

part 'cash_register_list_response.freezed.dart';
part 'cash_register_list_response.g.dart';

@freezed
class CashRegisterListResponse with _$CashRegisterListResponse {
  const factory CashRegisterListResponse({
    required bool success,
    int? count,
    List<CashRegisterModel>? registers,
    CashRegisterModel? register,
    String? message,
  }) = _CashRegisterListResponse;

  factory CashRegisterListResponse.fromJson(Map<String, dynamic> json) =>
      _$CashRegisterListResponseFromJson(json);
}
