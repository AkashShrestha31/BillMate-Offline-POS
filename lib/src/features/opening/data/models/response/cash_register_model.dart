import 'package:freezed_annotation/freezed_annotation.dart';

import 'cash_movement_model.dart';
import 'denomination_model.dart';

part 'cash_register_model.freezed.dart';
part 'cash_register_model.g.dart';

@freezed
class CashRegisterModel with _$CashRegisterModel {
  const factory CashRegisterModel({
    required int id,
    required String name,
    required String status,
    @JsonKey(name: 'shift_date') String? shiftDate,
    @JsonKey(name: 'opening_time') String? openingTime,
    @JsonKey(name: 'closing_time') String? closingTime,
    @JsonKey(name: 'opening_amount') double? openingAmount,
    @JsonKey(name: 'closing_amount') double? closingAmount,
    @JsonKey(name: 'expected_amount') double? expectedAmount,
    double? difference,
    @JsonKey(name: 'total_sales') double? totalSales,
    @JsonKey(name: 'total_cash_in') double? totalCashIn,
    @JsonKey(name: 'total_cash_out') double? totalCashOut,
    @JsonKey(name: 'opening_note') String? openingNote,
    @JsonKey(name: 'closing_note') String? closingNote,
    @JsonKey(name: 'opened_by') String? openedBy,
    @JsonKey(name: 'closed_by') String? closedBy,
    @JsonKey(name: 'opening_denominations') List<DenominationModel>? openingDenominations,
    @JsonKey(name: 'closing_denominations') List<DenominationModel>? closingDenominations,
    @JsonKey(name: 'total_denominations') double? totalDenominations,
    @JsonKey(name: 'variance_note') String? varianceNote,
    @JsonKey(name: 'cash_movements') List<CashMovementModel>? cashMovements,
  }) = _CashRegisterModel;

  factory CashRegisterModel.fromJson(Map<String, dynamic> json) =>
      _$CashRegisterModelFromJson(json);
}
