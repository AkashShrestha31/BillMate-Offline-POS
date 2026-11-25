import 'package:freezed_annotation/freezed_annotation.dart';

part 'updated_stock_item_model.freezed.dart';
part 'updated_stock_item_model.g.dart';

@freezed
class UpdatedStockItemModel with _$UpdatedStockItemModel {
  const factory UpdatedStockItemModel({
    required String name,
    required String item,
    required String location,
    @JsonKey(name: 'reporting_date') required String reportingDate,
    @JsonKey(name: 'previous_quantity') required double previousQuantity,
    required double rate,
    required double value,
    @JsonKey(name: 'batch_number') required String batchNumber,
    @JsonKey(name: 'expiry_date') required String expiryDate,
    String? notes,
    @JsonKey(name: 'is_active') required bool isActive,
    @JsonKey(name: 'modified_by') required String modifiedBy,
    required String modified,
  }) = _UpdatedStockItemModel;

  factory UpdatedStockItemModel.fromJson(Map<String, dynamic> json) =>
      _$UpdatedStockItemModelFromJson(json);
}
