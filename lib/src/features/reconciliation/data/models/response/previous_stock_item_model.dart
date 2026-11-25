import 'package:freezed_annotation/freezed_annotation.dart';

part 'previous_stock_item_model.freezed.dart';
part 'previous_stock_item_model.g.dart';

@freezed
class PreviousStockItemModel with _$PreviousStockItemModel {
  const factory PreviousStockItemModel({
    required String name,
    required String item,
    required String location,
    @JsonKey(name: 'reporting_date') required String reportingDate,
    @JsonKey(name: 'previous_quantity') required int previousQuantity,
    required double rate,
    required double value,
    @JsonKey(name: 'batch_number') required String batchNumber,
    @JsonKey(name: 'expiry_date') required String expiryDate,
    @JsonKey(name: 'is_active') required bool isActive,
    @JsonKey(name: 'upload_date') required String uploadDate,
    @JsonKey(name: 'uploaded_by') required String uploadedBy,
    required String notes,
    @JsonKey(name: 'created_by') required String createdBy,
    @JsonKey(name: 'modified_by') required String modifiedBy,
    required String created,
    required String modified,
  }) = _PreviousStockItemModel;

  factory PreviousStockItemModel.fromJson(Map<String, dynamic> json) =>
      _$PreviousStockItemModelFromJson(json);
}
