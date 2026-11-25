import 'package:dio/dio.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/features/order/data/models/request/create_order_request.dart';
import 'package:hotel/src/features/order/data/models/request/get_order_activity_request_params.dart';
import 'package:hotel/src/features/order/data/models/request/get_order_detail_request_params.dart';
import 'package:hotel/src/features/order/data/models/request/get_orders_request_params.dart';
import 'package:hotel/src/features/order/data/models/request/update_order_item_line_request_params.dart';
import 'package:hotel/src/features/order/data/models/request/update_order_item_status_request_params.dart';
import 'package:hotel/src/features/order/data/models/request/order_checkout_request_params.dart';
import 'package:hotel/src/features/order/data/models/request/update_order_status_request_params.dart';
import 'package:hotel/src/features/order/data/models/request/update_qot_request_params.dart';
import 'package:hotel/src/features/order/data/models/request/update_qot_status_request_params.dart';
import 'package:hotel/src/features/order/data/models/response/order_activity_response.dart';
import 'package:hotel/src/features/order/data/models/response/order_model.dart';
import 'package:hotel/src/features/order/data/models/response/order_checkout_response.dart';
import 'package:hotel/src/features/order/data/models/response/order_status_update_response.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class OrderRemoteDataSource {
  /// `GET /api/order/orders/` — filters via [GetOrdersRequestParams.query].
  Future<OrderListResponse> getOrders(GetOrdersRequestParams params);

  /// `POST /api/order/orders/`
  Future<OrderModel> createOrder(CreateOrderRequest request);

  /// `GET /api/order/orders/<name>/`
  Future<OrderModel> getOrderDetail(GetOrderDetailRequestParams params);

  /// `GET /api/order/orders/<name>/activity/`
  Future<OrderActivityResponse> getOrderActivity(GetOrderActivityRequestParams params);

  /// `PATCH /api/order/orders/<name>/status/`
  Future<OrderStatusUpdateResponse> updateOrderStatus(UpdateOrderStatusRequestParams params);

  /// `PATCH /api/order/orders/<order>/items/<line_name>/status/` — [itemLineName] is JSON `name` (e.g. `ab12cd-ef345678`).
  Future<void> updateOrderItemStatus(UpdateOrderItemStatusRequestParams params);

  /// `PATCH /api/order/orders/<order>/items/<line_name>/`
  Future<void> updateOrderItem(UpdateOrderItemLineRequestParams params);

  /// `PATCH /api/order/orders/<name>/qots/<qot_name>/status/`
  Future<void> updateQotStatus(UpdateQotStatusRequestParams params);

  /// `PATCH /api/order/orders/<name>/qots/<qot_name>/` — [notes], [assigned_to].
  Future<void> updateQot(UpdateQotRequestParams params);

  /// `POST /api/order/orders/<name>/checkout/`
  Future<OrderCheckoutResponse> checkoutOrder(OrderCheckoutRequestParams params);
}

