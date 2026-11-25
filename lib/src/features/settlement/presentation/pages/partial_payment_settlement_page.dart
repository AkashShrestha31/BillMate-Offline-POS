import 'dart:async';
import 'dart:math';
import 'package:hotel/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/helpers/payment_method_for_api.dart';
import 'package:hotel/src/core/layout/device_layout.dart';
import 'package:hotel/src/core/services/currency/app_currency_formatter.dart';
import 'package:hotel/src/core/services/display_precision/app_money_format.dart';
import 'package:hotel/src/core/services/app_loading_overlay.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/loyalty/domain/loyalty_features.dart';
import 'package:hotel/src/features/loyalty/domain/loyalty_math.dart';
import 'package:hotel/src/features/loyalty/domain/loyalty_program_service.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/edit_discount_sheet.dart';
import 'package:hotel/src/core/widget/partial_payment_preview_page.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/features/employee/data/models/request/employee_outstanding_request_params.dart';
import 'package:hotel/src/features/employee/data/models/response/employee_outstanding_response.dart';
import 'package:hotel/src/features/employee/data/models/response/employee_party_outstanding_mapper.dart';
import 'package:hotel/src/features/employee/presentation/bloc/employee_outstanding_cubit.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_sales_response_model.dart';
import 'package:hotel/src/features/settlement/data/models/request/partial_settlement_request_params.dart';
import 'package:hotel/src/features/settlement/presentation/bloc/partial_settlement_cubit.dart';
import 'package:hotel/src/features/settlement/presentation/widgets/bill_items_bottom_sheet.dart';
import 'package:hotel/src/features/payment_methods/presentation/cubit/payment_methods_cubit.dart';
import 'package:hotel/src/core/widget/app_search_icon.dart';
import 'package:hotel/src/features/setup/presentation/widgets/setup_bottom_action_bar.dart';

/// Fallback payment methods when the payment-methods API fails or returns nothing.
const List<String> _kFallbackPaymentMethods = ['Cash', 'Bank', 'Transfer', 'Settlement'];

class PartialPaymentSettlementPage extends StatefulWidget {
  final bool hideParties;
  final InvoiceItem? item;
  final Function()? onCompleted;
  final String selectedRole;

  /// When parties load, select this name and prefill amount (Parties list → Settle).
  final String? preselectPartyName;
  final double? preselectOutstandingAmount;

  /// Party directory: settlement without an [item]; sends [party_name] on submit.
  final String? settlementPartyName;
  final double? settlementPartyOutstanding;

  /// ISO currency for amounts (party currency). Falls back to org reporting currency.
  final String? settlementCurrencyCode;

  /// With [hideParties]: sheet chrome (handle, party header, close) instead of app bar.
  final bool showAsBottomSheet;

  const PartialPaymentSettlementPage({
    super.key,
    this.hideParties = false,
    this.onCompleted,
    this.item,
    this.selectedRole = 'customers',
    this.preselectPartyName,
    this.preselectOutstandingAmount,
    this.settlementPartyName,
    this.settlementPartyOutstanding,
    this.settlementCurrencyCode,
    this.showAsBottomSheet = false,
  });

