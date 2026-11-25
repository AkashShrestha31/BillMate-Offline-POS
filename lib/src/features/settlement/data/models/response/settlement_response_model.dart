import 'package:json_annotation/json_annotation.dart';

part 'settlement_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SettlementResponseModel {
  final bool success;
  final String message;
  final SettlementSummary? summary;
  final Map<String, dynamic>? results;

  SettlementResponseModel({
    required this.success,
    required this.message,
    this.summary,
    this.results,
  });

  /// Factory method to create an instance from a JSON map
  factory SettlementResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SettlementResponseModelFromJson(json);

  /// Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() => _$SettlementResponseModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SettlementSummary {
  final int totalPartiesProcessed;
  final int successfulSettlements;
  final int failedSettlements;
  final double totalAmountSettled;

  SettlementSummary({
    required this.totalPartiesProcessed,
    required this.successfulSettlements,
    required this.failedSettlements,
    required this.totalAmountSettled,
  });

  /// Factory method to create an instance from a JSON map
  factory SettlementSummary.fromJson(Map<String, dynamic> json) =>
      _$SettlementSummaryFromJson(json);

  /// Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() => _$SettlementSummaryToJson(this);
}
