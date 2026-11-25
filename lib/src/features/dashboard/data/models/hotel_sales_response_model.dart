import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'hotel_sales_response_model.freezed.dart';
part 'hotel_sales_response_model.g.dart';

@freezed
class HotelSalesResponseModel with _$HotelSalesResponseModel {
  const factory HotelSalesResponseModel({
    required int count,
    required String? next,
    required String? previous,
    required List<SalesReport> results,
  }) = _HotelSalesResponseModel;

  factory HotelSalesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$HotelSalesResponseModelFromJson(json);
}

@freezed
class SalesReport with _$SalesReport {
  const SalesReport._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SalesReport({
    required int id,
    required DateTime date,
    @JsonKey(fromJson: _stringToDouble) required double openingBalance,
    @JsonKey(fromJson: _stringToDouble) required double salesAmount,
    @JsonKey(fromJson: _stringToDouble) required double qrAmount,
    @JsonKey(fromJson: _stringToDouble) required double cashAmount,
    @JsonKey(fromJson: _stringToDouble) required double discount,
    @JsonKey(fromJson: _stringToDouble) required double expenses,
    @JsonKey(fromJson: _stringToDouble) required double unPaid,
    @JsonKey(fromJson: _stringToDouble) required double unPaidDiscount,
    @JsonKey(fromJson: _stringToDouble) required double creditPaidCash,
    @JsonKey(fromJson: _stringToDouble) required double creditQr,
    @JsonKey(fromJson: _stringToDouble) required double closingBalance,
    @JsonKey(fromJson: _stringToDouble) required double lostMoney,
  }) = _SalesReport;

  factory SalesReport.fromJson(Map<String, dynamic> json) =>
      _$SalesReportFromJson(json);

  // Helper methods
  double get netProfit => salesAmount - expenses;
  double get totalPayments => cashAmount + qrAmount;
  double get netCashFlow => totalPayments - expenses;
  bool get hasUnpaid => unPaid > 0;
  bool get hasLostMoney => lostMoney > 0;

  // Formatting helpers
  String get formattedDate => DateFormat('MMM dd, yyyy').format(date);
  String get formattedNetProfit => '\$${netProfit.toStringAsFixed(2)}';
  String get formattedSalesAmount => '\$${salesAmount.toStringAsFixed(2)}';
}

double _stringToDouble(dynamic value) {
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}
