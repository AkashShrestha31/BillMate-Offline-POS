import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/themes/app_colors.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/order/data/models/request/get_orders_request_params.dart';
import 'package:hotel/src/features/order/data/models/request/order_query_params.dart';
import 'package:hotel/src/features/order/data/models/response/order_model.dart';
import 'package:hotel/src/features/order/domain/usecases/get_orders_use_case.dart';
import 'package:hotel/src/features/order/presentation/cubit/order_cubit.dart';
import 'package:hotel/src/features/order/presentation/utils/order_ui_helpers.dart';
import 'package:hotel/constants.dart';

/// Kitchen (QOT) chip: one table → order detail; several → table picker.
void openKitchenQotFlow(BuildContext context, List<OrderModel> activeOrders) {
  final qot = activeOrders.where((o) => o.orderType?.toLowerCase() == 'qot').toList();
  if (qot.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('No kitchen (QOT) orders.')),
    );
    return;
  }
  final sorted = [...qot]..sort((a, b) => (b.created ?? '').compareTo(a.created ?? ''));
  final byTable = <String, OrderModel>{};
  for (final o in sorted) {
    final k = (o.tableNumber ?? '').trim().isEmpty ? 'General' : o.tableNumber!.trim();
    byTable.putIfAbsent(k, () => o);
  }
  if (byTable.length == 1) {
    final name = byTable.values.first.name;
    if (name != null && name.isNotEmpty) {
      context.router.push(OrderDetailRoute(orderName: name));
    }
    return;
  }
  context.router.push(OrderQotHubRoute());
}

Future<void> openOrderDetailForTable(BuildContext context, String tableNumber) async {
  final useCase = getIt<GetOrdersUseCase>();
  final result = await useCase.execute(
    GetOrdersRequestParams(
      query: OrderQueryParams(tableNumber: tableNumber, perPage: 20, page: 1),
    ),
  );
  if (!context.mounted) return;
  result.fold(
    (l) {
      l.when(
        serverError: (m) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m))),
        noInternet: () => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No internet')),
        ),
      );
    },
    (r) {
      final orders = r.data ?? [];
      if (orders.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No orders for $tableNumber yet.')),
        );
        return;
      }
      orders.sort((a, b) => (b.created ?? '').compareTo(a.created ?? ''));
      final name = orders.first.name;
      if (name != null) {
        context.router.push(OrderDetailRoute(orderName: name));
      }
    },
  );
}

@RoutePage()
class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OrderCubit>()..loadCurrentTab(),
      child: const _OrderView(),
    );
  }
}

class _OrderView extends StatefulWidget {
  const _OrderView();

  @override
  State<_OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<_OrderView> with SingleTickerProviderStateMixin {
  static const Color _orderTabActive = Color(0xFF0B9A6D);
  static const Color _orderTabInactive = Color(0xFF2E3138);

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    context.read<OrderCubit>().selectTab(_tabController.index);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        leading: AppBarIosBackButton(color: scheme.onSurface),
        titleSpacing: 0,
        title: Text(
          'Order',
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            color: scheme.onSurface,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.chat_bubble_outline),
            color: scheme.onSurface,
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(44.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TabBar(
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 4,
                indicatorPadding: EdgeInsets.zero,
                labelPadding: EdgeInsets.only(left: 28.w),
                labelColor: context.theme.colorScheme.primary,
                unselectedLabelColor: context.theme.colorScheme.inverseSurface,
                indicatorColor: context.theme.colorScheme.primary,
                dividerColor: Colors.transparent,
                labelStyle: context.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.theme.colorScheme.primary,
                ),
                unselectedLabelStyle: context.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.theme.colorScheme.inverseSurface,
                ),
                tabs: const [
                  Tab(text: 'Active'),
                  Tab(text: 'Table'),
                  Tab(text: 'KOT'),
                ],
              ),
              Container(height: 1, color: context.theme.colorScheme.surfaceContainerHighest),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(
            QuickAddItemsRoute(
              invoiceType: InvoiceType.sales,
              fromQuickSales: true,
              fromRestaurantOrder: true,
            ),
          );
        },
        backgroundColor: context.theme.colorScheme.primary,
        foregroundColor: Colors.white,
        tooltip: 'Add Order',
        child: Icon(Icons.add),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _ActiveTabBody(),
          _TableTabBody(),
          _KotTabBody(),
        ],
      ),
    );
  }
}

