import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_counter_response_model.freezed.dart';
part 'item_counter_response_model.g.dart';

@freezed
class ItemCounterResponseModel with _$ItemCounterResponseModel {
  const factory ItemCounterResponseModel({
    @JsonKey(name: 'item_counts') required List<ItemCount> itemCounts,
  }) = _ItemCounterResponseModel;

  factory ItemCounterResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ItemCounterResponseModelFromJson(json);
}

@freezed
class ItemCount with _$ItemCount {
  const factory ItemCount({
    required String item,
    @JsonKey(name: 'total_sold') required int totalSold,
    @JsonKey(name: 'total_purchased') required int totalPurchased,
  }) = _ItemCount;

  factory ItemCount.fromJson(Map<String, dynamic> json) =>
      _$ItemCountFromJson(json);
}
