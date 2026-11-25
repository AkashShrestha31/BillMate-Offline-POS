// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel_summary_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotelSummaryRequestParams _$HotelSummaryRequestParamsFromJson(
        Map<String, dynamic> json) =>
    HotelSummaryRequestParams(
      date: json['date'] as String?,
      openingAmount: json['opening_amount'] as String?,
      totalAvailableAmount: json['total_available_amount'] as String?,
      payCashGetQrExchange: json['pay_cash_get_qr_exchange'] as String?,
      payQrGetCashExchange: json['pay_qr_get_cash_exchange'] as String?,
      save: json['save'] as bool? ?? false,
    );

Map<String, dynamic> _$HotelSummaryRequestParamsToJson(
        HotelSummaryRequestParams instance) =>
    <String, dynamic>{
      'date': instance.date,
      'opening_amount': instance.openingAmount,
      'total_available_amount': instance.totalAvailableAmount,
      'pay_cash_get_qr_exchange': instance.payCashGetQrExchange,
      'pay_qr_get_cash_exchange': instance.payQrGetCashExchange,
      'save': instance.save,
    };

CreateHotelSummaryRequest _$CreateHotelSummaryRequestFromJson(
        Map<String, dynamic> json) =>
    CreateHotelSummaryRequest(
      date: json['date'] as String,
      openingBalance: (json['opening_balance'] as num).toDouble(),
      salesAmount: (json['sales_amount'] as num).toDouble(),
      qrAmount: (json['qr_amount'] as num).toDouble(),
      cashAmount: (json['cash_amount'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      expenses: (json['expenses'] as num).toDouble(),
      unPaid: (json['un_paid'] as num).toDouble(),
      unPaidDiscount: (json['un_paid_discount'] as num).toDouble(),
      creditPaidCash: (json['credit_paid_cash'] as num).toDouble(),
      creditQr: (json['credit_qr'] as num).toDouble(),
      closingBalance: (json['closing_balance'] as num).toDouble(),
      payCashGetQrExchange:
          (json['pay_cash_get_qr_exchange'] as num).toDouble(),
      payQrGetCashExchange:
          (json['pay_qr_get_cash_exchange'] as num).toDouble(),
      lostMoney: (json['lost_money'] as num).toDouble(),
    );

Map<String, dynamic> _$CreateHotelSummaryRequestToJson(
        CreateHotelSummaryRequest instance) =>
    <String, dynamic>{
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
      'pay_cash_get_qr_exchange': instance.payCashGetQrExchange,
      'pay_qr_get_cash_exchange': instance.payQrGetCashExchange,
    };
