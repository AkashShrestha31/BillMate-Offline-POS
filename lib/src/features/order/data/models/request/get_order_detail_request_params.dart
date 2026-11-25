import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_order_detail_request_params.freezed.dart';

@freezed
class GetOrderDetailRequestParams with _$GetOrderDetailRequestParams {
  const factory GetOrderDetailRequestParams({
    required String orderName,
  }) = _GetOrderDetailRequestParams;
}
