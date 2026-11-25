import 'package:freezed_annotation/freezed_annotation.dart';

part 'failed_stock_item_model.freezed.dart';
part 'failed_stock_item_model.g.dart';

@freezed
class FailedStockItemModel with _$FailedStockItemModel {
  const factory FailedStockItemModel({
    required String name,
    required String error,
  }) = _FailedStockItemModel;

  factory FailedStockItemModel.fromJson(Map<String, dynamic> json) =>
      _$FailedStockItemModelFromJson(json);
}
