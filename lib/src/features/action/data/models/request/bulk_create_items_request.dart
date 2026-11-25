import 'package:hotel/src/features/action/data/models/response/item_response_model.dart';

/// Body for `POST /api/hotel/api/items/bulk-create/`.
class BulkCreateItemsRequest {
  const BulkCreateItemsRequest({
    required this.items,
    this.stopOnError = true,
    this.skipDuplicates = false,
  });

  final List<ItemModel> items;
  final bool stopOnError;
  final bool skipDuplicates;

  Map<String, dynamic> toJson() => {
        'items': items.map((e) => e.toJson()).toList(),
        'stopOnError': stopOnError,
        'skipDuplicates': skipDuplicates,
      };
}