  /// Full settlement UI (Paid/Unpaid, API payment methods, multiple payment, etc.) in a modal sheet.
  static Future<Object?> showPartySettlementSheet(
    BuildContext context, {
    required String partyName,
    required InvoiceType invoiceType,
    double? outstandingAmount,
    String? currencyCode,
  }) {
    final selectedRole = invoiceType == InvoiceType.sales ? 'customer' : 'suppliers';
    return showModalBottomSheet<Object?>(
      context: context,
      isScrollControlled: true,
      useSafeArea: false,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final ime = MediaQuery.viewInsetsOf(ctx).bottom;
        final h = MediaQuery.sizeOf(ctx).height;
        return Padding(
          padding: EdgeInsets.only(bottom: ime),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              child: SizedBox(
                height: h * 0.92,
                child: PartialPaymentSettlementPage(
                  hideParties: true,
                  showAsBottomSheet: true,
                  settlementPartyName: partyName,
                  settlementPartyOutstanding: outstandingAmount,
                  settlementCurrencyCode: currencyCode,
                  selectedRole: selectedRole,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  State<PartialPaymentSettlementPage> createState() => _PartialPaymentSettlementPageState();
}

class _PartialPaymentSettlementPageState extends State<PartialPaymentSettlementPage>
    with SingleTickerProviderStateMixin {
  /// Own instance so settlement always loads payment methods from API (not a stale app-wide cubit).
  late final PaymentMethodsCubit _paymentMethodsCubit;

  // Form controllers
  final _paymentDateController = TextEditingController();
  final _createdByController = TextEditingController();
  final _amountController = TextEditingController();
  final _discountController = TextEditingController();

  // ValueNotifiers for reactive state
  final ValueNotifier<List<Party>> _selectedPartiesNotifier = ValueNotifier<List<Party>>([]);
  final ValueNotifier<String> _amountNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> _selectedRoleNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> _selectedPaymentMethodNotifier = ValueNotifier<String>('Cash');
  final ValueNotifier<DateTime?> _paymentDateNotifier = ValueNotifier<DateTime?>(null);
  final ValueNotifier<List<Party>> _allPartiesNotifier = ValueNotifier<List<Party>>([]);
  final ValueNotifier<InvoiceType> _invoiceTypeNotifier =
      ValueNotifier<InvoiceType>(InvoiceType.sales); // Added ValueNotifier for invoice type

  // Form values
  DateTime? paymentDate;

  // Single role selection - changed from multiple checkboxes to single choice
  late String selectedRole; // Default to customers

  // Available parties from API
  List<Party> allParties = [];

  bool _preselectApplied = false;

  /// Matches invoice checkout: recording a payment vs leaving credit.
  bool _paymentModePaid = true;

  /// When true, tender is split via [PartialPaymentPreviewPage]; API sends `payment` as an array.
  bool _multiplePayment = false;

  /// Keys are API-normalized (same as [PartialPaymentPreviewPage] confirm map).
  Map<String, double> _multiplePaymentAmounts = {};

  final List<String> roleOptions = ['customers', 'suppliers', 'others'];
  late final TabController _roleTabController;
  bool _suppressRoleTabListener = false;

  final _partySearchController = TextEditingController();
  final FocusNode _partySearchFocusNode = FocusNode();
  Timer? _partySearchDebounce;

  /// Party app bar: search icon first; mint pill field after tap.
  bool _partySearchExpanded = false;

  bool _showBillSummaryHint = true;

  /// Party / non-invoice flows: extra discount % on subtotal (preview only).
  double _summaryDiscountPercent = 0;

  /// Loyalty discount amount applied on the source sales invoice (redeem).
  double _invoiceLoyaltyDiscountAmount = 0;

  /// Active ISO currency for money display (party → widget → org reporting).
  String? _settlementCurrencyCode;

  ColorScheme get _scheme => Theme.of(context).colorScheme;
  Color get _scaffoldBg => _scheme.surfaceContainerLow;
  Color get _cardBg => _scheme.surface;
  Color get _cardBorder => _scheme.outlineVariant.withValues(alpha: 0.6);
  Color get _infoTint => _scheme.primaryContainer;
  Color get _paidColor => _scheme.primary;
  Color get _searchFill => _scheme.surfaceContainerHighest;

  String get _currencyCode {
    final fromState = _settlementCurrencyCode?.trim();
    if (fromState != null && fromState.isNotEmpty) return fromState.toUpperCase();
    final fromWidget = widget.settlementCurrencyCode?.trim();
    if (fromWidget != null && fromWidget.isNotEmpty) return fromWidget.toUpperCase();
    if (_selectedPartiesNotifier.value.isNotEmpty) {
      final fromParty = _selectedPartiesNotifier.value.first.currency.trim();
      if (fromParty.isNotEmpty) return fromParty.toUpperCase();
    }
    return AppCurrencyFormatter.code;
  }

  String get _currencyDisplaySymbol => AppCurrencyFormatter.symbolForCode(_currencyCode);

  @override
  void initState() {
    super.initState();
    _paymentMethodsCubit = getIt<PaymentMethodsCubit>();
    _paymentMethodsCubit.load();

    final seedCurrency = widget.settlementCurrencyCode?.trim();
    if (seedCurrency != null && seedCurrency.isNotEmpty) {
      _settlementCurrencyCode = seedCurrency.toUpperCase();
    }

    _invoiceTypeNotifier.value = _getInvoiceType(widget.selectedRole);
    selectedRole = widget.selectedRole == 'customer' ? 'customers' : widget.selectedRole;
    _selectedRoleNotifier.value = selectedRole;
    _selectedPaymentMethodNotifier.value = "Cash";

    // ✅ Use invoice date if available, else fallback to today
    final invoiceDate =
        widget.item?.date != null ? DateTime.tryParse(widget.item!.date.toString()) ?? DateTime.now() : DateTime.now();

    paymentDate = invoiceDate;
    _paymentDateNotifier.value = invoiceDate;
    _paymentDateController.text = _formatDate(invoiceDate); // ✅ auto-populated

    _createdByController.text = 'hotelroyalrestro@gmail.com';

    if (widget.hideParties && widget.item != null) {
      final item = widget.item!;
      final base = _invoiceAmountForSettlement(item);
      if (base != null && base > 0) {
        _amountController.text = _formatAmountForField(base);
        _amountNotifier.value = _amountController.text;
      }

      if (item.invoiceType != null) {
        _invoiceTypeNotifier.value = item.invoiceType!;
      }
    }

    if (widget.hideParties &&
        widget.item == null &&
        widget.settlementPartyName != null &&
        widget.settlementPartyName!.trim().isNotEmpty) {
      final o = widget.settlementPartyOutstanding;
      if (o != null && o > 0) {
        _amountController.text = _formatAmountForField(o);
        _amountNotifier.value = _amountController.text;
      }
    }

    _prefillDiscountFromItem();

    if (!widget.hideParties) {
      final pre = widget.preselectPartyName?.trim();
      if (pre != null && pre.isNotEmpty) {
        _partySearchController.text = pre;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          setState(() => _partySearchExpanded = true);
          _fetchPartiesFromApi(showFullScreenLoading: true);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) _partySearchFocusNode.requestFocus();
          });
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          _fetchPartiesFromApi(showFullScreenLoading: true);
        });
      }
    }

    final roleIdx = roleOptions.indexOf(selectedRole);
    _roleTabController = TabController(
      length: roleOptions.length,
      vsync: this,
      initialIndex: roleIdx >= 0 ? roleIdx : 0,
    );
    _roleTabController.addListener(_syncRoleFromTabController);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) unawaited(_hydrateSettlementCurrency());
      if (mounted) unawaited(_hydrateInvoiceLoyaltyDiscount());
    });
  }

  Future<void> _hydrateInvoiceLoyaltyDiscount() async {
    if (!LoyaltyFeatures.enabled) {
      if (mounted) setState(() => _invoiceLoyaltyDiscountAmount = 0);
      return;
    }
    if (widget.item == null || invoiceType != InvoiceType.sales) return;
    final invName =
        (widget.item?.invoiceName ?? widget.item?.parent)?.trim();
    if (invName == null || invName.isEmpty) return;
    try {
      final db = await getIt<LocalDb>().database;
      final rows = await db.query(
        'SalesInvoice',
        columns: ['redeemLoyaltyPoints', 'loyaltyPoints', 'loyaltyProgram'],
        where: 'name = ?',
        whereArgs: [invName],
        limit: 1,
      );
      if (rows.isEmpty || !mounted) return;
      final redeem = rows.first['redeemLoyaltyPoints'];
      final redeemed = redeem == 1 || redeem == true || redeem?.toString() == '1';
      if (!redeemed) return;
      final points = int.tryParse(rows.first['loyaltyPoints']?.toString() ?? '') ?? 0;
      if (points <= 0) return;
      final programName = rows.first['loyaltyProgram']?.toString();
      final program = await getIt<LoyaltyProgramService>().getProgram(programName);
      final factor = program?.conversionFactor ?? 1.0;
      final amount = LoyaltyMath.amountFromPoints(points, factor);
      if (!mounted) return;
      setState(() => _invoiceLoyaltyDiscountAmount = amount);
    } catch (_) {}
  }

  Future<void> _hydrateSettlementCurrency() async {
    if ((_settlementCurrencyCode ?? '').isNotEmpty) return;
    final fromWidget = widget.settlementCurrencyCode?.trim();
    if (fromWidget != null && fromWidget.isNotEmpty) {
      if (!mounted) return;
      setState(() => _settlementCurrencyCode = fromWidget.toUpperCase());
      return;
    }

    final partyName =
        widget.item?.party?.trim().isNotEmpty == true ? widget.item!.party!.trim() : widget.settlementPartyName?.trim();
    final invoiceName = (widget.item?.invoiceName ?? widget.item?.parent)?.trim();

    try {
      final db = await getIt<LocalDb>().database;
      if (partyName != null && partyName.isNotEmpty) {
        final partyRows = await db.query(
          'Party',
          columns: ['currency'],
          where: 'name = ?',
          whereArgs: [partyName],
          limit: 1,
        );
        final partyCurrency = partyRows.isNotEmpty ? partyRows.first['currency']?.toString().trim() : null;
        if (partyCurrency != null && partyCurrency.isNotEmpty) {
          if (!mounted) return;
          setState(() => _settlementCurrencyCode = partyCurrency.toUpperCase());
          return;
        }
      }

      if (invoiceName != null && invoiceName.isNotEmpty) {
        for (final table in const ['SalesInvoice', 'PurchaseInvoice']) {
          final rows = await db.query(
            table,
            columns: ['currency'],
            where: 'name = ?',
            whereArgs: [invoiceName],
            limit: 1,
          );
          if (rows.isEmpty) continue;
          final invCurrency = rows.first['currency']?.toString().trim();
          if (invCurrency != null && invCurrency.isNotEmpty) {
            if (!mounted) return;
            setState(() => _settlementCurrencyCode = invCurrency.toUpperCase());
            return;
          }
        }
      }
    } catch (_) {
      // Keep reporting currency if lookup fails.
    }
  }

  void _syncRoleFromTabController() {
    if (!mounted || _suppressRoleTabListener || _roleTabController.indexIsChanging) return;
    final r = roleOptions[_roleTabController.index];
    if (r == selectedRole) return;
    setState(() {
      selectedRole = r;
      _selectedRoleNotifier.value = r;
      _invoiceTypeNotifier.value = _getInvoiceTypeForRole(r);
      _selectedPartiesNotifier.value = [];
    });
  }

  List<Party> _partiesForRoleKey(String roleKey) {
    return allParties.where((party) {
      final role = party.role.toLowerCase();
      switch (roleKey) {
        case 'customers':
          return role == 'customer';
        case 'suppliers':
          return role == 'supplier';
        case 'others':
          return role == 'both' || role == 'other' || role == 'employee';
        default:
          return false;
      }
    }).toList();
  }

  String _roleKeyForParty(Party p) {
    switch (p.role.toLowerCase()) {
      case 'customer':
        return 'customers';
      case 'supplier':
        return 'suppliers';
      default:
        return 'others';
    }
  }

  void _fetchPartiesFromApi({required bool showFullScreenLoading}) {
    if (widget.hideParties || !mounted) return;
    final term = _partySearchController.text.trim();
    context.read<EmployeeOutstandingCubit>().getEmployeeOutstanding(
          params: EmployeeOutstandingRequestParams(
            searchTerm: term,
            outstandingOnly: true,
          ),
          emitLoading: showFullScreenLoading,
        );
  }

  void _onPartySearchTextChanged(String _) {
    setState(() {});
    if (widget.hideParties || !_partySearchExpanded) return;
    _partySearchDebounce?.cancel();
    _partySearchDebounce = Timer(const Duration(milliseconds: 420), () {
      if (!mounted || widget.hideParties || !_partySearchExpanded) return;
      _fetchPartiesFromApi(showFullScreenLoading: false);
    });
  }

  void _onPartyListTileTapped(Party p, String roleKey) {
    HapticFeedback.mediumImpact();
    setState(() {
      selectedRole = roleKey;
      _selectedRoleNotifier.value = roleKey;
      _invoiceTypeNotifier.value = _getInvoiceTypeForRole(roleKey);
      _selectedPartiesNotifier.value = [p];
      final partyCurrency = p.currency.trim();
      _settlementCurrencyCode = partyCurrency.isNotEmpty ? partyCurrency.toUpperCase() : null;
      final o = p.outstandingAmount;
      if (o > 0) {
        _amountController.text = _formatAmountForField(o);
        _amountNotifier.value = _amountController.text;
      }
    });
    _openPaymentSettlementSheet();
  }

  void _openPaymentSettlementSheet() {
    if (_selectedPartiesNotifier.value.isEmpty) return;
    final party = _selectedPartiesNotifier.value.first;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) {
        final imeBottom = MediaQuery.viewInsetsOf(sheetCtx).bottom;
        final h = MediaQuery.sizeOf(sheetCtx).height;
        return Padding(
          padding: EdgeInsets.only(bottom: imeBottom),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: h * 0.92,
              decoration: BoxDecoration(
                color: _scaffoldBg,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              ),
              child: Column(
                children: [
                  SizedBox(height: 8.h),
                  Center(
                    child: Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: Theme.of(sheetCtx).colorScheme.outlineVariant,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                party.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(sheetCtx).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Payable: ${_formatRsSummary(party.outstandingAmount)}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(sheetCtx).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close_rounded),
                          onPressed: () => Navigator.pop(sheetCtx),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 28.h),
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      child: _buildPaymentFormColumn(sheetCtx, imeBottom),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatRsSummary(double value) => AppCurrencyFormatter.format(value, currencyCode: _currencyCode, decimals: 2);

  bool get _isTablet => DeviceLayout.isTablet(context);

  double? _sumInvoiceLineItems(InvoiceItem item) {
    final lines = item.items;
    if (lines == null || lines.isEmpty) return null;
    var s = 0.0;
    for (final d in lines) {
      if (d.amount != null) s += d.amount!;
    }
    return s > 0 ? s : null;
  }

  bool get _billSummaryHasInvoiceItem => widget.hideParties && widget.item != null;

  double _billSummaryItemTotal() {
    final item = widget.item;
    if (item != null) {
      final linesSum = _sumInvoiceLineItems(item);
      if (linesSum != null && linesSum > 0) return linesSum;
      if (item.grandTotal != null && item.grandTotal! > 0) return item.grandTotal!;
      final o = _invoiceAmountForSettlement(item);
      if (o != null && o > 0) return o;
    }
    final parsed = double.tryParse(_amountController.text.trim());
    if (parsed != null && parsed > 0) return parsed;
    if (!widget.hideParties && _selectedPartiesNotifier.value.isNotEmpty) {
      final o = _selectedPartiesNotifier.value.first.outstandingAmount;
      if (o > 0) return o;
    }
    final pnOut = widget.settlementPartyOutstanding;
    if (pnOut != null && pnOut > 0) return pnOut;
    final pre = widget.preselectOutstandingAmount;
    if (pre != null && pre > 0) return pre;
    return 0;
  }

  /// Already recorded against the invoice (`payment` lines, totals map, or grand − outstanding).
  double _billSummaryTotalPaidAmount() {
    final item = widget.item;
    if (item != null) {
      final payments = item.payment;
      if (payments != null && payments.isNotEmpty) {
        var s = 0.0;
        for (final p in payments) {
          if (p.amount != null) s += p.amount!;
        }
        if (s > 0) return s;
      }
      final pt = item.paymentTotals;
      if (pt != null && pt.isNotEmpty) {
        var s = 0.0;
        for (final v in pt.values) {
          if (v is num) s += v.toDouble();
        }
        if (s > 0) return s;
      }
      final g = item.grandTotal;
      final o = item.outstandingAmount;
      if (g != null && o != null) {
        final paid = g - o;
        if (paid > 0) return paid;
      }
    }
    return 0;
  }

  /// Net bill (after loyalty + summary discount) minus payments already recorded.
  double _billSummaryNetPayableMinusPaid() {
    final itemTotal = _billSummaryItemTotal();
    final loyaltyAmt = _invoiceLoyaltyDiscountAmount.clamp(0.0, itemTotal);
    final subTotal = (itemTotal - loyaltyAmt).clamp(0.0, double.infinity);
    final discountAmt = _billSummaryDiscountAmount(subTotal).clamp(0.0, subTotal);
    final netTotal = (subTotal - discountAmt).clamp(0.0, double.infinity);
    final paid = _billSummaryTotalPaidAmount();
    return (netTotal - paid).clamp(0.0, double.infinity);
  }

  /// Amount still owed. Sales & party flows follow bill-summary discount; purchase prefers API outstanding.
  double _billSummaryUnpaidAmount() {
    if (_billSummaryHasInvoiceItem && invoiceType == InvoiceType.purchase) {
      final o = widget.item!.outstandingAmount;
      if (o != null && o >= 0) return o;
    }
    return _billSummaryNetPayableMinusPaid();
  }

  /// Align tender with current unpaid; clears split payment. Call inside [setState].
  void _applyTenderFromUnpaidWithinState() {
    final unpaid = _billSummaryUnpaidAmount();
    if (_multiplePayment) {
      _multiplePayment = false;
      _multiplePaymentAmounts.clear();
    }
    if (unpaid > 0) {
      _amountController.text = _formatAmountForField(unpaid);
    } else {
      _amountController.clear();
    }
    _amountNotifier.value = _amountController.text;
  }

  double _billSummaryDiscountAmount(double subTotal) {
    if (_billSummaryHasInvoiceItem && invoiceType == InvoiceType.sales) {
      final t = _discountController.text.trim();
      if (t.isNotEmpty) {
        final p = double.tryParse(t);
        if (p != null && p >= 0) return p;
      }
      final inv = widget.item!;
      return inv.discountAmount ?? inv.totalDiscount ?? 0;
    }
    if (_billSummaryHasInvoiceItem && invoiceType == InvoiceType.purchase) {
      return 0;
    }
    return subTotal * _summaryDiscountPercent / 100;
  }

  double _billSummaryDiscountPercentLabel(double itemTotal, double discountAmt) {
    if (_billSummaryHasInvoiceItem && invoiceType == InvoiceType.sales) {
      final p = widget.item!.discountPercent;
      if (p != null && p > 0) return p;
      if (itemTotal > 0 && discountAmt > 0) return (discountAmt / itemTotal * 100);
      return 0;
    }
    if (_billSummaryHasInvoiceItem && invoiceType == InvoiceType.purchase) {
      return 0;
    }
    return _summaryDiscountPercent;
  }

  Future<void> _onBillSummaryViewItems() async {
    final emptyMessage = widget.item == null
        ? 'Line items appear when you open settlement from an invoice. '
            '${context.l10n.partySettlementUsesUnpaidTotal}'
        : 'No line items on this invoice. Totals use the invoice summary.';

    await BillItemsBottomSheet.show(
      context,
      lines: widget.item?.items,
      emptyMessage: emptyMessage,
    );
  }

  Future<void> _onBillSummaryCalculationHint() async {
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Calculation'),
        content: Text(
          'Sub total is item total minus loyalty discount. Total amount also subtracts discount '
          '(sales invoice: editable amount; party settlement: % from Tap to Edit). '
          'Tender amount is what you submit for settlement.',
          style: Theme.of(ctx).textTheme.bodyMedium?.copyWith(height: 1.4),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text('OK')),
        ],
      ),
    );
  }

  Future<void> _onBillSummaryEditDiscount() async {
    if (_billSummaryHasInvoiceItem && invoiceType == InvoiceType.purchase) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invoice discount applies to sales invoices only'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final itemTotal = _billSummaryItemTotal();
    final loyaltyAmt = _invoiceLoyaltyDiscountAmount.clamp(0.0, itemTotal);
    final subTotal = (itemTotal - loyaltyAmt).clamp(0.0, double.infinity);

    final double initialDiscount;
    if (_billSummaryHasInvoiceItem && invoiceType == InvoiceType.sales) {
      final t = _discountController.text.trim();
      if (t.isNotEmpty) {
        initialDiscount = double.tryParse(t) ?? 0;
      } else {
        final inv = widget.item!;
        initialDiscount = inv.discountAmount ?? inv.totalDiscount ?? 0;
      }
    } else {
      initialDiscount = subTotal * _summaryDiscountPercent / 100;
    }

    final next = await EditDiscountSheet.show(
      context,
      subTotal: subTotal,
      initialDiscountAmount: initialDiscount.clamp(0, subTotal),
    );

    if (!mounted || next == null) return;

    setState(() {
      if (_billSummaryHasInvoiceItem && invoiceType == InvoiceType.sales) {
        if (next <= 0) {
          _discountController.clear();
        } else {
          _discountController.text = _formatAmountForField(next);
        }
      } else {
        _summaryDiscountPercent = subTotal > 0 ? ((next / subTotal) * 100).clamp(0.0, 100.0) : 0.0;
      }
      _applyTenderFromUnpaidWithinState();
    });
  }

  TextStyle _billSummaryLabelStyle(ThemeData theme, {bool isBold = false}) {
    return theme.textTheme.bodyMedium!.copyWith(
      fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
      fontSize: _isTablet ? 14.sp : 13.sp,
      color: theme.colorScheme.onSurfaceVariant,
      height: 1.25,
    );
  }

  TextStyle _billSummaryValueStyle(
    ThemeData theme, {
    bool isBold = false,
    Color? color,
  }) {
    return theme.textTheme.bodyMedium!.copyWith(
      fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
      fontSize: _isTablet ? 14.sp : 13.sp,
      color: color ?? theme.colorScheme.onSurface,
      height: 1.25,
    );
  }

  Widget _billSummaryRow(
    ThemeData theme,
    String label,
    String value, {
    bool isBold = false,
    Color? valueColor,
  }) {
    final labelStyle = _billSummaryLabelStyle(theme, isBold: isBold);
    final valueStyle = _billSummaryValueStyle(
      theme,
      isBold: isBold,
      color: valueColor,
    );
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: labelStyle,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.end,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: valueStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _billSummaryEditableRow(
    ThemeData theme, {
    required String label,
    required String value,
    required VoidCallback onEdit,
    Color? valueColor,
  }) {
    final labelStyle = _billSummaryLabelStyle(theme);
    final valueStyle = _billSummaryValueStyle(theme, color: valueColor);
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: labelStyle,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onEdit,
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                  child: Text(
                    'Tap to Edit',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      fontSize: _isTablet ? 13.sp : 12.sp,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Flexible(
                  child: Text(
                    value,
                    textAlign: TextAlign.end,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: valueStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillSummarySection(BuildContext context) {
    final theme = Theme.of(context);
    final itemTotal = _billSummaryItemTotal();
    final loyaltyAmt = _invoiceLoyaltyDiscountAmount.clamp(0.0, itemTotal);
    final subTotal = (itemTotal - loyaltyAmt).clamp(0.0, double.infinity);
    final discountAmt = _billSummaryDiscountAmount(subTotal).clamp(0.0, subTotal);
    final discountPctLabel = _billSummaryDiscountPercentLabel(itemTotal, discountAmt);
    final totalAmount = (subTotal - discountAmt).clamp(0.0, double.infinity);
    final totalPaid = _billSummaryTotalPaidAmount();
    final totalUnpaid = _billSummaryUnpaidAmount();

    return _settlementCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                'Bill Summary',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: _onBillSummaryViewItems,
                style: TextButton.styleFrom(
                  foregroundColor: _paidColor,
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text('View Items'),
              ),
            ],
          ),
          if (_showBillSummaryHint) ...[
            SizedBox(height: 10.h),
            Material(
              color: _infoTint,
              borderRadius: BorderRadius.circular(10.r),
              child: InkWell(
                onTap: _onBillSummaryCalculationHint,
                borderRadius: BorderRadius.circular(10.r),
                child: Padding(
                  padding: EdgeInsets.all(8.r),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.lightbulb_outline_rounded,
                            size: 20.sp,
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                          8.horizontalSpace,
                          Text(
                            'Tap to know more detailed calculation.',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onPrimaryContainer,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () => setState(() => _showBillSummaryHint = false),
                        borderRadius: BorderRadius.circular(20.r),
                        child: Padding(
                          padding: EdgeInsets.all(4.r),
                          child: Icon(
                            Icons.close_rounded,
                            size: 20.sp,
                            color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          SizedBox(height: 12.h),
          _billSummaryRow(theme, 'Item Total', _formatRsSummary(itemTotal)),
          if (LoyaltyFeatures.enabled)
            _billSummaryRow(
              theme,
              'Loyalty Discount',
              _formatRsSummary(loyaltyAmt),
            ),
          _billSummaryRow(
            theme,
            'Subtotal',
            _formatRsSummary(subTotal),
            isBold: true,
          ),
          _billSummaryEditableRow(
            theme,
            label: '- Discount (${discountPctLabel.toStringAsFixed(0)}%)',
            value: _formatRsSummary(discountAmt),
            onEdit: _onBillSummaryEditDiscount,
            valueColor: discountAmt > 0 ? theme.colorScheme.error : null,
          ),
          _billSummaryRow(
            theme,
            'Total Amount',
            _formatRsSummary(totalAmount),
            isBold: true,
          ),
          _billSummaryRow(
            theme,
            'Total paid',
            _formatRsSummary(totalPaid),
            valueColor: _paidColor,
            isBold: true,
          ),
          _billSummaryRow(
            theme,
            'Total unpaid',
            _formatRsSummary(totalUnpaid),
            valueColor: theme.colorScheme.error,
            isBold: true,
          ),
          _billSummaryRow(
            theme,
            'Payment status',
            'Unpaid / Credit',
          ),
        ],
      ),
    );
  }

  /// Payment UI used on invoice flow (inline) and party flow (bottom sheet).
  Widget _buildPaymentFormColumn(
    BuildContext context,
    double imeBottom, {
    bool includeDiscountAndInvoiceBanner = false,
  }) {
    return BlocConsumer<PaymentMethodsCubit, PaymentMethodsState>(
      listenWhen: (prev, curr) =>
          prev.paymentMethodNames() != curr.paymentMethodNames() ||
          (prev.maybeWhen(success: (_) => false, orElse: () => true) &&
              curr.maybeWhen(success: (_) => true, orElse: () => false)),
      listener: (context, state) {
        _syncPaymentMethodSelection(_resolvePaymentMethodLabels(state));
      },
      builder: (context, pmState) {
        final theme = Theme.of(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_paymentModePaid) ...[
              AnimatedBuilder(
                animation: Listenable.merge([
                  _amountNotifier,
                  _discountController,
                  _selectedPartiesNotifier,
                ]),
                builder: (context, _) => _buildBillSummarySection(context),
              ),
              SizedBox(height: 12.h),
            ],
            _buildPaymentModeCard(pmState, Theme.of(context)),
            SizedBox(height: 12.h),
            if (_paymentModePaid) ...[
              if (!_multiplePayment) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tender Amount',
                      style: AppFonts.interStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: _isTablet ? 320 : double.infinity,
                        ),
                        child: CustomTextFormField(
                          hint: '0.00',
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.none,
                          scrollPadding: EdgeInsets.only(bottom: imeBottom + 220),
                          borderRadius: 10,
                          height: _isTablet ? 48.h : 50.h,
                          useFixedSizes: _isTablet,
                          prefixText: '$_currencyDisplaySymbol ',
                          onChanged: (value) {
                            _amountNotifier.value = value;
                          },
                          validating: (value) {
                            if (!_paymentModePaid) return null;
                            if (value == null || value.trim().isEmpty) {
                              return 'Amount is required';
                            }
                            final amount = double.tryParse(value.trim());
                            if (amount == null || amount <= 0) {
                              return 'Please enter a valid amount greater than 0';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
              ],
              _buildDateField('Payment Date', _paymentDateController, (date) {
                paymentDate = date;
                _paymentDateNotifier.value = date;
              }),
            ],
            // if (includeDiscountAndInvoiceBanner && _paymentModePaid) ...[
            //   ValueListenableBuilder<InvoiceType>(
            //     valueListenable: _invoiceTypeNotifier,
            //     builder: (context, invType, _) {
            //       if (invType != InvoiceType.sales && invType != InvoiceType.purchase) {
            //         return const SizedBox.shrink();
            //       }
            //       return Column(
            //         crossAxisAlignment: CrossAxisAlignment.stretch,
            //         children: [
            //           SizedBox(height: 16.h),
            //           CustomTextFormField(
            //             hint: 'Discount',
            //             controller: _discountController,
            //             keyboardType: const TextInputType.numberWithOptions(decimal: true),
            //             textInputAction: TextInputAction.done,
            //             textCapitalization: TextCapitalization.none,
            //             scrollPadding: EdgeInsets.only(bottom: imeBottom + 220),
            //             validating: (value) {
            //               if (value == null || value.trim().isEmpty) return null;
            //               final d = double.tryParse(value.trim());
            //               if (d == null || d < 0) {
            //                 return 'Enter a valid discount (0 or greater)';
            //               }
            //               return null;
            //             },
            //           ),
            //         ],
            //       );
            //     },
            //   ),
            // ],
            SizedBox(height: 20.h),
            ValueListenableBuilder<List<Party>>(
              valueListenable: _selectedPartiesNotifier,
              builder: (context, selectedParties, child) {
                return ValueListenableBuilder<String>(
                  valueListenable: _amountNotifier,
                  builder: (context, amountText, child) {
                    return CustomButtonWidget(
                      width: _isTablet ? double.infinity : MediaQuery.sizeOf(context).width,
                      title: 'Process Settlement',
                      onPressed: _paymentModePaid && _isFormValid(selectedParties, amountText)
                          ? () {
                              if (_isFormValid(selectedParties, amountText)) {
                                _submitForm();
                              }
                            }
                          : null,
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildPartyListForRole(String roleKey) {
    final theme = Theme.of(context);
    final filtered = _partiesForRoleKey(roleKey);
    if (allParties.isEmpty) {
      return Center(
        child: Text('Loading parties…', style: AppFonts.interStyle(color: theme.colorScheme.onSurfaceVariant)),
      );
    }
    if (filtered.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Text(
            'No parties in this category',
            textAlign: TextAlign.center,
            style: AppFonts.interStyle(color: theme.colorScheme.onSurfaceVariant),
          ),
        ),
      );
    }
    return ValueListenableBuilder<List<Party>>(
      valueListenable: _selectedPartiesNotifier,
      builder: (context, selected, _) {
        final sel = selected.isNotEmpty ? selected.first : null;
        return ListView.separated(
          padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 24.h),
          itemCount: filtered.length,
          separatorBuilder: (_, __) => verticalMarginSmall,
          itemBuilder: (context, i) {
            final p = filtered[i];
            final isSel = sel != null && sel.name == p.name && sel.role == p.role;
            return Material(
              color: isSel ? theme.colorScheme.primary.withOpacity(0.09) : _cardBg,
              borderRadius: BorderRadius.circular(12.r),
              child: ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                title: Text(p.name, style: AppFonts.interStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(
                  '${p.currency} ${p.outstandingAmount.toStringAsFixed(2)}',
                ),
                trailing: Icon(Icons.payments_outlined, color: theme.colorScheme.primary),
                onTap: () => _onPartyListTileTapped(p, roleKey),
              ),
            );
          },
        );
      },
    );
  }

  /// Single list while search field is open (API-filtered, no role tabs).
  Widget _buildPartyFlatSearchList() {
    final theme = Theme.of(context);
    if (allParties.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Text(
            'No results',
            textAlign: TextAlign.center,
            style: AppFonts.interStyle(color: theme.colorScheme.onSurfaceVariant),
          ),
        ),
      );
    }
    return ValueListenableBuilder<List<Party>>(
      valueListenable: _selectedPartiesNotifier,
      builder: (context, selected, _) {
        final sel = selected.isNotEmpty ? selected.first : null;
        return ListView.separated(
          padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 24.h),
          itemCount: allParties.length,
          separatorBuilder: (_, __) => verticalMarginSmall,
          itemBuilder: (context, i) {
            final p = allParties[i];
            final rk = _roleKeyForParty(p);
            final isSel = sel != null && sel.name == p.name && sel.role == p.role;
            return Material(
              color: isSel ? theme.colorScheme.primary.withOpacity(0.09) : _cardBg,
              borderRadius: BorderRadius.circular(12.r),
              child: ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                title: Text(p.name, style: AppFonts.interStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(
                  '${p.role} · ${p.currency} ${p.outstandingAmount.toStringAsFixed(2)}',
                ),
                trailing: Icon(Icons.payments_outlined, color: theme.colorScheme.primary),
                onTap: () => _onPartyListTileTapped(p, rk),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPartySearchResultsBody() {
    if (_partySearchExpanded) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Padding(
          //   padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 6.h),
          //   child: Text(
          //     '${allParties.length} ${allParties.length == 1 ? 'result' : 'results'}',
          //     style: AppFonts.interStyle(fontSize: 12.sp, color: Colors.grey[600]),
          //   ),
          // ),
          Expanded(child: _buildPartyFlatSearchList()),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Material(
          color: _cardBg,
          elevation: 0.5,
          shadowColor: _scheme.shadow.withValues(alpha: 0.12),
          child: TabBar(
            controller: _roleTabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 4,
            indicatorPadding: EdgeInsets.zero,
            labelPadding: EdgeInsets.only(left: 28.w),
            labelColor: context.theme.colorScheme.primary,
            unselectedLabelColor: context.theme.colorScheme.onSurfaceVariant,
            indicatorColor: context.theme.colorScheme.primary,
            dividerColor: Colors.transparent,
            labelStyle: context.theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.theme.colorScheme.primary,
            ),
            unselectedLabelStyle: context.theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.theme.colorScheme.onSurfaceVariant,
            ),
            tabs: const [
              Tab(text: 'Customers'),
              Tab(text: 'Suppliers'),
              Tab(text: 'Others'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _roleTabController,
            children: [
              _buildPartyListForRole('customers'),
              _buildPartyListForRole('suppliers'),
              _buildPartyListForRole('others'),
            ],
          ),
        ),
      ],
    );
  }

  void _collapsePartySearchBar() {
    _partySearchFocusNode.unfocus();
    _partySearchDebounce?.cancel();
    if (!mounted) return;
    _partySearchController.clear();
    setState(() => _partySearchExpanded = false);
    _fetchPartiesFromApi(showFullScreenLoading: false);
  }

  PreferredSizeWidget _buildSettlementAppBar() {
    final scheme = _scheme;
    if (widget.hideParties) {
      return AppBar(
        backgroundColor: _cardBg,
        elevation: 0,
        foregroundColor: scheme.onSurface,
        leading: AppBarIosBackButton(
          color: scheme.onSurfaceVariant,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Payment Settlement',
          style: AppFonts.interStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: scheme.onSurface),
        ),
        toolbarHeight: 80,
      );
    }

    Widget roundedBackButton({required Color background, required VoidCallback onPressed}) {
      return Material(
        color: background,
        borderRadius: BorderRadius.circular(14.r),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(14.r),
          child: SizedBox(
            width: 44.w,
            height: 44.h,
            child: Icon(Icons.chevron_left_rounded, color: scheme.onSurface, size: 28.sp),
          ),
        ),
      );
    }

    if (!_partySearchExpanded) {
      return AppBar(
        backgroundColor: _cardBg,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        toolbarHeight: 56,
        titleSpacing: 0,
        foregroundColor: scheme.onSurface,
        title: Padding(
          padding: EdgeInsets.only(left: 8.w, right: 4.w, top: 6.h, bottom: 6.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              roundedBackButton(
                background: scheme.surfaceContainerHighest,
                onPressed: () => Navigator.of(context).pop(),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  'Payment Settlement',
                  style: AppFonts.interStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: scheme.onSurface),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Search',
            icon: AppSearchIcon(color: scheme.onSurfaceVariant, size: 26.sp),
            onPressed: () {
              setState(() => _partySearchExpanded = true);
              _fetchPartiesFromApi(showFullScreenLoading: true);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) _partySearchFocusNode.requestFocus();
              });
            },
          ),
          SizedBox(width: 4.w),
        ],
      );
    }

    return AppBar(
      backgroundColor: _cardBg,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      toolbarHeight: 56,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.only(left: 8.w, right: 12.w, top: 6.h, bottom: 6.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            roundedBackButton(
              background: _searchFill,
              onPressed: _collapsePartySearchBar,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: CustomTextFormField(
                height: 40.h,
                controller: _partySearchController,
                focusNode: _partySearchFocusNode,
                onChanged: _onPartySearchTextChanged,
                textInputAction: TextInputAction.search,
                suffixIcon: _partySearchController.text.isNotEmpty
                    ? IconButton(
                        tooltip: 'Clear',
                        icon: Icon(Icons.clear_rounded, color: scheme.onSurfaceVariant),
                        onPressed: () {
                          _partySearchController.clear();
                          _onPartySearchTextChanged('');
                        },
                      )
                    : null,
                hint: 'Search here',
                hintStyle: AppFonts.interStyle(color: scheme.onSurfaceVariant),
                prefixIcon: AppSearchIcon.inputDecoration(color: scheme.onSurfaceVariant),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> _resolvePaymentMethodLabels(PaymentMethodsState state) {
    if (state.maybeWhen(error: (_) => true, noInternet: () => true, orElse: () => false)) {
      return List<String>.from(_kFallbackPaymentMethods);
    }
    final api = state.paymentMethodNames();
    if (api.isEmpty) {
      if (state.maybeWhen(loading: () => true, orElse: () => false)) {
        return const [];
      }
      return List<String>.from(_kFallbackPaymentMethods);
    }
    final out = List<String>.from(api);
    // final hasSettlement = out.any((e) => e.trim().toLowerCase() == 'settlement');
    // if (!hasSettlement) {
    //   out.add('Settlement');
    // }
    return out;
  }

  void _syncPaymentMethodSelection(List<String> methods) {
    if (methods.isEmpty) return;
    final cur = _selectedPaymentMethodNotifier.value;
    if (!methods.contains(cur)) {
      _selectedPaymentMethodNotifier.value = methods.first;
    }
  }

  /// Matches [InvoiceCard] trailing amount: use outstanding when &gt; 0, otherwise grand total.
  double? _invoiceAmountForSettlement(InvoiceItem? item) {
    if (item == null) return null;
    final o = item.outstandingAmount;
    if (o != null && o > 0) return o;
    final g = item.grandTotal;
    if (g != null && g > 0) return g;
    return null;
  }

  double? _grandTotalForPartialSplit() {
    final t = double.tryParse(_amountController.text.trim());
    if (t != null && t > 0) return t;
    if (widget.hideParties) {
      final fromItem = _invoiceAmountForSettlement(widget.item);
      if (fromItem != null && fromItem > 0) return fromItem;
    }
    final parties = _selectedPartiesNotifier.value;
    if (!widget.hideParties && parties.isNotEmpty) {
      final o = parties.first.outstandingAmount;
      if (o > 0) return o;
    }
    return null;
  }

  String _dominantApiMethodFromMap(Map<String, double> m) {
    if (m.isEmpty) return normalizePaymentMethodForApi(_selectedPaymentMethodNotifier.value);
    return m.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
  }

  String _displayNameForApiKey(String apiKey, List<String> displayMethods) {
    for (final d in displayMethods) {
      if (normalizePaymentMethodForApi(d) == apiKey) return d;
    }
    return apiKey;
  }

  void _applyPartialSplitResult(Map<String, double> data) {
    if (!mounted) return;
    setState(() {
      _multiplePaymentAmounts = Map<String, double>.from(data);
      final sum = data.values.fold<double>(0, (a, b) => a + b);
      _amountController.text = _formatAmountForField(sum);
      _amountNotifier.value = _amountController.text;
      final dominant = _dominantApiMethodFromMap(data);
      final displays = _resolvePaymentMethodLabels(context.read<PaymentMethodsCubit>().state);
      _selectedPaymentMethodNotifier.value = _displayNameForApiKey(dominant, displays);
    });
  }

  Future<Map<String, double>?> _openPartialPaymentPreviewAndReturn() async {
    final total = _grandTotalForPartialSplit();
    if (total == null || total <= 0) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.l10n.selectPartyWithUnpaidFirst),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      return null;
    }
    final pmCubit = context.read<PaymentMethodsCubit>();
    final accent = Theme.of(context).colorScheme.primary;
    final isTablet = DeviceLayout.isTablet(context);

    Widget buildPreview(BuildContext sheetCtx) {
      final viewInsets = MediaQuery.viewInsetsOf(sheetCtx).bottom;
      return Padding(
        padding: EdgeInsets.only(bottom: viewInsets),
        child: isTablet
            ? BlocProvider<PaymentMethodsCubit>.value(
                value: pmCubit,
                child: PartialPaymentPreviewPage(
                  total: total,
                  accent: accent,
                  initialAmounts:
                      _multiplePaymentAmounts.isEmpty ? null : Map<String, double>.from(_multiplePaymentAmounts),
                  paymentMethodNames: null,
                  embedInSheet: true,
                ),
              )
            : Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: MediaQuery.sizeOf(sheetCtx).height * 0.93,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                    child: BlocProvider<PaymentMethodsCubit>.value(
                      value: pmCubit,
                      child: PartialPaymentPreviewPage(
                        total: total,
                        accent: accent,
                        initialAmounts:
                            _multiplePaymentAmounts.isEmpty ? null : Map<String, double>.from(_multiplePaymentAmounts),
                        paymentMethodNames: null,
                        embedInSheet: true,
                      ),
                    ),
                  ),
                ),
              ),
      );
    }

    if (isTablet) {
      return showDialog<Map<String, double>?>(
        context: context,
        barrierDismissible: true,
        builder: buildPreview,
      );
    }

    return showModalBottomSheet<Map<String, double>?>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: buildPreview,
    );
  }

  Future<void> _onMultiplePaymentSwitch(bool v) async {
    if (!v) {
      setState(() {
        _multiplePayment = false;
        _multiplePaymentAmounts.clear();
      });
      return;
    }
    setState(() => _multiplePayment = true);
    // Let the switch frame apply; avoids rare cases where an immediate push is dropped.
    await WidgetsBinding.instance.endOfFrame;
    if (!mounted) return;
    final data = await _openPartialPaymentPreviewAndReturn();
    if (!mounted) return;
    if (data == null) {
      setState(() {
        _multiplePayment = false;
      });
      return;
    }
    _applyPartialSplitResult(data);
  }

  Future<void> _editPartialSplit() async {
    if (!_multiplePayment) return;
    final data = await _openPartialPaymentPreviewAndReturn();
    if (!mounted || data == null) return;
    _applyPartialSplitResult(data);
  }

  String _formatPartialSplitSummary(List<String> displayMethods) {
    if (_multiplePaymentAmounts.isEmpty) return '';
    return _multiplePaymentAmounts.entries.where((e) => e.value > 0).map((e) {
      final label = _displayNameForApiKey(e.key, displayMethods);
      return '$label: ${_formatRsSummary(e.value)}';
    }).join(' · ');
  }

  double _multiplePaymentSum() => _multiplePaymentAmounts.values.fold<double>(0, (a, b) => a + b);

  Widget _buildMultiplePaymentBreakdown(ThemeData theme, List<String> displayMethods) {
    final entries = _multiplePaymentAmounts.entries.where((e) => e.value > 0).toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    if (entries.isEmpty) return const SizedBox.shrink();
    final sum = _multiplePaymentSum();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.h),
        ...entries.map((e) {
          final label = _displayNameForApiKey(e.key, displayMethods);
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Row(
              children: [
                Expanded(child: Text(label, style: theme.textTheme.labelLarge)),
                Text(
                  _formatRsSummary(e.value),
                  style: theme.textTheme.labelLarge,
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
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                _formatRsSummary(sum),
                style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _settlementCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(_isTablet ? 18.r : 14.r),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(_isTablet ? 16.r : 14.r),
        border: Border.all(color: _cardBorder),
      ),
      child: child,
    );
  }

  Widget _buildPaymentMethodChips(List<String> methods) {
    final scheme = _scheme;
    final unselectedFill = scheme.surfaceContainerHighest;
    final unselectedBorder = scheme.outlineVariant.withValues(alpha: 0.6);
    final selectedFill = scheme.primaryContainer;
    final selectedBorder = scheme.primary;
    final chipHPad = _isTablet ? 18.sp : 12.sp;
    final chipVPad = _isTablet ? 12.sp : 6.sp;
    final chipRadius = _isTablet ? 10.sp : 4.sp;

    return ValueListenableBuilder<String>(
      valueListenable: _selectedPaymentMethodNotifier,
      builder: (context, sel, _) {
        return Wrap(
          spacing: _isTablet ? 10 : 8,
          runSpacing: _isTablet ? 10 : 8,
          alignment: WrapAlignment.start,
          children: methods.map((m) {
            final isSel = m == sel;
            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: methods.isEmpty
                    ? null
                    : () {
                        HapticFeedback.selectionClick();
                        _selectedPaymentMethodNotifier.value = m;
                      },
                borderRadius: BorderRadius.circular(chipRadius),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: chipHPad, vertical: chipVPad),
                  decoration: BoxDecoration(
                    color: isSel ? selectedFill : unselectedFill,
                    borderRadius: BorderRadius.circular(chipRadius),
                    border: Border.all(
                      color: isSel ? selectedBorder : unselectedBorder,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    m,
                    style: context.theme.textTheme.labelMedium?.copyWith(
                      color: isSel ? scheme.onPrimaryContainer : scheme.onSurface,
                      fontWeight: isSel ? FontWeight.w600 : FontWeight.w500,
                      fontSize: _isTablet ? 14.sp : null,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildPaymentModeCard(PaymentMethodsState pmState, ThemeData theme) {
    final primary = theme.colorScheme.primary;
    final methods = _resolvePaymentMethodLabels(pmState);
    final loading = pmState.maybeWhen(loading: () => true, orElse: () => false);

    return _settlementCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Mode *',
            style: AppFonts.interStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 10.h),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Material(
          //         color: Colors.transparent,
          //         child: InkWell(
          //           onTap: () => setState(() => _paymentModePaid = true),
          //           borderRadius: BorderRadius.circular(10.r),
          //           child: Container(
          //             height: 46.h,
          //             alignment: Alignment.center,
          //             decoration: BoxDecoration(
          //               color: _paymentModePaid ? _paidColor : Colors.white,
          //               borderRadius: BorderRadius.circular(10.r),
          //               border: Border.all(color: _paidColor, width: 1.5),
          //             ),
          //             child: Text(
          //               'Paid',
          //               style: AppFonts.interStyle(
          //                 fontWeight: FontWeight.w600,
          //                 fontSize: 15.sp,
          //                 color: _paymentModePaid ? Colors.white : _paidColor,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //     SizedBox(width: 10.w),
          //     Expanded(
          //       child: Material(
          //         color: Colors.transparent,
          //         child: InkWell(
          //           onTap: () => setState(() => _paymentModePaid = false),
          //           borderRadius: BorderRadius.circular(10.r),
          //           child: Container(
          //             height: 46.h,
          //             alignment: Alignment.center,
          //             decoration: BoxDecoration(
          //               color: !_paymentModePaid ? _paidColor : Colors.white,
          //               borderRadius: BorderRadius.circular(10.r),
          //               border: Border.all(color: _paidColor, width: 1.5),
          //             ),
          //             child: Text(
          //               'Unpaid / Credit',
          //               textAlign: TextAlign.center,
          //               style: AppFonts.interStyle(
          //                 fontWeight: FontWeight.w600,
          //                 fontSize: 12.sp,
          //                 color: !_paymentModePaid ? Colors.white : _paidColor,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          if (_paymentModePaid) ...[
            SizedBox(height: 14.h),
            if (loading)
              Row(
                children: [
                  SizedBox(
                    width: 18.w,
                    height: 18.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: primary,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Loading payment methods…',
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ],
              )
            else if (!_multiplePayment)
              _buildPaymentMethodChips(methods)
            else if (_multiplePayment && _multiplePaymentAmounts.values.any((v) => v > 0))
              Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment split',
                      style: AppFonts.interStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      _formatPartialSplitSummary(methods),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Text(
                  'Multiple Payment',
                  style: AppFonts.interStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(Icons.help_outline_rounded, size: 16.sp, color: theme.colorScheme.onSurfaceVariant),
                const Spacer(),
                if (_multiplePayment)
                  IconButton(
                    onPressed: _editPartialSplit,
                    icon: Icon(Icons.edit_outlined, size: 20.sp, color: primary),
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                    tooltip: 'Edit split',
                  ),
                Transform.scale(
                  scale: 0.82,
                  alignment: Alignment.centerRight,
                  child: Switch.adaptive(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: _multiplePayment,
                    onChanged: (v) => _onMultiplePaymentSwitch(v),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: _infoTint,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                'Turn this ON, if customer pay via Multiple payment mode or make Partial payments.',
                style: theme.textTheme.bodySmall?.copyWith(
                  height: 1.35,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            if (_multiplePayment && _multiplePaymentSum() > 0) _buildMultiplePaymentBreakdown(theme, methods),
          ] else ...[
            SizedBox(height: 12.h),
            Text(
              'Turn Paid on to choose a payment method and record a settlement.',
              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  // Get invoice type based on selected role
  InvoiceType get invoiceType {
    return _invoiceTypeNotifier.value;
  }

  // Check if the form is valid for submission using ValueNotifiers
  bool _isFormValid(List<Party> selectedParties, String amountText) {
    if (!_paymentModePaid) return false;
    final amount = double.tryParse(amountText.trim());
    if (!widget.hideParties) {
      return selectedParties.isNotEmpty && amountText.trim().isNotEmpty && amount != null && amount > 0;
    } else {
      return amount != null && amount > 0;
    }
  }

  // Extract parties from API response - simplified to work with Party objects
  void _updatePartiesFromApiResponse(EmployeeOutstandingResponse apiResponse) {
    allParties.clear();

    // Add all parties from different roles
    allParties.addAll(apiResponse.partiesByRole.customerParties);
    allParties.addAll(apiResponse.partiesByRole.supplierParties);
    allParties.addAll(apiResponse.partiesByRole.employeeParties);
    allParties.addAll(apiResponse.partiesByRole.otherParties);

    _allPartiesNotifier.value = List.from(allParties);
    _tryApplyPreselectedParty();
  }

  void _tryApplyPreselectedParty() {
    if (widget.hideParties || _preselectApplied) return;
    final raw = widget.preselectPartyName;
    if (raw == null || raw.trim().isEmpty) return;

    final want = raw.trim();
    Party? found;
    for (final p in allParties) {
      if (p.name.trim() == want) {
        found = p;
        break;
      }
    }
    if (found == null) {
      final wantLower = want.toLowerCase();
      for (final p in allParties) {
        if (p.name.trim().toLowerCase() == wantLower) {
          found = p;
          break;
        }
      }
    }
    if (found == null) return;

    switch (found.role.toLowerCase()) {
      case 'customer':
        selectedRole = 'customers';
        break;
      case 'supplier':
        selectedRole = 'suppliers';
        break;
      default:
        selectedRole = 'others';
    }
    _selectedRoleNotifier.value = selectedRole;
    _invoiceTypeNotifier.value = _getInvoiceTypeForRole(selectedRole);
    _selectedPartiesNotifier.value = [found];
    final partyCurrency = found.currency.trim();
    if (partyCurrency.isNotEmpty) {
      _settlementCurrencyCode = partyCurrency.toUpperCase();
    }

    final preset = widget.preselectOutstandingAmount;
    final amount = (preset != null && preset > 0) ? preset : found.outstandingAmount;
    if (amount > 0) {
      _amountController.text = _formatAmountForField(amount);
      _amountNotifier.value = _amountController.text;
    }
    _preselectApplied = true;
    if (mounted) setState(() {});
    final idx = roleOptions.indexOf(selectedRole);
    Future<void> openPaymentSheetDeferred() async {
      await WidgetsBinding.instance.endOfFrame;
      if (!mounted) return;
      _openPaymentSettlementSheet();
    }

    if (idx >= 0 && _roleTabController.index != idx) {
      _suppressRoleTabListener = true;
      _roleTabController.animateTo(idx);
      void afterTabSettled(Duration _) {
        if (!mounted) return;
        if (_roleTabController.indexIsChanging) {
          WidgetsBinding.instance.addPostFrameCallback(afterTabSettled);
          return;
        }
        _suppressRoleTabListener = false;
        openPaymentSheetDeferred();
      }

      WidgetsBinding.instance.addPostFrameCallback(afterTabSettled);
    } else {
      openPaymentSheetDeferred();
    }
  }

  Widget _buildLoadingState() {
    final scheme = _scheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(scheme.primary),
            strokeWidth: 3,
          ),
          SizedBox(height: 24.h),
          Text(
            'Loading parties...',
            style: AppFonts.interStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: scheme.onSurface,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Please wait while we fetch the party data',
            style: AppFonts.interStyle(
              fontSize: 14.sp,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String title, String message, IconData icon) {
    final scheme = _scheme;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64.sp, color: scheme.onSurfaceVariant),
            SizedBox(height: 24.h),
            Text(
              title,
              style: AppFonts.interStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: scheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            Text(
              message,
              style: AppFonts.interStyle(
                fontSize: 14.sp,
                color: scheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            ElevatedButton.icon(
              onPressed: () {
                _fetchPartiesFromApi(showFullScreenLoading: true);
              },
              icon: Icon(Icons.refresh, color: scheme.onPrimary),
              label: Text('Retry', style: AppFonts.interStyle(color: scheme.onPrimary)),
              style: ElevatedButton.styleFrom(
                backgroundColor: scheme.primary,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Party directory modal: same header pattern as party-flow payment sheet.
  Widget _buildPartyDirectorySheetBody() {
    final scheme = _scheme;
    final name = widget.settlementPartyName?.trim() ?? '';
    final payable = widget.settlementPartyOutstanding;
    return ColoredBox(
      color: _scaffoldBg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 8.h),
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: scheme.outlineVariant,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 4.w, 8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (payable != null) ...[
                        SizedBox(height: 6.h),
                        Text(
                          'Payable: $payable',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close_rounded, color: scheme.onSurfaceVariant),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: scheme.outlineVariant.withValues(alpha: 0.5)),
          Expanded(child: _buildMainContent()),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    final imeBottom = MediaQuery.viewInsetsOf(context).bottom;
    final safeBottom = MediaQuery.paddingOf(context).bottom;
    final scrollPadBottom = 40.0 + imeBottom + safeBottom + (imeBottom > 0 ? 160.0 : 32.0);
    final horizontalPad = _isTablet ? 24.sp : 8.sp;
    final topPad = _isTablet ? 16.sp : 8.sp;

    final form = _buildPaymentFormColumn(
      context,
      imeBottom,
      includeDiscountAndInvoiceBanner: true,
    );

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
              padding: EdgeInsets.fromLTRB(horizontalPad, topPad, horizontalPad, scrollPadBottom),
              child: _isTablet ? SetupTabletContentWidth(maxWidth: 640, child: form) : form,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentMethodsCubit>.value(
      value: _paymentMethodsCubit,
      child: MultiBlocListener(
        listeners: [
          BlocListener<PartialSettlementCubit, PartialSettlementState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () => null,
                error: (message) {
                  AppLoadingOverlay.of(context).hide();
                },
                success: (response) {
                  if (widget.hideParties) {
                    widget.onCompleted?.call();
                  }
                  AppLoadingOverlay.of(context).hide();
                  context.showKiiSnackBarSuccess(response.message);

                  Navigator.of(context).pop(response);
                },
                loading: () {
                  AppLoadingOverlay.of(context).show();
                },
              );
            },
          ),
        ],
        child: PopScope(
          canPop: widget.hideParties || !_partySearchExpanded,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            _collapsePartySearchBar();
          },
          child: Scaffold(
            // If true, [MediaQuery.viewInsets] in the body is often cleared and bottom padding is wrong — can't scroll to the button.
            resizeToAvoidBottomInset: false,
            backgroundColor: _scaffoldBg,
            appBar: (widget.showAsBottomSheet && widget.hideParties) ? null : _buildSettlementAppBar(),
            body: widget.hideParties
                ? (widget.showAsBottomSheet ? _buildPartyDirectorySheetBody() : _buildMainContent())
                : BlocConsumer<EmployeeOutstandingCubit, EmployeeOutstandingState>(
                    listener: (context, state) {
                      state.when(
                        initial: () {},
                        loading: () {},
                        noInternet: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('No internet connection. Please check your network.'),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        error: (message) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error loading parties: $message'),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        success: (response) {
                          response.data.when(
                            search: _updatePartiesFromApiResponse,
                            employeePartyLookup: (r) => _updatePartiesFromApiResponse(
                              r.toLegacyEmployeeOutstandingResponse(),
                            ),
                          );
                        },
                      );
                    },
                    builder: (context, state) {
                      return state.when(
                        initial: () => _buildLoadingState(),
                        loading: () => allParties.isNotEmpty ? _buildPartySearchResultsBody() : _buildLoadingState(),
                        noInternet: () => _buildErrorState(
                            'No Internet Connection', 'Please check your network and try again.', Icons.wifi_off),
                        error: (message) => _buildErrorState('Error Loading Data', message, Icons.error_outline),
                        success: (response) => _buildPartySearchResultsBody(),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }

  InvoiceType _getInvoiceType(String role) {
    switch (role) {
      case 'customers':
      case 'customer':
        return InvoiceType.sales;
      case 'suppliers':
        return InvoiceType.purchase;
      default:
        // Employees / others → sales (same as `others` tab).
        return InvoiceType.sales;
    }
  }

  InvoiceType _getInvoiceTypeForRole(String role) {
    switch (role) {
      case 'customers':
        return InvoiceType.sales;
      case 'suppliers':
        return InvoiceType.purchase;
      case 'others':
        return InvoiceType.sales;
      default:
        return InvoiceType.sales;
    }
  }

  void _prefillDiscountFromItem() {
    if (!widget.hideParties) return;
    final inv = _invoiceTypeNotifier.value;
    if (inv != InvoiceType.sales) return;
    final item = widget.item;
    if (item == null) return;
    final d = item.discountAmount ?? item.totalDiscount;
    if (d == null || d == 0) return;
    _discountController.text = _formatAmountForField(d);
  }

  String _formatAmountForField(double d) => AppMoneyFormat.formatAmountForField(d);

  /// `discount_amount` — only for [sales_invoice_name] mode (server applies delta vs existing discount).
  double? _discountAmountForPartialSettlement() {
    if (!widget.hideParties) return null;
    if (invoiceType != InvoiceType.sales) return null;
    final text = _discountController.text.trim();
    if (text.isNotEmpty) {
      return double.tryParse(text);
    }
    final item = widget.item;
    if (item == null) return null;
    return item.discountAmount ?? item.totalDiscount;
  }

  Widget _buildDateField(String label, TextEditingController controller, Function(DateTime) onDateChanged) {
    final scheme = _scheme;
    return CustomTextFormField(
      labelText: label,
      controller: controller,
      readOnly: true,
      borderRadius: 10,
      height: _isTablet ? 48.h : 50.h,
      useFixedSizes: _isTablet,
      suffixIcon: Icon(
        Icons.calendar_today_rounded,
        color: scheme.onSurfaceVariant,
        size: 18.sp,
      ),
      onTap: () {
        unawaited(_pickPaymentDate(controller, onDateChanged));
      },
    );
  }

  Future<void> _pickPaymentDate(
    TextEditingController controller,
    Function(DateTime) onDateChanged,
  ) async {
    final date = await showDatePicker(
      context: context,
      initialDate: paymentDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (!mounted || date == null) return;
    controller.text = _formatDate(date);
    onDateChanged(date);
  }

  /// [CustomTextFormField] outer [FormField] value is not synced from [TextEditingController]
  /// until the user types; `Form.validate()` would fail on pre-filled amount/discount. Validate from controllers instead.
  bool _validatePaymentControllers() {
    final amountText = _amountController.text.trim();
    if (amountText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Amount is required'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return false;
    }
    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid amount greater than 0'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return false;
    }
    if (widget.hideParties && invoiceType == InvoiceType.sales) {
      final discountText = _discountController.text.trim();
      if (discountText.isNotEmpty) {
        final d = double.tryParse(discountText);
        if (d == null || d < 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Enter a valid discount (0 or greater)'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
          return false;
        }
      }
    }
    return true;
  }

  List<PartialSettlementPaymentLine> _buildSettlementPaymentLines({
    required String apiPaymentMethod,
    required double totalAmount,
  }) {
    final payDate = formatDate(paymentDate!);
    if (_multiplePayment && _multiplePaymentAmounts.isNotEmpty) {
      final lines = _multiplePaymentAmounts.entries.where((e) => e.value > 0).map((e) {
        final method = e.key;
        final needsRef = method != 'Cash';
        return PartialSettlementPaymentLine(
          paymentMethod: method,
          amount: e.value,
          referenceId: needsRef ? generateReferenceId(method) : null,
          referenceDate: needsRef ? payDate : null,
          clearanceDate: needsRef ? payDate : null,
        );
      }).toList();
      if (lines.isNotEmpty) return lines;
    }
    final needsRef = apiPaymentMethod != 'Cash';
    return [
      PartialSettlementPaymentLine(
        paymentMethod: apiPaymentMethod,
        amount: totalAmount,
        referenceId: needsRef ? generateReferenceId(apiPaymentMethod) : null,
        referenceDate: needsRef ? payDate : null,
        clearanceDate: needsRef ? payDate : null,
      ),
    ];
  }

  void _submitForm() {
    if (!_paymentModePaid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Select Paid to record a settlement'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    if (!_validatePaymentControllers()) return;
    if (_multiplePayment && _multiplePaymentAmounts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Turn on Multiple Payment and complete the split'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    if (!_isFormValid(_selectedPartiesNotifier.value, _amountNotifier.value)) return;

    final amount = double.tryParse(_amountNotifier.value.trim());
    final apiPaymentMethod = _multiplePayment && _multiplePaymentAmounts.isNotEmpty
        ? _dominantApiMethodFromMap(_multiplePaymentAmounts)
        : normalizePaymentMethodForApi(_selectedPaymentMethodNotifier.value);

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid amount greater than 0'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    String? partyName;
    String? salesInvoiceName;
    String? purchaseInvoiceName;

    if (!widget.hideParties) {
      if (_selectedPartiesNotifier.value.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Select a party to settle'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }
      partyName = _selectedPartiesNotifier.value.first.name.trim();
    } else if (widget.item != null) {
      final inv = widget.item!;
      final invName = inv.invoiceName?.trim();
      if (invName == null || invName.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invoice name is missing'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }
      final it = inv.invoiceType ?? _invoiceTypeNotifier.value;
      switch (it) {
        case InvoiceType.sales:
          salesInvoiceName = invName;
          break;
        case InvoiceType.purchase:
          purchaseInvoiceName = invName;
          break;
      }
    } else {
      final pn = widget.settlementPartyName?.trim();
      if (pn == null || pn.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Settlement target is missing'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }
      partyName = pn;
    }

    var targetCount = 0;
    if (partyName != null && partyName.isNotEmpty) targetCount++;
    if (salesInvoiceName != null && salesInvoiceName.isNotEmpty) targetCount++;
    if (purchaseInvoiceName != null && purchaseInvoiceName.isNotEmpty) targetCount++;
    if (targetCount != 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Exactly one of party, sales invoice, or purchase invoice must be set'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final paymentLines = _buildSettlementPaymentLines(
      apiPaymentMethod: apiPaymentMethod,
      totalAmount: amount,
    );

    final String? invoiceTypeParam = partyName != null && partyName.isNotEmpty ? invoiceType.name : null;

    final discountForRequest =
        salesInvoiceName != null && salesInvoiceName.isNotEmpty ? _discountAmountForPartialSettlement() : null;

    final createdBy =
        _createdByController.text.trim().isEmpty ? 'hotelroyalrestro@gmail.com' : _createdByController.text.trim();

    final settlementParams = PartialSettlementRequestParams(
      partyName: partyName,
      salesInvoiceName: salesInvoiceName,
      purchaseInvoiceName: purchaseInvoiceName,
      payment: paymentLines,
      paymentDate: formatDate(paymentDate!),
      invoiceType: invoiceTypeParam,
      discountAmount: discountForRequest,
      createdBy: createdBy,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PartialSettlementCubit>().partialSettlement(params: settlementParams);
    });
  }

  String generateReferenceId(String paymentMethod) {
    final random = Random();

    // Define prefixes for payment methods
    final prefixes = {
      'Transfer': 'TXN',
      'Cash': 'CSH',
      'Cheque': 'CHQ',
      'Settlement': 'STL',
    };

    // Get prefix or use default
    final prefix = prefixes[paymentMethod] ?? 'REF';

    // Generate 5-digit random number (10000-99999)
    final number = (10000 + random.nextInt(90000)).toString();

    // Return formatted reference ID
    return '$prefix-$number';
  }

  String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _paymentMethodsCubit.close();
    _partySearchDebounce?.cancel();
    _roleTabController.removeListener(_syncRoleFromTabController);
    _roleTabController.dispose();
    _partySearchFocusNode.dispose();
    _partySearchController.dispose();
    _paymentDateController.dispose();
    _createdByController.dispose();
    _amountController.dispose();
    _discountController.dispose();
    _selectedPartiesNotifier.dispose();
    _amountNotifier.dispose();
    _selectedRoleNotifier.dispose();
    _selectedPaymentMethodNotifier.dispose();
    _paymentDateNotifier.dispose();
    _allPartiesNotifier.dispose();
    _invoiceTypeNotifier.dispose(); // Dispose the new notifier
    super.dispose();
  }
}