@LazySingleton(as: OrderRemoteDataSource)
class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  OrderRemoteDataSourceImpl(@Named('authenticated') Dio dio) : _dio = dio;

  final Dio _dio;

  @override
  Future<OrderListResponse> getOrders(GetOrdersRequestParams params) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        "${dotenv.env['BASE_URL']}${ApiEndPoints.orderOrders}",
        queryParameters: params.query?.toQueryParams(),
        options: options,
      );
      if (response.statusCode == 200) {
        final raw = response.data;
        if (raw is! Map) {
          throw const AppException(message: 'Invalid orders response');
        }
        final body = Map<String, dynamic>.from(raw);
        return OrderListResponse.fromJson(body);
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<OrderModel> getOrderDetail(GetOrderDetailRequestParams params) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        "${dotenv.env['BASE_URL']}${ApiEndPoints.orderDetail(params.orderName)}",
        options: options,
      );
      if (response.statusCode == 200) {
        final raw = response.data;
        if (raw is! Map) {
          throw const AppException(message: 'Invalid order detail');
        }
        return OrderModel.fromJson(Map<String, dynamic>.from(raw));
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<OrderActivityResponse> getOrderActivity(GetOrderActivityRequestParams params) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        "${dotenv.env['BASE_URL']}${ApiEndPoints.orderActivity(params.orderName)}",
        queryParameters: <String, dynamic>{
          'page': params.page,
          'per_page': params.perPage,
        },
        options: options,
      );
      if (response.statusCode == 200) {
        final raw = response.data;
        if (raw is! Map) {
          throw const AppException(message: 'Invalid order activity');
        }
        return OrderActivityResponse.fromJson(Map<String, dynamic>.from(raw));
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<OrderModel> createOrder(CreateOrderRequest request) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.post(
        "${dotenv.env['BASE_URL']}${ApiEndPoints.orderOrders}",
        data: request.toJson(),
        options: options,
      );
      final code = response.statusCode;
      // Backend may return 200 OK (append QOT to existing order) or 201 Created.
      if (code == 200 || code == 201) {
        final raw = response.data;
        if (raw is! Map) {
          throw const AppException(message: 'Invalid create order response');
        }
        final body = Map<String, dynamic>.from(raw);
        final data = body['data'];
        if (data is Map) {
          return OrderModel.fromJson(Map<String, dynamic>.from(data));
        }
        throw const AppException(message: 'Create order response missing data');
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<OrderStatusUpdateResponse> updateOrderStatus(UpdateOrderStatusRequestParams params) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.patch(
        "${dotenv.env['BASE_URL']}${ApiEndPoints.orderStatusUpdate(params.orderName)}",
        data: <String, dynamic>{'order_status': params.orderStatus},
        options: options,
      );
      if (response.statusCode == 200) {
        final raw = response.data;
        if (raw is Map) {
          return OrderStatusUpdateResponse.fromJson(Map<String, dynamic>.from(raw));
        }
        return const OrderStatusUpdateResponse();
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<void> updateOrderItemStatus(UpdateOrderItemStatusRequestParams params) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.patch(
        "${dotenv.env['BASE_URL']}${ApiEndPoints.orderItemStatusUpdate(params.orderName, params.itemLineName)}",
        data: <String, dynamic>{'item_status': params.itemStatus},
        options: options,
      );
      final code = response.statusCode ?? 0;
      if (code >= 200 && code < 300) {
        return;
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<void> updateOrderItem(UpdateOrderItemLineRequestParams params) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.patch(
        "${dotenv.env['BASE_URL']}${ApiEndPoints.orderItemUpdate(params.orderName, params.itemLineName)}",
        data: params.body.toJson(),
        options: options,
      );
      final code = response.statusCode ?? 0;
      if (code >= 200 && code < 300) {
        return;
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<void> updateQotStatus(UpdateQotStatusRequestParams params) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.patch(
        "${dotenv.env['BASE_URL']}${ApiEndPoints.orderQotStatusUpdate(params.orderName, params.qotName)}",
        data: <String, dynamic>{'qot_status': params.qotStatus},
        options: options,
      );
      final code = response.statusCode ?? 0;
      if (code >= 200 && code < 300) {
        return;
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<void> updateQot(UpdateQotRequestParams params) async {
    try {
      final body = params.toJson();
      if (body.isEmpty) {
        throw const AppException(message: 'QOT update requires notes or assigned_to');
      }
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.patch(
        "${dotenv.env['BASE_URL']}${ApiEndPoints.orderQotUpdate(params.orderName, params.qotName)}",
        data: body,
        options: options,
      );
      final code = response.statusCode ?? 0;
      if (code >= 200 && code < 300) {
        return;
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<OrderCheckoutResponse> checkoutOrder(OrderCheckoutRequestParams params) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.post(
        "${dotenv.env['BASE_URL']}${ApiEndPoints.orderCheckout(params.orderName)}",
        data: params.toJson(),
        options: options,
      );
      final code = response.statusCode ?? 0;
      if (code >= 200 && code < 300) {
        final raw = response.data;
        if (raw is! Map) {
          throw const AppException(message: 'Invalid checkout response');
        }
        final body = Map<String, dynamic>.from(raw);
        final data = body['data'];
        if (data is Map) {
          return OrderCheckoutResponse.fromJson(Map<String, dynamic>.from(data));
        }
        return OrderCheckoutResponse.fromJson(body);
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }
}
