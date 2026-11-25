import 'package:freezed_annotation/freezed_annotation.dart';
import 'previous_stock_item_model.dart';

part 'previous_stock_details_response_model.freezed.dart';
part 'previous_stock_details_response_model.g.dart';

@freezed
class PreviousStockDetailsResponseModel with _$PreviousStockDetailsResponseModel {
  const factory PreviousStockDetailsResponseModel({
    required bool success,
    @JsonKey(name: 'stock_items') required List<PreviousStockItemModel> stockItems,
  }) = _PreviousStockDetailsResponseModel;

  factory PreviousStockDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PreviousStockDetailsResponseModelFromJson(json);
}
