// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_invoice_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteInvoiceResponseModel _$DeleteInvoiceResponseModelFromJson(
        Map<String, dynamic> json) =>
    DeleteInvoiceResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      summary: DeleteInvoiceSummary.fromJson(
          json['summary'] as Map<String, dynamic>),
      deletedInvoices: (json['deleted_invoices'] as List<dynamic>)
          .map((e) => DeletedInvoiceDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      partyUpdates: (json['party_updates'] as List<dynamic>)
          .map((e) => PartyUpdate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DeleteInvoiceResponseModelToJson(
        DeleteInvoiceResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'summary': instance.summary,
      'deleted_invoices': instance.deletedInvoices,
      'party_updates': instance.partyUpdates,
    };

DeleteInvoiceSummary _$DeleteInvoiceSummaryFromJson(
        Map<String, dynamic> json) =>
    DeleteInvoiceSummary(
      totalInvoicesRequested: (json['total_invoices_requested'] as num).toInt(),
      totalInvoicesDeleted: (json['total_invoices_deleted'] as num).toInt(),
      totalInvoicesNotFound: (json['total_invoices_not_found'] as num).toInt(),
      totalItemsDeleted: (json['total_items_deleted'] as num).toInt(),
      totalPaymentForDeleted:
          (json['total_payment_for_deleted'] as num).toInt(),
      totalPaymentsDeleted: (json['total_payments_deleted'] as num).toInt(),
      partiesUpdated: (json['parties_updated'] as num).toInt(),
    );

Map<String, dynamic> _$DeleteInvoiceSummaryToJson(
        DeleteInvoiceSummary instance) =>
    <String, dynamic>{
      'total_invoices_requested': instance.totalInvoicesRequested,
      'total_invoices_deleted': instance.totalInvoicesDeleted,
      'total_invoices_not_found': instance.totalInvoicesNotFound,
      'total_items_deleted': instance.totalItemsDeleted,
      'total_payment_for_deleted': instance.totalPaymentForDeleted,
      'total_payments_deleted': instance.totalPaymentsDeleted,
      'parties_updated': instance.partiesUpdated,
    };

DeletedInvoiceDetail _$DeletedInvoiceDetailFromJson(
        Map<String, dynamic> json) =>
    DeletedInvoiceDetail(
      invoiceName: json['invoice_name'] as String,
      party: json['party'] as String,
      outstandingAmount: (json['outstanding_amount'] as num).toDouble(),
      itemsDeleted: (json['items_deleted'] as num).toInt(),
      paymentForDeleted: (json['payment_for_deleted'] as num).toInt(),
      paymentsDeleted: (json['payments_deleted'] as num).toInt(),
    );

Map<String, dynamic> _$DeletedInvoiceDetailToJson(
        DeletedInvoiceDetail instance) =>
    <String, dynamic>{
      'invoice_name': instance.invoiceName,
      'party': instance.party,
      'outstanding_amount': instance.outstandingAmount,
      'items_deleted': instance.itemsDeleted,
      'payment_for_deleted': instance.paymentForDeleted,
      'payments_deleted': instance.paymentsDeleted,
    };

PartyUpdate _$PartyUpdateFromJson(Map<String, dynamic> json) => PartyUpdate(
      party: json['party'] as String,
      outstandingReduction: (json['outstanding_reduction'] as num).toDouble(),
    );

Map<String, dynamic> _$PartyUpdateToJson(PartyUpdate instance) =>
    <String, dynamic>{
      'party': instance.party,
      'outstanding_reduction': instance.outstandingReduction,
    };
