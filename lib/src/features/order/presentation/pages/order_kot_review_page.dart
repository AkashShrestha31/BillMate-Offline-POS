import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/features/employee_management/data/models/response/employee_model.dart';
import 'package:hotel/constants.dart';
import 'package:hotel/src/features/employee_management/presentation/bloc/employee_cubit.dart'
    show EmployeeCubit, EmployeeState;
import 'package:hotel/src/features/order/data/models/request/create_order_request.dart';
import 'package:hotel/src/features/order/data/models/response/order_model.dart';
import 'package:hotel/src/features/order/domain/usecases/create_order_use_case.dart';
import 'package:hotel/src/features/order/presentation/models/restaurant_cart_line.dart';
import 'package:hotel/src/core/widget/app_search_icon.dart';
import 'package:hotel/src/core/widget/app_delete_icon.dart';

/// Builds a loadable http(s) URL for cart line thumbnails (absolute URLs unchanged;
/// relative paths like `/media/...` are resolved against [dotenv] `BASE_URL`).
String? _kotLineImageUrlForNetwork(String? raw) {
  final t = raw?.trim();
  if (t == null || t.isEmpty) return null;
  final lower = t.toLowerCase();
  if (lower.startsWith('http://') || lower.startsWith('https://')) return t;
  if (t.startsWith('//')) {
    try {
      final base = dotenv.env['BASE_URL']?.trim();
      if (base != null && base.isNotEmpty) {
        final scheme = Uri.parse(base).scheme;
        if (scheme.isNotEmpty) return '$scheme:$t';
      }
    } catch (_) {}
    return 'https:$t';
  }
  final base = dotenv.env['BASE_URL']?.trim();
  if (base == null || base.isEmpty) return null;
  try {
    return Uri.parse(base).resolve(t).toString();
  } catch (_) {
    return null;
  }
}

/// KOT-style review: lines, remarks, staff, guest count → `POST api/order/orders/`.
@RoutePage()
class OrderKotReviewPage extends StatefulWidget implements AutoRouteWrapper {
  const OrderKotReviewPage({
    super.key,
    required this.cartJson,
    required this.tableNumber,
    required this.displayTableLabel,
    this.customerMetaNotes,
    this.hideGuestCount = false,
  });

  final String cartJson;
  final String tableNumber;
  final String displayTableLabel;
  final String? customerMetaNotes;
  final bool hideGuestCount;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<EmployeeCubit>(
      create: (_) => getIt<EmployeeCubit>(),
      child: this,
    );
  }

  @override
  State<OrderKotReviewPage> createState() => _OrderKotReviewPageState();
}

class _OrderKotReviewPageState extends State<OrderKotReviewPage> {
  final _kotFormKey = GlobalKey<FormState>();
  final _listScrollController = ScrollController();
  late final ValueNotifier<List<RestaurantCartLine>> _lines;
  late List<TextEditingController> _lineRemarkCtrls;
  final _kotNotesController = TextEditingController();
  final _guestCountController = TextEditingController();
  final _staffEmail = ValueNotifier<String?>(null);
  final _submitting = ValueNotifier<bool>(false);
  late final Listenable _kotListenable;
  bool _showBottomKotContainer = true;
  double _lastScrollOffset = 0;
  static const double _scrollToggleThreshold = 18;

  static const _green = Color(0xFF2E7D32);

