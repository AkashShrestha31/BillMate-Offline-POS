import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_order_activity_request_params.freezed.dart';

@freezed
class GetOrderActivityRequestParams with _$GetOrderActivityRequestParams {
  const factory GetOrderActivityRequestParams({
    required String orderName,
    @Default(1) int page,
    @Default(50) int perPage,
  }) = _GetOrderActivityRequestParams;
}
