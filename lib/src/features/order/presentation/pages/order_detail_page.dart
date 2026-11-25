import 'dart:async' show Timer, unawaited;
import 'package:hotel/constants.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/helpers/payment_method_for_api.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/features/action/data/models/request/party_request_params.dart';
import 'package:hotel/src/features/action/presentation/cubit/party_cubit.dart';
import 'package:hotel/src/features/employee_management/data/models/response/employee_model.dart';
import 'package:hotel/src/features/employee_management/presentation/bloc/employee_cubit.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/themes/app_colors.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/core/widget/edit_discount_sheet.dart';
import 'package:hotel/src/core/widget/estimate_invoice_sheet.dart';
import 'package:hotel/src/core/widget/partial_payment_preview_page.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/order/data/models/request/order_checkout_request_params.dart';
import 'package:hotel/src/features/order/data/models/response/order_activity_response.dart';
import 'package:hotel/src/features/order/data/models/response/order_model.dart';
import 'package:hotel/src/features/order/presentation/cubit/order_detail_cubit.dart';
import 'package:hotel/src/features/payment_methods/presentation/cubit/payment_methods_cubit.dart';
import 'package:hotel/src/features/order/presentation/utils/kot_esc_pos_print.dart';
import 'package:hotel/src/features/order/presentation/utils/order_ui_helpers.dart';
import 'package:hotel/src/features/order/presentation/widgets/edit_order_item_sheet.dart';
import 'package:hotel/src/features/order/presentation/widgets/qot_status_picker_sheet.dart';
import 'package:hotel/src/core/widget/app_search_icon.dart';

const Color _tabRed = Color(0xFFE53935);
const Color _tabInactive = Color(0xFF424242);
const Color _tabDivider = Color(0xFFE0E0E0);

String _checkoutPaymentMethodForApi(String uiLabel) => normalizePaymentMethodForApi(uiLabel);

// --- KOT line for estimate (order checkout) ---------------------------------

String _kotNumbersLine(OrderModel order) {
  final tickets = order.kitchenQotTickets;
  final nums = tickets.map((t) => t.qotNo).whereType<int>().toList();
  nums.sort((a, b) => b.compareTo(a));
  final staffLabels = <String>{};
  for (final t in tickets) {
    final s = estimateStaffShort(t.assignedTo ?? order.assignedEmployee);
    if (s.isNotEmpty) staffLabels.add(s);
  }
  final staff = staffLabels.length <= 1 ? (staffLabels.isEmpty ? '' : staffLabels.first) : staffLabels.join(', ');
  if (nums.isEmpty) {
    return staff.isEmpty ? 'KOT No: —' : 'KOT No: — (by $staff)';
  }
  final list = nums.join(', ');
  return staff.isEmpty ? 'KOT No: $list' : 'KOT No: $list (by $staff)';
}

@RoutePage()
class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({super.key, required this.orderName});

  final String orderName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OrderDetailCubit>()..load(orderName),
      child: _OrderDetailScaffold(initialOrderName: orderName),
    );
  }
}

class _OrderDetailScaffold extends StatefulWidget {
  const _OrderDetailScaffold({required this.initialOrderName});

  final String initialOrderName;

  @override
  State<_OrderDetailScaffold> createState() => _OrderDetailScaffoldState();
}

class _OrderDetailScaffoldState extends State<_OrderDetailScaffold> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _guestCountController = TextEditingController();

  void _handleTabChange() {
    if (_tabController.index == 2) {
      unawaited(context.read<OrderDetailCubit>().loadActivities());
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    _guestCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accent = context.theme.colorScheme.error;

    return BlocBuilder<OrderDetailCubit, OrderDetailState>(
      builder: (context, state) {
        final order = state.maybeWhen(
          loaded: (o, _, __, ___, ____, _____, ______) => o,
          loading: (c) => c,
          noInternet: (c) => c,
          error: (_, c) => c,
          orElse: () => null,
        );
        final activities = state.maybeWhen(
          loaded: (_, __, ___, ____, a, _____, ______) => a,
          orElse: () => const <OrderActivityEntry>[],
        );
        final isActivityLoading = state.maybeWhen(
          loaded: (_, __, ___, ____, _____, activityLoading, ______) => activityLoading,
          orElse: () => false,
        );
        final activityErrorMessage = state.maybeWhen(
          loaded: (_, __, ___, ____, _____, ______, error) => error,
          orElse: () => null,
        );
        final title = order?.tableNumber?.trim().isNotEmpty == true
            ? order!.tableNumber!
            : (order?.name ?? widget.initialOrderName);

        final blockingLoad = order == null &&
            state.maybeWhen(
              initial: () => true,
              loading: (_) => true,
              orElse: () => false,
            );
        final blockingError = state.maybeWhen(
          error: (m, c) => c == null ? m : null,
          orElse: () => null,
        );
        final blockingNoNet = state.maybeWhen(
          noInternet: (c) => c == null,
          orElse: () => false,
        );

        Widget bodyChild;
        if (blockingLoad) {
          bodyChild = Center(child: CircularProgressIndicator());
        } else if (blockingError != null) {
          bodyChild = _ErrorView(
            message: blockingError,
            onRetry: () => context.read<OrderDetailCubit>().load(widget.initialOrderName),
          );
        } else if (blockingNoNet) {
          bodyChild = Center(child: Text('No internet', style: context.theme.textTheme.bodyLarge));
        } else if (order == null) {
          bodyChild = const SizedBox.shrink();
        } else {
          bodyChild = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // _GuestCustomerBar(controller: _guestCountController),
              Material(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 22.w),
                      child: TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 4,
                        indicatorPadding: EdgeInsets.zero,
                        labelPadding: EdgeInsets.only(right: 28.w),
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
                          Tab(text: 'Dishes'),
                          Tab(text: 'KOT'),
                          Tab(text: 'Activity'),
                        ],
                      ),
                    ),
                    const Divider(height: 1, thickness: 1, color: _tabDivider),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _DishesTab(
                      order: order,
                      onOpenKotTab: () => _tabController.animateTo(1),
                    ),
                    _KotDetailTab(order: order),
                    _ActivityTab(
                      order: order,
                      activities: activities,
                      isLoading: isActivityLoading,
                      errorMessage: activityErrorMessage,
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: AppBarIosBackButton(),
            title: Text(
              title,
            ),
            centerTitle: false,
            actions: [
              if (order != null) ...[
                CustomButtonWidget.outlined(
                  onPressed: () async {
                    final suffix = order.tableNumber?.trim();
                    // Always refetch detail (`GET …/orders/<id>/`) when this flow closes.
                    // Pop results are often lost with `replace` + `popForced`, so do not rely on [push] return value.
                    final detailOrderKey =
                        (order.name?.trim().isNotEmpty ?? false) ? order.name!.trim() : widget.initialOrderName;
                    await context.router.push<String?>(
                      QuickAddItemsRoute(
                        invoiceType: InvoiceType.sales,
                        fromQuickSales: true,
                        fromRestaurantOrder: true,
                        initialTableNumber: (suffix != null && suffix.isNotEmpty) ? suffix : order.name,
                        menuTitleSuffix: (suffix != null && suffix.isNotEmpty) ? suffix : order.name,
                      ),
                    );
                    if (!context.mounted) return;
                    await context.read<OrderDetailCubit>().load(detailOrderKey);
                  },
                  title: 'Add Dishes',
                  titleStyle: context.theme.textTheme.labelMedium
                      ?.copyWith(color: context.theme.colorScheme.primary, fontWeight: FontWeight.w600),
                  titleColor: context.theme.colorScheme.primary,
                  borderColor: context.theme.colorScheme.primary,
                  backgroundColor: context.theme.colorScheme.primary.withOpacity(0.1),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  borderRadius: 6.sp,
                  shrinkWrap: true,
                  expandCrossAxis: false,
                ).pOnly(right: context.theme.appTheme.spacing12),
                // IconButton(
                //   icon: Icon(Icons.more_horiz),
                //   onPressed: () {},
                // ),
              ],
            ],
          ),
          body: bodyChild,
          bottomNavigationBar: order != null
              ? SafeArea(
                  top: false,
                  child: _CheckoutFooter(order: order, accent: accent),
                )
              : null,
        );
      },
    );
  }
}

