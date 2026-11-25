import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/order/data/models/request/update_order_item_request.dart';

part 'update_order_item_line_request_params.freezed.dart';

@freezed
class UpdateOrderItemLineRequestParams with _$UpdateOrderItemLineRequestParams {
  const factory UpdateOrderItemLineRequestParams({
    required String orderName,
    required String itemLineName,
    required UpdateOrderItemRequest body,
  }) = _UpdateOrderItemLineRequestParams;
}
