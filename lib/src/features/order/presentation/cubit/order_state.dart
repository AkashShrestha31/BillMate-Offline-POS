import 'package:equatable/equatable.dart';
import 'package:hotel/src/features/order/data/models/response/order_model.dart';

/// Snapshot for the order list tabs (active / tables / KOT).
class OrderViewData extends Equatable {
  const OrderViewData({
    this.tabIndex = 0,
    this.activeOrders = const <OrderModel>[],
    this.tableTiles = const <OrderTableTileModel>[],
    this.kotOrders = const <OrderModel>[],
    this.activeTotalCount = 0,
  });

  final int tabIndex;
  final List<OrderModel> activeOrders;
  final List<OrderTableTileModel> tableTiles;
  final List<OrderModel> kotOrders;
  final int activeTotalCount;

  OrderViewData copyWith({
    int? tabIndex,
    List<OrderModel>? activeOrders,
    List<OrderTableTileModel>? tableTiles,
    List<OrderModel>? kotOrders,
    int? activeTotalCount,
  }) {
    return OrderViewData(
      tabIndex: tabIndex ?? this.tabIndex,
      activeOrders: activeOrders ?? this.activeOrders,
      tableTiles: tableTiles ?? this.tableTiles,
      kotOrders: kotOrders ?? this.kotOrders,
      activeTotalCount: activeTotalCount ?? this.activeTotalCount,
    );
  }

  @override
  List<Object?> get props =>
      [tabIndex, activeOrders, tableTiles, kotOrders, activeTotalCount];
}

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

final class OrderStateInitial extends OrderState {
  const OrderStateInitial();
}

final class OrderStateLoading extends OrderState {
  const OrderStateLoading(this.data);

  final OrderViewData data;

  @override
  List<Object?> get props => [data];
}

final class OrderStateNoInternet extends OrderState {
  const OrderStateNoInternet(this.data);

  final OrderViewData data;

  @override
  List<Object?> get props => [data];
}

final class OrderStateError extends OrderState {
  const OrderStateError({required this.message, required this.data});

  final String message;
  final OrderViewData data;

  @override
  List<Object?> get props => [message, data];
}

final class OrderStateSuccess extends OrderState {
  const OrderStateSuccess(this.data);

  final OrderViewData data;

  @override
  List<Object?> get props => [data];
}

extension OrderStateX on OrderState {
  int get tabIndex => switch (this) {
        OrderStateInitial() => 0,
        OrderStateLoading(:final data) => data.tabIndex,
        OrderStateNoInternet(:final data) => data.tabIndex,
        OrderStateError(:final data) => data.tabIndex,
        OrderStateSuccess(:final data) => data.tabIndex,
      };

  bool get isLoading => this is OrderStateLoading;

  List<OrderModel> get activeOrders => switch (this) {
        OrderStateInitial() => const [],
        OrderStateLoading(:final data) => data.activeOrders,
        OrderStateNoInternet(:final data) => data.activeOrders,
        OrderStateError(:final data) => data.activeOrders,
        OrderStateSuccess(:final data) => data.activeOrders,
      };

  List<OrderTableTileModel> get tableTiles => switch (this) {
        OrderStateInitial() => const [],
        OrderStateLoading(:final data) => data.tableTiles,
        OrderStateNoInternet(:final data) => data.tableTiles,
        OrderStateError(:final data) => data.tableTiles,
        OrderStateSuccess(:final data) => data.tableTiles,
      };

  List<OrderModel> get kotOrders => switch (this) {
        OrderStateInitial() => const [],
        OrderStateLoading(:final data) => data.kotOrders,
        OrderStateNoInternet(:final data) => data.kotOrders,
        OrderStateError(:final data) => data.kotOrders,
        OrderStateSuccess(:final data) => data.kotOrders,
      };

  int get activeTotalCount => switch (this) {
        OrderStateInitial() => 0,
        OrderStateLoading(:final data) => data.activeTotalCount,
        OrderStateNoInternet(:final data) => data.activeTotalCount,
        OrderStateError(:final data) => data.activeTotalCount,
        OrderStateSuccess(:final data) => data.activeTotalCount,
      };

  String? get errorMessage => switch (this) {
        OrderStateError(:final message) => message,
        _ => null,
      };

  bool get isNoInternet => this is OrderStateNoInternet;
}

OrderViewData viewDataFromOrderState(OrderState s) {
  return switch (s) {
    OrderStateInitial() => const OrderViewData(),
    OrderStateLoading(:final data) => data,
    OrderStateNoInternet(:final data) => data,
    OrderStateError(:final data) => data,
    OrderStateSuccess(:final data) => data,
  };
}