class _ActiveTabBody extends StatelessWidget {
  const _ActiveTabBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      buildWhen: (p, c) =>
          p.tabIndex != c.tabIndex ||
          p.isLoading != c.isLoading ||
          p.activeOrders != c.activeOrders ||
          p.errorMessage != c.errorMessage ||
          p.isNoInternet != c.isNoInternet,
      builder: (context, state) {
        if (state.tabIndex != 0) return const SizedBox.shrink();
        if (state.isNoInternet) {
          return Center(child: Text('No internet', style: Theme.of(context).textTheme.bodyLarge));
        }
        if (state.errorMessage != null) {
          return _RetryBody(
            message: state.errorMessage!,
            onRetry: () => context.read<OrderCubit>().loadActiveOrders(),
          );
        }
        if (state.isLoading && state.activeOrders.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        final orders = state.activeOrders;
        final qotCount = orders.where((o) => o.orderType?.toLowerCase() == 'qot').length;

        final byTable = <String, List<OrderModel>>{};
        for (final o in orders) {
          final key = (o.tableNumber ?? '').trim().isNotEmpty ? o.tableNumber!.trim() : 'General';
          byTable.putIfAbsent(key, () => []).add(o);
        }
        final keys = byTable.keys.toList()..sort();

        final green = const Color(0xFF2E7D32);
        final sectionChildren = <Widget>[
          // if (qotCount > 0)
          //   Padding(
          //     padding: EdgeInsets.only(bottom: 12.h),
          //     child: Align(
          //       alignment: Alignment.centerLeft,
          //       child: InkWell(
          //         onTap: () => openKitchenQotFlow(context, orders),
          //         borderRadius: BorderRadius.circular(20),
          //         child: SizedBox(
          //           height: 36.h,
          //           child: Material(
          //             color: const Color(0xFFE8F5E9),
          //             borderRadius: BorderRadius.circular(20),
          //             child: Container(
          //               padding: EdgeInsets.symmetric(horizontal: 10.w),
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(20),
          //                 border: Border.all(color: green.withValues(alpha: 0.55)),
          //               ),
          //               alignment: Alignment.center,
          //               child: Row(
          //                 mainAxisSize: MainAxisSize.min,
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   Icon(Icons.restaurant, size: 18, color: green),
          //                   SizedBox(width: 6.w),
          //                   Text(
          //                     'Kitchen (QOT)  $qotCount',
          //                     style: Theme.of(context).textTheme.labelMedium?.copyWith(
          //                           color: green,
          //                           fontWeight: FontWeight.w600,
          //                         ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
        ];
        const activeRowMaxCols = 2;
        final activeColGap = 12.w;
        for (var start = 0; start < keys.length; start += activeRowMaxCols) {
          final end = start + activeRowMaxCols > keys.length ? keys.length : start + activeRowMaxCols;
          final chunk = keys.sublist(start, end);

          sectionChildren.add(
            LayoutBuilder(
              builder: (context, constraints) {
                final cellWidth = (constraints.maxWidth - activeColGap * (activeRowMaxCols - 1)) / activeRowMaxCols;

                Widget columnForKey(String k) {
                  final tableOrders = byTable[k]!;
                  return SizedBox(
                    width: cellWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Text(
                            k,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        for (var oi = 0; oi < tableOrders.length; oi++) ...[
                          _ActiveOrderCard(order: tableOrders[oi]),
                          if (oi < tableOrders.length - 1) SizedBox(height: 12.h),
                        ],
                      ],
                    ),
                  );
                }

                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var ci = 0; ci < chunk.length; ci++) ...[
                        if (ci > 0) SizedBox(width: activeColGap),
                        columnForKey(chunk[ci]),
                      ],
                    ],
                  ),
                );
              },
            ),
          );
        }
        sectionChildren.add(
          Center(
            child: Text(
              'Total Order : ${state.activeTotalCount}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        );

        return RefreshIndicator(
          onRefresh: () => context.read<OrderCubit>().loadActiveOrders(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (orders.isEmpty) {
                return ListView(
                  physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 88.h),
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(minHeight: (constraints.maxHeight - 100.h).clamp(0, double.infinity)),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            Text(
                              'No active orders (Created / Accepted).',
                              style: Theme.of(context).textTheme.labelLarge,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              return ListView(
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 88.h),
                children: sectionChildren,
              );
            },
          ),
        );
      },
    );
  }
}

