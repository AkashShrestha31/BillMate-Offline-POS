import 'package:json_annotation/json_annotation.dart';

part 'daily_cash_summary_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DailyCashSummaryResponseModel {
  final bool success;
  final String? message;
  final DailyCashSummaryModel? summary;
  final List<DailyCashSummaryModel>? summaries;
  final PaginationModel? pagination;
  final FiltersModel? filters;
  final int? deletedId;
  final String? deletedDate;

  DailyCashSummaryResponseModel({
    required this.success,
    this.message,
    this.summary,
    this.summaries,
    this.pagination,
    this.filters,
    this.deletedId,
    this.deletedDate,
  });

  factory DailyCashSummaryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DailyCashSummaryResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$DailyCashSummaryResponseModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class DailyCashSummaryModel {
  final int id;
  final String date;
  final double? openingBalance;
  final double? salesAmount;
  final double? qrAmount;
  final double? cashAmount;
  final double? discount;
  final double? expenses;
  final double? unPaid;
  final double? unPaidDiscount;
  final double? creditPaidCash;
  final double? creditQr;
  final double? closingBalance;
  final double? lostMoney;
  final double? extraMoney; // Added missing field
  final String? createdBy;
  final String? createdAt;
  final String? modifiedBy;
  final String? modifiedAt;
  final double? payCashGetQrExchange;
  final double? payQrGetCashExchange;

  DailyCashSummaryModel({
    required this.id,
    required this.date,
    this.openingBalance,
    this.salesAmount,
    this.qrAmount,
    this.cashAmount,
    this.discount,
    this.expenses,
    this.unPaid,
    this.unPaidDiscount,
    this.creditPaidCash,
    this.creditQr,
    this.closingBalance,
    this.lostMoney,
    this.extraMoney, // Added to constructor
    this.createdBy,
    this.createdAt,
    this.modifiedBy,
    this.modifiedAt,
    this.payCashGetQrExchange,
    this.payQrGetCashExchange,
  });

  factory DailyCashSummaryModel.fromJson(Map<String, dynamic> json) => _$DailyCashSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$DailyCashSummaryModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PaginationModel {
  final int totalCount;
  final int limit;
  final int offset;
  final bool hasMore;

  PaginationModel({
    required this.totalCount,
    required this.limit,
    required this.offset,
    required this.hasMore,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) => _$PaginationModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class FiltersModel {
  final String? date;
  final String? startDate;
  final String? endDate;

  FiltersModel({
    this.date,
    this.startDate,
    this.endDate,
  });

  factory FiltersModel.fromJson(Map<String, dynamic> json) => _$FiltersModelFromJson(json);

  Map<String, dynamic> toJson() => _$FiltersModelToJson(this);
}
