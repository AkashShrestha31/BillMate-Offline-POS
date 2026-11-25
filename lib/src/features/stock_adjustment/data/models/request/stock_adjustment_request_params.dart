import 'package:hotel/src/core/extensions/extensions/string_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stock_adjustment_request_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class StockAdjustmentRequestParams {
  final String adjustmentDate;
  final String? reason;
  final String? notes;
  final List<AdjustmentItem> adjustments;

  StockAdjustmentRequestParams({
    required this.adjustmentDate,
    this.reason,
    this.notes,
    required this.adjustments,
  });

  factory StockAdjustmentRequestParams.fromJson(Map<String, dynamic> json) =>
      _$StockAdjustmentRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$StockAdjustmentRequestParamsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AdjustmentItem {
  final String item;
  final String location;
  final String batchNumber;
  final int currentQuantity;
  final int adjustedQuantity;
  final double rate;
  final String? reason;

  AdjustmentItem({
    required this.item,
    required this.location,
    required this.batchNumber,
    required this.currentQuantity,
    required this.adjustedQuantity,
    required this.rate,
    this.reason,
  });

  factory AdjustmentItem.fromJson(Map<String, dynamic> json) =>
      _$AdjustmentItemFromJson(json);

  Map<String, dynamic> toJson() => _$AdjustmentItemToJson(this);
}
