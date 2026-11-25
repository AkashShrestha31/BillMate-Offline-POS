import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/features/order/data/models/request/get_orders_request_params.dart';
import 'package:hotel/src/features/order/data/models/request/order_query_params.dart';
import 'package:hotel/src/features/order/data/models/response/order_model.dart';
import 'package:hotel/src/features/order/domain/usecases/get_orders_use_case.dart';

bool _isActiveKitchenOrder(String? status) {
  return status == 'Created' || status == 'Accepted' || status == 'Processing';
}

/// Pick-table screen after tapping **Kitchen (QOT)** when multiple QOT tables exist.
@RoutePage()
class OrderQotHubPage extends StatefulWidget {
  const OrderQotHubPage({super.key});

  @override
  State<OrderQotHubPage> createState() => _OrderQotHubPageState();
}

class _OrderQotHubPageState extends State<OrderQotHubPage> {
  List<_QotTablePick>? _rows;
  Object? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final result = await getIt<GetOrdersUseCase>().execute(
      const GetOrdersRequestParams(
        query: OrderQueryParams(page: 1, perPage: 100),
      ),
    );
    if (!mounted) return;
    result.fold(
      (l) {
        l.when(
          serverError: (m) => setState(() {
            _loading = false;
            _error = m;
          }),
          noInternet: () => setState(() {
            _loading = false;
            _error = 'No internet';
          }),
        );
      },
      (resp) {
        final raw = resp.data ?? [];
        final qot = raw
            .where(
              (o) =>
                  _isActiveKitchenOrder(o.orderStatus) &&
                  o.orderType?.toLowerCase() == 'qot',
            )
            .toList()
          ..sort((a, b) => (b.created ?? '').compareTo(a.created ?? ''));
        final byTable = <String, OrderModel>{};
        for (final o in qot) {
          final k =
              (o.tableNumber ?? '').trim().isEmpty ? 'General' : o.tableNumber!.trim();
          byTable.putIfAbsent(k, () => o);
        }
        final rows = byTable.entries
            .map((e) => _QotTablePick(tableLabel: e.key, order: e.value))
            .toList()
          ..sort((a, b) => a.tableLabel.compareTo(b.tableLabel));
        setState(() {
          _loading = false;
          _rows = rows;
          _error = null;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const tabRed = Color(0xFFE53935);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        foregroundColor: tabRed,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 10),
          constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
          icon: Icon(Icons.arrow_back_ios_new, size: 20.sp, color: tabRed),
          onPressed: () => context.router.maybePop(),
        ),
        title: Text(
          'Kitchen (QOT)',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: scheme.onSurface,
              ),
        ),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_error!.toString(), textAlign: TextAlign.center),
                        SizedBox(height: 16.h),
                        FilledButton(onPressed: () => _load(), child: const Text('Retry')),
                      ],
                    ),
                  ),
                )
              : (_rows == null || _rows!.isEmpty)
                  ? Center(
                      child: Text(
                        'No active kitchen (QOT) orders.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
                      itemCount: _rows!.length,
                      separatorBuilder: (_, __) => SizedBox(height: 10.h),
                      itemBuilder: (context, i) {
                        final row = _rows![i];
                        final orderName = row.order.name;
                        return Material(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: orderName == null || orderName.isEmpty
                                ? null
                                : () => context.router.push(OrderDetailRoute(orderName: orderName)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                              child: Row(
                                children: [
                                  Icon(Icons.table_restaurant_outlined,
                                      color: scheme.primary, size: 28),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          row.tableLabel,
                                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        if (orderName != null && orderName.isNotEmpty)
                                          Text(
                                            orderName,
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                  color: scheme.onSurfaceVariant,
                                                ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}

class _QotTablePick {
  const _QotTablePick({required this.tableLabel, required this.order});

  final String tableLabel;
  final OrderModel order;
}
