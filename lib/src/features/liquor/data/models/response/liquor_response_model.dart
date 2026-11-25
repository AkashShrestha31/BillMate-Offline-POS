import 'package:json_annotation/json_annotation.dart';

part 'liquor_response_model.g.dart';

@JsonSerializable()
class LiquorItem {
  @JsonKey(name: 'itemId')
  final int id;

  @JsonKey(name: 'itemName')
  final String name;

  @JsonKey(name: 'categoryName')
  final String category;

  @JsonKey(name: 'brandName')
  final String brand;

  final String volume;

  @JsonKey(name: 'itemDescription')
  final String? description;

  @JsonKey(name: 'itemCreated')
  final String created;

  final int pricingId;
  final double purchasePrice;
  final double sellingPrice;
  final double marginAmount;
  final double marginPercentage;
  final String effectiveFrom;

  @JsonKey(name: 'pricingLocation')
  final String location;

  // Additional fields from API response
  @JsonKey(name: 'itemIsActive')
  final int itemIsActive;

  @JsonKey(name: 'categoryId')
  final int categoryId;

  @JsonKey(name: 'categoryDescription')
  final String? categoryDescription;

  @JsonKey(name: 'categoryIsActive')
  final int categoryIsActive;

  @JsonKey(name: 'brandId')
  final int brandId;

  @JsonKey(name: 'effectiveTo')
  final String? effectiveTo;

  @JsonKey(name: 'pricingNotes')
  final String? pricingNotes;

  @JsonKey(name: 'pricingIsActive')
  final int pricingIsActive;

  @JsonKey(name: 'pricingCreated')
  final String pricingCreated;

  const LiquorItem({
    required this.id,
    required this.name,
    required this.category,
    required this.brand,
    required this.volume,
     this.description,
    required this.created,
    required this.pricingId,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.marginAmount,
    required this.marginPercentage,
    required this.effectiveFrom,
    required this.location,
    required this.itemIsActive,
    required this.categoryId,
     this.categoryDescription,
    required this.categoryIsActive,
    required this.brandId,
    this.effectiveTo,
    this.pricingNotes,
    required this.pricingIsActive,
    required this.pricingCreated,
  });

  factory LiquorItem.fromJson(Map<String, dynamic> json) =>
      _$LiquorItemFromJson(json);

  Map<String, dynamic> toJson() => _$LiquorItemToJson(this);

  // Business logic getters
  bool get isWhiskey => category.toLowerCase() == 'whiskey';
  bool get isVodka => category.toLowerCase() == 'vodka';
  bool get isRum => category.toLowerCase() == 'rum';
  bool get hasHighMargin => marginPercentage > 30.0;
  bool get isPremium => sellingPrice > 2000;
  bool get isActive => itemIsActive == 1;
  bool get isPricingActive => pricingIsActive == 1;
  bool get isCategoryActive => categoryIsActive == 1;

  // Formatted strings
  String get formattedSellingPrice => 'Rs. ${sellingPrice.toStringAsFixed(0)}';
  String get formattedPurchasePrice => 'Rs. ${purchasePrice.toStringAsFixed(0)}';
  String get formattedMarginAmount => 'Rs. ${marginAmount.toStringAsFixed(0)}';
  String get formattedMarginPercentage => '${marginPercentage.toStringAsFixed(2)}%';

  // Price categories
  String get priceCategory {
    if (sellingPrice < 1500) return 'Budget';
    if (sellingPrice < 2500) return 'Mid-range';
    return 'Premium';
  }

  // Margin categories
  String get marginCategory {
    if (marginPercentage < 25) return 'Low Margin';
    if (marginPercentage < 30) return 'Average Margin';
    return 'High Margin';
  }

  // Location categories
  bool get isMainBar => location.toLowerCase() == 'main bar';
  bool get isVIP => location.toLowerCase() == 'vip';
  bool get isPoolSide => location.toLowerCase().contains('pool');

  // Pricing status
  bool get hasActivePricing => isPricingActive && isActive;
  bool get isPricingExpired => effectiveTo != null &&
      DateTime.tryParse(effectiveTo!)?.isBefore(DateTime.now()) == true;