class _ActiveOrderCard extends StatelessWidget {
  const _ActiveOrderCard({required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    const justNowGreen = Color(0xFF2E7D32);
    final items = order.mergedOrderLinesByProduct;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        final n = order.name;
        if (n != null) {
          context.router.push(OrderDetailRoute(orderName: n));
        }
      },
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.45)),
        ),
        child: SizedBox(
          height: 220.h,
          child: Padding(
            padding: EdgeInsets.all(18.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        order.name!,
                        style: Theme.of(context).textTheme.labelSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      orderRelativeTime(order.created) ?? '',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: justNowGreen,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    orderStatusChip(context, order.orderStatus),
                    // if ((order.name ?? '').isNotEmpty)
                      // Flexible(
                      //   child: Text(
                      //     order.name!,
                      //     textAlign: TextAlign.end,
                      //     style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      //           color: scheme.onSurfaceVariant,
                      //         ),
                      //     overflow: TextOverflow.ellipsis,
                      //   ),
                      // ),
                  ],
                ),
                SizedBox(height: 8.h),
                Expanded(
                  child: items.isEmpty
                      ? const SizedBox.shrink()
                      : ListView.separated(
                          padding: EdgeInsets.zero,
                          physics: const ClampingScrollPhysics(),
                          itemCount: items.length,
                          separatorBuilder: (_, __) => SizedBox(height: 4.h),
                          itemBuilder: (context, i) => _activeItemLine(context, scheme, items[i]),
                        ),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dishes: ${items.length}',
                      style: context.theme.textTheme.labelSmall,
                    ),
                    Text(
                      '$currencySymbol ${order.displayTotal.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _qtyStr(double? q) {
    if (q == null) return '0';
    if (q == q.roundToDouble()) return '${q.round()}';
    return q.toString();
  }

  Widget _activeItemLine(BuildContext context, ColorScheme scheme, OrderItemModel line) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('• ', style: AppFonts.interStyle(color: scheme.success)),
        Expanded(
          child: Text(
            '${line.item ?? ''}  (${_qtyStr(line.quantity)})',
            overflow: TextOverflow.ellipsis,
            style: context.theme.textTheme.labelSmall,
          ),
        ),
      ],
    );
  }
}

