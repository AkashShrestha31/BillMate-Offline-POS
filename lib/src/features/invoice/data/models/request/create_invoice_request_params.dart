import 'package:hotel/src/features/invoice/data/models/request/invoice_payment_payload.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_invoice_request_params.g.dart';

/// Sales create payload: [payment_mode] controls draft vs submit; [payment] is encoded as
/// one JSON object (single line), a list (multiple lines), or null — see API spec.
class CreateInvoiceRequestParams {
  final String party;
  final String? account;
  final String? date;
  final String? currency;
  final double? exchangeRate;
  final String? priceList;
  final bool? setDiscountAmount;
  final double? discountAmount;
  final double? discountPercent;
  final String? terms;
  final String createdBy;
  final String modifiedBy;
  final InvoiceType invoiceType;
  final List<CreateInvoiceItem> items;

  /// Checkout always books the sale (`submitted`). [paymentMode] is unused for
  /// that; payment rows in [payment] are what clear outstanding.
  /// Empty [payment] = credit / unpaid (collect later).
  final bool paymentMode;

  /// Normalized list used by the app; [toJson] emits a single map if length is 1, else a list.
  final List<CreateInvoicePaymentLine>? payment;

  /// Local sales invoices only — when false, tax is not added even if org tax is configured.
  final bool applyTax;

  /// Per-invoice tax rate (%). When null, org [defaultTaxRate] is used.
  final double? taxRateOverride;

  /// Per-invoice tax kind (`vat`, `corporate`, `personal`) for display/PDF.
  final String? invoiceTaxKind;

  /// Sales loyalty: program name on the party / invoice.
  final String? loyaltyProgram;

  /// Sales loyalty: points redeemed on this invoice (0 = none).
  final int? loyaltyPoints;

  /// Sales loyalty: whether points are being redeemed.
  final bool redeemLoyaltyPoints;

  CreateInvoiceRequestParams({
    required this.party,
    this.account,
    this.date,
    this.currency,
    this.exchangeRate,
    this.priceList,
    this.setDiscountAmount,
    this.discountAmount,
    this.discountPercent,
    this.terms,
    required this.invoiceType,
    required this.createdBy,
    required this.modifiedBy,
    required this.items,
    this.paymentMode = false,
    this.payment,
    this.applyTax = false,
    this.taxRateOverride,
    this.invoiceTaxKind,
    this.loyaltyProgram,
    this.loyaltyPoints,
    this.redeemLoyaltyPoints = false,
  });

  factory CreateInvoiceRequestParams.fromJson(Map<String, dynamic> json) {
    List<CreateInvoicePaymentLine>? paymentList;
    final rawPayment = json['payment'];
    if (rawPayment == null) {
      paymentList = null;
    } else if (rawPayment is List) {
      paymentList = rawPayment
          .map((e) => CreateInvoicePaymentLine.fromJson(e as Map<String, dynamic>))
          .toList();
    } else if (rawPayment is Map<String, dynamic>) {
      paymentList = [CreateInvoicePaymentLine.fromJson(rawPayment)];
    } else if (rawPayment is Map) {
      paymentList = [CreateInvoicePaymentLine.fromJson(Map<String, dynamic>.from(rawPayment))];
    }

    return CreateInvoiceRequestParams(
      party: json['party'] as String,
      account: json['account'] as String?,
      date: json['date'] as String?,
      currency: json['currency'] as String?,
      exchangeRate: (json['exchangeRate'] as num?)?.toDouble(),
      priceList: json['priceList'] as String?,
      setDiscountAmount: json['setDiscountAmount'] as bool?,
      discountAmount: (json['discountAmount'] as num?)?.toDouble(),
      discountPercent: (json['discountPercent'] as num?)?.toDouble(),
      terms: json['terms'] as String?,
      invoiceType: _invoiceTypeFromJson(json['invoiceType']),
      createdBy: json['createdBy'] as String,
      modifiedBy: json['modifiedBy'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => CreateInvoiceItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      paymentMode: json['payment_mode'] as bool? ?? false,
      payment: paymentList,
      loyaltyProgram: json['loyaltyProgram'] as String?,
      loyaltyPoints: (json['loyaltyPoints'] as num?)?.toInt(),
      redeemLoyaltyPoints: json['redeemLoyaltyPoints'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'party': party,
      if (account case final value?) 'account': value,
      if (date case final value?) 'date': value,
      if (currency case final value?) 'currency': value,
      if (exchangeRate case final value?) 'exchangeRate': value,
      if (priceList case final value?) 'priceList': value,
      if (setDiscountAmount case final value?) 'setDiscountAmount': value,
      if (discountAmount case final value?) 'discountAmount': value,
      if (discountPercent case final value?) 'discountPercent': value,
      if (terms case final value?) 'terms': value,
      if (loyaltyProgram case final value?) 'loyaltyProgram': value,
      if (loyaltyPoints case final value?) 'loyaltyPoints': value,
      if (redeemLoyaltyPoints) 'redeemLoyaltyPoints': true,
      'createdBy': createdBy,
      'modifiedBy': modifiedBy,
      'items': items.map((e) => e.toJson()).toList(),
    };

    applyInvoicePaymentToJson(
      map,
      paymentMode: paymentMode,
      payment: payment,
    );

    return map;
  }
}

InvoiceType _invoiceTypeFromJson(Object? value) {
  if (value == InvoiceType.purchase.name) return InvoiceType.purchase;
  if (value == InvoiceType.sales.name) return InvoiceType.sales;
  return InvoiceType.sales;
}

@JsonSerializable(includeIfNull: false)
class CreateInvoiceItem {
  final String item;
  final double rate;
  final double? quantity;
  final String? account;
  final String? description;
  final String? unit;
  final bool? setItemDiscountAmount;
  final double? itemDiscountAmount;
  final double? itemDiscountPercent;

  CreateInvoiceItem({
    required this.item,
    required this.rate,
    required this.quantity,
    this.account,
    this.description,
    this.unit,
    this.setItemDiscountAmount,
    this.itemDiscountAmount,
    this.itemDiscountPercent,
  });

  factory CreateInvoiceItem.fromJson(Map<String, dynamic> json) =>
      _$CreateInvoiceItemFromJson(json);

  Map<String, dynamic> toJson() => _$CreateInvoiceItemToJson(this);
}

@JsonSerializable(includeIfNull: false)
class CreateInvoicePaymentLine {
  final double amount;
  @JsonKey(name: 'payment_method')
  final String paymentMethod;
  @JsonKey(name: 'payment_date')
  final String paymentDate;
  @JsonKey(name: 'reference_id')
  final String? referenceId;
  @JsonKey(name: 'clearance_date')
  final String? clearanceDate;

  const CreateInvoicePaymentLine({
    required this.amount,
    required this.paymentMethod,
    required this.paymentDate,
    this.referenceId,
    this.clearanceDate,
  });

  factory CreateInvoicePaymentLine.fromJson(Map<String, dynamic> json) =>
      _$CreateInvoicePaymentLineFromJson(json);

  Map<String, dynamic> toJson() => _$CreateInvoicePaymentLineToJson(this);
}