  // Helper methods
  double get profitMargin => sellingPrice - purchasePrice;
  double get profitPercentage => (profitMargin / purchasePrice) * 100;

  // Create a copy with updated values
  LiquorItem copyWith({
    int? id,
    String? name,
    String? category,
    String? brand,
    String? volume,
    String? description,
    String? created,
    int? pricingId,
    double? purchasePrice,
    double? sellingPrice,
    double? marginAmount,
    double? marginPercentage,
    String? effectiveFrom,
    String? location,
    int? itemIsActive,
    int? categoryId,
    String? categoryDescription,
    int? categoryIsActive,
    int? brandId,
    String? effectiveTo,
    String? pricingNotes,
    int? pricingIsActive,
    String? pricingCreated,
  }) {
    return LiquorItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      volume: volume ?? this.volume,
      description: description ?? this.description,
      created: created ?? this.created,
      pricingId: pricingId ?? this.pricingId,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      marginAmount: marginAmount ?? this.marginAmount,
      marginPercentage: marginPercentage ?? this.marginPercentage,
      effectiveFrom: effectiveFrom ?? this.effectiveFrom,
      location: location ?? this.location,
      itemIsActive: itemIsActive ?? this.itemIsActive,
      categoryId: categoryId ?? this.categoryId,
      categoryDescription: categoryDescription ?? this.categoryDescription,
      categoryIsActive: categoryIsActive ?? this.categoryIsActive,
      brandId: brandId ?? this.brandId,
      effectiveTo: effectiveTo ?? this.effectiveTo,
      pricingNotes: pricingNotes ?? this.pricingNotes,
      pricingIsActive: pricingIsActive ?? this.pricingIsActive,
      pricingCreated: pricingCreated ?? this.pricingCreated,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is LiquorItem &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'LiquorItem{id: $id, name: $name, brand: $brand, category: $category, sellingPrice: $sellingPrice}';
  }
}

@JsonSerializable()
class LiquorResponseModel {
  final List<LiquorItem> items;
  final int count;

  const LiquorResponseModel({
    required this.items,
    required this.count,
  });

  factory LiquorResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LiquorResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LiquorResponseModelToJson(this);

  // Basic checks
  bool get hasData => items.isNotEmpty;
  bool get isEmpty => items.isEmpty;

  // Category filters
  List<LiquorItem> get whiskeyItems =>
      items.where((item) => item.isWhiskey).toList();

  List<LiquorItem> get vodkaItems =>
      items.where((item) => item.isVodka).toList();

  List<LiquorItem> get rumItems =>
      items.where((item) => item.isRum).toList();

  // Price filters
  List<LiquorItem> get premiumItems =>
      items.where((item) => item.isPremium).toList();

  List<LiquorItem> get budgetItems =>
      items.where((item) => item.sellingPrice < 1500).toList();

  List<LiquorItem> get midRangeItems =>
      items.where((item) =>
      item.sellingPrice >= 1500 && item.sellingPrice < 2500).toList();

  // Margin filters
  List<LiquorItem> get highMarginItems =>
      items.where((item) => item.hasHighMargin).toList();

  List<LiquorItem> get lowMarginItems =>
      items.where((item) => item.marginPercentage < 25).toList();

  // Location filters
  List<LiquorItem> get mainBarItems =>
      items.where((item) => item.isMainBar).toList();

  List<LiquorItem> get vipItems =>
      items.where((item) => item.isVIP).toList();

  // Status filters
  List<LiquorItem> get activeItems =>
      items.where((item) => item.isActive).toList();

  List<LiquorItem> get inactiveItems =>
      items.where((item) => !item.isActive).toList();

  // Advanced filtering methods
  List<LiquorItem> getItemsByCategory(String category) {
    return items.where((item) =>
    item.category.toLowerCase() == category.toLowerCase()).toList();
  }

  List<LiquorItem> getItemsByBrand(String brand) {
    return items.where((item) =>
    item.brand.toLowerCase() == brand.toLowerCase()).toList();
  }

