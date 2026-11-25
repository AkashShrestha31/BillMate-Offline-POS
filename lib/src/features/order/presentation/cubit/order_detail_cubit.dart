import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/features/order/data/models/request/get_order_activity_request_params.dart';
import 'package:hotel/src/features/order/data/models/request/get_order_detail_request_params.dart';
import 'package:hotel/src/features/order/data/models/request/update_order_item_line_request_params.dart';
import 'package:hotel/src/features/order/data/models/request/update_order_item_request.dart';
import 'package:hotel/src/features/order/data/models/request/update_order_item_status_request_params.dart';
import 'package:hotel/src/features/order/data/models/request/order_checkout_request_params.dart';
import 'package:hotel/src/features/order/data/models/request/update_qot_request_params.dart';
import 'package:hotel/src/features/order/data/models/request/update_qot_status_request_params.dart';
import 'package:hotel/src/features/order/data/models/response/order_activity_response.dart';
import 'package:hotel/src/features/order/data/models/response/order_model.dart';
import 'package:hotel/src/features/order/domain/usecases/get_order_activity_use_case.dart';
import 'package:hotel/src/features/order/domain/usecases/get_order_detail_use_case.dart';
import 'package:hotel/src/features/order/domain/usecases/update_order_item_status_use_case.dart';
import 'package:hotel/src/features/order/domain/usecases/update_order_item_use_case.dart';
import 'package:hotel/src/features/order/domain/usecases/update_qot_status_use_case.dart';
import 'package:hotel/src/features/order/domain/usecases/update_qot_use_case.dart';
import 'package:hotel/src/features/order/domain/usecases/checkout_order_use_case.dart';
import 'package:injectable/injectable.dart';

part 'order_detail_state.dart';
part 'order_detail_cubit.freezed.dart';

@injectable
class OrderDetailCubit extends Cubit<OrderDetailState> {
  OrderDetailCubit(
    this._getDetail,
    this._getActivity,
    this._checkoutOrder,
    this._updateItemStatus,
    this._updateOrderItem,
    this._updateQotStatus,
    this._updateQot,
  ) : super(const OrderDetailState.initial());

  final GetOrderDetailUseCase _getDetail;
  final GetOrderActivityUseCase _getActivity;
  final CheckoutOrderUseCase _checkoutOrder;
  final UpdateOrderItemStatusUseCase _updateItemStatus;
  final UpdateOrderItemUseCase _updateOrderItem;
  final UpdateQotStatusUseCase _updateQotStatus;
  final UpdateQotUseCase _updateQot;

  String? _orderName;

  OrderModel? _orderOrCached() {
    return state.maybeWhen(
      loaded: (o, _, __, ___, ____, _____, ______) => o,
      loading: (c) => c,
      noInternet: (c) => c,
      error: (_, c) => c,
      orElse: () => null,
    );
  }

  Future<void> load(String orderName) async {
    _orderName = orderName;
    final cached = _orderOrCached();
    final previousActivities = state.maybeWhen(
      loaded: (_, __, ___, ____, activities, _____, ______) => activities,
      orElse: () => const <OrderActivityEntry>[],
    );
    emit(OrderDetailState.loading(cachedOrder: cached));
    emit(
      (await _getDetail.execute(GetOrderDetailRequestParams(orderName: orderName))).fold(
        (error) => error.when(
          serverError: (m) => OrderDetailState.error(message: m, cachedOrder: cached),
          noInternet: () => OrderDetailState.noInternet(cachedOrder: cached),
        ),
        (order) => OrderDetailState.loaded(order: order, activities: previousActivities),
      ),
    );
  }

  Future<void> refresh() async {
    final name = _orderName ?? _orderOrCached()?.name;
    if (name == null || name.isEmpty) return;
    await load(name);
  }

