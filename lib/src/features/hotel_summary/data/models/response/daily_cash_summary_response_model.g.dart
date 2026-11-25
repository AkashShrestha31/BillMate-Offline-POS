// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_cash_summary_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyCashSummaryResponseModel _$DailyCashSummaryResponseModelFromJson(
        Map<String, dynamic> json) =>
    DailyCashSummaryResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String?,
      summary: json['summary'] == null
          ? null
          : DailyCashSummaryModel.fromJson(
              json['summary'] as Map<String, dynamic>),
      summaries: (json['summaries'] as List<dynamic>?)
          ?.map(
              (e) => DailyCashSummaryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : PaginationModel.fromJson(
              json['pagination'] as Map<String, dynamic>),
      filters: json['filters'] == null
          ? null
          : FiltersModel.fromJson(json['filters'] as Map<String, dynamic>),
      deletedId: (json['deleted_id'] as num?)?.toInt(),
      deletedDate: json['deleted_date'] as String?,
    );

Map<String, dynamic> _$DailyCashSummaryResponseModelToJson(
        DailyCashSummaryResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'summary': instance.summary,
      'summaries': instance.summaries,
      'pagination': instance.pagination,
      'filters': instance.filters,
      'deleted_id': instance.deletedId,
      'deleted_date': instance.deletedDate,
    };

DailyCashSummaryModel _$DailyCashSummaryModelFromJson(
        Map<String, dynamic> json) =>
    DailyCashSummaryModel(
      id: (json['id'] as num).toInt(),
      date: json['date'] as String,
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
      createdBy: json['created_by'] as String?,
      createdAt: json['created_at'] as String?,
      modifiedBy: json['modified_by'] as String?,
      modifiedAt: json['modified_at'] as String?,
      payCashGetQrExchange:
          (json['pay_cash_get_qr_exchange'] as num?)?.toDouble(),
      payQrGetCashExchange:
          (json['pay_qr_get_cash_exchange'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DailyCashSummaryModelToJson(
        DailyCashSummaryModel instance) =>
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
      'created_by': instance.createdBy,
      'created_at': instance.createdAt,
      'modified_by': instance.modifiedBy,
      'modified_at': instance.modifiedAt,
      'pay_cash_get_qr_exchange': instance.payCashGetQrExchange,
      'pay_qr_get_cash_exchange': instance.payQrGetCashExchange,
    };

PaginationModel _$PaginationModelFromJson(Map<String, dynamic> json) =>
    PaginationModel(
      totalCount: (json['total_count'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      offset: (json['offset'] as num).toInt(),
      hasMore: json['has_more'] as bool,
    );

Map<String, dynamic> _$PaginationModelToJson(PaginationModel instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'limit': instance.limit,
      'offset': instance.offset,
      'has_more': instance.hasMore,
    };

FiltersModel _$FiltersModelFromJson(Map<String, dynamic> json) => FiltersModel(
      date: json['date'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
    );

Map<String, dynamic> _$FiltersModelToJson(FiltersModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
    };
