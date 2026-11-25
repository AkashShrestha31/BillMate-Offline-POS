// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_transaction_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PartyTransactionSummaryModelImpl _$$PartyTransactionSummaryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PartyTransactionSummaryModelImpl(
      totalSalesInvoices: (json['total_sales_invoices'] as num?)?.toInt(),
      totalSalesAmount: (json['total_sales_amount'] as num?)?.toDouble(),
      totalPurchaseInvoices: (json['total_purchase_invoices'] as num?)?.toInt(),
      totalPurchaseAmount: (json['total_purchase_amount'] as num?)?.toDouble(),
      totalPayments: (json['total_payments'] as num?)?.toInt(),
      totalPaymentAmount: (json['total_payment_amount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$PartyTransactionSummaryModelImplToJson(
        _$PartyTransactionSummaryModelImpl instance) =>
    <String, dynamic>{
      'total_sales_invoices': instance.totalSalesInvoices,
      'total_sales_amount': instance.totalSalesAmount,
      'total_purchase_invoices': instance.totalPurchaseInvoices,
      'total_purchase_amount': instance.totalPurchaseAmount,
      'total_payments': instance.totalPayments,
      'total_payment_amount': instance.totalPaymentAmount,
    };
