import 'dart:convert';

/// Serializable cart line from Quick Add → Check In → KOT Review → POST order.
class RestaurantCartLine {
  const RestaurantCartLine({
    required this.name,
    required this.quantity,
    required this.rate,
    this.imageUrl,
  });

  final String name;
  final int quantity;
  final double rate;

  /// Item photo URL when provided by Quick Add (same source as [ItemModel.image]).
  final String? imageUrl;

  double get lineTotal => rate * quantity;

  Map<String, dynamic> toJson() => {
        'name': name,
        'quantity': quantity,
        'rate': rate,
        if (imageUrl != null && imageUrl!.trim().isNotEmpty) 'imageUrl': imageUrl,
      };

  factory RestaurantCartLine.fromJson(Map<String, dynamic> j) {
    final rawUrl = j['imageUrl'] ?? j['image'];
    final url = rawUrl == null ? null : rawUrl.toString().trim();
    return RestaurantCartLine(
      name: j['name'] as String,
      quantity: (j['quantity'] as num).toInt(),
      rate: (j['rate'] as num).toDouble(),
      imageUrl: url == null || url.isEmpty ? null : url,
    );
  }

  static String encodeList(List<RestaurantCartLine> lines) =>
      jsonEncode(lines.map((e) => e.toJson()).toList());

  static List<RestaurantCartLine> decodeList(String cartJson) {
    final raw = jsonDecode(cartJson);
    if (raw is! List) return [];
    return raw
        .map((e) => RestaurantCartLine.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  RestaurantCartLine copyWith({
    String? name,
    int? quantity,
    double? rate,
    String? imageUrl,
  }) {
    return RestaurantCartLine(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      rate: rate ?? this.rate,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
