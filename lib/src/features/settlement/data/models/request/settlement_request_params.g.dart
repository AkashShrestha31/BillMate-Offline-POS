// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settlement_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettlementRequestParams _$SettlementRequestParamsFromJson(
        Map<String, dynamic> json) =>
    SettlementRequestParams(
      parties:
          (json['parties'] as List<dynamic>).map((e) => e as String).toList(),
      paymentMethod: json['payment_method'] as String,
      paymentDate: json['payment_date'] as String,
      settleSalesInvoices: json['settle_sales_invoices'] as bool? ?? true,
      settlePurchaseInvoices: json['settle_purchase_invoices'] as bool? ?? true,
      skipPartiesWithErrors: json['skip_parties_with_errors'] as bool? ?? true,
      createdBy: json['created_by'] as String,
    );

Map<String, dynamic> _$SettlementRequestParamsToJson(
        SettlementRequestParams instance) =>
    <String, dynamic>{
      'parties': instance.parties,
      'payment_method': instance.paymentMethod,
      'payment_date': instance.paymentDate,
      'settle_sales_invoices': instance.settleSalesInvoices,
      'settle_purchase_invoices': instance.settlePurchaseInvoices,
      'skip_parties_with_errors': instance.skipPartiesWithErrors,
      'created_by': instance.createdBy,
    };
