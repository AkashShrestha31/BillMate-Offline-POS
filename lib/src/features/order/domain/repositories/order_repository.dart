import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/order/data/models/request/create_order_request.dart';
import 'package:hotel/src/features/order/data/models/request/get_order_activity_request_params.dart';
import 'package:hotel/src/features/order/data/models/request/get_order_detail_request_params.dart';
import 'package:hotel/src/features/order/data/models/request/get_orders_request_params.dart';
import 'package:hotel/src/features/order/data/models/request/order_checkout_request_params.dart';
import 'package:hotel/src/features/order/data/models/request/update_order_item_line_request_params.dart';
import 'package:hotel/src/features/order/data/models/request/update_order_item_status_request_params.dart';
import 'package:hotel/src/features/order/data/models/request/update_order_status_request_params.dart';
import 'package:hotel/src/features/order/data/models/request/update_qot_request_params.dart';
import 'package:hotel/src/features/order/data/models/request/update_qot_status_request_params.dart';
import 'package:hotel/src/features/order/data/models/response/order_activity_response.dart';
import 'package:hotel/src/features/order/data/models/response/order_model.dart' show OrderListResponse, OrderModel;
import 'package:hotel/src/features/order/data/models/response/order_checkout_response.dart';
import 'package:hotel/src/features/order/data/models/response/order_status_update_response.dart';

abstract class OrderRepository {
  Future<Either<AppError, OrderListResponse>> getOrders(GetOrdersRequestParams params);
  Future<Either<AppError, OrderModel>> getOrderDetail(GetOrderDetailRequestParams params);
  Future<Either<AppError, OrderActivityResponse>> getOrderActivity(
    GetOrderActivityRequestParams params,
  );
  Future<Either<AppError, OrderModel>> createOrder(CreateOrderRequest request);
  Future<Either<AppError, OrderStatusUpdateResponse>> updateOrderStatus(
    UpdateOrderStatusRequestParams params,
  );

  /// `PATCH /api/order/orders/{order}/items/{line_name}/status/` — [itemLineName] is JSON `name` (e.g. `ab12cd-ef345678`).
  Future<Either<AppError, Unit>> updateOrderItemStatus(
    UpdateOrderItemStatusRequestParams params,
  );

  Future<Either<AppError, Unit>> updateOrderItem(UpdateOrderItemLineRequestParams params);

  Future<Either<AppError, Unit>> updateQotStatus(UpdateQotStatusRequestParams params);

  Future<Either<AppError, Unit>> updateQot(UpdateQotRequestParams params);

  Future<Either<AppError, OrderCheckoutResponse>> checkoutOrder(OrderCheckoutRequestParams params);
}
