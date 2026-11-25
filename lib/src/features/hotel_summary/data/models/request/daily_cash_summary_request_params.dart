import 'package:hotel/src/core/extensions/extensions/string_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'daily_cash_summary_request_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DailyCashSummaryRequestParams {
  final int? id;
  final String? date;
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
  final double? extraMoney; // New field
  final double? payQrGetCashExchange; // New field
  final double? payCashGetQrExchange; // New field
  final String? createdBy;
  final String? modifiedBy;

  DailyCashSummaryRequestParams({
    this.id,
    this.date,
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
    this.extraMoney, // New field
    this.payQrGetCashExchange, // New field
    this.payCashGetQrExchange, // New field
    this.createdBy,
    this.modifiedBy,
  });

  factory DailyCashSummaryRequestParams.fromJson(Map<String, dynamic> json) =>
      _$DailyCashSummaryRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$DailyCashSummaryRequestParamsToJson(this);

  Map<String, dynamic> toRequestBody() {
    final body = <String, dynamic>{};
    if (id != null) body['id'] = id;
    if (date?.isNotEmpty == true) body['date'] = date;
    if (openingBalance != null) body['opening_balance'] = openingBalance;
    if (salesAmount != null) body['sales_amount'] = salesAmount;
    if (qrAmount != null) body['qr_amount'] = qrAmount;
    if (cashAmount != null) body['cash_amount'] = cashAmount;
    if (discount != null) body['discount'] = discount;
    if (expenses != null) body['expenses'] = expenses;
    if (unPaid != null) body['un_paid'] = unPaid;
    if (unPaidDiscount != null) body['un_paid_discount'] = unPaidDiscount;
    if (creditPaidCash != null) body['credit_paid_cash'] = creditPaidCash;
    if (creditQr != null) body['credit_qr'] = creditQr;
    if (closingBalance != null) body['closing_balance'] = closingBalance;
    if (lostMoney != null) body['lost_money'] = lostMoney;
    if (extraMoney != null) body['extra_money'] = extraMoney; // New field
    if (payQrGetCashExchange != null) body['pay_qr_get_cash_exchange'] = payQrGetCashExchange; // New field
    if (payCashGetQrExchange != null) body['pay_cash_get_qr_exchange'] = payCashGetQrExchange; // New field
    if (createdBy?.isNotEmpty == true) body['createdBy'] = createdBy;
    if (modifiedBy?.isNotEmpty == true) body['modifiedBy'] = modifiedBy;
    return body;
  }
}