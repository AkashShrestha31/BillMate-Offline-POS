import 'package:json_annotation/json_annotation.dart';

part 'stock_adjustment_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class StockAdjustmentResponseModel {
  final bool success;
  final String message;
  final int adjustmentsMade;
  final int totalVarianceCorrected;
  final List<AdjustmentRecord> adjustmentRecords;
  final String adjustmentDate;

  StockAdjustmentResponseModel({
    required this.success,
    required this.message,
    required this.adjustmentsMade,
    required this.totalVarianceCorrected,
    required this.adjustmentRecords,
    required this.adjustmentDate,
  });

  factory StockAdjustmentResponseModel.fromJson(Map<String, dynamic> json) =>
      _$StockAdjustmentResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$StockAdjustmentResponseModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AdjustmentRecord {
  final String item;
  final String location;
  final String batchNumber;
  final int previousQuantity;
  final int adjustedQuantity;
  final int variance;
  final double adjustmentValue;
  final String? reason;

  AdjustmentRecord({
    required this.item,
    required this.location,
    required this.batchNumber,
    required this.previousQuantity,
    required this.adjustedQuantity,
    required this.variance,
    required this.adjustmentValue,
    this.reason,
  });

  factory AdjustmentRecord.fromJson(Map<String, dynamic> json) =>
      _$AdjustmentRecordFromJson(json);

  Map<String, dynamic> toJson() => _$AdjustmentRecordToJson(this);
}
