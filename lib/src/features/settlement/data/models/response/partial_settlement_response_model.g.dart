// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partial_settlement_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartialSettlementResponseModel _$PartialSettlementResponseModelFromJson(
        Map<String, dynamic> json) =>
    PartialSettlementResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      summary: PartialSettlementSummary.fromJson(
          json['summary'] as Map<String, dynamic>),
      payments: (json['payments'] as List<dynamic>)
          .map((e) =>
              PartialSettlementPayment.fromJson(e as Map<String, dynamic>))
          .toList(),
      settledInvoices: (json['settled_invoices'] as List<dynamic>)
          .map((e) =>
              PartialSettlementInvoice.fromJson(e as Map<String, dynamic>))
          .toList(),
      settlementDetails: PartialSettlementDetails.fromJson(
          json['settlement_details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PartialSettlementResponseModelToJson(
        PartialSettlementResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'summary': instance.summary,
      'payments': instance.payments,
      'settled_invoices': instance.settledInvoices,
      'settlement_details': instance.settlementDetails,
    };

PartialSettlementSummary _$PartialSettlementSummaryFromJson(
        Map<String, dynamic> json) =>
    PartialSettlementSummary(
      requestedAmount: (json['requested_amount'] as num).toDouble(),
      totalAmountSettled: (json['total_amount_settled'] as num).toDouble(),
      remainingAmount: (json['remaining_amount'] as num).toDouble(),
      paymentsCreated: (json['payments_created'] as num).toInt(),
      invoicesAffected: (json['invoices_affected'] as num).toInt(),
      fullySettledInvoices: (json['fully_settled_invoices'] as num).toInt(),
      partiallySettledInvoices:
          (json['partially_settled_invoices'] as num).toInt(),
    );

Map<String, dynamic> _$PartialSettlementSummaryToJson(
        PartialSettlementSummary instance) =>
    <String, dynamic>{
      'requested_amount': instance.requestedAmount,
      'total_amount_settled': instance.totalAmountSettled,
      'remaining_amount': instance.remainingAmount,
      'payments_created': instance.paymentsCreated,
      'invoices_affected': instance.invoicesAffected,
      'fully_settled_invoices': instance.fullySettledInvoices,
      'partially_settled_invoices': instance.partiallySettledInvoices,
    };

PartialSettlementPayment _$PartialSettlementPaymentFromJson(
        Map<String, dynamic> json) =>
    PartialSettlementPayment(
      paymentName: json['payment_name'] as String,
      type: json['type'] as String,
      amount: (json['amount'] as num).toDouble(),
      invoice: json['invoice'] as String,
    );

Map<String, dynamic> _$PartialSettlementPaymentToJson(
        PartialSettlementPayment instance) =>
    <String, dynamic>{
      'payment_name': instance.paymentName,
      'type': instance.type,
      'amount': instance.amount,
      'invoice': instance.invoice,
    };

PartialSettlementInvoice _$PartialSettlementInvoiceFromJson(
        Map<String, dynamic> json) =>
    PartialSettlementInvoice(
      type: json['type'] as String,
      invoice: json['invoice'] as String,
      originalOutstanding: (json['original_outstanding'] as num?)?.toDouble(),
      settledAmount: (json['settled_amount'] as num).toDouble(),
      remainingOutstanding: (json['remaining_outstanding'] as num).toDouble(),
      fullySettled: json['fully_settled'] as bool,
    );

Map<String, dynamic> _$PartialSettlementInvoiceToJson(
        PartialSettlementInvoice instance) =>
    <String, dynamic>{
      'type': instance.type,
      'invoice': instance.invoice,
      'original_outstanding': instance.originalOutstanding,
      'settled_amount': instance.settledAmount,
      'remaining_outstanding': instance.remainingOutstanding,
      'fully_settled': instance.fullySettled,
    };

Map<String, dynamic> _$PartialSettlementDetailsToJson(
        PartialSettlementDetails instance) =>
    <String, dynamic>{
      'party': instance.party,
      'payment_method': instance.paymentMethod,
      'payment_date': instance.paymentDate,
      'payment_account': instance.paymentAccount,
      'reference_id': instance.referenceId,
      'reference_date': instance.referenceDate,
      'clearance_date': instance.clearanceDate,
      'notes': instance.notes,
      'invoice_type': instance.invoiceType,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt,
    };
