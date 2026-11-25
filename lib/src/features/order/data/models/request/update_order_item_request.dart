import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_order_item_request.freezed.dart';

/// Body for `PATCH /api/order/orders/{name}/items/{item_name}/`.
@freezed
class UpdateOrderItemRequest with _$UpdateOrderItemRequest {
  const UpdateOrderItemRequest._();

  const factory UpdateOrderItemRequest({
    required double quantity,
    String? description,
    String? unit,
    String? remarks,
    String? modifiedBy,
  }) = _UpdateOrderItemRequest;

  /// [unit] is kept for UI/domain use but is not sent. Optional strings are omitted when blank.
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{'quantity': quantity};
    final d = description?.trim();
    if (d != null && d.isNotEmpty) json['description'] = d;
    final r = remarks?.trim();
    if (r != null && r.isNotEmpty) json['remarks'] = r;
    final m = modifiedBy?.trim();
    if (m != null && m.isNotEmpty) json['modifiedBy'] = m;
    return json;
  }
}
