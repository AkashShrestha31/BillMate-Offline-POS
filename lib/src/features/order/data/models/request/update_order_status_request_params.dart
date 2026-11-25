import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_order_status_request_params.freezed.dart';

@freezed
class UpdateOrderStatusRequestParams with _$UpdateOrderStatusRequestParams {
  const factory UpdateOrderStatusRequestParams({
    required String orderName,
    required String orderStatus,
  }) = _UpdateOrderStatusRequestParams;
}
