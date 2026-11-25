import 'package:json_annotation/json_annotation.dart';

part 'pricing_update_request_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PricingUpdateRequestParams {
  final int id;
  final double? purchasePrice;
  final double? sellingPrice;
  final String? location;
  final String? notes;

  const PricingUpdateRequestParams({
    required this.id,
    this.purchasePrice,
    this.sellingPrice,
    this.location,
    this.notes,
  });

  factory PricingUpdateRequestParams.fromJson(Map<String, dynamic> json) =>
      _$PricingUpdateRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PricingUpdateRequestParamsToJson(this);
}
