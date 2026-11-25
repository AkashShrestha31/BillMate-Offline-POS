import 'package:json_annotation/json_annotation.dart';

part 'liquor_create_request_params.g.dart';

@JsonSerializable()
class PricingInfo {
  final int purchasePrice;
  final int sellingPrice;
  final String effectiveFrom;
  final String effectiveTo;
  final String location;
  final String? notes;

  const PricingInfo({
    required this.purchasePrice,
    required this.sellingPrice,
    required this.effectiveFrom,
    required this.effectiveTo,
    required this.location,
    this.notes,
  });

  factory PricingInfo.fromJson(Map<String, dynamic> json) =>
      _$PricingInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PricingInfoToJson(this);
}

@JsonSerializable(includeIfNull: false)
class LiquorCreateRequestParams {
  final String name;
  final String category;
  final String? categoryDescription;
  final String brand;
  final String volume;
  final String? description;
  final PricingInfo pricing;

  const LiquorCreateRequestParams({
    required this.name,
    required this.category,
    this.categoryDescription,
    required this.brand,
    required this.volume,
     this.description,
    required this.pricing,
  });

  factory LiquorCreateRequestParams.fromJson(Map<String, dynamic> json) =>
      _$LiquorCreateRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$LiquorCreateRequestParamsToJson(this);



}