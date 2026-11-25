import 'package:freezed_annotation/freezed_annotation.dart';

part 'deleted_stock_item_model.freezed.dart';
part 'deleted_stock_item_model.g.dart';

@freezed
class DeletedStockItemModel with _$DeletedStockItemModel {
  const factory DeletedStockItemModel({
    required String name,
    required String item,
    required String location,
    required int quantity,
    required double value,
  }) = _DeletedStockItemModel;

  factory DeletedStockItemModel.fromJson(Map<String, dynamic> json) =>
      _$DeletedStockItemModelFromJson(json);
}

