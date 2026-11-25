// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel_summary_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotelSummaryResponseModel _$HotelSummaryResponseModelFromJson(
        Map<String, dynamic> json) =>
    HotelSummaryResponseModel(
      success: json['success'] as bool,
      queryDate: json['query_date'] as String,
      summary: SalesSummary.fromJson(json['summary'] as Map<String, dynamic>),
      salesList: (json['sales_list'] as List<dynamic>)
          .map((e) => SalesInvoice.fromJson(e as Map<String, dynamic>))
          .toList(),
      creditList: (json['credit_list'] as List<dynamic>)
          .map((e) => CreditPayment.fromJson(e as Map<String, dynamic>))
          .toList(),
      purchaseList: (json['purchase_list'] as List<dynamic>)
          .map((e) => PurchaseInvoice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HotelSummaryResponseModelToJson(
        HotelSummaryResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'query_date': instance.queryDate,
      'summary': instance.summary,
      'sales_list': instance.salesList,
      'credit_list': instance.creditList,
      'purchase_list': instance.purchaseList,
    };

SalesSummary _$SalesSummaryFromJson(Map<String, dynamic> json) => SalesSummary(
      openingBalance: (json['opening_balance'] as num).toInt(),
      totalSales: (json['total_sales'] as num).toInt(),
      salesQrAmount: (json['sales_qr_amount'] as num).toInt(),
      salesTransferAmount: (json['sales_transfer_amount'] as num).toInt(),
      salesCashAmount: (json['sales_cash_amount'] as num).toInt(),
      totalDiscount: (json['total_discount'] as num).toInt(),
      totalExpenses: (json['total_expenses'] as num).toInt(),
      totalExpensesQr: (json['total_expenses_qr'] as num).toInt(),
      totalExpensesTransfer: (json['total_expenses_transfer'] as num).toInt(),
      totalExpensesCash: (json['total_expenses_cash'] as num).toInt(),
      unpaidAmount: (json['unpaid_amount'] as num).toInt(),
      creditCash: (json['credit_cash'] as num).toInt(),
      creditQr: (json['credit_qr'] as num).toInt(),
      lostAmount: (json['lost_amount'] as num).toInt(),
      extraAmount: (json['extra_amount'] as num).toInt(),
      creditDiscount: (json['credit_discount'] as num).toInt(),
      closingBalance: (json['closing_balance'] as num).toInt(),
      payCashGetQrExchange:
          (json['pay_cash_get_qr_exchange'] as num?)?.toDouble(),
      payQrGetCashExchange:
          (json['pay_qr_get_cash_exchange'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SalesSummaryToJson(SalesSummary instance) =>
    <String, dynamic>{
      'opening_balance': instance.openingBalance,
      'total_sales': instance.totalSales,
      'sales_qr_amount': instance.salesQrAmount,
      'sales_transfer_amount': instance.salesTransferAmount,
      'sales_cash_amount': instance.salesCashAmount,
      'total_discount': instance.totalDiscount,
      'total_expenses': instance.totalExpenses,
      'total_expenses_qr': instance.totalExpensesQr,
      'total_expenses_transfer': instance.totalExpensesTransfer,
      'total_expenses_cash': instance.totalExpensesCash,
      'unpaid_amount': instance.unpaidAmount,
      'credit_cash': instance.creditCash,
      'credit_qr': instance.creditQr,
      'lost_amount': instance.lostAmount,
      'extra_amount': instance.extraAmount,
      'credit_discount': instance.creditDiscount,
      'closing_balance': instance.closingBalance,
      'pay_cash_get_qr_exchange': instance.payCashGetQrExchange,
      'pay_qr_get_cash_exchange': instance.payQrGetCashExchange,
    };

SalesInvoice _$SalesInvoiceFromJson(Map<String, dynamic> json) => SalesInvoice(
      id: json['id'] as String,
      party: json['party'] as String,
      date: json['date'] as String,
      totalAmount: (json['total_amount'] as num).toInt(),
      totalAmountWithDiscount:
          (json['total_amount_with_discount'] as num).toInt(),
      discountAmount: (json['discount_amount'] as num).toInt(),
      paymentDetails: (json['payment_details'] as List<dynamic>)
          .map((e) => PaymentDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SalesInvoiceToJson(SalesInvoice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'party': instance.party,
      'date': instance.date,
      'total_amount': instance.totalAmount,
      'total_amount_with_discount': instance.totalAmountWithDiscount,
      'discount_amount': instance.discountAmount,
      'payment_details': instance.paymentDetails,
    };

PaymentDetail _$PaymentDetailFromJson(Map<String, dynamic> json) =>
    PaymentDetail(
      paymentId: json['payment_id'] as String,
      paymentMethod: json['payment_method'] as String,
      paymentDate: json['payment_date'] as String,
      paymentAmount: (json['payment_amount'] as num).toInt(),
    );

Map<String, dynamic> _$PaymentDetailToJson(PaymentDetail instance) =>
    <String, dynamic>{
      'payment_id': instance.paymentId,
      'payment_method': instance.paymentMethod,
      'payment_date': instance.paymentDate,
      'payment_amount': instance.paymentAmount,
    };

CreditPayment _$CreditPaymentFromJson(Map<String, dynamic> json) =>
    CreditPayment(
      invoiceId: json['invoice_id'] as String,
      party: json['party'] as String,
      salesDate: json['sales_date'] as String,
      invoiceAmount: (json['invoice_amount'] as num).toInt(),
      originalDiscount: (json['original_discount'] as num).toInt(),
      outstandingAmount: (json['outstanding_amount'] as num).toInt(),
      totalPayments: (json['total_payments'] as num).toInt(),
      creditDiscountGiven: (json['credit_discount_given'] as num).toInt(),
      payments: (json['payments'] as List<dynamic>)
          .map((e) => PaymentDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreditPaymentToJson(CreditPayment instance) =>
    <String, dynamic>{
      'invoice_id': instance.invoiceId,
      'party': instance.party,
      'sales_date': instance.salesDate,
      'invoice_amount': instance.invoiceAmount,
      'original_discount': instance.originalDiscount,
      'outstanding_amount': instance.outstandingAmount,
      'total_payments': instance.totalPayments,
      'credit_discount_given': instance.creditDiscountGiven,
      'payments': instance.payments,
    };

PurchaseInvoice _$PurchaseInvoiceFromJson(Map<String, dynamic> json) =>
    PurchaseInvoice(
      id: json['id'] as String,
      party: json['party'] as String,
      date: json['date'] as String,
      totalAmount: (json['total_amount'] as num).toInt(),
      totalAmountWithDiscount:
          (json['total_amount_with_discount'] as num).toInt(),
      discountAmount: (json['discount_amount'] as num).toInt(),
      paymentDetails: (json['payment_details'] as List<dynamic>)
          .map((e) => PaymentDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PurchaseInvoiceToJson(PurchaseInvoice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'party': instance.party,
      'date': instance.date,
      'total_amount': instance.totalAmount,
      'total_amount_with_discount': instance.totalAmountWithDiscount,
      'discount_amount': instance.discountAmount,
      'payment_details': instance.paymentDetails,
    };