  /// Refetch order without blocking the screen (no [OrderDetailState.loading]).
  Future<void> refreshOrderSilently() async {
    final name = _orderName ?? _orderOrCached()?.name;
    if (name == null || name.isEmpty) return;
    _orderName = name;
    final result = await _getDetail.execute(GetOrderDetailRequestParams(orderName: name));
    result.fold(
      (l) => l.when(
        serverError: (m) {
          final next = state.maybeMap(
            loaded: (v) => v.copyWith(errorMessage: m, isNoInternet: false),
            orElse: () => OrderDetailState.error(message: m, cachedOrder: _orderOrCached()),
          );
          emit(next);
        },
        noInternet: () {
          final next = state.maybeMap(
            loaded: (v) => v.copyWith(isNoInternet: true, errorMessage: null),
            orElse: () => OrderDetailState.noInternet(cachedOrder: _orderOrCached()),
          );
          emit(next);
        },
      ),
      (order) {
        final next = state.maybeMap(
          loaded: (v) => v.copyWith(order: order, errorMessage: null, isNoInternet: false),
          orElse: () => OrderDetailState.loaded(
            order: order,
            activities: state.maybeWhen(
              loaded: (_, __, ___, ____, activities, _____, ______) => activities,
              orElse: () => const <OrderActivityEntry>[],
            ),
          ),
        );
        emit(next);
      },
    );
  }

  Future<void> loadActivities({bool forceRefresh = false}) async {
    final name = _orderName ?? _orderOrCached()?.name;
    if (name == null || name.isEmpty) return;

    final snapshot = state.mapOrNull(loaded: (v) => v);
    if (snapshot == null) return;
    if (snapshot.isActivityLoading) return;
    if (!forceRefresh && snapshot.activities.isNotEmpty) return;

    emit(snapshot.copyWith(isActivityLoading: true, activityErrorMessage: null));
    final result = await _getActivity.execute(GetOrderActivityRequestParams(orderName: name));
    result.fold(
      (l) {
        final message = l.when(
          serverError: (m) => m,
          noInternet: () => 'No internet connection',
        );
        emit(
          state.maybeMap(
            loaded: (v) => v.copyWith(
              isActivityLoading: false,
              activityErrorMessage: message,
            ),
            orElse: () => state,
          )!,
        );
      },
      (res) {
        emit(
          state.maybeMap(
            loaded: (v) => v.copyWith(
              activities: res.data,
              isActivityLoading: false,
              activityErrorMessage: null,
            ),
            orElse: () => state,
          )!,
        );
      },
    );
  }

  /// PATCH each distinct line `name` (API path segment). Returns `null` on full success.
  /// [forOrderName] when set (e.g. from UI sheet) ensures the path uses that order id.
  Future<String?> updateItemLineStatuses({
    required Set<String> itemLineNames,
    required String itemStatus,
    String? forOrderName,
  }) async {
    final orderName = (forOrderName != null && forOrderName.trim().isNotEmpty)
        ? forOrderName.trim()
        : (_orderName ?? _orderOrCached()?.name);
    if (orderName == null || orderName.isEmpty) {
      return 'Order not loaded';
    }
    final ids = itemLineNames.map((e) => e.trim()).where((e) => e.isNotEmpty).toSet();
    if (ids.isEmpty) {
      return 'Item id missing — cannot update status';
    }
    for (final lineName in ids) {
      final result = await _updateItemStatus.execute(
        UpdateOrderItemStatusRequestParams(
          orderName: orderName,
          itemLineName: lineName,
          itemStatus: itemStatus,
        ),
      );
      final message = result.fold<String?>(
        (l) => l.when(
          serverError: (m) => m,
          noInternet: () => 'No internet connection',
        ),
        (_) => null,
      );
      if (message != null) return message;
    }
    await refreshOrderSilently();
    return null;
  }

  /// PATCH line fields. Returns `null` on success.
  Future<String?> updateOrderItemFields({
    required String forOrderName,
    required String itemLineName,
    required double quantity,
    String? description,
    String? unit,
    String? remarks,
    String? modifiedBy,
  }) async {
    final orderName = forOrderName.trim();
    if (orderName.isEmpty) return 'Order not loaded';
    final line = itemLineName.trim();
    if (line.isEmpty) return 'Item id missing';
    if (quantity <= 0) return 'Quantity must be greater than zero';

    final result = await _updateOrderItem.execute(
      UpdateOrderItemLineRequestParams(
        orderName: orderName,
        itemLineName: line,
        body: UpdateOrderItemRequest(
          quantity: quantity,
          description: description?.trim(),
          unit: unit?.trim(),
          remarks: remarks?.trim(),
          modifiedBy: modifiedBy?.trim(),
        ),
      ),
    );
    final message = result.fold<String?>(
      (l) => l.when(
        serverError: (m) => m,
        noInternet: () => 'No internet connection',
      ),
      (_) => null,
    );
    if (message != null) return message;
    await refreshOrderSilently();
    return null;
  }