class _GuestCustomerBar extends StatelessWidget {
  const _GuestCustomerBar({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
      child: Row(
        children: [
          Expanded(
            child: CustomTextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              prefixIcon: Icon(Icons.people_outline, size: 20),
              hint: 'eg. 5',
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Customer info — link to Party when ready.')),
                );
              },
              child: CustomTextFormField(
                prefixIcon: Icon(Icons.person_outline),
                hint: 'Customer Info',
                suffixIcon: Icon(Icons.arrow_drop_down),
                enabled: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DishesTab extends StatelessWidget {
  const _DishesTab({required this.order, this.onOpenKotTab});

  final OrderModel order;
  final VoidCallback? onOpenKotTab;

  @override
  Widget build(BuildContext context) {
    final scheme = context.theme.colorScheme;
    final accent = scheme.error;
    final items = order.mergedOrderLinesByProduct;
    final totalQty = items.fold<double>(0, (a, b) => a + (b.quantity ?? 0));
    final pendingQty = _pendingQuantity(order, items);
    final cancelledQty = order.orderStatus == 'Cancelled' ? totalQty : 0.0;
    final completedQty = _completedQuantity(order, items);
    final kotCount = order.kitchenQotTickets.length;

    return ListView(
      padding: EdgeInsets.fromLTRB(24.w, 16.h, 16.w, 24.h),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Dishes', style: context.theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            Row(
              children: [
                Icon(Icons.access_time, size: 16.sp, color: scheme.onSurfaceVariant),
                horizontalMarginSmall,
                Text(
                  orderRelativeTimeVerbose(order.created) ?? '',
                  style: context.theme.textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 12.h),
        if (items.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: Center(
              child: Text(
                'No dishes on this order yet.',
                style: context.theme.textTheme.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
              ),
            ),
          )
        else
          Card(
            elevation: 0,
            color: scheme.surface.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: BorderSide(color: scheme.outlineVariant.withOpacity(0.5)),
            ),
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                children: [
                  for (var i = 0; i < items.length; i++) ...[
                    if (i > 0)
                      Divider(
                        height: 24.h,
                        thickness: 1,
                        color: scheme.outlineVariant.withOpacity(0.5),
                      ),
                    _DishRow(
                      order: order,
                      line: items[i],
                      onTap: () => _showDishOrderDetailsBottomSheet(
                        context,
                        order: order,
                        summaryLine: items[i],
                        onViewFullKot: onOpenKotTab,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        SizedBox(height: 16.h),
        Text(
          '${items.length} Dishes Ordered across $kotCount KOT',
          textAlign: TextAlign.center,
          style: context.theme.textTheme.labelSmall,
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 8.w,
                height: 8.w,
                decoration: const BoxDecoration(color: Color(0xFFFFA000), shape: BoxShape.circle)),
            SizedBox(width: 6.w),
            Text('${pendingQty.toInt()} Pending', style: context.theme.textTheme.labelSmall),
            SizedBox(width: 20.w),
            Container(
              width: 8.w,
              height: 8.w,
              decoration: const BoxDecoration(color: Color(0xFF2E7D32), shape: BoxShape.circle),
            ),
            SizedBox(width: 6.w),
            Text('${completedQty.round()} Completed', style: context.theme.textTheme.labelSmall),
            SizedBox(width: 20.w),
            Container(width: 8.w, height: 8.w, decoration: BoxDecoration(color: accent, shape: BoxShape.circle)),
            SizedBox(width: 6.w),
            Text('${cancelledQty.round()} Cancelled', style: context.theme.textTheme.labelSmall),
          ],
        ),
      ],
    );
  }

  double _pendingQuantity(OrderModel order, List<OrderItemModel> items) {
    final s = order.orderStatus;
    if (s == 'Cancelled' || s == 'Completed') return 0;
    return items.fold<double>(0, (a, b) => a + (b.quantity ?? 0));
  }

  double _completedQuantity(OrderModel order, List<OrderItemModel> items) {
    if (order.orderStatus == 'Completed') {
      return items.fold<double>(0, (a, b) => a + (b.quantity ?? 0));
    }
    return items
        .where((e) => (e.itemStatus ?? '').trim().toLowerCase() == 'served')
        .fold<double>(0, (a, b) => a + (b.quantity ?? 0));
  }
}

class _DishRow extends StatelessWidget {
  const _DishRow({required this.order, required this.line, required this.onTap});

  final OrderModel order;
  final OrderItemModel line;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = context.theme.colorScheme;
    final amt = line.amount ?? 0;
    final qty = line.quantity ?? 0;

    final imgUrl = resolveOrderItemImageUrl(line.imageUrl);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: EdgeInsets.only(bottom: 6.h, top: 6.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8.sp),
                  border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.64), width: 2.sp),
                ),
                clipBehavior: Clip.antiAlias,
                child: imgUrl != null && (imgUrl.startsWith('http://') || imgUrl.startsWith('https://'))
                    ? Image.network(
                        imgUrl,
                        fit: BoxFit.cover,
                        width: 56.w,
                        height: 56.w,
                        errorBuilder: (_, __, ___) => Icon(Icons.restaurant, color: scheme.onSurfaceVariant),
                      )
                    : Icon(Icons.restaurant, color: scheme.onSurfaceVariant),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      line.item ?? '',
                      style: context.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '$currencySymbol ${amt.toStringAsFixed(amt == amt.roundToDouble() ? 0 : 1)}',
                      style: context.theme.textTheme.labelMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerHighest.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(4.sp),
                    ),
                    child: Text(
                      'x${_qtyLabel(qty)}',
                      style: context.theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  dishLineStatusBadge(
                    context,
                    order.orderStatus,
                    lineItemStatus: line.itemStatus,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _qtyLabel(double q) {
    if (q == q.roundToDouble()) return '${q.round()}';
    return q.toString();
  }
}

/// One KOT’s contribution for a single product (aggregated lines in that ticket).
class _DishKotSlice {
  _DishKotSlice({
    required this.qot,
    required this.kotOrdinal,
    required this.quantity,
    required this.amount,
    required this.variantLabel,
    required this.line,
    required this.matchingLines,
  });

  final OrderQotModel qot;
  final int kotOrdinal;
  final double quantity;
  final double amount;
  final String variantLabel;
  final OrderItemModel line;

  /// Raw lines in this KOT for this product (each may have distinct `name` for PATCH).
  final List<OrderItemModel> matchingLines;
}

List<_DishKotSlice> _kotSlicesForProduct(OrderModel order, String productKeyLower, OrderItemModel summaryLine) {
  final tickets = order.kitchenQotTickets;
  final out = <_DishKotSlice>[];
  for (var i = 0; i < tickets.length; i++) {
    final qot = tickets[i];
    final matches = (qot.items ?? const <OrderItemModel>[]).where((l) {
      return (l.item ?? '').trim().toLowerCase() == productKeyLower;
    }).toList();
    if (matches.isEmpty) continue;
    final qty = matches.fold<double>(0, (a, b) => a + (b.quantity ?? 0));
    final amt = matches.fold<double>(0, (a, b) => a + (b.amount ?? 0));
    final first = matches.first;
    var variant = first.item ?? '';
    if ((first.description ?? '').trim().isNotEmpty) {
      variant = '${first.item ?? ''} - ${first.description!.trim()}';
    }
    final kotOrdinal = qot.qotNo ?? (i + 1);
    out.add(_DishKotSlice(
      qot: qot,
      kotOrdinal: kotOrdinal,
      quantity: qty,
      amount: amt,
      variantLabel: variant,
      line: first,
      matchingLines: matches,
    ));
  }
  out.sort((a, b) => b.kotOrdinal.compareTo(a.kotOrdinal));
  if (out.isEmpty) {
    if (tickets.isNotEmpty) {
      final q0 = tickets.first;
      out.add(_DishKotSlice(
        qot: q0,
        kotOrdinal: q0.qotNo ?? 1,
        quantity: summaryLine.quantity ?? 0,
        amount: summaryLine.amount ?? 0,
        variantLabel: (summaryLine.description ?? '').trim().isNotEmpty
            ? '${summaryLine.item ?? ''} - ${summaryLine.description!.trim()}'
            : (summaryLine.item ?? ''),
        line: summaryLine,
        matchingLines: [summaryLine],
      ));
    } else {
      out.add(_DishKotSlice(
        qot: OrderQotModel(qotNo: 1, items: [summaryLine]),
        kotOrdinal: 1,
        quantity: summaryLine.quantity ?? 0,
        amount: summaryLine.amount ?? 0,
        variantLabel: (summaryLine.description ?? '').trim().isNotEmpty
            ? '${summaryLine.item ?? ''} - ${summaryLine.description!.trim()}'
            : (summaryLine.item ?? ''),
        line: summaryLine,
        matchingLines: [summaryLine],
      ));
    }
  }
  return out;
}

void _showDishOrderDetailsBottomSheet(
  BuildContext context, {
  required OrderModel order,
  required OrderItemModel summaryLine,
  VoidCallback? onViewFullKot,
}) {
  final key = (summaryLine.item ?? '').trim().toLowerCase();
  final slices = _kotSlicesForProduct(order, key, summaryLine);
  // Modal routes sit beside the page, not under its [BlocProvider]; without this,
  // [context.read] in the sheet hits the app-level cubit and the page never refreshes.
  final orderDetailCubit = context.read<OrderDetailCubit>();

  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => BlocProvider<OrderDetailCubit>.value(
      value: orderDetailCubit,
      child: _DishOrderDetailsSheet(
        order: order,
        summaryLine: summaryLine,
        slices: slices,
        onViewFullKot: onViewFullKot,
      ),
    ),
  );
}

class _DishOrderDetailsSheet extends StatefulWidget {
  const _DishOrderDetailsSheet({
    required this.order,
    required this.summaryLine,
    required this.slices,
    this.onViewFullKot,
  });

  final OrderModel order;
  final OrderItemModel summaryLine;
  final List<_DishKotSlice> slices;
  final VoidCallback? onViewFullKot;

  @override
  State<_DishOrderDetailsSheet> createState() => _DishOrderDetailsSheetState();
}

class _DishOrderDetailsSheetState extends State<_DishOrderDetailsSheet> {
  static const _statusChoices = ['Pending', 'Preparing', 'Ready', 'Served'];

  late final List<String> _lineStatus;

  @override
  void initState() {
    super.initState();
    _lineStatus = widget.slices.map((s) {
      for (final line in s.matchingLines) {
        final v = line.itemStatus?.trim();
        if (v != null && v.isNotEmpty && _statusChoices.contains(v)) return v;
      }
      return 'Pending';
    }).toList();
  }

  /// Read-only summary: reflects KOT line statuses (single value or "Mixed").
  String _summaryItemStatusLabel() {
    if (_lineStatus.isEmpty) {
      final v = widget.summaryLine.itemStatus?.trim();
      if (v != null && v.isNotEmpty && _statusChoices.contains(v)) return v;
      return 'Pending';
    }
    final first = _lineStatus.first;
    if (_lineStatus.every((s) => s == first)) return first;
    return 'Mixed';
  }

  /// Returns an error message, or `null` on success.
  Future<String?> _patchItemLines(Set<String> itemLineNames, String status) async {
    if (itemLineNames.isEmpty) {
      return 'Cannot update: server line id is missing. Reload order or check API.';
    }
    final orderKey = (widget.order.name ?? '').trim();
    if (orderKey.isEmpty) {
      return 'Order id missing';
    }
    return context.read<OrderDetailCubit>().updateItemLineStatuses(
          forOrderName: orderKey,
          itemLineNames: itemLineNames,
          itemStatus: status,
        );
  }

  void _onKotSliceStatusSelected(_DishKotSlice s, int index, String? v) {
    if (v == null || v == _lineStatus[index]) return;
    // URL segment = JSON "name" (e.g. febcac-570cde1a), not JSON "item" (e.g. Bhatmas Sadeko).
    final ids = s.matchingLines
        .map((l) => l.orderLineIdForItemStatusPatch)
        .whereType<String>()
        .map((n) => n.trim())
        .where((n) => n.isNotEmpty)
        .toSet();
    final prev = _lineStatus[index];
    setState(() => _lineStatus[index] = v);
    unawaited(() async {
      final err = await _patchItemLines(ids, v);
      if (!mounted) return;
      if (err != null) {
        setState(() => _lineStatus[index] = prev);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
        return;
      }
      if (!mounted) return;
      Navigator.of(context).pop();
    }());
  }

  void _openEditForSlice(_DishKotSlice slice) {
    if (slice.matchingLines.length != 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Edit needs a single line for this dish on this KOT.'),
        ),
      );
      return;
    }
    final orderName = (widget.order.name ?? '').trim();
    if (orderName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order id missing.')),
      );
      return;
    }
    final line = slice.matchingLines.first;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(sheetCtx).bottom),
        child: BlocProvider<OrderDetailCubit>.value(
          value: context.read<OrderDetailCubit>(),
          child: EditOrderItemSheet(
            orderName: orderName,
            line: line,
            productTitle: widget.summaryLine.item ?? line.item ?? '',
            onSaved: () {
              Navigator.pop(sheetCtx);
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  String _sliceStaffLabel(_DishKotSlice s) {
    final e = (s.qot.assignedTo ?? widget.order.assignedEmployee)?.trim() ?? '';
    if (e.isEmpty) return widget.order.createdBy?.trim() ?? '—';
    final at = e.indexOf('@');
    if (at > 0) return e.substring(0, at);
    return e;
  }

  String _kotTimestampLine() {
    final iso = widget.order.modified ?? widget.order.created;
    final clock = formatOrderTimestamp(iso);
    final rel = orderRelativeTime(iso);
    if (clock != null && rel != null) return '$clock ($rel)';
    return clock ?? rel ?? '—';
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.theme.colorScheme;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final summary = widget.summaryLine;
    final totalQty = summary.quantity ?? 0;
    final totalAmt = summary.amount ?? 0;
    final imgUrl = resolveOrderItemImageUrl(summary.imageUrl);

    final maxH = MediaQuery.sizeOf(context).height * 0.92;

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxH),
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h + bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: scheme.outlineVariant,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    SizedBox(width: 40.w),
                    Expanded(
                      child: Text(
                        "Dish's order details",
                        textAlign: TextAlign.center,
                        style: context.theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: scheme.surfaceContainerHighest.withValues(alpha: 0.35),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.5)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        summary.item ?? '',
                                        style:
                                            context.theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        '$currencySymbol ${totalAmt.toStringAsFixed(totalAmt == totalAmt.roundToDouble() ? 0 : 1)}',
                                        style:
                                            context.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        'Qty : ${_qtyStrSheet(totalQty)}',
                                        style:
                                            context.theme.textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                                      ),
                                      SizedBox(height: 10.h),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                                        decoration: BoxDecoration(
                                          color: scheme.primary,
                                          borderRadius: BorderRadius.circular(6.sp),
                                        ),
                                        child: Text(
                                          _summaryItemStatusLabel(),
                                          style: context.theme.textTheme.labelMedium?.copyWith(
                                            color: scheme.onInverseSurface,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SizedBox(
                                    width: 72.w,
                                    height: 72.w,
                                    child: imgUrl != null &&
                                            (imgUrl.startsWith('http://') || imgUrl.startsWith('https://'))
                                        ? Image.network(
                                            imgUrl,
                                            fit: BoxFit.cover,
                                            errorBuilder: (_, __, ___) =>
                                                Icon(Icons.restaurant_menu, color: scheme.onSurfaceVariant, size: 32),
                                          )
                                        : ColoredBox(
                                            color: scheme.surfaceContainerHighest,
                                            child:
                                                Icon(Icons.restaurant_menu, color: scheme.onSurfaceVariant, size: 32),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'KOT Details',
                          style: context.theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 12.h),
                        ...List.generate(widget.slices.length, (i) {
                          final s = widget.slices[i];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 14.h),
                            child: _DishKotDetailCard(
                              kotLabel: 'KOT #${s.kotOrdinal}',
                              timestampLine: _kotTimestampLine(),
                              staffLabel: _sliceStaffLabel(s),
                              variantLabel: s.variantLabel,
                              quantity: s.quantity,
                              amount: s.amount,
                              statusValue: _lineStatus[i],
                              onStatusChanged: (v) => _onKotSliceStatusSelected(s, i, v),
                              onViewFullKot: widget.onViewFullKot == null
                                  ? null
                                  : () {
                                      Navigator.of(context).pop();
                                      widget.onViewFullKot!();
                                    },
                              onCancel: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Cancel line — not wired yet.')),
                                );
                              },
                              onEdit: () => _openEditForSlice(s),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _qtyStrSheet(double q) {
    if (q == q.roundToDouble()) return '${q.round()}';
    return q.toString();
  }
}

class _DishKotDetailCard extends StatefulWidget {
  const _DishKotDetailCard({
    required this.kotLabel,
    required this.timestampLine,
    required this.staffLabel,
    required this.variantLabel,
    required this.quantity,
    required this.amount,
    required this.statusValue,
    required this.onStatusChanged,
    this.onViewFullKot,
    required this.onCancel,
    required this.onEdit,
  });

  final String kotLabel;
  final String timestampLine;
  final String staffLabel;
  final String variantLabel;
  final double quantity;
  final double amount;
  final String statusValue;

  /// Must be synchronous — call PATCH from here via [unawaited], not `async` closure.
  final void Function(String? value) onStatusChanged;
  final VoidCallback? onViewFullKot;
  final VoidCallback onCancel;
  final VoidCallback onEdit;

  @override
  State<_DishKotDetailCard> createState() => _DishKotDetailCardState();
}

class _DishKotDetailCardState extends State<_DishKotDetailCard> {
  final bool _packaging = false;

  @override
  Widget build(BuildContext context) {
    final scheme = context.theme.colorScheme;
    final accent = context.theme.colorScheme.primary;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.65)),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.kotLabel,
                        style: context.theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        widget.timestampLine,
                        style: context.theme.textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'by: ${widget.staffLabel}',
                        style: context.theme.textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                if (widget.onViewFullKot != null)
                  TextButton(
                    onPressed: widget.onViewFullKot,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text('View Full KOT', style: AppFonts.interStyle(color: accent, fontWeight: FontWeight.w600)),
                  ),
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              widget.variantLabel,
              style: context.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 6.h),
            Text(
              'Qty : ${_qtyStr(widget.quantity)} | $currencySymbol ${widget.amount.toStringAsFixed(widget.amount == widget.amount.roundToDouble() ? 0 : 1)}',
              style: context.theme.textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
            ),
            SizedBox(height: 12.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.sp),
                      border: Border.all(color: const Color(0xFFFFA000), width: 1.5),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => _openKotStatusBottomSheet(context),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _statusChoices.contains(widget.statusValue) ? widget.statusValue : 'Pending',
                                  style: context.theme.textTheme.labelMedium,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 22.sp,
                                color: scheme.onSurfaceVariant,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                CustomButtonWidget.outlined(
                  onPressed: widget.onCancel,
                  icon: Icon(Icons.close, color: scheme.error),
                  title: 'Cancel',
                  titleColor: scheme.error,
                  borderColor: scheme.error,
                  backgroundColor: scheme.error.withOpacity(0.1),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  borderRadius: 6.sp,
                  shrinkWrap: true,
                  expandCrossAxis: false,
                ),
                horizontalMarginSmall,
                CustomButtonWidget.outlined(
                  onPressed: widget.onEdit,
                  icon: Icon(Icons.edit),
                  title: 'Edit',
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                  borderRadius: 6.sp,
                  shrinkWrap: true,
                  expandCrossAxis: false,
                ),
              ],
            ),
            verticalMarginMedium
          ],
        ),
      ),
    );
  }

  static const _statusChoices = ['Pending', 'Preparing', 'Ready', 'Served'];

  void _openKotStatusBottomSheet(BuildContext context) {
    final theme = context.theme;
    final cs = theme.colorScheme;
    final current = _statusChoices.contains(widget.statusValue) ? widget.statusValue : 'Pending';

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (sheetCtx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 12.h),
                child: Text(
                  'KOT status',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              ..._statusChoices.map(
                (e) => ListTile(
                  title: Text(e),
                  trailing: e == current ? Icon(Icons.check_rounded, color: cs.primary) : null,
                  onTap: () {
                    Navigator.pop(sheetCtx);
                    widget.onStatusChanged(e);
                  },
                ),
              ),
              SizedBox(height: 8.h),
            ],
          ),
        );
      },
    );
  }

  String _qtyStr(double q) {
    if (q == q.roundToDouble()) return '${q.round()}';
    return q.toString();
  }
}