class _TableTabBody extends StatelessWidget {
  const _TableTabBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      buildWhen: (p, c) =>
          p.tabIndex != c.tabIndex ||
          p.isLoading != c.isLoading ||
          p.tableTiles != c.tableTiles ||
          p.errorMessage != c.errorMessage ||
          p.isNoInternet != c.isNoInternet,
      builder: (context, state) {
        if (state.tabIndex != 1) return const SizedBox.shrink();
        if (state.isNoInternet) {
          return Center(child: Text('No internet', style: Theme.of(context).textTheme.bodyLarge));
        }
        if (state.errorMessage != null) {
          return _RetryBody(
            message: state.errorMessage!,
            onRetry: () => context.read<OrderCubit>().loadTables(),
          );
        }
        if (state.isLoading && state.tableTiles.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        final tiles = state.tableTiles;

        return RefreshIndicator(
          onRefresh: () => context.read<OrderCubit>().loadTables(),
          child: tiles.isEmpty
              ? ListView(
                  padding: EdgeInsets.fromLTRB(16.w, 48.h, 16.w, 88.h),
                  children: [
                    Center(
                      child: Text(
                        'No table numbers in orders yet.\nOrders use Party names as tableNumber.',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
              : ListView(
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 88.h),
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Text(
                        'From orders',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 12.h,
                      crossAxisSpacing: 12.w,
                      childAspectRatio: 1.6,
                      children: tiles.map((t) => _TableCard(tile: t)).toList(),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class _TableCard extends StatelessWidget {
  const _TableCard({required this.tile});

  final OrderTableTileModel tile;

  @override
  Widget build(BuildContext context) {
    final occupied = tile.occupied;
    final bg = occupied
        ? const Color(0xFFE8F5E9)
        : Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.35);

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => openOrderDetailForTable(context, tile.name),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tile.name,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.h),
              Text(occupied ? 'Occupied' : 'Open'),
            ],
          ),
        ),
      ),
    );
  }
}

class _KotTabBody extends StatelessWidget {
  const _KotTabBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      buildWhen: (p, c) =>
          p.tabIndex != c.tabIndex ||
          p.isLoading != c.isLoading ||
          p.kotOrders != c.kotOrders ||
          p.errorMessage != c.errorMessage ||
          p.isNoInternet != c.isNoInternet,
      builder: (context, state) {
        if (state.tabIndex != 2) return const SizedBox.shrink();
        if (state.isNoInternet) {
          return Center(child: Text('No internet', style: Theme.of(context).textTheme.bodyLarge));
        }
        if (state.errorMessage != null) {
          return _RetryBody(
            message: state.errorMessage!,
            onRetry: () => context.read<OrderCubit>().loadKot(),
          );
        }
        if (state.isLoading && state.kotOrders.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        final kots = state.kotOrders;

        if (kots.isEmpty) {
          return RefreshIndicator(
            onRefresh: () => context.read<OrderCubit>().loadKot(),
            child: ListView(
              padding: EdgeInsets.fromLTRB(16.w, 48.h, 16.w, 88.h),
              children: [
                Center(
                  child: Text(
                    'No kitchen orders (order_type=qot).',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => context.read<OrderCubit>().loadKot(),
          child: ListView.separated(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 88.h),
            itemCount: kots.length + 1,
            separatorBuilder: (_, __) => SizedBox(height: 16.h),
            itemBuilder: (context, i) {
              if (i == kots.length) {
                return Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Center(
                    child: Text('Total KOT : ${kots.length}'),
                  ),
                );
              }
              return _KotCard(order: kots[i], ticketNumber: i + 1);
            },
          ),
        );
      },
    );
  }
}

class _KotCard extends StatelessWidget {
  const _KotCard({required this.order, required this.ticketNumber});

  final OrderModel order;
  final int ticketNumber;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final items = order.mergedOrderLinesByProduct;
    final dishCount = items.length;
    final qtySum = items.fold<double>(0, (a, b) => a + (b.quantity ?? 0)).round();

    final tableLabel = (order.tableNumber ?? '').trim().isNotEmpty
        ? order.tableNumber!.trim()
        : ((order.party ?? '').trim().isNotEmpty ? order.party!.trim() : '—');
    final orderBy = (order.primaryAssignedForList ?? '').trim().isNotEmpty
        ? order.primaryAssignedForList!.trim()
        : ((order.party ?? '').trim().isNotEmpty ? order.party!.trim() : (order.createdBy ?? '—'));

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        final n = order.name;
        if (n != null) {
          context.router.push(OrderDetailRoute(orderName: n));
        }
      },
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.5)),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'KOT $ticketNumber',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'Type: Dine In',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Table: $tableLabel',
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Order By: $orderBy',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              SizedBox(height: 6.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Order At: ${formatOrderTimestamp(order.created) ?? '—'}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: _kotDashedRule(scheme),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 36.w,
                    child: Text('S.N', style: Theme.of(context).textTheme.labelSmall),
                  ),
                  Expanded(
                    child: Text('Dishes', style: Theme.of(context).textTheme.labelSmall),
                  ),
                  SizedBox(
                    width: 40.w,
                    child: Text(
                      'QTY',
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.h, bottom: 4.h),
                child: _kotDashedRule(scheme),
              ),
              ...items.asMap().entries.map((e) {
                final sn = e.key + 1;
                final line = e.value;
                final dishLabel = '${line.item ?? ''}'.trim();
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 36.w,
                        child: Text(
                          '$sn.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      _KotItemThumb(imageUrl: line.imageUrl, scheme: scheme),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          dishLabel,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      SizedBox(
                        width: 40.w,
                        child: Text(
                          _kotLineQty(line.quantity),
                          textAlign: TextAlign.right,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                );
              }),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: _kotDashedRule(scheme),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total (Dishes/QTY)',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '$dishCount/$qtySum',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                'Printed By: ${order.modifiedBy ?? order.createdBy ?? '—'}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
              ),
              SizedBox(height: 4.h),
              Text(
                'Printed At: ${formatOrderTimestamp(order.modified) ?? formatOrderTimestamp(order.created) ?? '—'}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
              ),
              SizedBox(height: 12.h),
              Text(
                'Thank You!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _kotLineQty(double? q) {
    if (q == null) return '0';
    if (q == q.roundToDouble()) return '${q.round()}';
    return q.toString();
  }
}

