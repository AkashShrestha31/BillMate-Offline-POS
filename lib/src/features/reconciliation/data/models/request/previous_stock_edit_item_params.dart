import 'package:freezed_annotation/freezed_annotation.dart';

part 'previous_stock_edit_item_params.freezed.dart';
part 'previous_stock_edit_item_params.g.dart';

@freezed
class PreviousStockEditItemParams with _$PreviousStockEditItemParams {
  @JsonSerializable(includeIfNull: false)
  const factory PreviousStockEditItemParams({
    required String name,
    @JsonKey(name: 'previousQuantity') double? previousQuantity,
    double? rate,
    double? value,
    @JsonKey(name: 'batchNumber') String? batchNumber,
    @JsonKey(name: 'expiryDate') String? expiryDate,
    String? notes,
    @JsonKey(name: 'isActive') bool? isActive,
  }) = _PreviousStockEditItemParams;

  factory PreviousStockEditItemParams.fromJson(Map<String, dynamic> json) =>
      _$PreviousStockEditItemParamsFromJson(json);
}
