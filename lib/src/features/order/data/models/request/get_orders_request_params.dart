import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/order/data/models/request/order_query_params.dart';

part 'get_orders_request_params.freezed.dart';

@freezed
class GetOrdersRequestParams with _$GetOrdersRequestParams {
  const factory GetOrdersRequestParams({
    OrderQueryParams? query,
  }) = _GetOrdersRequestParams;
}
