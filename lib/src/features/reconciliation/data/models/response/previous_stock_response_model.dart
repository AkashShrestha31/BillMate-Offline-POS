import 'package:json_annotation/json_annotation.dart';

part 'previous_stock_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PreviousStockResponseModel {
  final List<ReportingDateModel> uniqueReportingDates;
  final int totalUniqueDates;
  final int returnedCount;
  final FiltersAppliedModel filtersApplied;

  PreviousStockResponseModel({
    required this.uniqueReportingDates,
    required this.totalUniqueDates,
    required this.returnedCount,
    required this.filtersApplied,
  });

  /// Factory method to create an instance from a JSON map
  factory PreviousStockResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PreviousStockResponseModelFromJson(json);

  /// Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() => _$PreviousStockResponseModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ReportingDateModel {
  final String reportingDate;
  final int recordCount;
  final int uniqueItems;
  final int uniqueLocations;
  final int totalQuantity;
  final double totalValue;
  final int uploadersCount;

  ReportingDateModel({
    required this.reportingDate,
    required this.recordCount,
    required this.uniqueItems,
    required this.uniqueLocations,
    required this.totalQuantity,
    required this.totalValue,
    required this.uploadersCount,
  });

  /// Factory method to create an instance from a JSON map
  factory ReportingDateModel.fromJson(Map<String, dynamic> json) =>
      _$ReportingDateModelFromJson(json);

  /// Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() => _$ReportingDateModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class FiltersAppliedModel {
  final String? startDate;
  final String? endDate;
  final String? locations;
  final String? items;
  final String sortOrder;
  final String? limit;
  final bool onlyActive;

  FiltersAppliedModel({
    this.startDate,
    this.endDate,
    this.locations,
    this.items,
    required this.sortOrder,
    this.limit,
    required this.onlyActive,
  });

  /// Factory method to create an instance from a JSON map
  factory FiltersAppliedModel.fromJson(Map<String, dynamic> json) =>
      _$FiltersAppliedModelFromJson(json);

  /// Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() => _$FiltersAppliedModelToJson(this);
}
