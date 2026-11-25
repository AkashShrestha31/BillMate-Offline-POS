import 'package:json_annotation/json_annotation.dart';

part 'pricing_create_request_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PricingCreateRequestParams {
  final String itemName;
  final double purchasePrice;
  final double sellingPrice;
  final String effectiveFrom;
  final String location;
  final String? notes;

  const PricingCreateRequestParams({
    required this.itemName,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.effectiveFrom,
    required this.location,
    this.notes,
  });

  factory PricingCreateRequestParams.fromJson(Map<String, dynamic> json) =>
      _$PricingCreateRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PricingCreateRequestParamsToJson(this);

  double get marginAmount => sellingPrice - purchasePrice;
  double get marginPercentage => (marginAmount / sellingPrice) * 100;
}
