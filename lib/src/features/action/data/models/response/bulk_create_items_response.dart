import 'package:hotel/src/features/action/data/models/response/item_response_model.dart';

class BulkCreateItemsResponse {
  const BulkCreateItemsResponse({
    required this.success,
    this.message,
    this.count,
    this.items = const [],
  });

  final bool success;
  final String? message;
  final int? count;
  final List<ItemModel> items;

  factory BulkCreateItemsResponse.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'] ?? json['data'];
    return BulkCreateItemsResponse(
      success: json['success'] as bool? ?? true,
      message: json['message']?.toString(),
      count: (json['count'] as num?)?.toInt() ??
          (json['created_count'] as num?)?.toInt(),
      items: rawItems is List
          ? rawItems
              .whereType<Map>()
              .map((e) => ItemModel.fromJson(Map<String, dynamic>.from(e)))
              .toList()
          : const [],
    );
  }
}
