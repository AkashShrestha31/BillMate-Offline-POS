import 'package:json_annotation/json_annotation.dart';

part 'payment_method_item.g.dart';

/// One row from `GET /api/analytics/payment-methods/`.
@JsonSerializable(includeIfNull: false)
class PaymentMethodItem {
  const PaymentMethodItem({
    required this.name,
    required this.type,
    this.account,
  });

  factory PaymentMethodItem.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodItemFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodItemToJson(this);

  final String name;
  final String type;
  final String? account;
}
