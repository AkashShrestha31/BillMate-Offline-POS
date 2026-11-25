import 'package:json_annotation/json_annotation.dart';

part 'update_invoice_request_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class UpdateInvoiceRequestParams {
  final String invoiceName;
  final String action;
  final String modifiedBy;
  final String? party;
  final String? account;
  final String? date;
  final String? currency;
  final int? submitted;
  final double? exchangeRate;
  final String? priceList;
  final bool? setDiscountAmount;
  final double? discountAmount;
  final double? discountPercent;
  final String? terms;
  final List<UpdateInvoiceItem>? items;

  UpdateInvoiceRequestParams({
    required this.invoiceName,
    this.action = "update",
    required this.modifiedBy,
    this.party,
    this.account,
    this.submitted,
    this.date,
    this.currency,
    this.exchangeRate,
    this.priceList,
    this.setDiscountAmount,
    this.discountAmount,
    this.discountPercent,
    this.terms,
    this.items,
  });

  factory UpdateInvoiceRequestParams.fromJson(Map<String, dynamic> json) =>
      _$UpdateInvoiceRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateInvoiceRequestParamsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class UpdateInvoiceItem {
  final String action;
  final String? itemId;
  final String? item;
  final double? rate;
  final double? quantity;
  final String? account;
  final String? description;
  final String? unit;
  final bool? setItemDiscountAmount;
  final double? itemDiscountAmount;
  final double? itemDiscountPercent;

  UpdateInvoiceItem({
    required this.action,
    this.itemId,
    this.item,
    this.rate,
    this.quantity,
    this.account,
    this.description,
    this.unit,
    this.setItemDiscountAmount,
    this.itemDiscountAmount,
    this.itemDiscountPercent,
  });

  factory UpdateInvoiceItem.fromJson(Map<String, dynamic> json) =>
      _$UpdateInvoiceItemFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateInvoiceItemToJson(this);

  factory UpdateInvoiceItem.add({
    required String item,
    required double rate,
    double? quantity,
    String? account,
    String? description,
    String? unit,
    bool? setItemDiscountAmount,
    double? itemDiscountAmount,
    double? itemDiscountPercent,
  }) => UpdateInvoiceItem(
        action: "add",
        item: item,
        rate: rate,
        quantity: quantity,
        account: account,
        description: description,
        unit: unit,
        setItemDiscountAmount: setItemDiscountAmount,
        itemDiscountAmount: itemDiscountAmount,
        itemDiscountPercent: itemDiscountPercent,
      );

  factory UpdateInvoiceItem.update({
    required String itemId,
    String? item,
    double? rate,
    double? quantity,
    String? account,
    String? description,
    String? unit,
    bool? setItemDiscountAmount,
    double? itemDiscountAmount,
    double? itemDiscountPercent,
  }) => UpdateInvoiceItem(
        action: "update",
        itemId: itemId,
        item: item,
        rate: rate,
        quantity: quantity,
        account: account,
        description: description,
        unit: unit,
        setItemDiscountAmount: setItemDiscountAmount,
        itemDiscountAmount: itemDiscountAmount,
        itemDiscountPercent: itemDiscountPercent,
      );

  factory UpdateInvoiceItem.delete({required String itemId}) =>
      UpdateInvoiceItem(action: "delete", itemId: itemId);
}