class _KotItemThumb extends StatelessWidget {
  const _KotItemThumb({required this.imageUrl, required this.scheme});

  final String? imageUrl;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final url = resolveOrderItemImageUrl(imageUrl);
    final net = url != null && (url.startsWith('http://') || url.startsWith('https://'));

    return SizedBox(
      width: 36.w,
      height: 36.w,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.85)),
        ),
        clipBehavior: Clip.antiAlias,
        child: net
            ? Image.network(
                url,
                fit: BoxFit.cover,
                width: 36.w,
                height: 36.w,
                errorBuilder: (_, __, ___) => _kotThumbFallback(scheme),
                loadingBuilder: (ctx, child, prog) {
                  if (prog == null) return child;
                  return ColoredBox(
                    color: scheme.surfaceContainerHighest,
                    child: Center(
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2, color: scheme.primary),
                      ),
                    ),
                  );
                },
              )
            : _kotThumbFallback(scheme),
      ),
    );
  }

  Widget _kotThumbFallback(ColorScheme scheme) {
    return ColoredBox(
      color: scheme.surfaceContainerHighest,
      child: Icon(Icons.restaurant, size: 18, color: scheme.onSurfaceVariant),
    );
  }
}

Widget _kotDashedRule(ColorScheme scheme) {
  return LayoutBuilder(
    builder: (context, constraints) {
      const dashW = 4.0;
      const gap = 4.0;
      final n = (constraints.maxWidth / (dashW + gap)).floor().clamp(1, 400);
      return Row(
        children: List.generate(
          n,
          (_) => Padding(
            padding: const EdgeInsets.only(right: gap),
            child: Container(
              width: dashW,
              height: 1,
              color: scheme.outlineVariant.withValues(alpha: 0.65),
            ),
          ),
        ),
      );
    },
  );
}

class _RetryBody extends StatelessWidget {
  const _RetryBody({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            SizedBox(height: 12.h),
            FilledButton(onPressed: onRetry, child: Text('Retry')),
          ],
        ),
      ),
    );
  }
}