class _KotDetailTab extends StatelessWidget {
  const _KotDetailTab({required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final scheme = context.theme.colorScheme;
    final tickets = order.kitchenQotTickets;
    final tableLabel = (order.tableNumber ?? '').trim();
    final rel = orderRelativeTimeVerbose(order.modified ?? order.created);

    if (tickets.isEmpty) {
      return ListView(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
        children: [
          Text(
            'No kitchen tickets yet.',
            style: context.theme.textTheme.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ],
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (tableLabel.isNotEmpty) ...[
            Text(
              tableLabel,
              style: context.theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 12.h),
          ],
          for (var i = 0; i < tickets.length; i += 2)
            Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _KotTicketCard(
                      order: order,
                      qot: tickets[i],
                      cardIndex: i,
                      relativeTime: rel,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: i + 1 < tickets.length
                        ? _KotTicketCard(
                            order: order,
                            qot: tickets[i + 1],
                            cardIndex: i + 1,
                            relativeTime: rel,
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _KotTicketCard extends StatelessWidget {
  const _KotTicketCard({
    required this.order,
    required this.qot,
    required this.cardIndex,
    required this.relativeTime,
  });

  final OrderModel order;
  final OrderQotModel qot;
  final int cardIndex;
  final String? relativeTime;
  static final double _cardHeight = 250;

  String _qotNumberLine() {
    final n = qot.qotNo;
    if (n != null) return 'QOT #$n';
    return 'QOT #${cardIndex + 1}';
  }

  String _qtyLabel(double? q) {
    if (q == null) return '0';
    if (q == q.roundToDouble()) return '${q.round()}';
    return q.toString();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.theme.colorScheme;
    final lines = mergeOrderItemsByProductName(qot.items ?? const []);
    final status = qot.qotStatus ?? order.orderStatus;
    final total = qot.displaySubtotal;

    return SizedBox(
      height: _cardHeight.h,
      child: Card(
        elevation: 0,
        color: scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.6)),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _showKotPrintPreviewSheet(
            context,
            order: order,
            qot: qot,
            cardIndex: cardIndex,
          ),
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        _qotNumberLine(),
                        style: context.theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    if (relativeTime != null && relativeTime!.isNotEmpty)
                      Text(
                        relativeTime!,
                        style: context.theme.textTheme.labelSmall?.copyWith(
                          color: context.theme.colorScheme.success,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 10.h),
                Wrap(
                  spacing: 6.w,
                  runSpacing: 6.h,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    orderStatusChip(context, status),
                    // Text(
                    //   _qotNumberLine(),
                    //   style: context.theme.textTheme.labelSmall?.copyWith(
                    //         fontWeight: FontWeight.w700,
                    //         color: scheme.onSurface,
                    //       ),
                    // ),
                    // if ((order.name ?? '').isNotEmpty)
                    //   Text(
                    //     '· ${order.name}',
                    //     style: context.theme.textTheme.labelSmall?.copyWith(color: scheme.onSurfaceVariant),
                    //   ),
                  ],
                ),
                // if ((qot.name ?? '').trim().isNotEmpty) ...[
                //   SizedBox(height: 4.h),
                //   Text(
                //     qot.name!.trim(),
                //     style: context.theme.textTheme.labelSmall?.copyWith(color: scheme.onSurfaceVariant),
                //   ),
                // ],
                verticalMarginMedium,
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(right: 2.w),
                    child: Column(
                      children: lines.map((line) {
                        final qty = line.quantity ?? 0;
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 6.h),
                                child: Container(
                                  width: 6.w,
                                  height: 6.w,
                                  decoration: BoxDecoration(
                                    color: context.theme.colorScheme.success,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(
                                  '${line.item ?? ''} (${_qtyLabel(qty)})',
                                  style: context.theme.textTheme.labelSmall?.copyWith(height: 1.35),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text(
                      'Dishes: ${lines.length}',
                      style: context.theme.textTheme.labelSmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '$currencySymbol ${total.toStringAsFixed(2)}',
                      style: context.theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
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
}

Future<void> _showKotPrintPreviewSheet(
  BuildContext context, {
  required OrderModel order,
  required OrderQotModel qot,
  required int cardIndex,
}) async {
  final cubit = context.read<OrderDetailCubit>();
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (sheetCtx) => BlocProvider<OrderDetailCubit>.value(
      value: cubit,
      child: _KotPrintPreviewSheet(
        order: order,
        qot: qot,
        cardIndex: cardIndex,
      ),
    ),
  );
}

class _KotPrintPreviewSheet extends StatefulWidget {
  const _KotPrintPreviewSheet({
    required this.order,
    required this.qot,
    required this.cardIndex,
  });

  final OrderModel order;
  final OrderQotModel qot;
  final int cardIndex;

  @override
  State<_KotPrintPreviewSheet> createState() => _KotPrintPreviewSheetState();
}

class _KotPrintPreviewSheetState extends State<_KotPrintPreviewSheet> {
  static const List<String> _statusChoices = [
    'Created',
    'Accepted',
    'Processing',
    'Completed',
    'Cancelled',
  ];
  late String _selectedStatus;
  bool _statusUpdating = false;
  bool _printingKot = false;
  bool _assigningKitchenStaff = false;

  /// After a successful `PATCH .../qots/.../`, local mirror until the sheet is closed.
  String? _localAssignedTo;

  @override
  void initState() {
    super.initState();
    final raw = (widget.qot.qotStatus ?? widget.order.orderStatus ?? '').trim();
    _selectedStatus = _statusChoices.contains(raw) ? raw : 'Created';
  }

  String _qotNumberLine() {
    final n = widget.qot.qotNo;
    if (n != null) return 'KOT #$n';
    return 'KOT #${widget.cardIndex + 1}';
  }

  String _staffLabel() {
    final e = (_localAssignedTo ?? widget.qot.assignedTo ?? widget.order.assignedEmployee)?.trim() ?? '';
    if (e.isEmpty) return widget.order.createdBy?.trim() ?? '-';
    final at = e.indexOf('@');
    if (at > 0) return e.substring(0, at);
    return e;
  }

  String _qtyLabel(double? q) {
    if (q == null) return '0';
    if (q == q.roundToDouble()) return '${q.round()}';
    return q.toStringAsFixed(1);
  }

  Future<void> _openAssignKitchenStaff() async {
    if (_assigningKitchenStaff) return;
    final qotName = (widget.qot.name ?? '').trim();
    if (qotName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('QOT id missing; cannot assign staff')),
      );
      return;
    }
    final current = (_localAssignedTo ?? widget.qot.assignedTo ?? widget.order.assignedEmployee ?? '').trim();
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: false,
      builder: (_) => BlocProvider(
        create: (_) => getIt<EmployeeCubit>()..getEmployees(employmentStatus: 'ACTIVE'),
        child: _KitchenEmployeePickSheet(initialSelection: current.isNotEmpty ? current : null),
      ),
    );
    if (selected == null || !mounted) return;
    final trimmed = selected.trim();
    setState(() => _assigningKitchenStaff = true);
    final message = await context.read<OrderDetailCubit>().updateQotFields(
          qotName: qotName,
          assignedTo: trimmed,
          forOrderName: widget.order.name,
        );
    if (!mounted) return;
    setState(() => _assigningKitchenStaff = false);
    if (message != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      return;
    }
    setState(() => _localAssignedTo = trimmed);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Kitchen staff updated')),
    );
  }

  Future<void> _openTicketStatusPicker() async {
    if (_statusUpdating) return;
    await showQotStatusPickerSheet(
      context,
      statuses: _statusChoices,
      selected: _selectedStatus,
      onSelected: (s) => _onStatusChanged(s),
    );
  }

  Future<void> _onStatusChanged(String nextStatus) async {
    if (_statusUpdating || nextStatus == _selectedStatus) return;
    final previous = _selectedStatus;
    setState(() {
      _selectedStatus = nextStatus;
      _statusUpdating = true;
    });
    final qotName = (widget.qot.name ?? '').trim();
    if (qotName.isEmpty) {
      if (!mounted) return;
      setState(() {
        _selectedStatus = previous;
        _statusUpdating = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('QOT id missing; cannot update status')),
      );
      return;
    }

    final message = await context.read<OrderDetailCubit>().updateQotStatus(
          qotName: qotName,
          qotStatus: nextStatus,
          forOrderName: widget.order.name,
        );
    if (!mounted) return;
    setState(() => _statusUpdating = false);
    if (message != null) {
      setState(() => _selectedStatus = previous);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Future<void> _printKot() async {
    if (_printingKot) return;
    final qot = widget.qot;
    final order = widget.order;
    final merged = mergeOrderItemsByProductName(qot.items ?? const []);
    final orderTime = formatOrderTimestamp(order.created ?? order.date) ?? (order.created ?? order.date ?? '-');
    final printTime = formatOrderTimestamp(DateTime.now().toIso8601String()) ?? '-';
    final qotNo = qot.qotNo ?? (widget.cardIndex + 1);
    final rawTable = order.tableNumber?.trim();
    final table = (rawTable == null || rawTable.isEmpty) ? '-' : rawTable;

    setState(() => _printingKot = true);
    try {
      final bytes = buildKotEscPosBytes(
        kotNumber: qotNo,
        orderTypeLabel: orderTypeLabel(order.orderType),
        tableLabel: table,
        orderBy: _staffLabel(),
        orderAt: orderTime,
        status: _selectedStatus,
        mergedLines: merged,
        printedBy: _staffLabel(),
        printedAt: printTime,
      );
      await sendEscPosToSocket(bytes);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('KOT sent to printer')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$e'),
          duration: const Duration(seconds: 10),
        ),
      );
    } finally {
      if (mounted) setState(() => _printingKot = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.theme.colorScheme;
    final merged = mergeOrderItemsByProductName(widget.qot.items ?? const []);
    final orderAt = formatOrderTimestamp(widget.order.created ?? widget.order.date) ??
        (widget.order.created ?? widget.order.date ?? '-');
    final printAt = formatOrderTimestamp(DateTime.now().toIso8601String()) ?? '-';
    final totalQty = merged.fold<double>(0, (a, b) => a + (b.quantity ?? 0));

    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.94),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26.r)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 56.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: scheme.outlineVariant.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F8FC),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Move action coming soon')),
                          );
                        },
                        icon: Icon(Icons.redo_rounded, size: 18),
                        label: Text('Move'),
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF243247),
                          minimumSize: Size.fromHeight(44.h),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    flex: 2,
                    child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      child: InkWell(
                        onTap: _statusUpdating ? null : _openTicketStatusPicker,
                        borderRadius: BorderRadius.circular(10.r),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                            filled: true,
                            fillColor: Colors.white,
                            isDense: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.85)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(color: scheme.primary, width: 1.2),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            suffixIcon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: scheme.onSurfaceVariant,
                              size: 22.sp,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _selectedStatus,
                              key: ValueKey('kot_status_label_${widget.qot.name}_$_selectedStatus'),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.theme.textTheme.titleMedium?.copyWith(
                                color: const Color(0xFFF9A825),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFE8EAF0)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: Text(
                              _qotNumberLine(),
                              style: context.theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                          verticalMarginLarge,
                          Row(
                            children: [
                              Expanded(child: Text('Type: ${orderTypeLabel(widget.order.orderType)}')),
                              Expanded(
                                child: Text(
                                  'Table: ${(widget.order.tableNumber ?? '-').trim().isEmpty ? '-' : widget.order.tableNumber!}',
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                          verticalMarginXSmall,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: Text('Order By: ${_staffLabel()}')),
                              TextButton(
                                onPressed: _assigningKitchenStaff ? null : _openAssignKitchenStaff,
                                child: Text(_assigningKitchenStaff ? '…' : 'Assign'),
                              ),
                            ],
                          ),
                          verticalMarginXSmall,
                          Text('Order At: $orderAt'),
                          verticalMarginMedium,
                          Divider(color: const Color(0xFFECEEF3), height: 12.h),
                          verticalMarginSmall,
                          Row(
                            children: [
                              SizedBox(
                                width: 24.w,
                                child: Text('S.N', style: AppFonts.interStyle(fontWeight: FontWeight.w600)),
                              ),
                              Expanded(
                                child: Text('Dishes', style: AppFonts.interStyle(fontWeight: FontWeight.w600)),
                              ),
                              SizedBox(
                                width: 50.w,
                                child: Text(
                                  'QTY',
                                  textAlign: TextAlign.end,
                                  style: AppFonts.interStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          verticalMarginSmall,
                          Divider(color: const Color(0xFFECEEF3), height: 16.h),
                          verticalMarginSmall,
                          ...List.generate(merged.length, (i) {
                            final line = merged[i];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: 24.w, child: Text('${i + 1}.')),
                                  Expanded(child: Text(line.item ?? '-')),
                                  SizedBox(
                                    width: 50.w,
                                    child: Text(
                                      _qtyLabel(line.quantity),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          verticalMarginSmall,
                          Divider(color: const Color(0xFFECEEF3), height: 16.h),
                          verticalMarginSmall,
                          Row(
                            children: [
                              Text('Total (Dishes/QTY)', style: AppFonts.interStyle(fontWeight: FontWeight.w600)),
                              const Spacer(),
                              Text('${merged.length}/${_qtyLabel(totalQty)}',
                                  style: AppFonts.interStyle(fontWeight: FontWeight.w600)),
                            ],
                          ),
                          verticalMarginSmall,
                          Divider(color: const Color(0xFFECEEF3), height: 16.h),
                          Text('Printed By: ${_staffLabel()}'),
                          verticalMarginXSmall,
                          Text('Printed At: $printAt'),
                          verticalMarginLarge,
                          Text(
                            'Thank You!',
                            textAlign: TextAlign.center,
                            style: context.theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'Actions',
                style: context.theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F8FC),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton.icon(
                        onPressed: (_printingKot || _statusUpdating) ? null : _printKot,
                        icon: _printingKot
                            ? SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: scheme.primary,
                                ),
                              )
                            : Icon(Icons.print_outlined),
                        label: Text(_printingKot ? 'Printing…' : 'Print KOT'),
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF243247),
                          minimumSize: Size.fromHeight(48.h),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  SizedBox(
                    width: 64.w,
                    height: 48.h,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.9)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Icon(Icons.keyboard_arrow_up_rounded),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivityTab extends StatelessWidget {
  const _ActivityTab({
    required this.order,
    required this.activities,
    required this.isLoading,
    required this.errorMessage,
  });

  final OrderModel order;
  final List<OrderActivityEntry> activities;
  final bool isLoading;
  final String? errorMessage;

  String _titleForAction(String? action) {
    switch (action) {
      case 'item_cancelled':
        return 'Item cancelled';
      case 'item_updated':
        return 'Item updated';
      case 'item_status_changed':
        return 'Item status changed';
      case 'order_created':
        return 'Order created';
      case 'order_status_changed':
        return 'Order status changed';
      default:
        final v = action?.trim();
        if (v == null || v.isEmpty) return 'Activity';
        return v.replaceAll('_', ' ');
    }
  }

  IconData _iconForAction(String? action) {
    switch (action) {
      case 'item_cancelled':
        return Icons.cancel_outlined;
      case 'item_updated':
        return Icons.edit_note_rounded;
      case 'item_status_changed':
        return Icons.sync_alt_rounded;
      case 'order_created':
        return Icons.add_circle_outline_rounded;
      case 'order_status_changed':
        return Icons.track_changes_rounded;
      default:
        return Icons.history_rounded;
    }
  }

  Color _colorForAction(BuildContext context, String? action) {
    final scheme = context.theme.colorScheme;
    switch (action) {
      case 'item_cancelled':
        return scheme.error;
      case 'item_updated':
        return const Color(0xFF1565C0);
      case 'item_status_changed':
      case 'order_status_changed':
        return const Color(0xFF7B1FA2);
      case 'order_created':
        return scheme.primary;
      default:
        return scheme.tertiary;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading && activities.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    final scheme = context.theme.colorScheme;
    return ListView(
      padding: EdgeInsets.all(16.w),
      children: [
        Text(
          'Activity',
          style: context.theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 8.h),
        if (errorMessage != null && activities.isEmpty)
          Card(
            elevation: 0,
            color: scheme.errorContainer.withValues(alpha: 0.25),
            child: ListTile(
              leading: Icon(Icons.error_outline, color: scheme.error),
              title: Text(errorMessage!),
            ),
          )
        else if (activities.isEmpty)
          Card(
            elevation: 0,
            child: const ListTile(
              leading: Icon(Icons.history_toggle_off),
              title: Text('No activity yet'),
            ),
          )
        else
          ...activities.map(
            (entry) {
              final actionTitle = _titleForAction(entry.action);
              final actionColor = _colorForAction(context, entry.action);
              final details = [
                if ((entry.field ?? '').trim().isNotEmpty)
                  '${entry.oldValue ?? '—'} → ${entry.newValue ?? '—'}, ${formatOrderTimestamp(entry.timestamp) ?? entry.timestamp!} ',
                if ((entry.performedBy ?? '').trim().isNotEmpty) 'By ${entry.performedBy}',
                // if ((entry.timestamp ?? '').trim().isNotEmpty)
                //   formatOrderTimestamp(entry.timestamp) ?? entry.timestamp!,
              ];
              return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Card(
                  elevation: 0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.5)),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      if (details.isEmpty) return;
                      showModalBottomSheet<void>(
                        context: context,
                        showDragHandle: true,
                        builder: (ctx) => SafeArea(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 20.h),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  actionTitle,
                                  style: Theme.of(ctx).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 10.h),
                                ...details.map(
                                  (line) => Padding(
                                    padding: EdgeInsets.only(bottom: 6.h),
                                    child: Text(
                                      line,
                                      style: Theme.of(ctx).textTheme.bodyMedium,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 34.w,
                            height: 34.w,
                            decoration: BoxDecoration(
                              color: actionColor.withValues(alpha: 0.12),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(_iconForAction(entry.action), size: 18.sp, color: actionColor),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        actionTitle,
                                        style:
                                            context.theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                ...details.take(2).map(
                                      (line) => Padding(
                                        padding: EdgeInsets.only(bottom: 2.h),
                                        child: Text(
                                          line,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: context.theme.textTheme.bodySmall?.copyWith(
                                            color: scheme.onSurfaceVariant,
                                          ),
                                        ),
                                      ),
                                    ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}

class _CheckoutFooter extends StatelessWidget {
  const _CheckoutFooter({required this.order, required this.accent});

  final OrderModel order;
  final Color accent;

  void _openCheckoutSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: false,
      builder: (_) => BlocProvider(
        create: (_) => getIt<PaymentMethodsCubit>()..load(),
        child: _OrderCheckoutSheet(
          order: order,
          accent: accent,
          onConfirmCheckout: (params) => context.read<OrderDetailCubit>().checkout(params),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = order.displayTotal;

    return Material(
      elevation: 8,
      color: context.theme.colorScheme.surface,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text('Total', style: context.theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                const Spacer(),
                Text(
                  '$currencySymbol ${total.toStringAsFixed(2)}',
                  style: context.theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            BlocBuilder<OrderDetailCubit, OrderDetailState>(
              buildWhen: (p, c) {
                bool checkout(OrderDetailState s) => s.maybeWhen(
                      loaded: (_, loading, __, ___, ____, _____, ______) => loading,
                      orElse: () => false,
                    );
                return checkout(p) != checkout(c);
              },
              builder: (context, state) {
                final checkoutBusy = state.maybeWhen(
                  loaded: (_, loading, __, ___, ____, _____, ______) => loading,
                  orElse: () => false,
                );
                return CustomButtonWidget(
                  width: double.infinity,
                  title: 'Check Out',
                  onPressed:
                      checkoutBusy || order.orderStatus == 'Completed' ? null : () => _openCheckoutSheet(context),
                  backgroundColor: accent,
                  titleColor: Colors.white,
                  borderRadius: 10,
                  height: 48,
                  loading: checkoutBusy,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderCheckoutSheet extends StatefulWidget {
  const _OrderCheckoutSheet({
    required this.order,
    required this.accent,
    required this.onConfirmCheckout,
  });

  final OrderModel order;
  final Color accent;
  final void Function(OrderCheckoutRequestParams params) onConfirmCheckout;

  @override
  State<_OrderCheckoutSheet> createState() => _OrderCheckoutSheetState();
}

class _OrderCheckoutSheetState extends State<_OrderCheckoutSheet> {
  bool _showInfo = true;
  final ValueNotifier<bool> _isPaidNotifier = ValueNotifier<bool>(true);
  bool _multiplePayment = false;

  /// Non-zero amounts per method after confirming partial payment.
  Map<String, double> _multiplePaymentAmounts = {};
  String? _assignedUser;
  int? _assignedPartyId;
  bool _billingPickIsEmployee = false;
  String _selectedMethod = 'Cash';
  double _discountAmount = 0;
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _tenderAmountController = TextEditingController();

  @override
  void dispose() {
    _isPaidNotifier.dispose();
    _remarksController.dispose();
    _tenderAmountController.dispose();
    super.dispose();
  }

  List<OrderItemModel> get _items => widget.order.mergedOrderLinesByProduct;

  double get _subTotal => widget.order.displayTotal;

  /// Effective discount % from entered amount vs subtotal (for bill summary label).
  String _discountPercentDisplay() {
    if (_subTotal <= 0 || _discountAmount <= 0) return '0';
    final p = (_discountAmount / _subTotal) * 100;
    if ((p - p.round()).abs() < 0.05) return '${p.round()}';
    return p.toStringAsFixed(1);
  }

  String _qtyLabel(double? q) {
    if (q == null) return '0';
    if (q == q.roundToDouble()) return '${q.round()}';
    return q.toStringAsFixed(1);
  }

  OrderCheckoutRequestParams _buildCheckoutRequest() {
    final orderKey = (widget.order.name ?? '').trim();
    final email = context.employeeData?.email?.trim();
    final modifiedBy = (email != null && email.isNotEmpty) ? email : null;
    final partyName = _assignedUser?.trim().isNotEmpty == true ? _assignedUser!.trim() : null;
    final paid = _isPaidNotifier.value;

    OrderCheckoutPaymentLine? single;
    List<OrderCheckoutPaymentLine>? multi;
    if (paid) {
      if (_multiplePayment) {
        final lines = _multiplePaymentAmounts.entries
            .where((e) => e.value > 0)
            .map(
              (e) => OrderCheckoutPaymentLine(
                amount: e.value,
                paymentMethod: _checkoutPaymentMethodForApi(e.key),
              ),
            )
            .toList();
        multi = lines.isEmpty ? null : lines;
      } else {
        final t = double.tryParse(_tenderAmountController.text.trim()) ?? 0;
        single = OrderCheckoutPaymentLine(
          amount: t,
          paymentMethod: _checkoutPaymentMethodForApi(_selectedMethod),
        );
      }
    }

    return OrderCheckoutRequestParams(
      orderName: orderKey,
      party: _assignedPartyId == null ? partyName : null,
      partyId: _assignedPartyId,
      modifiedBy: modifiedBy,
      paymentMode: paid,
      discountAmount: _discountAmount > 0 ? _discountAmount : null,
      paymentSingle: single,
      paymentMultiple: multi,
    );
  }

  void _confirmCheckout() {
    final orderKey = (widget.order.name ?? '').trim();
    if (orderKey.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order id missing')),
      );
      return;
    }
    final totalAfterDiscount = (_subTotal - _discountAmount).clamp(0, double.infinity).toDouble();
    if (_isPaidNotifier.value &&
        _multiplePayment &&
        _multiplePaymentSum > totalAfterDiscount + 1e-6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment amounts cannot exceed the bill total')),
      );
      return;
    }
    if (_isPaidNotifier.value && !_multiplePayment) {
      final tenderRaw = _tenderAmountController.text.trim();
      if (tenderRaw.isNotEmpty) {
        final tender = double.tryParse(tenderRaw);
        if (tender != null && tender > totalAfterDiscount + 1e-6) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Tender amount cannot exceed the bill total')),
          );
          return;
        }
      }
    }
    final params = _buildCheckoutRequest();
    Navigator.of(context).pop();
    widget.onConfirmCheckout(params);
  }

  Future<void> _openAssignUserSheet() async {
    final selected = await showModalBottomSheet<_CheckoutBillingPickResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: false,
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<PartyCubit>()),
          BlocProvider(
            create: (_) => getIt<EmployeeCubit>()..getEmployees(employmentStatus: 'ACTIVE'),
          ),
        ],
        child: _CheckoutBillingAssignSheet(
          initialSelection: _assignedUser,
          initialPartyId: _assignedPartyId,
          initialPickIsEmployee: _billingPickIsEmployee,
        ),
      ),
    );
    if (selected != null && selected.label.trim().isNotEmpty) {
      setState(() {
        _assignedUser = selected.label.trim();
        _assignedPartyId = selected.partyId;
        _billingPickIsEmployee = selected.isEmployee;
      });
    }
  }

  Future<void> _openDiscountSheet() async {
    final next = await EditDiscountSheet.show(
      context,
      subTotal: _subTotal,
      initialDiscountAmount: _discountAmount,
    );
    if (next != null) {
      setState(() => _discountAmount = next);
    }
  }

  Future<void> _openItemsSheet() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: false,
      builder: (_) => _CheckoutItemsSheet(
        items: _items,
        qtyLabel: _qtyLabel,
      ),
    );
  }

  Future<void> _openRemarksSheet() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: false,
      builder: (_) => _RemarksSheet(controller: _remarksController),
    );
    if (mounted) setState(() {});
  }

  double get _multiplePaymentSum => _multiplePaymentAmounts.values.fold<double>(0, (a, b) => a + b);

  Future<Map<String, double>?> _openPartialPaymentPage({Map<String, double>? initial}) {
    final total = (_subTotal - _discountAmount).clamp(0, double.infinity).toDouble();
    // Same cubit as checkout sheet (already ..load() when sheet opens).
    final pmCubit = context.read<PaymentMethodsCubit>();
    return Navigator.of(context).push<Map<String, double>?>(
      MaterialPageRoute<Map<String, double>?>(
        builder: (_) => BlocProvider<PaymentMethodsCubit>.value(
          value: pmCubit,
          child: PartialPaymentPreviewPage(
            total: total,
            accent: widget.accent,
            initialAmounts: initial,
            paymentMethodNames: null,
          ),
        ),
      ),
    );
  }

  String _estimatePaymentSummary(double totalAfterDiscount) {
    if (!_isPaidNotifier.value) return 'Unpaid / Credit ($currencySymbol ${totalAfterDiscount.toStringAsFixed(1)})';
    if (_multiplePayment && _multiplePaymentSum > 0) {
      return 'Multiple ($currencySymbol ${_multiplePaymentSum.toStringAsFixed(1)})';
    }
    return '${_selectedMethod} ($currencySymbol ${totalAfterDiscount.toStringAsFixed(1)})';
  }

  void _openEstimateInvoice() {
    final totalAfterDiscount = (_subTotal - _discountAmount).clamp(0, double.infinity).toDouble();
    final orderLabel = (widget.order.tableNumber ?? '').trim().isNotEmpty
        ? widget.order.tableNumber!.trim()
        : ((widget.order.party ?? '').trim().isNotEmpty ? widget.order.party!.trim() : 'Table');
    final tableLabel = (widget.order.tableNumber ?? '').trim().isNotEmpty
        ? widget.order.tableNumber!.trim()
        : ((widget.order.party ?? '').trim().isNotEmpty ? widget.order.party!.trim() : '—');
    final party = (widget.order.party ?? '').trim();
    final customerLabel = party.isEmpty ? 'Cash Customer' : party;

    final lines = widget.order.mergedOrderLinesByProduct.map((line) {
      final q = line.quantity ?? 0.0;
      final a = line.amount ?? 0.0;
      final rate = q > 0 ? a / q : a;
      return EstimateInvoiceLine(
        particular: (line.item ?? line.name ?? '—').trim(),
        rate: rate,
        quantity: q,
        amount: a,
      );
    }).toList();

    final rawBase = (widget.order.tableNumber ?? widget.order.party ?? widget.order.name ?? 'estimate_invoice').trim();
    final cleanedBase = rawBase.replaceAll(RegExp(r'[^a-zA-Z0-9_-]+'), '_');
    final fileBaseName = cleanedBase.isEmpty ? 'estimate_invoice' : cleanedBase;

    final payRows = <EstimateInvoicePaymentRow>[];
    double? payPaid;
    double? payOut;
    final estimatePayDateText = formatEstimateInvoiceDateFromRaw(widget.order.date);
    if (!_isPaidNotifier.value) {
      payOut = totalAfterDiscount;
    } else if (_multiplePayment && _multiplePaymentAmounts.isNotEmpty) {
      for (final e in _multiplePaymentAmounts.entries) {
        if (e.value > 1e-6) {
          payRows.add(EstimateInvoicePaymentRow(
            label: e.key,
            amount: e.value,
            dateText: estimatePayDateText,
          ));
        }
      }
      payPaid = _multiplePaymentSum;
      final left = (totalAfterDiscount - _multiplePaymentSum).clamp(0.0, double.infinity);
      if (left > 1e-6) payOut = left;
    } else {
      final tender = double.tryParse(_tenderAmountController.text.trim()) ?? 0.0;
      final t = tender > 1e-6 ? tender : totalAfterDiscount;
      payRows.add(EstimateInvoicePaymentRow(
        label: _selectedMethod,
        amount: t,
        dateText: estimatePayDateText,
      ));
      payPaid = t;
      final left = (totalAfterDiscount - t).clamp(0.0, double.infinity);
      if (left > 1e-6) payOut = left;
    }
    final paymentRows = payRows.isEmpty ? null : payRows;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (ctx) => EstimateInvoiceSheet(
        data: EstimateInvoiceViewData(
          titleSuffix: '$orderLabel - Checkout',
          invoiceNumber: widget.order.name ?? '##',
          invoiceDateText: formatEstimateInvoiceDateFromRaw(widget.order.date),
          headerLine: 'Dine In: Table $tableLabel',
          customerLabel: customerLabel,
          lines: lines,
          subTotal: _subTotal,
          discountAmount: _discountAmount,
          totalAfterDiscount: totalAfterDiscount,
          paymentSummary: _estimatePaymentSummary(totalAfterDiscount),
          kotLine: _kotNumbersLine(widget.order),
          billedBy: context.loggedInUserFullName,
          fileBaseName: fileBaseName,
          paymentRows: paymentRows,
          paymentPaidTotal: payPaid,
          paymentOutstanding: payOut,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.theme.colorScheme;
    final orderLabel = (widget.order.tableNumber ?? '').trim().isNotEmpty
        ? widget.order.tableNumber!.trim()
        : ((widget.order.party ?? '').trim().isNotEmpty ? widget.order.party!.trim() : 'Table');
    final totalAfterDiscount = (_subTotal - _discountAmount).clamp(0, double.infinity).toDouble();
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.96),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F8),
        borderRadius: BorderRadius.vertical(top: Radius.circular(26.r)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            SizedBox(height: 8.h),
            Container(
              width: 56.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: scheme.outlineVariant.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 6.h),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios_new_rounded),
                    visualDensity: VisualDensity.compact,
                  ),
                  Expanded(
                    child: Text(
                      '$orderLabel - Checkout',
                      style: context.theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: _openEstimateInvoice,
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(92.w, 40.h),
                      side: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.9)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                    ),
                    child: Text('Estimate'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _CheckoutCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Billing party', style: context.theme.textTheme.labelLarge),
                          SizedBox(height: 10.h),
                          CustomTextFormField(
                            readOnly: true,
                            hint: _assignedUser == null
                                ? 'Customer, room, table, or employee'
                                : _assignedUser!,
                            suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                            onTap: _openAssignUserSheet,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    _CheckoutCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Bill Summary',
                                  style: context.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700)),
                              const Spacer(),
                              TextButton(
                                onPressed: _openItemsSheet,
                                child: Text(
                                  'View Items',
                                  style: context.theme.textTheme.labelMedium?.copyWith(
                                      color: context.theme.colorScheme.primary, decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          ),
                          if (_showInfo) ...[
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF2EEFF),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.lightbulb_outline_rounded,
                                      color: context.theme.colorScheme.primary, size: 18.sp),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                      child: Text(
                                    'Tap to know more detailed calculation.',
                                    style: context.theme.textTheme.labelMedium,
                                  )),
                                  InkWell(
                                    onTap: () => setState(() => _showInfo = false),
                                    child: Icon(Icons.close_rounded, size: 18),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                          ],
                          _summaryLine(context, 'Item Total', _subTotal),
                          // Loyalty temporarily disabled — restore with LoyaltyFeatures.enabled.
                          // _summaryLine(context, 'Loyalty Discount', 0),
                          _summaryLine(context, 'Sub Total', _subTotal, isBold: true),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    horizontalMarginSmall,
                                    Text(
                                      '- Discount (${_discountPercentDisplay()}%)',
                                      style: context.theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: _openDiscountSheet,
                                style: TextButton.styleFrom(
                                  minimumSize: Size(0, 30.h),
                                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                ),
                                child: Text(
                                  'Tap to Edit',
                                  style: context.theme.textTheme.labelMedium?.copyWith(
                                      color: context.theme.colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text('$currencySymbol ${_discountAmount.toStringAsFixed(1)}'),
                            ],
                          ),
                          _summaryLine(context, 'Total Amount', totalAfterDiscount, isBold: true),
                          ValueListenableBuilder<bool>(
                            valueListenable: _isPaidNotifier,
                            builder: (context, isPaid, _) {
                              final tender =
                                  double.tryParse(_tenderAmountController.text.trim()) ?? 0.0;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(height: 8.h),
                                  _checkoutSummaryTextLine(
                                    context,
                                    'Payment status',
                                    isPaid ? 'Paid' : 'Unpaid / Credit',
                                  ),
                                  if (isPaid) ...[
                                    if (_multiplePayment && _multiplePaymentSum > 0)
                                      _checkoutSummaryTextLine(
                                        context,
                                        'Payment methods',
                                        _multiplePaymentAmounts.entries
                                            .where((e) => e.value > 0)
                                            .map((e) => '${e.key}: $currencySymbol ${e.value.toStringAsFixed(1)}')
                                            .join(' · '),
                                      )
                                    else if (!_multiplePayment) ...[
                                      _checkoutSummaryTextLine(
                                        context,
                                        'Payment method',
                                        _selectedMethod,
                                      ),
                                      if (tender > 0)
                                        _summaryLine(context, 'Tender amount', tender),
                                    ],
                                  ],
                                ],
                              );
                            },
                          ),
                          SizedBox(height: 8.h),
                          OutlinedButton.icon(
                            onPressed: _openRemarksSheet,
                            icon: Icon(
                              Icons.note_alt_outlined,
                              size: context.theme.appTheme.spacing16,
                            ),
                            label: Text(
                              _remarksController.text.trim().isEmpty ? 'Add remarks to Bill' : 'Edit remarks',
                              style: context.theme.textTheme.labelMedium
                                  ?.copyWith(color: context.theme.colorScheme.primary),
                            ),
                            style: OutlinedButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              side: const BorderSide(color: Color(0xFFE5E7EB)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    _CheckoutCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Payment Mode *', style: context.theme.textTheme.labelLarge),
                          SizedBox(height: 10.h),
                          ValueListenableBuilder<bool>(
                            valueListenable: _isPaidNotifier,
                            builder: (context, isPaid, _) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: isPaid
                                            ? CustomButtonWidget(
                                                height: 42,
                                                borderRadius: 6.sp,
                                                onPressed: () => _isPaidNotifier.value = true,
                                                title: 'Paid',
                                              )
                                            : CustomButtonWidget.outlined(
                                                height: 42,
                                                borderRadius: 6.sp,
                                                onPressed: () => _isPaidNotifier.value = true,
                                                title: 'Paid',
                                              ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Expanded(
                                        child: isPaid
                                            ? CustomButtonWidget.outlined(
                                                height: 42,
                                                borderRadius: 6.sp,
                                                onPressed: () {
                                                  _multiplePayment = false;
                                                  _multiplePaymentAmounts = {};
                                                  _isPaidNotifier.value = false;
                                                },
                                                title: 'Unpaid / Credit',
                                              )
                                            : CustomButtonWidget(
                                                height: 42,
                                                borderRadius: 6.sp,
                                                onPressed: () {
                                                  _multiplePayment = false;
                                                  _multiplePaymentAmounts = {};
                                                  _isPaidNotifier.value = false;
                                                },
                                                title: 'Unpaid / Credit',
                                              ),
                                      ),
                                    ],
                                  ),
                                  if (isPaid) ...[
                                    SizedBox(height: 12.h),
                                    if (!_multiplePayment) ...[
                                      BlocBuilder<PaymentMethodsCubit, PaymentMethodsState>(
                                        builder: (context, pmState) {
                                          final api = pmState.paymentMethodNames();
                                          final chips =
                                              api.isNotEmpty ? api : const ['Cash', 'Transfer'];
                                          return Wrap(
                                            spacing: 8.w,
                                            runSpacing: 8.h,
                                            children: [
                                              for (final m in chips)
                                                _PaymentMethodChip(
                                                  label: m,
                                                  selected: _selectedMethod == m,
                                                  onTap: () => setState(() => _selectedMethod = m),
                                                ),
                                            ],
                                          );
                                        },
                                      ),
                                      SizedBox(height: 14.h),
                                    ],
                                    Row(
                                      children: [
                                        Text('Multiple Payment', style: context.theme.textTheme.labelLarge),
                                        SizedBox(width: 8.w),
                                        Icon(Icons.help_outline_rounded, size: 16),
                                        const Spacer(),
                                        if (_multiplePayment)
                                          IconButton(
                                            onPressed: () async {
                                              final data = await _openPartialPaymentPage(
                                                initial: _multiplePaymentAmounts,
                                              );
                                              if (!mounted || data == null) return;
                                              setState(() => _multiplePaymentAmounts = data);
                                            },
                                            icon: Icon(Icons.edit_outlined, size: 20.sp, color: widget.accent),
                                            visualDensity: VisualDensity.compact,
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(minWidth: 36.w, minHeight: 36.h),
                                          ),
                                        Transform.scale(
                                          scale: 0.7,
                                          alignment: Alignment.centerRight,
                                          child: Switch.adaptive(
                                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            value: _multiplePayment,
                                            onChanged: (v) async {
                                              if (!v) {
                                                if (mounted) {
                                                  setState(() {
                                                    _multiplePayment = false;
                                                    _multiplePaymentAmounts = {};
                                                  });
                                                }
                                                return;
                                              }
                                              if (mounted) setState(() => _multiplePayment = true);
                                              final data = await _openPartialPaymentPage(
                                                initial: _multiplePaymentAmounts,
                                              );
                                              if (!mounted) return;
                                              if (data == null) {
                                                setState(() {
                                                  _multiplePayment = false;
                                                  _multiplePaymentAmounts = {};
                                                });
                                              } else {
                                                setState(() => _multiplePaymentAmounts = data);
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF2EEFF),
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                      child: Text(
                                          'Turn this ON, if customer pay via Multiple payment mode or make Partial payments.',
                                          style: context.theme.textTheme.labelMedium),
                                    ),
                                    if (_multiplePayment && _multiplePaymentSum > 0) ...[
                                      SizedBox(height: 12.h),
                                      ..._multiplePaymentAmounts.entries.map((e) {
                                        final m = e.key;
                                        final a = e.value;
                                        if (a <= 0) return const SizedBox.shrink();
                                        return Padding(
                                          padding: EdgeInsets.symmetric(vertical: 6.h),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(m, style: context.theme.textTheme.labelLarge),
                                              ),
                                              Text(
                                                '$currencySymbol ${a.toStringAsFixed(1)}',
                                                style: context.theme.textTheme.labelLarge,
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                      Padding(
                                        padding: EdgeInsets.only(top: 8.h),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Total',
                                                style: context.theme.textTheme.titleSmall
                                                    ?.copyWith(fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                            Text(
                                              '$currencySymbol ${_multiplePaymentSum.toStringAsFixed(1)}',
                                              style: context.theme.textTheme.titleSmall
                                                  ?.copyWith(fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ],
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: _isPaidNotifier,
                      builder: (context, isPaid, _) {
                        if (!isPaid || _multiplePayment) return const SizedBox.shrink();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 12.h),
                            _CheckoutCard(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Tender Amount', style: context.theme.textTheme.labelLarge),
                                  SizedBox(height: 10.h),
                                  CustomTextFormField(
                                    controller: _tenderAmountController,
                                    onChanged: (_) => setState(() {}),
                                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                    prefixIcon: Icon(Icons.currency_rupee),
                                    hint: '0.00',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 82.h),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 14.h),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFF1F2F5))),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Net Sales Amount', style: context.theme.textTheme.labelMedium),
                        Text(
                          '$currencySymbol ${totalAfterDiscount.toStringAsFixed(1)}',
                          style: context.theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  horizontalMarginLarge,
                  Expanded(
                    flex: 2,
                    child: ValueListenableBuilder<bool>(
                      valueListenable: _isPaidNotifier,
                      builder: (context, isPaid, _) {
                        final multiPayOk = !_multiplePayment ||
                            (_multiplePaymentSum > 0 &&
                                _multiplePaymentSum <= totalAfterDiscount + 1e-6);
                        final tenderEntered =
                            double.tryParse(_tenderAmountController.text.trim()) ?? 0.0;
                        final tenderWithinGrandTotal =
                            tenderEntered <= totalAfterDiscount + 1e-6;
                        final hasEnteredAmount = isPaid
                            ? (_multiplePayment
                                ? multiPayOk
                                : (tenderEntered > 1e-6 && tenderWithinGrandTotal))
                            : true;
                        return CustomButtonWidget(
                          width: double.infinity,
                          title: 'Confirm Checkout',
                          onPressed: hasEnteredAmount
                              ? () async {
                                  if (_isPaidNotifier.value && _multiplePayment) {
                                    if (_multiplePaymentSum <= 0) {
                                      final data = await _openPartialPaymentPage(
                                        initial: _multiplePaymentAmounts,
                                      );
                                      if (!mounted) return;
                                      if (data == null) return;
                                      final sum = data.values.fold<double>(0, (a, b) => a + b);
                                      if (sum <= 0) return;
                                      setState(() => _multiplePaymentAmounts = data);
                                    }
                                  }
                                  if (_isPaidNotifier.value && !_multiplePayment) {
                                    final tenderRaw = _tenderAmountController.text.trim();
                                    if (tenderRaw.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Please enter tender amount')),
                                      );
                                      return;
                                    }
                                    final tender = double.tryParse(tenderRaw);
                                    if (tender == null) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Enter a valid tender amount')),
                                      );
                                      return;
                                    }
                                    if (tender < 0) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Tender amount cannot be negative')),
                                      );
                                      return;
                                    }
                                    if (tender > totalAfterDiscount + 1e-6) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Tender amount cannot exceed the bill total'),
                                        ),
                                      );
                                      return;
                                    }
                                  }
                                  _confirmCheckout();
                                }
                              : null,
                          backgroundColor: widget.accent,
                          titleColor: Colors.white,
                          borderRadius: 10,
                          height: 50,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryLine(BuildContext context, String label, double value, {bool isBold = false}) {
    final style = (isBold ? context.theme.textTheme.titleSmall : context.theme.textTheme.labelLarge)
        ?.copyWith(fontWeight: isBold ? FontWeight.w600 : FontWeight.w600);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        children: [
          Expanded(child: Text(label, style: style)),
          Text('$currencySymbol ${value.toStringAsFixed(1)}', style: style),
        ],
      ),
    );
  }

  Widget _checkoutSummaryTextLine(BuildContext context, String label, String value) {
    final style = context.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(label, style: style)),
          Expanded(
            flex: 2,
            child: Text(value, style: style, textAlign: TextAlign.end),
          ),
        ],
      ),
    );
  }
}

class _CheckoutCard extends StatelessWidget {
  const _CheckoutCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFEDEFF4)),
      ),
      child: child,
    );
  }
}

class _PaymentMethodChip extends StatelessWidget {
  const _PaymentMethodChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFFFF2F2) : const Color(0xFFF7F8FA),
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(color: selected ? const Color(0xFFFFD5D5) : const Color(0xFFEDEFF4)),
        ),
        child: Text(
          label,
          style: context.theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

/// KOT kitchen assignee: prefers employee email, else full name (`assigned_to` free text).
class _KitchenEmployeePickSheet extends StatefulWidget {
  const _KitchenEmployeePickSheet({this.initialSelection});

  final String? initialSelection;

  @override
  State<_KitchenEmployeePickSheet> createState() => _KitchenEmployeePickSheetState();
}

class _KitchenEmployeePickSheetState extends State<_KitchenEmployeePickSheet> {
  String? _picked;

  @override
  void initState() {
    super.initState();
    _picked = widget.initialSelection;
  }

  String _assignValue(EmployeeModel e) {
    final em = (e.email ?? '').trim();
    if (em.isNotEmpty) return em;
    return e.fullName.trim();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height * 0.55;
    return SizedBox(
      height: h,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(26.r)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
            Padding(
              padding: EdgeInsets.fromLTRB(14.w, 8.h, 8.w, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Kitchen staff',
                      style: context.theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close_rounded),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<EmployeeCubit, EmployeeState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loaded: (res) {
                      final list = res.employees
                          .where((e) => e.department.trim().toLowerCase() == 'kitchen')
                          .toList();
                      if (list.isEmpty) {
                        return Center(
                          child: Text(
                            'No kitchen employees',
                            style: context.theme.textTheme.bodyLarge,
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        itemCount: list.length,
                        itemBuilder: (ctx, i) {
                          final e = list[i];
                          final v = _assignValue(e);
                          final selected =
                              _picked != null && _picked!.trim().toLowerCase() == v.trim().toLowerCase();
                          final email = (e.email ?? '').trim();
                          return ListTile(
                            title: Text(e.fullName),
                            subtitle: Text(email.isEmpty ? '—' : email),
                            onTap: () => setState(() => _picked = v),
                            trailing: selected ? Icon(Icons.check, color: Color(0xFFE53935)) : null,
                          );
                        },
                      );
                    },
                    error: (m) => Center(child: Text(m)),
                    orElse: () => Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 12.h),
              child: FilledButton(
                onPressed: _picked == null || _picked!.trim().isEmpty
                    ? null
                    : () => Navigator.pop(context, _picked!.trim()),
                style: FilledButton.styleFrom(
                  minimumSize: Size.fromHeight(46.h),
                  backgroundColor: const Color(0xFFE53935),
                ),
                child: Text('Save'),
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}

/// Result of [_CheckoutBillingAssignSheet] — [partyId] set for Customer/Room/Table when API provides `id`.
class _CheckoutBillingPickResult {
  const _CheckoutBillingPickResult({
    required this.label,
    this.partyId,
    required this.isEmployee,
  });

  final String label;
  final int? partyId;
  final bool isEmployee;
}

/// Checkout billing assignee: **Customer / Room / Table** use Party API `role` (`customer`, `room`, `cabin`);
/// **Employee** uses [EmployeeModel.fullName] (search also matches position / department).
class _CheckoutBillingAssignSheet extends StatefulWidget {
  const _CheckoutBillingAssignSheet({
    this.initialSelection,
    this.initialPartyId,
    this.initialPickIsEmployee = false,
  });

  final String? initialSelection;
  final int? initialPartyId;
  final bool initialPickIsEmployee;

  @override
  State<_CheckoutBillingAssignSheet> createState() => _CheckoutBillingAssignSheetState();
}

class _CheckoutBillingAssignSheetState extends State<_CheckoutBillingAssignSheet>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _search = TextEditingController();
  Timer? _debounce;
  String? _pickedLabel;
  int? _pickedPartyId;
  bool _pickIsEmployee = false;

  /// Party API query `role` (see [PartyRequestParams.toQueryParams]).
  String? _partyRoleForTab(int tab) {
    return switch (tab) {
      0 => 'customer',
      1 => 'room',
      2 => 'cabin',
      _ => null,
    };
  }

  @override
  void initState() {
    super.initState();
    _pickedLabel = widget.initialSelection;
    _pickedPartyId = widget.initialPartyId;
    _pickIsEmployee = widget.initialPickIsEmployee;
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_onTabChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _fetchPartiesForTab(_tabController.index);
    });
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    setState(() {});
    if (_tabController.index < 3) {
      _search.clear();
      _fetchPartiesForTab(_tabController.index);
    }
  }

  void _fetchPartiesForTab(int tab) {
    if (tab >= 3) return;
    final role = _partyRoleForTab(tab);
    if (role == null) return;
    final search = _search.text.trim().isEmpty ? null : _search.text.trim();
    context.read<PartyCubit>().getParties(
          params: PartyRequestParams(
            page: 1,
            perPage: 500,
            partyType: role,
            search: search,
            sortBy: 'name',
            sortOrder: 'asc',
          ),
        );
  }

  void _onSearchChanged(String _) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (!mounted) return;
      if (_tabController.index < 3) {
        _fetchPartiesForTab(_tabController.index);
      } else {
        setState(() {});
      }
    });
  }

  List<EmployeeModel> _filteredEmployees(List<EmployeeModel> all) {
    final q = _search.text.trim().toLowerCase();
    if (q.isEmpty) return all;
    return all.where((e) {
      return e.fullName.toLowerCase().contains(q) ||
          (e.email ?? '').toLowerCase().contains(q) ||
          e.position.toLowerCase().contains(q) ||
          e.department.toLowerCase().contains(q);
    }).toList();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26.r)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 12.h),
          child: Column(
            children: [
              Container(
                width: 56.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFD6D8DE),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Billing party',
                      style: context.theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close_rounded),
                  ),
                ],
              ),
              TabBar(
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                tabs: const [
                  Tab(text: 'Customer'),
                  Tab(text: 'Room'),
                  Tab(text: 'Table'),
                  Tab(text: 'Employee'),
                ],
              ),
              SizedBox(height: 10.h),
              TextField(
                controller: _search,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: AppSearchIcon.inputDecoration(),
                  filled: true,
                  fillColor: const Color(0xFFF8F9FB),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Expanded(
                child: _tabController.index == 3
                    ? BlocBuilder<EmployeeCubit, EmployeeState>(
                        builder: (context, empState) {
                          return empState.maybeWhen(
                            loaded: (res) {
                              final list = _filteredEmployees(res.employees);
                              if (list.isEmpty) {
                                return Center(
                                  child: Text(
                                    'No employees',
                                    style: context.theme.textTheme.bodyLarge,
                                  ),
                                );
                              }
                              return ListView.builder(
                                itemCount: list.length,
                                itemBuilder: (context, i) {
                                  final e = list[i];
                                  final name = e.fullName.trim();
                                  final sub = [
                                    if ((e.email ?? '').trim().isNotEmpty) (e.email ?? '').trim(),
                                    if (e.position.trim().isNotEmpty) e.position.trim(),
                                  ].join(' · ');
                                  final selected =
                                      _pickIsEmployee && name == (_pickedLabel ?? '');
                                  return InkWell(
                                    onTap: () => setState(() {
                                      _pickIsEmployee = true;
                                      _pickedPartyId = null;
                                      _pickedLabel = name;
                                    }),
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 8.h),
                                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12.r),
                                        border: Border.all(
                                          color:
                                              selected ? const Color(0xFFE53935) : const Color(0xFFEDEFF4),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 18.r,
                                            backgroundColor: const Color(0xFFF5F6F8),
                                            child: Text(
                                              name.isEmpty ? '?' : name.substring(0, 1).toUpperCase(),
                                              style: context.theme.textTheme.titleSmall,
                                            ),
                                          ),
                                          SizedBox(width: 10.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  name,
                                                  style: context.theme.textTheme.titleMedium
                                                      ?.copyWith(fontWeight: FontWeight.w600),
                                                ),
                                                if (sub.isNotEmpty)
                                                  Text(
                                                    sub,
                                                    style: context.theme.textTheme.bodySmall?.copyWith(
                                                      color: context.theme.colorScheme.onSurfaceVariant,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          if (selected) Icon(Icons.check_circle, color: Color(0xFFE53935)),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            loading: () => Center(child: CircularProgressIndicator()),
                            error: (m) => Center(child: Text(m)),
                            noInternet: () => Center(child: Text('No internet')),
                            orElse: () => Center(child: CircularProgressIndicator()),
                          );
                        },
                      )
                    : BlocBuilder<PartyCubit, PartyState>(
                        builder: (context, partyState) {
                          return partyState.maybeWhen(
                            success: (r) {
                              final items = r.data.data ?? [];
                              if (items.isEmpty) {
                                return Center(
                                  child: Text('No results', style: context.theme.textTheme.bodyLarge),
                                );
                              }
                              return ListView.builder(
                                itemCount: items.length,
                                itemBuilder: (context, i) {
                                  final p = items[i];
                                  final name = (p.name ?? '').trim();
                                  if (name.isEmpty) return SizedBox(height: 0.h);
                                  final role = (p.role ?? '').trim();
                                  final pid = p.id;
                                  final selected = !_pickIsEmployee &&
                                      ((pid != null && pid == _pickedPartyId) ||
                                          (pid == null &&
                                              _pickedPartyId == null &&
                                              name == (_pickedLabel ?? '')));
                                  return InkWell(
                                    onTap: () => setState(() {
                                      _pickIsEmployee = false;
                                      _pickedPartyId = p.id;
                                      _pickedLabel = name;
                                    }),
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 8.h),
                                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12.r),
                                        border: Border.all(
                                          color: selected ? const Color(0xFFE53935) : const Color(0xFFEDEFF4),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 18.r,
                                            backgroundColor: const Color(0xFFF5F6F8),
                                            child: Text(
                                              name.substring(0, 1).toUpperCase(),
                                              style: context.theme.textTheme.titleSmall,
                                            ),
                                          ),
                                          SizedBox(width: 10.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  name,
                                                  style: context.theme.textTheme.titleMedium
                                                      ?.copyWith(fontWeight: FontWeight.w600),
                                                ),
                                                if (role.isNotEmpty)
                                                  Text(
                                                    role,
                                                    style: context.theme.textTheme.bodySmall?.copyWith(
                                                      color: context.theme.colorScheme.onSurfaceVariant,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          if (selected) Icon(Icons.check_circle, color: Color(0xFFE53935)),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            loading: () => Center(child: CircularProgressIndicator()),
                            error: (m) => Center(child: Text(m)),
                            noInternet: () => Center(child: Text('No internet')),
                            orElse: () => Center(child: CircularProgressIndicator()),
                          );
                        },
                      ),
              ),
              SizedBox(height: 10.h),
              FilledButton(
                onPressed: _pickedLabel == null || _pickedLabel!.trim().isEmpty
                    ? null
                    : () => Navigator.pop(
                          context,
                          _CheckoutBillingPickResult(
                            label: _pickedLabel!.trim(),
                            partyId: _pickedPartyId,
                            isEmployee: _pickIsEmployee,
                          ),
                        ),
                style: FilledButton.styleFrom(
                  minimumSize: Size.fromHeight(46.h),
                  backgroundColor: const Color(0xFFE53935),
                ),
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CheckoutItemsSheet extends StatelessWidget {
  const _CheckoutItemsSheet({
    required this.items,
    required this.qtyLabel,
  });

  final List<OrderItemModel> items;
  final String Function(double?) qtyLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.85),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26.r)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 12.h),
          child: Column(
            children: [
              Container(
                  width: 56.w,
                  height: 4.h,
                  decoration: BoxDecoration(color: const Color(0xFFD6D8DE), borderRadius: BorderRadius.circular(999))),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                      child: Text('Items',
                          style: context.theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700))),
                  IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close_rounded)),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, i) {
                    final line = items[i];
                    return Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: const Color(0xFFEDEFF4)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.check_box_outline_blank_rounded, color: Color(0xFFCFD4DD)),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(line.item ?? '-', style: context.theme.textTheme.labelLarge),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE8FAFF),
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: Text('QTY: ${qtyLabel(line.quantity)}',
                                      style: context.theme.textTheme.labelMedium),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('$currencySymbol ${(line.amount ?? 0).toStringAsFixed(1)}',
                                  style: context.theme.textTheme.labelLarge),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: CustomButtonWidget.outlined(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  title: 'Add Custom Item',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RemarksSheet extends StatelessWidget {
  const _RemarksSheet({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.85),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26.r)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 12.h),
          child: Column(
            children: [
              Container(
                  width: 56.w,
                  height: 4.h,
                  decoration: BoxDecoration(color: const Color(0xFFD6D8DE), borderRadius: BorderRadius.circular(999))),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                      child: Text('Add remarks to Invoice',
                          style: context.theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700))),
                  IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close_rounded)),
                ],
              ),
              TextField(
                controller: controller,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Do you want to add anything as remarks to this invoice as future reference.',
                  hintStyle: context.theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Color(0xFFE6E8ED)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Color(0xFFE53935)),
                  ),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: CustomButtonWidget.outlined(

                      onPressed: () => Navigator.pop(context),
                      title: 'Back',
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CustomButtonWidget.primary(

                      onPressed: () => Navigator.pop(context),
                      title: 'Save',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

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