  Future<void> _openDishRemarksSheet({
    required RestaurantCartLine line,
    required TextEditingController controller,
  }) async {
    final next = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: false,
      builder: (_) => _RemarksEditorSheet(
        title: 'Add remarks to Dish',
        header: _DishRemarksHeader(line: line),
        initialText: controller.text,
        accent: Theme.of(context).colorScheme.primary,
      ),
    );
    if (next == null) return;
    controller.text = next;
    if (mounted) setState(() {});
  }

  Future<void> _openKotRemarksSheet() async {
    final next = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: false,
      builder: (_) => _RemarksEditorSheet(
        title: 'Add remarks to KOT',
        header: _KotRemarksHeader(tableLabel: widget.displayTableLabel),
        initialText: _kotNotesController.text,
        accent: Theme.of(context).colorScheme.primary,
      ),
    );
    if (next == null) return;
    _kotNotesController.text = next;
    if (mounted) setState(() {});
  }

  String _staffNameFromEmail(List<EmployeeModel> employees, String? email) {
    final key = (email ?? '').trim();
    if (key.isEmpty) return '';
    for (final e in employees) {
      final em = (e.email ?? '').trim();
      if (em == key) return e.fullName;
    }
    return '';
  }

  Future<String?> _openStaffPickerSheet(List<EmployeeModel> employees) async {
    return showModalBottomSheet<String?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: false,
      builder: (_) => _StaffPickerBottomSheet(
        employees: employees,
        selectedEmail: _staffEmail.value,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    final decoded = RestaurantCartLine.decodeList(widget.cartJson);
    _lines = ValueNotifier<List<RestaurantCartLine>>(decoded);
    _lineRemarkCtrls = List.generate(decoded.length, (_) => TextEditingController());
    _kotListenable = Listenable.merge([_lines, _staffEmail, _submitting]);
    _listScrollController.addListener(_handleListScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<EmployeeCubit>().getEmployees(employmentStatus: 'ACTIVE');
    });
  }

  void _handleListScroll() {
    if (!_listScrollController.hasClients) return;
    final position = _listScrollController.position;
    final currentOffset = position.pixels;

    // Always show when close to top.
    if (currentOffset <= 8) {
      if (!_showBottomKotContainer && mounted) {
        setState(() => _showBottomKotContainer = true);
      }
      _lastScrollOffset = currentOffset;
      return;
    }

    final delta = currentOffset - _lastScrollOffset;
    if (delta.abs() < _scrollToggleThreshold) return;

    final scrollingDown = delta > 0;
    if (scrollingDown && _showBottomKotContainer && mounted) {
      setState(() => _showBottomKotContainer = false);
      _lastScrollOffset = currentOffset;
      return;
    }
    if (!scrollingDown && !_showBottomKotContainer && mounted) {
      setState(() => _showBottomKotContainer = true);
      _lastScrollOffset = currentOffset;
      return;
    }

    _lastScrollOffset = currentOffset;
  }

  @override
  void dispose() {
    _listScrollController.removeListener(_handleListScroll);
    _listScrollController.dispose();
    _lines.dispose();
    _staffEmail.dispose();
    _submitting.dispose();
    for (final c in _lineRemarkCtrls) {
      c.dispose();
    }
    _kotNotesController.dispose();
    _guestCountController.dispose();
    super.dispose();
  }

  double _grandTotal(List<RestaurantCartLine> lines) => lines.fold<double>(0, (s, l) => s + l.lineTotal);

  int _totalQty(List<RestaurantCartLine> lines) => lines.fold<int>(0, (s, l) => s + l.quantity);

  void _setQty(int index, int next) {
    if (next < 1) return;
    final copy = List<RestaurantCartLine>.from(_lines.value);
    copy[index] = copy[index].copyWith(quantity: next);
    _lines.value = copy;
  }

  bool _employeesListReady(EmployeeState state) => state.maybeWhen(loaded: (_) => true, orElse: () => false);

  bool _validateKotFormForSubmit() {
    if (!_employeesListReady(context.read<EmployeeCubit>().state)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please wait for staff list to load')),
      );
      return false;
    }
    if (!(_kotFormKey.currentState?.validate() ?? false)) {
      return false;
    }
    // When the bottom strip is collapsed, staff [FormField]s may be out of tree during/after
    // [AnimatedSwitcher]; enforce assignment here as well.
    if ((_staffEmail.value ?? '').trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please assign staff')),
      );
      return false;
    }
    return true;
  }

  Future<void> _confirmOrder() async {
    if (_submitting.value) return;
    if (!_validateKotFormForSubmit()) return;
    _submitting.value = true;
    try {
      // API: `notes` = free text; `remarks` = order-level special instructions; `guest_count` = int.
      final notes = (widget.customerMetaNotes != null && widget.customerMetaNotes!.trim().isNotEmpty)
          ? widget.customerMetaNotes!.trim()
          : null;
      final orderRemarks = _kotNotesController.text.trim();
      final guestCount = widget.hideGuestCount ? null : int.tryParse(_guestCountController.text.trim());

      final lines = _lines.value;
      final items = <CreateOrderLineRequest>[];
      for (var i = 0; i < lines.length; i++) {
        final line = lines[i];
        final lineRm = _lineRemarkCtrls[i].text.trim();
        items.add(
          CreateOrderLineRequest(
            item: line.name,
            quantity: line.quantity.toDouble(),
            remarks: lineRm.isEmpty ? null : lineRm,
          ),
        );
      }

      final now = DateTime.now();
      final dateStr = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

      // Doc: `tableNumber` = physical table/cabin Party; `party` = billing party (optional). When we have both a table label and a distinct customer/table key, map them explicitly.
      final tableKey = widget.tableNumber.trim();
      final display = widget.displayTableLabel.trim();
      final hasSeparateTableLabel = display.isNotEmpty && display != tableKey;

      final req = CreateOrderRequest(
        tableNumber: hasSeparateTableLabel ? display : tableKey,
        party: hasSeparateTableLabel ? tableKey : null,
        items: items,
        orderType: 'qot',
        date: dateStr,
        notes: notes,
        remarks: orderRemarks.isEmpty ? null : orderRemarks,
        guestCount: guestCount,
        assignedEmployee:
            (_staffEmail.value != null && _staffEmail.value!.trim().isNotEmpty) ? _staffEmail.value!.trim() : null,
        createdBy: 'hotelroyalrestro@gmail.com',
        modifiedBy: 'hotelroyalrestro@gmail.com',
      );

      final result = await getIt<CreateOrderUseCase>().execute(req);
      if (!mounted) return;
      result.fold(
        (AppError l) {
          l.when(
            serverError: (m) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m))),
            noInternet: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('No internet')),
            ),
          );
        },
        (OrderModel order) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Order created')),
          );
          final id = order.name?.trim();
          context.router.popForced<String?>(id?.isNotEmpty == true ? id : null);
        },
      );
    } finally {
      if (mounted) _submitting.value = false;
    }
  }

  void _confirmPrintStub() {
    if (!_validateKotFormForSubmit()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Print queue not configured')),
    );
  }

  Future<void> _clearCart() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Clear cart?'),
        content: Text('Discard this order and go back?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text('Discard')),
        ],
      ),
    );
    if (ok == true && mounted) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: AppBarIosBackButton(),
        title: Text(
          '${widget.displayTableLabel} - KOT',
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          CustomButtonWidget.outlined(
            height: 40,
            borderRadius: 8.r,
            padding: EdgeInsetsGeometry.symmetric(horizontal: 8.sp),
            onPressed: _clearCart,
            icon: const AppDeleteIcon(),
            title: 'Clear Cart',
          ).pOnly(right: 8.sp),
        ],
      ),
      body: Form(
        key: _kotFormKey,
        child: AnimatedBuilder(
          animation: _kotListenable,
          builder: (context, _) {
            final lines = _lines.value;
            final submitting = _submitting.value;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _listScrollController,
                    padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
                    itemCount: lines.length,
                    itemBuilder: (context, index) {
                      final line = lines[index];
                      return Card(
                        elevation: 0,
                        margin: EdgeInsets.only(bottom: 12.h),
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _kotLineThumbnail(line, cs),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          line.name,
                                          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          '$currencySymbol ${line.rate.toStringAsFixed(1)}',
                                          style: theme.textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  _qtyBtn(Icons.remove, () => _setQty(index, line.quantity - 1)),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                                    child: Text(
                                      '${line.quantity}',
                                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  _qtyBtn(Icons.add, () => _setQty(index, line.quantity + 1)),
                                  const Spacer(),
                                  Text(
                                    '$currencySymbol ${line.lineTotal.toStringAsFixed(1)}',
                                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              verticalMarginMedium,
                              CustomTextFormField(
                                controller: _lineRemarkCtrls[index],
                                prefixIcon: Icon(Icons.description_outlined, size: 18.sp, color: cs.outline),
                                hint: 'Add remarks to Dish',
                                readOnly: true,
                                onTap: () => _openDishRemarksSheet(
                                  line: line,
                                  controller: _lineRemarkCtrls[index],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // [Form] must wrap [AnimatedSwitcher]: during the switch animation both outgoing
                // and incoming children can exist briefly; a [Form] inside each branch would
                // duplicate the same [GlobalKey].
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 240),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeOut,
                  transitionBuilder: (child, animation) {
                    return SizeTransition(
                      sizeFactor: animation,
                      axisAlignment: -1,
                      child: FadeTransition(opacity: animation, child: child),
                    );
                  },
                  child: _showBottomKotContainer
                      ? Column(
                          key: const ValueKey('kot_bottom_visible'),
                          children: [
                            Container(
                              height: 2,
                              width: double.infinity,
                              color: Colors.grey[100],
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(16.w, 10, 16.w, 8.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  CustomTextFormField(
                                    controller: _kotNotesController,
                                    hint: 'Add Remarks to KOT',
                                    prefixIcon: Icon(Icons.description_outlined, size: 20.sp),
                                    readOnly: true,
                                    onTap: _openKotRemarksSheet,
                                  ),
                                  verticalMarginMedium,
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: BlocBuilder<EmployeeCubit, EmployeeState>(
                                          builder: (context, state) {
                                            return state.maybeWhen(
                                              loaded: (response) {
                                                final withEmail = response.employees
                                                    .where(
                                                      (e) =>
                                                          e.email != null &&
                                                          e.email!.trim().isNotEmpty &&
                                                          e.department.trim().toLowerCase() == 'kitchen',
                                                    )
                                                    .toList();
                                                return FormField<String?>(
                                                  initialValue: _staffEmail.value,
                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                  validator: (v) {
                                                    final val = (v ?? '').trim();
                                                    if (val.isEmpty) return 'Please assign staff';
                                                    return null;
                                                  },
                                                  builder: (field) {
                                                    final pickedName = _staffNameFromEmail(withEmail, _staffEmail.value);
                                                    final display = pickedName.isEmpty ? 'Select' : pickedName;
                                                    return CustomTextFormField(
                                                      readOnly: true,
                                                      labelText: 'Assign Staff *',
                                                      hint: display,
                                                      suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                                                      errorText: field.errorText,
                                                      onTap: () async {
                                                        final selected = await _openStaffPickerSheet(withEmail);
                                                        if (!mounted || selected == null) return;
                                                        _staffEmail.value = selected.trim().isEmpty ? null : selected.trim();
                                                        field.didChange(_staffEmail.value);
                                                        setState(() {});
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                              error: (m) => Text(m, style: AppFonts.interStyle(color: cs.error)),
                                              orElse: () => Padding(
                                                padding: EdgeInsets.only(top: 8),
                                                child: LinearProgressIndicator(),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      if (!widget.hideGuestCount) ...[
                                        SizedBox(width: 12.w),
                                        Expanded(
                                          child: CustomTextFormField(
                                            controller: _guestCountController,
                                            keyboardType: TextInputType.number,
                                            inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                                            prefixIcon: Icon(Icons.people_outline),
                                            labelText: 'Guest Count',
                                            hint: 'No of Guest',
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  SizedBox(height: 12.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Total', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                                      Text('QTY: ${_totalQty(lines)}', style: theme.textTheme.bodyMedium),
                                      Text(
                                        '$currencySymbol ${_grandTotal(lines).toStringAsFixed(1)}',
                                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomButtonWidget.outlined(
                                          title: 'Confirm & Print',
                                          onPressed: _confirmPrintStub,
                                          width: double.infinity,
                                          elevation: 0,
                                          borderColor: _green,
                                          titleColor: _green,
                                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        child: CustomButtonWidget.primary(
                                          title: 'Confirm Order',
                                          onPressed: submitting ? null : _confirmOrder,
                                          loading: submitting,
                                          backgroundColor: _green,
                                          titleColor: Colors.white,
                                          width: double.infinity,
                                          elevation: 0,
                                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: MediaQuery.paddingOf(context).bottom + 8),
                                ],
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(key: ValueKey('kot_bottom_hidden')),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _kotLineThumbnail(RestaurantCartLine line, ColorScheme cs) {
    final url = _kotLineImageUrlForNetwork(line.imageUrl);
    final canNetwork = url != null && (url.startsWith('http://') || url.startsWith('https://'));
    if (canNetwork) {
      return Container(
        width: 56.w,
        height: 56.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: cs.outlineVariant.withOpacity(0.85)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.network(
          url,
          fit: BoxFit.cover,
          width: 56.w,
          height: 56.w,
          errorBuilder: (_, __, ___) => _kotLineImagePlaceholder(cs, withBorder: false),
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return ColoredBox(
              color: cs.surfaceContainerHighest,
              child: Center(
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(strokeWidth: 2, color: cs.primary),
                ),
              ),
            );
          },
        ),
      );
    }
    return _kotLineImagePlaceholder(cs);
  }

  Widget _kotLineImagePlaceholder(ColorScheme cs, {bool withBorder = true}) {
    return Container(
      width: 56.w,
      height: 56.w,
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: withBorder ? Border.all(color: cs.outlineVariant.withOpacity(0.85)) : null,
      ),
      child: Icon(Icons.restaurant, color: cs.onSurfaceVariant),
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback onTap) {
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.8),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Icon(icon, size: 16.sp),
        ),
      ),
    );
  }
}

class _DishRemarksHeader extends StatelessWidget {
  const _DishRemarksHeader({required this.line});

  final RestaurantCartLine line;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44.w,
          height: 44.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: cs.surfaceContainerHighest,
          ),
          clipBehavior: Clip.antiAlias,
          child: line.imageUrl != null && line.imageUrl!.trim().isNotEmpty
              ? Image.network(
                  _kotLineImageUrlForNetwork(line.imageUrl) ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Icon(Icons.restaurant, color: cs.onSurfaceVariant),
                )
              : Icon(Icons.restaurant, color: cs.onSurfaceVariant),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                line.name,
                style: context.theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 2.h),
              Text(
                '$currencySymbol ${line.rate.toStringAsFixed(1)}',
                style: context.theme.textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
              ),
            ],
          ),
        ),
        Text(
          '$currencySymbol ${line.lineTotal.toStringAsFixed(1)}',
          style: context.theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class _KotRemarksHeader extends StatelessWidget {
  const _KotRemarksHeader({required this.tableLabel});

  final String tableLabel;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Container(
          width: 44.w,
          height: 44.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: cs.surfaceContainerHighest,
          ),
          child: Icon(Icons.receipt_long_rounded, color: cs.onSurfaceVariant),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            tableLabel.isEmpty ? 'KOT' : tableLabel,
            style: context.theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}

class _RemarksEditorSheet extends StatefulWidget {
  const _RemarksEditorSheet({
    required this.title,
    required this.header,
    required this.initialText,
    required this.accent,
  });

  final String title;
  final Widget header;
  final String initialText;
  final Color accent;

  @override
  State<_RemarksEditorSheet> createState() => _RemarksEditorSheetState();
}

class _RemarksEditorSheetState extends State<_RemarksEditorSheet> {
  late final TextEditingController _controller = TextEditingController(text: widget.initialText);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.92),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, MediaQuery.viewInsetsOf(context).bottom + 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: context.theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close_rounded),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              widget.header,
              SizedBox(height: 14.h),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xFFE6E8ED)),
                  ),
                  child: TextField(
                    controller: _controller,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      hintText: 'Do you want to add anything as remarks for future reference.',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(12.w),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              Row(
                children: [
                  Expanded(
                    child: CustomButtonWidget.outlined(
                      title: 'Reset',
                      onPressed: () {
                        _controller.clear();
                        setState(() {});
                      },
                      borderColor: const Color(0xFFE5E7EB),
                      titleColor: cs.onSurface,
                      height: 46.h,
                      borderRadius: 6.r,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomButtonWidget(
                      title: 'Save Remarks',
                      onPressed: () => Navigator.pop(context, _controller.text),
                      backgroundColor: widget.accent,
                      titleColor: Colors.white,
                      height: 46.h,
                      borderRadius: 6.r,
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

class _StaffPickerBottomSheet extends StatefulWidget {
  const _StaffPickerBottomSheet({
    required this.employees,
    required this.selectedEmail,
  });

  final List<EmployeeModel> employees;
  final String? selectedEmail;

  @override
  State<_StaffPickerBottomSheet> createState() => _StaffPickerBottomSheetState();
}

class _StaffPickerBottomSheetState extends State<_StaffPickerBottomSheet> {
  final TextEditingController _search = TextEditingController();
  bool _showSearch = false;

  String _initials(String fullName) {
    final parts = fullName.trim().split(RegExp(r'\s+')).where((e) => e.isNotEmpty).toList();
    if (parts.isEmpty) return '--';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts[1].substring(0, 1)).toUpperCase();
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final q = _search.text.trim().toLowerCase();
    final filtered = widget.employees.where((e) {
      final name = e.fullName.toLowerCase();
      final email = (e.email ?? '').toLowerCase();
      return q.isEmpty || name.contains(q) || email.contains(q);
    }).toList();

    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.82),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Select Party',
                      style: context.theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() => _showSearch = !_showSearch),
                    icon: _showSearch
                        ? Icon(Icons.search_off_rounded, color: context.theme.colorScheme.primary)
                        : AppSearchIcon(color: context.theme.colorScheme.primary),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close_rounded, color: cs.onSurfaceVariant),
                  ),
                ],
              ),
              if (_showSearch) ...[
                CustomTextFormField(
                  controller: _search,
                  hint: 'Search',
                  prefixIcon: AppSearchIcon.inputDecoration( size: 18.sp),
                  onChanged: (_) => setState(() {}),
                ),
                SizedBox(height: 8.h),
              ],
              if ((widget.selectedEmail ?? '').trim().isNotEmpty)
                ListTile(
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
                  leading: Icon(Icons.remove_circle_outline_rounded),
                  title: Text('Unselect staff'),
                  onTap: () => Navigator.pop(context, ''),
                ),
              Expanded(
                child: ListView.separated(
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  itemBuilder: (context, i) {
                    final e = filtered[i];
                    final isSelected = (e.email ?? '').trim() == (widget.selectedEmail ?? '').trim();
                    return InkWell(
                      borderRadius: BorderRadius.circular(14.r),
                      onTap: () => Navigator.pop(context, (e.email ?? '').trim()),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(
                            color: isSelected ? context.theme.colorScheme.primary : const Color(0xFFDDE5E4),
                          ),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 27.r,
                              backgroundColor: const Color(0xFFDDE7E3),
                              child: Text(
                                _initials(e.fullName),
                                style: context.theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: cs.onSurface,
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.fullName,
                                    style: context.theme.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    (e.department).trim().isEmpty ? 'Staff' : e.department,
                                    style: context.theme.textTheme.bodySmall?.copyWith(
                                      color: cs.onSurfaceVariant,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              Icon(Icons.check_circle_rounded, color: context.theme.colorScheme.primary),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
