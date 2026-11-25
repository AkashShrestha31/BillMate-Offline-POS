// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel_sales_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HotelSalesResponseModelImpl _$$HotelSalesResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$HotelSalesResponseModelImpl(
      count: (json['count'] as num).toInt(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>)
          .map((e) => SalesReport.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$HotelSalesResponseModelImplToJson(
        _$HotelSalesResponseModelImpl instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };

_$SalesReportImpl _$$SalesReportImplFromJson(Map<String, dynamic> json) =>
    _$SalesReportImpl(
      id: (json['id'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
      openingBalance: _stringToDouble(json['opening_balance']),
      salesAmount: _stringToDouble(json['sales_amount']),
      qrAmount: _stringToDouble(json['qr_amount']),
      cashAmount: _stringToDouble(json['cash_amount']),
      discount: _stringToDouble(json['discount']),
      expenses: _stringToDouble(json['expenses']),
      unPaid: _stringToDouble(json['un_paid']),
      unPaidDiscount: _stringToDouble(json['un_paid_discount']),
      creditPaidCash: _stringToDouble(json['credit_paid_cash']),
      creditQr: _stringToDouble(json['credit_qr']),
      closingBalance: _stringToDouble(json['closing_balance']),
      lostMoney: _stringToDouble(json['lost_money']),
    );

Map<String, dynamic> _$$SalesReportImplToJson(_$SalesReportImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
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
    };