  Future<String?> updateQotStatus({
    required String qotName,
    required String qotStatus,
    String? forOrderName,
  }) async {
    final orderName = (forOrderName != null && forOrderName.trim().isNotEmpty)
        ? forOrderName.trim()
        : (_orderName ?? _orderOrCached()?.name);
    if (orderName == null || orderName.isEmpty) return 'Order not loaded';
    final qot = qotName.trim();
    if (qot.isEmpty) return 'QOT id missing';

    final result = await _updateQotStatus.execute(
      UpdateQotStatusRequestParams(
        orderName: orderName,
        qotName: qot,
        qotStatus: qotStatus,
      ),
    );
    final message = result.fold<String?>(
      (l) => l.when(
        serverError: (m) => m,
        noInternet: () => 'No internet connection',
      ),
      (_) => null,
    );
    if (message != null) return message;
    await refreshOrderSilently();
    return null;
  }

  /// `PATCH .../qots/{qot}/` with [notes] and/or [assignedTo] (`assigned_to` in JSON).
  Future<String?> updateQotFields({
    required String qotName,
    String? notes,
    String? assignedTo,
    String? forOrderName,
  }) async {
    final orderName = (forOrderName != null && forOrderName.trim().isNotEmpty)
        ? forOrderName.trim()
        : (_orderName ?? _orderOrCached()?.name);
    if (orderName == null || orderName.isEmpty) return 'Order not loaded';
    final qot = qotName.trim();
    if (qot.isEmpty) return 'QOT id missing';

    final notesTrim = notes?.trim();
    final hasNotes = notesTrim != null && notesTrim.isNotEmpty;
    if (!hasNotes && assignedTo == null) {
      return 'Nothing to update';
    }

    final result = await _updateQot.execute(
      UpdateQotRequestParams(
        orderName: orderName,
        qotName: qot,
        notes: hasNotes ? notesTrim : null,
        assignedTo: assignedTo?.trim(),
      ),
    );
    final message = result.fold<String?>(
      (l) => l.when(
        serverError: (m) => m,
        noInternet: () => 'No internet connection',
      ),
      (_) => null,
    );
    if (message != null) return message;
    await refreshOrderSilently();
    return null;
  }

  /// `POST /api/order/orders/{name}/checkout/` — complete order, invoice, payments (per order API doc §3.18).
  Future<void> checkout(OrderCheckoutRequestParams params) async {
    final orderKey = params.orderName.trim();
    if (orderKey.isEmpty) return;

    final snapshot = state.mapOrNull(loaded: (v) => v);
    if (snapshot == null) return;

    emit(snapshot.copyWith(isCheckoutLoading: true, errorMessage: null, isNoInternet: false));
    final result = await _checkoutOrder.execute(params);
    await result.fold(
      (l) async {
        l.when(
          serverError: (m) {
            emit(
              state.maybeMap(
                loaded: (v) => v.copyWith(isCheckoutLoading: false),
                orElse: () => state,
              )!,
            );
            scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(m)));
          },
          noInternet: () => emit(
            state.maybeMap(
              loaded: (v) => v.copyWith(isCheckoutLoading: false, isNoInternet: true),
              orElse: () => state,
            )!,
          ),
        );
      },
      (res) async {
        emit(
          state.maybeMap(
            loaded: (v) => v.copyWith(isCheckoutLoading: false),
            orElse: () => state,
          )!,
        );
        final msg = res.message ?? 'Order checked out successfully.';
        scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(msg)));
        await load(orderKey);
      },
    );
  }
}