  List<LiquorItem> getItemsByLocation(String location) {
    return items.where((item) =>
    item.location.toLowerCase() == location.toLowerCase()).toList();
  }

  List<LiquorItem> getItemsByPriceRange(double minPrice, double maxPrice) {
    return items.where((item) =>
    item.sellingPrice >= minPrice && item.sellingPrice <= maxPrice).toList();
  }

  List<LiquorItem> getItemsByMarginRange(double minMargin, double maxMargin) {
    return items.where((item) =>
    item.marginPercentage >= minMargin &&
        item.marginPercentage <= maxMargin).toList();
  }

  // Sorting methods
  List<LiquorItem> get itemsSortedByPriceAsc {
    final sortedItems = List<LiquorItem>.from(items);
    sortedItems.sort((a, b) => a.sellingPrice.compareTo(b.sellingPrice));
    return sortedItems;
  }

  List<LiquorItem> get itemsSortedByPriceDesc {
    final sortedItems = List<LiquorItem>.from(items);
    sortedItems.sort((a, b) => b.sellingPrice.compareTo(a.sellingPrice));
    return sortedItems;
  }

  List<LiquorItem> get itemsSortedByMarginDesc {
    final sortedItems = List<LiquorItem>.from(items);
    sortedItems.sort((a, b) => b.marginPercentage.compareTo(a.marginPercentage));
    return sortedItems;
  }

  List<LiquorItem> get itemsSortedByName {
    final sortedItems = List<LiquorItem>.from(items);
    sortedItems.sort((a, b) => a.name.compareTo(b.name));
    return sortedItems;
  }

  // Analytics methods
  List<String> get uniqueCategories {
    return items.map((item) => item.category).toSet().toList();
  }

  List<String> get uniqueBrands {
    return items.map((item) => item.brand).toSet().toList();
  }

  List<String> get uniqueLocations {
    return items.map((item) => item.location).toSet().toList();
  }

  // Statistical calculations
  double get averageSellingPrice {
    if (items.isEmpty) return 0.0;
    final total = items.fold<double>(0, (sum, item) => sum + item.sellingPrice);
    return total / items.length;
  }

  double get averagePurchasePrice {
    if (items.isEmpty) return 0.0;
    final total = items.fold<double>(0, (sum, item) => sum + item.purchasePrice);
    return total / items.length;
  }

  double get averageMarginPercentage {
    if (items.isEmpty) return 0.0;
    final total = items.fold<double>(0, (sum, item) => sum + item.marginPercentage);
    return total / items.length;
  }

  // Financial calculations
  double get totalInventoryValue {
    return items.fold<double>(0, (sum, item) => sum + item.purchasePrice);
  }

  double get totalPotentialRevenue {
    return items.fold<double>(0, (sum, item) => sum + item.sellingPrice);
  }

  double get totalPotentialProfit {
    return items.fold<double>(0, (sum, item) => sum + item.marginAmount);
  }

  double get totalMarginAmount {
    return items.fold<double>(0, (sum, item) => sum + item.marginAmount);
  }

  // Search functionality
  List<LiquorItem> searchByName(String query) {
    return items.where((item) =>
        item.name.toLowerCase().contains(query.toLowerCase())).toList();
  }

  List<LiquorItem> searchByBrand(String query) {
    return items.where((item) =>
        item.brand.toLowerCase().contains(query.toLowerCase())).toList();
  }



  // Category statistics
  Map<String, int> get categoryCount {
    final Map<String, int> counts = {};
    for (final item in items) {
      counts[item.category] = (counts[item.category] ?? 0) + 1;
    }
    return counts;
  }

  Map<String, int> get brandCount {
    final Map<String, int> counts = {};
    for (final item in items) {
      counts[item.brand] = (counts[item.brand] ?? 0) + 1;
    }
    return counts;
  }

  Map<String, int> get locationCount {
    final Map<String, int> counts = {};
    for (final item in items) {
      counts[item.location] = (counts[item.location] ?? 0) + 1;
    }
    return counts;
  }

  @override
  String toString() {
    return 'LiquorResponseModel{itemsCount: ${items.length}, totalCount: $count}';
  }
}