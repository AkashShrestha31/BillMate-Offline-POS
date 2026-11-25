import 'package:bloc/bloc.dart';
import 'package:hotel/src/features/order/data/models/request/get_orders_request_params.dart';
import 'package:hotel/src/features/order/data/models/request/order_query_params.dart';
import 'package:hotel/src/features/order/data/models/response/order_model.dart';
import 'package:hotel/src/features/order/domain/usecases/get_orders_use_case.dart';
import 'package:hotel/src/features/order/presentation/cubit/order_state.dart';
import 'package:injectable/injectable.dart';

export 'order_state.dart';

bool _isActiveStatus(String? s) {
  return s == 'Created' || s == 'Accepted' || s == 'Processing';
}

List<OrderModel> _filterActive(List<OrderModel> raw) {
  final list = raw.where((o) => _isActiveStatus(o.orderStatus)).toList();
  list.sort((a, b) => (b.created ?? '').compareTo(a.created ?? ''));
  return list;
}

List<OrderTableTileModel> _buildTableTiles(List<OrderModel> raw) {
  final byTable = <String, List<OrderModel>>{};
  for (final o in raw) {
    final t = (o.tableNumber ?? '').trim();
    if (t.isEmpty) continue;
    byTable.putIfAbsent(t, () => []).add(o);
  }
  final names = byTable.keys.toList()..sort();
  return names
      .map(
        (name) => OrderTableTileModel(
          name: name,
          occupied: byTable[name]!.any((o) => _isActiveStatus(o.orderStatus)),
        ),
      )
      .toList();
}

@injectable
class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this._getOrders) : super(const OrderStateInitial());

  final GetOrdersUseCase _getOrders;

  static const _pageSize = 100;

  void selectTab(int index) {
    final data = viewDataFromOrderState(state);
    if (index == data.tabIndex) return;
    emit(OrderStateSuccess(data.copyWith(tabIndex: index)));
    loadCurrentTab();
  }

  Future<void> loadCurrentTab() async {
    switch (state.tabIndex) {
      case 0:
        await loadActiveOrders();
        break;
      case 1:
        await loadTables();
        break;
      case 2:
        await loadKot();
        break;
      default:
        break;
    }
  }

  /// Active tab: non-terminal orders (`Created` / `Accepted`).
  Future<void> loadActiveOrders() async {
    final data = viewDataFromOrderState(state);
    emit(OrderStateLoading(data));
    emit(
      (await _getOrders.execute(
        const GetOrdersRequestParams(
          query: OrderQueryParams(
            page: 1,
            perPage: _pageSize,
          ),
        ),
      )).fold(
        (error) => error.when(
          serverError: (message) => OrderStateError(message: message, data: data),
          noInternet: () => OrderStateNoInternet(data),
        ),
        (r) {
          final filtered = _filterActive(r.data ?? []);
          return OrderStateSuccess(
            data.copyWith(
              activeOrders: filtered,
              activeTotalCount: filtered.length,
            ),
          );
        },
      ),
    );
  }

  /// Table tab: derive occupancy from a wider fetch (no `/tables/` endpoint).
  Future<void> loadTables() async {
    final data = viewDataFromOrderState(state);
    emit(OrderStateLoading(data));
    emit(
      (await _getOrders.execute(
        const GetOrdersRequestParams(
          query: OrderQueryParams(
            page: 1,
            perPage: 500,
          ),
        ),
      )).fold(
        (error) => error.when(
          serverError: (message) => OrderStateError(message: message, data: data),
          noInternet: () => OrderStateNoInternet(data),
        ),
        (r) {
          final tiles = _buildTableTiles(r.data ?? []);
          return OrderStateSuccess(data.copyWith(tableTiles: tiles));
        },
      ),
    );
  }

  /// KOT tab: kitchen queue orders (`order_type=qot`).
  Future<void> loadKot() async {
    final data = viewDataFromOrderState(state);
    emit(OrderStateLoading(data));
    emit(
      (await _getOrders.execute(
        const GetOrdersRequestParams(
          query: OrderQueryParams(
            page: 1,
            perPage: _pageSize,
            orderType: 'qot',
          ),
        ),
      )).fold(
        (error) => error.when(
          serverError: (message) => OrderStateError(message: message, data: data),
          noInternet: () => OrderStateNoInternet(data),
        ),
        (r) {
          var list = r.data ?? [];
          list = [...list]..sort((a, b) => (b.created ?? '').compareTo(a.created ?? ''));
          return OrderStateSuccess(data.copyWith(kotOrders: list));
        },
      ),
    );
  }
}
