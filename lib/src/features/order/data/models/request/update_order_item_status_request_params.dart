import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_order_item_status_request_params.freezed.dart';

@freezed
class UpdateOrderItemStatusRequestParams with _$UpdateOrderItemStatusRequestParams {
  const factory UpdateOrderItemStatusRequestParams({
    required String orderName,
    required String itemLineName,
    required String itemStatus,
  }) = _UpdateOrderItemStatusRequestParams;
}
