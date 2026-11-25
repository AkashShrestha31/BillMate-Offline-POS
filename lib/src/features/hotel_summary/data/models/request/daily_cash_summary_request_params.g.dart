// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_cash_summary_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyCashSummaryRequestParams _$DailyCashSummaryRequestParamsFromJson(
        Map<String, dynamic> json) =>
    DailyCashSummaryRequestParams(
      id: (json['id'] as num?)?.toInt(),
      date: json['date'] as String?,
      openingBalance: (json['opening_balance'] as num?)?.toDouble(),
      salesAmount: (json['sales_amount'] as num?)?.toDouble(),
      qrAmount: (json['qr_amount'] as num?)?.toDouble(),
      cashAmount: (json['cash_amount'] as num?)?.toDouble(),
      discount: (json['discount'] as num?)?.toDouble(),
      expenses: (json['expenses'] as num?)?.toDouble(),
      unPaid: (json['un_paid'] as num?)?.toDouble(),
      unPaidDiscount: (json['un_paid_discount'] as num?)?.toDouble(),
      creditPaidCash: (json['credit_paid_cash'] as num?)?.toDouble(),
      creditQr: (json['credit_qr'] as num?)?.toDouble(),
      closingBalance: (json['closing_balance'] as num?)?.toDouble(),
      lostMoney: (json['lost_money'] as num?)?.toDouble(),
      extraMoney: (json['extra_money'] as num?)?.toDouble(),
      payQrGetCashExchange:
          (json['pay_qr_get_cash_exchange'] as num?)?.toDouble(),
      payCashGetQrExchange:
          (json['pay_cash_get_qr_exchange'] as num?)?.toDouble(),
      createdBy: json['created_by'] as String?,
      modifiedBy: json['modified_by'] as String?,
    );

Map<String, dynamic> _$DailyCashSummaryRequestParamsToJson(
        DailyCashSummaryRequestParams instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'opening_balance': instance.openingBalance,
      'sales_amount': instance.salesAmount,
      'qr_amount': instance.qrAmount,
      'cash_amount': instance.cashAmount,
      'discount': instance.discount,
      'expenses': instance.expenses,
      'un_paid': instance.unPaid,
      'un_paid_discount': instance.unPaidDiscount,
      'credit_paid_cash': instance.creditPaidCash,
      'credit_qr': instance.creditQr,
      'closing_balance': instance.closingBalance,
      'lost_money': instance.lostMoney,
      'extra_money': instance.extraMoney,
      'pay_qr_get_cash_exchange': instance.payQrGetCashExchange,
      'pay_cash_get_qr_exchange': instance.payCashGetQrExchange,
      'created_by': instance.createdBy,
      'modified_by': instance.modifiedBy,
    };
