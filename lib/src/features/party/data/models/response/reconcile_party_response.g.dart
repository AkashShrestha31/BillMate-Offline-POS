// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reconcile_party_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReconcilePartyResponseImpl _$$ReconcilePartyResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ReconcilePartyResponseImpl(
      success: json['success'] as bool,
      message: json['message'] as String,
      summary: ReconciliationSummary.fromJson(
          json['summary'] as Map<String, dynamic>),
      reconciliationResults: (json['reconciliation_results'] as List<dynamic>)
          .map((e) => ReconciliationResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ReconcilePartyResponseImplToJson(
        _$ReconcilePartyResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'summary': instance.summary,
      'reconciliation_results': instance.reconciliationResults,
    };

_$ReconciliationSummaryImpl _$$ReconciliationSummaryImplFromJson(
        Map<String, dynamic> json) =>
    _$ReconciliationSummaryImpl(
      totalPartiesChecked: (json['total_parties_checked'] as num).toInt(),
      totalMismatches: (json['total_mismatches'] as num).toInt(),
      totalFixed: (json['total_fixed'] as num).toInt(),
      autoFixEnabled: json['auto_fix_enabled'] as bool,
      transactionStatus: json['transaction_status'] as String,
    );

Map<String, dynamic> _$$ReconciliationSummaryImplToJson(
        _$ReconciliationSummaryImpl instance) =>
    <String, dynamic>{
      'total_parties_checked': instance.totalPartiesChecked,
      'total_mismatches': instance.totalMismatches,
      'total_fixed': instance.totalFixed,
      'auto_fix_enabled': instance.autoFixEnabled,
      'transaction_status': instance.transactionStatus,
    };

_$ReconciliationResultImpl _$$ReconciliationResultImplFromJson(
        Map<String, dynamic> json) =>
    _$ReconciliationResultImpl(
      partyName: json['party_name'] as String,
      partyOutstanding: (json['party_outstanding'] as num).toDouble(),
      actualOutstanding: (json['actual_outstanding'] as num).toDouble(),
      totalGrandTotal: (json['total_grand_total'] as num).toDouble(),
      difference: (json['difference'] as num).toDouble(),
      totalInvoiceCount: (json['total_invoice_count'] as num).toInt(),
      unpaidInvoiceCount: (json['unpaid_invoice_count'] as num).toInt(),
      status: json['status'] as String,
      updated: json['updated'] as bool,
      updateError: json['update_error'] as String?,
      unpaidInvoices: (json['unpaid_invoices'] as List<dynamic>)
          .map((e) => UnpaidInvoice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ReconciliationResultImplToJson(
        _$ReconciliationResultImpl instance) =>
    <String, dynamic>{
      'party_name': instance.partyName,
      'party_outstanding': instance.partyOutstanding,
      'actual_outstanding': instance.actualOutstanding,
      'total_grand_total': instance.totalGrandTotal,
      'difference': instance.difference,
      'total_invoice_count': instance.totalInvoiceCount,
      'unpaid_invoice_count': instance.unpaidInvoiceCount,
      'status': instance.status,
      'updated': instance.updated,
      'update_error': instance.updateError,
      'unpaid_invoices': instance.unpaidInvoices,
    };

_$UnpaidInvoiceImpl _$$UnpaidInvoiceImplFromJson(Map<String, dynamic> json) =>
    _$UnpaidInvoiceImpl(
      invoiceName: json['invoice_name'] as String,
      discountAmount: json['discount_amount'] as String,
      grandTotal: (json['grand_total'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      status: json['status'] as String,
      outstandingAmount: (json['outstanding_amount'] as num).toDouble(),
    );

Map<String, dynamic> _$$UnpaidInvoiceImplToJson(_$UnpaidInvoiceImpl instance) =>
    <String, dynamic>{
      'invoice_name': instance.invoiceName,
      'discount_amount': instance.discountAmount,
      'grand_total': instance.grandTotal,
      'date': instance.date.toIso8601String(),
      'status': instance.status,
      'outstanding_amount': instance.outstandingAmount,
    };
