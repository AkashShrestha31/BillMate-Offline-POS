import 'package:json_annotation/json_annotation.dart';

part 'liquor_update_request_params.g.dart';

@JsonSerializable(includeIfNull: false)
class LiquorUpdateRequestParams {
  final int itemId;
  final String itemName;
  final String volume;
  final String? itemDescription;
  final String? itemCreated;
  final int itemIsActive;
  final int categoryId;
  final String categoryName;
  final String? categoryDescription;
  final int? categoryIsActive;
  final int brandId;
  final String brandName;
  final int pricingId;
  final int purchasePrice;
  final int sellingPrice;
  final int marginAmount;
  final double? marginPercentage;
  final String? effectiveFrom;
  final String? effectiveTo;
  final String? pricingLocation;
  final String? pricingNotes;
  final int? pricingIsActive;
  final String? pricingCreated;

  const LiquorUpdateRequestParams({
    required this.itemId,
    required this.itemName,
    required this.volume,
     this.itemDescription,
     this.itemCreated,
    required this.itemIsActive,
    required this.categoryId,
    required this.categoryName,
     this.categoryDescription,
     this.categoryIsActive,
    required this.brandId,
    required this.brandName,
    required this.pricingId,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.marginAmount,
     this.marginPercentage,
     this.effectiveFrom,
    this.effectiveTo,
     this.pricingLocation,
    this.pricingNotes,
    required this.pricingIsActive,
     this.pricingCreated,
  });

  factory LiquorUpdateRequestParams.fromJson(Map<String, dynamic> json) =>
      _$LiquorUpdateRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$LiquorUpdateRequestParamsToJson(this);
}