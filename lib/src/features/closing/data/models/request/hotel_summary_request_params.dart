import 'package:hotel/src/core/extensions/extensions/string_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hotel_summary_request_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class HotelSummaryRequestParams {
  final String? date;
  final String? openingAmount;
  final String? totalAvailableAmount;
  final String? payCashGetQrExchange;
  final String? payQrGetCashExchange;
  final bool? save;

  HotelSummaryRequestParams(
      {this.date,
      this.openingAmount,
      this.totalAvailableAmount,
      this.payCashGetQrExchange,
      this.payQrGetCashExchange,
      this.save = false});

  factory HotelSummaryRequestParams.fromJson(Map<String, dynamic> json) => _$HotelSummaryRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$HotelSummaryRequestParamsToJson(this);

  Map<String, dynamic> toQueryParams() {
    final queryParams = <String, dynamic>{};
    if (date.isNotNullNotEmpty) queryParams['date'] = date!;
    if (openingAmount.isNotNullNotEmpty) queryParams['opening_balance'] = openingAmount!;
    if (totalAvailableAmount.isNotNullNotEmpty) queryParams['total_available_amount'] = totalAvailableAmount!;
    if (payCashGetQrExchange.isNotNullNotEmpty) queryParams['pay_cash_get_qr_exchange'] = payCashGetQrExchange!;
    if (payQrGetCashExchange.isNotNullNotEmpty) queryParams['pay_qr_get_cash_exchange'] = payQrGetCashExchange!;
    queryParams['save'] = save!;

    return queryParams;
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CreateHotelSummaryRequest {
  final String date;
  final double openingBalance;
  final double salesAmount;
  final double qrAmount;
  final double cashAmount;
  final double discount;
  final double expenses;
  final double unPaid;
  final double unPaidDiscount;
  final double creditPaidCash;
  final double creditQr;
  final double closingBalance;
  final double lostMoney;
  final double payCashGetQrExchange;
  final double payQrGetCashExchange;

  CreateHotelSummaryRequest({
    required this.date,
    required this.openingBalance,
    required this.salesAmount,
    required this.qrAmount,
    required this.cashAmount,
    required this.discount,
    required this.expenses,
    required this.unPaid,
    required this.unPaidDiscount,
    required this.creditPaidCash,
    required this.creditQr,
    required this.closingBalance,
    required this.payCashGetQrExchange,
    required this.payQrGetCashExchange,
    required this.lostMoney,
  });

  factory CreateHotelSummaryRequest.fromJson(Map<String, dynamic> json) => _$CreateHotelSummaryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateHotelSummaryRequestToJson(this);
}
