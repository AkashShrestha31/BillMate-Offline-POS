import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/internet/internet_info.dart';
import 'package:hotel/src/features/order/data/datasources/order_remote_data_source.dart';
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
import 'package:hotel/src/features/order/data/models/response/order_model.dart';
import 'package:hotel/src/features/order/data/models/response/order_checkout_response.dart';
import 'package:hotel/src/features/order/data/models/response/order_status_update_response.dart';
import 'package:hotel/src/features/order/domain/repositories/order_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OrderRepository)
class OrderRepositoryImpl implements OrderRepository {
  OrderRepositoryImpl(this._remote, this._internetInfo);

  final OrderRemoteDataSource _remote;
  final InternetInfo _internetInfo;

  @override
  Future<Either<AppError, OrderListResponse>> getOrders(GetOrdersRequestParams params) async {
    if (await _internetInfo.isConnected) {
      try {
        final res = await _remote.getOrders(params);
        return right(res);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
    } else {
      return left(const AppError.noInternet());
    }
  }

  @override
  Future<Either<AppError, OrderModel>> getOrderDetail(GetOrderDetailRequestParams params) async {
    if (await _internetInfo.isConnected) {
      try {
        final res = await _remote.getOrderDetail(params);
        return right(res);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
    } else {
      return left(const AppError.noInternet());
    }
  }

  @override
  Future<Either<AppError, OrderActivityResponse>> getOrderActivity(
    GetOrderActivityRequestParams params,
  ) async {
    if (await _internetInfo.isConnected) {
      try {
        final res = await _remote.getOrderActivity(params);
        return right(res);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
    } else {
      return left(const AppError.noInternet());
    }
  }

  @override
  Future<Either<AppError, OrderModel>> createOrder(CreateOrderRequest request) async {
    if (await _internetInfo.isConnected) {
      try {
        final res = await _remote.createOrder(request);
        return right(res);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
    } else {
      return left(const AppError.noInternet());
    }
  }

  @override
  Future<Either<AppError, OrderStatusUpdateResponse>> updateOrderStatus(
    UpdateOrderStatusRequestParams params,
  ) async {
    if (await _internetInfo.isConnected) {
      try {
        final res = await _remote.updateOrderStatus(params);
        return right(res);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
    } else {
      return left(const AppError.noInternet());
    }
  }

  @override
  Future<Either<AppError, Unit>> updateOrderItemStatus(
    UpdateOrderItemStatusRequestParams params,
  ) async {
    if (await _internetInfo.isConnected) {
      try {
        await _remote.updateOrderItemStatus(params);
        return right(unit);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
    } else {
      return left(const AppError.noInternet());
    }
  }

  @override
  Future<Either<AppError, Unit>> updateOrderItem(UpdateOrderItemLineRequestParams params) async {
    if (await _internetInfo.isConnected) {
      try {
        await _remote.updateOrderItem(params);
        return right(unit);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
    } else {
      return left(const AppError.noInternet());
    }
  }

  @override
  Future<Either<AppError, Unit>> updateQotStatus(UpdateQotStatusRequestParams params) async {
    if (await _internetInfo.isConnected) {
      try {
        await _remote.updateQotStatus(params);
        return right(unit);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
    } else {
      return left(const AppError.noInternet());
    }
  }

  @override
  Future<Either<AppError, Unit>> updateQot(UpdateQotRequestParams params) async {
    if (await _internetInfo.isConnected) {
      try {
        await _remote.updateQot(params);
        return right(unit);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
    } else {
      return left(const AppError.noInternet());
    }
  }

  @override
  Future<Either<AppError, OrderCheckoutResponse>> checkoutOrder(OrderCheckoutRequestParams params) async {
    if (await _internetInfo.isConnected) {
      try {
        final res = await _remote.checkoutOrder(params);
        return right(res);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
    } else {
      return left(const AppError.noInternet());
    }
  }
}
