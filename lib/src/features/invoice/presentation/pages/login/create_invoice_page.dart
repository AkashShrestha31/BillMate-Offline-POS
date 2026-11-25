import 'dart:async';
import 'dart:math';
import 'package:hotel/constants.dart';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hotel/src/core/widget/app_delete_icon.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/helpers/freemium_navigation.dart';
import 'package:hotel/src/core/helpers/payment_method_for_api.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/constants/margin_constants.dart';
import 'package:hotel/src/core/constants/padding_constants.dart';
import 'package:hotel/src/core/constants/radius_constants.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/layout/device_layout.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/core/services/currency/app_currency_formatter.dart';
import 'package:hotel/src/core/services/currency/app_currency_service.dart';
import 'package:hotel/src/core/widget/edit_discount_sheet.dart';
import 'package:hotel/src/core/widget/edit_invoice_tax_sheet.dart';
import 'package:hotel/src/core/widget/estimate_invoice_sheet.dart';
import 'package:hotel/src/core/widget/partial_payment_preview_page.dart';
import 'package:hotel/src/core/widget/keyboard_done_bar.dart';
import 'package:hotel/src/features/action/data/models/request/item_request_params.dart';
import 'package:hotel/src/features/action/data/models/request/party_request_params.dart';
import 'package:hotel/src/features/action/data/models/response/item_response_model.dart';
import 'package:hotel/src/features/action/data/models/response/party_response_model.dart';
import 'package:hotel/src/features/action/presentation/cubit/item_cubit.dart';
import 'package:hotel/src/features/action/presentation/cubit/party_cubit.dart';
import 'package:hotel/src/features/action/presentation/widgets/party_picker_sheet.dart';
import 'package:hotel/src/features/loyalty/domain/loyalty_features.dart';
import 'package:hotel/src/features/loyalty/domain/loyalty_math.dart';
import 'package:hotel/src/features/loyalty/domain/loyalty_program.dart';
import 'package:hotel/src/features/loyalty/domain/loyalty_program_service.dart';
import 'package:hotel/src/features/invoice/data/models/request/create_invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_sales_response_model.dart';
import 'package:hotel/src/features/invoice/presentation/cubits/create_invoice/create_invoice_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/cubits/update_invoice/update_invoice_cubit.dart';
import 'package:hotel/src/features/payment_methods/presentation/cubit/payment_methods_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/pages/login/quick_add_items_page.dart'
    show QuickAddItemsPage, SelectedItemSummary;
import 'package:hotel/src/features/settings/presentation/live_stock_issue_guard.dart';
import 'package:hotel/src/core/helpers/item_search_helper.dart';
import 'package:hotel/src/core/widget/app_search_icon.dart';
import 'package:hotel/src/features/role/data/models/role_item.dart';
import 'package:hotel/src/features/role/domain/party_picker_role_helper.dart';
import 'package:hotel/src/features/role/domain/repositories/roles_repository.dart';
import 'package:hotel/src/features/org/domain/country_tax_profile.dart';
import 'package:hotel/src/features/org/domain/country_tax_rate_picker.dart';
import 'package:hotel/src/features/org/domain/invoice_tax_kind.dart';
import 'package:hotel/src/features/org/domain/tax_math.dart';
import 'package:hotel/src/features/org/domain/tax_settings_service.dart';

/// Up to [maxDecimals] fraction digits; trims trailing zeros (and a trailing dot).
String _formatInvoiceMoney(double value, {int maxDecimals = 15}) {
  if (value.isNaN || value.isInfinite) return value.toString();
  final fixed = value.toStringAsFixed(maxDecimals);
  if (!fixed.contains('.')) return fixed;
  var trimmed = fixed.replaceFirst(RegExp(r'0+$'), '');
  if (trimmed.endsWith('.')) {
    trimmed = trimmed.substring(0, trimmed.length - 1);
  }
  return trimmed.isEmpty ? '0' : trimmed;
}

String _invoiceSummaryEstimatePaymentSummary({
  required bool showPaymentDetails,
  required bool isPaid,
  required bool multiplePayment,
  required double multiplePaymentSum,
  required String selectedMethod,
  required double totalAfterDiscount,
  required String currencySymbol,
}) {
  if (!showPaymentDetails) return '—';
  if (!isPaid) return 'Unpaid / Credit ($currencySymbol ${totalAfterDiscount.toStringAsFixed(1)})';
  if (multiplePayment && multiplePaymentSum > 0) {
    return 'Multiple ($currencySymbol ${multiplePaymentSum.toStringAsFixed(1)})';
  }
  return '$selectedMethod ($currencySymbol ${totalAfterDiscount.toStringAsFixed(1)})';
}

class QuickAddInvoiceDraft {
  final InvoiceType invoiceType;
  final List<SelectedItemSummary> items;
  final String? partyName;
  final String? partyCurrency;

  const QuickAddInvoiceDraft({
    required this.invoiceType,
    required this.items,
    this.partyName,
    this.partyCurrency,
  });
}

class QuickAddInvoiceDraftBridge {
  static QuickAddInvoiceDraft? _pending;

  static void set(QuickAddInvoiceDraft draft) {
    _pending = draft;
  }

  static QuickAddInvoiceDraft? takeFor(InvoiceType invoiceType) {
    final draft = _pending;
    if (draft == null || draft.invoiceType != invoiceType) return null;
    _pending = null;
    return draft;
  }
}

class _InvoiceCheckoutSnapshot {
  const _InvoiceCheckoutSnapshot({
    required this.showPaymentDetails,
    required this.isPaid,
    required this.multiplePayment,
    required this.multiplePaymentAmounts,
    required this.selectedMethod,
    required this.singleTenderAmount,
  });

  final bool showPaymentDetails;
  final bool isPaid;
  final bool multiplePayment;
  final Map<String, double> multiplePaymentAmounts;
  final String selectedMethod;
  final double? singleTenderAmount;
}

@RoutePage()
class CreateInvoicePage extends StatefulWidget implements AutoRouteWrapper {
  final DateTime? selectedDate;
  final InvoiceType invoiceType;
  final Function() onComplete;

  /// When set (e.g. purchase tab edit), the page uses the same UI as create but saves via [UpdateInvoiceCubit].
  final InvoiceItem? invoiceToEdit;

  /// Prefill a **new** invoice from an existing one (line items, party, discounts); does not update the source.
  final InvoiceItem? invoiceToDuplicate;

  const CreateInvoicePage({
    super.key,
    this.selectedDate,
    required this.onComplete,
    required this.invoiceType,
    this.invoiceToEdit,
    this.invoiceToDuplicate,
  }) : assert(
          invoiceToEdit == null || invoiceToDuplicate == null,
          'Use either invoiceToEdit or invoiceToDuplicate, not both.',
        );

  @override
  State<CreateInvoicePage> createState() => _CreateInvoicePageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    if (invoiceToEdit != null) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => GetIt.instance<CreateInvoiceCubit>()),
          BlocProvider(create: (_) => GetIt.instance<UpdateInvoiceCubit>()),
          BlocProvider(
            create: (_) => GetIt.instance<PaymentMethodsCubit>()..load(),
          ),
        ],
        child: this,
      );
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.instance<CreateInvoiceCubit>()),
        BlocProvider(
          create: (_) => GetIt.instance<PaymentMethodsCubit>()..load(),
        ),
      ],
      child: this,
    );
  }
}

class _CreateInvoicePageState extends State<CreateInvoicePage> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();
  final ValueNotifier<List<ItemModel>> _availableItems = ValueNotifier<List<ItemModel>>([]);

  /// Baseline line items when editing (for add/update/delete diff).
  List<ItemDetails> _originalLineItems = [];

  /// Server line ids removed in the UI (supplement diff vs [_originalLineItems]).
  final List<String> _deletedItemIds = [];

  bool _editLinePrefillApplied = false;

  // Controllers for main invoice fields
  final _partyController = TextEditingController();
  final _partySearchController = TextEditingController();
  final _accountController = TextEditingController();
  final _dateController = TextEditingController();
  final _currencyController = TextEditingController();
  final _exchangeRateController = TextEditingController();
  final _priceListController = TextEditingController();
  final _discountAmountController = TextEditingController();
  final _discountPercentController = TextEditingController();
  final _termsController = TextEditingController();
  final _createdByController = TextEditingController();
  final _modifiedByController = TextEditingController();

  // ValueNotifiers for reactive state
  final _setDiscountAmountNotifier = ValueNotifier<bool>(false);
  final _itemsNotifier = ValueNotifier<List<InvoiceItemData>>([]);
  final _grandTotalNotifier = ValueNotifier<double>(0.0);
  final _selectedSummaryNotifier = ValueNotifier<List<SelectedItemSummary>>([]);

  // Party search ValueNotifiers
  final ValueNotifier<String?> _selectedPartyName = ValueNotifier<String?>(null);
  final ValueNotifier<List<String>> _availableParties = ValueNotifier<List<String>>([]);
  final ValueNotifier<List<String>> _filteredParties = ValueNotifier<List<String>>([]);
  final ValueNotifier<bool> _showPartyDropdown = ValueNotifier<bool>(false);

  /// ISO code from the selected party; null falls back to org reporting currency.
  String? _partyCurrencyCode;

  bool _loyaltyEnabled = false;
  PartyLoyaltySnapshot? _partyLoyalty;
  int _redeemLoyaltyPoints = 0;

  String get _invoiceCurrencyCode {
    final code = _partyCurrencyCode?.trim();
    if (code != null && code.isNotEmpty) return code.toUpperCase();
    return AppCurrencyFormatter.code;
  }

  String get _invoiceCurrencySymbol =>
      AppCurrencyFormatter.symbolForCode(_invoiceCurrencyCode);

  void _setPartyCurrency(String? code) {
    final trimmed = code?.trim();
    final next =
        (trimmed == null || trimmed.isEmpty) ? null : trimmed.toUpperCase();
    if (_partyCurrencyCode == next) return;
    setState(() => _partyCurrencyCode = next);
  }

  double get _loyaltyDiscountAmount {
    if (!LoyaltyFeatures.enabled) return 0;
    if (!_loyaltyEnabled || _redeemLoyaltyPoints <= 0) return 0;
    final factor = _partyLoyalty?.program?.conversionFactor ?? 1.0;
    final raw = LoyaltyMath.amountFromPoints(_redeemLoyaltyPoints, factor);
    return raw.clamp(0.0, _invoiceSubtotal());
  }

  Future<void> _refreshPartyLoyalty(String? partyName) async {
    if (!LoyaltyFeatures.enabled) {
      if (!mounted) return;
      setState(() {
        _loyaltyEnabled = false;
        _partyLoyalty = null;
        _redeemLoyaltyPoints = 0;
      });
      _calculateGrandTotal();
      return;
    }
    final name = partyName?.trim() ?? '';
    if (name.isEmpty || widget.invoiceType != InvoiceType.sales) {
      if (!mounted) return;
      setState(() {
        _partyLoyalty = null;
        _redeemLoyaltyPoints = 0;
      });
      _calculateGrandTotal();
      return;
    }
    final service = getIt<LoyaltyProgramService>();
    final enabled = await service.isEnabled();
    final snap = enabled ? await service.snapshotForParty(name) : null;
    if (!mounted) return;
    setState(() {
      _loyaltyEnabled = enabled;
      _partyLoyalty = snap;
      if (snap == null || !snap.canRedeem) {
        _redeemLoyaltyPoints = 0;
      } else if (_redeemLoyaltyPoints > snap.points) {
        _redeemLoyaltyPoints = snap.points;
      }
    });
    _calculateGrandTotal();
  }

  String _money(BuildContext ctx, double value) =>
      ctx.l10n.formatMoneyWithSymbol(_invoiceCurrencySymbol, value);

  /// True while item picker bottom sheet is open (search/pagination = silent loading, no overlay).
  bool _isItemPickerOpen = false;

  /// True while party picker bottom sheet is open (no main-list update from cubit).
  bool _isPartyPickerOpen = false;

  TaxSettings? _taxSettings;
  final _applyTaxNotifier = ValueNotifier<bool>(false);
  InvoiceTaxKind _invoiceTaxKind = InvoiceTaxKind.vat;
  double _invoiceTaxRate = 0;

  ColorScheme get _scheme => Theme.of(context).colorScheme;
  Color get _cardBg => _scheme.surface;
  Color get _cardBorder => _scheme.outlineVariant.withValues(alpha: 0.6);
  Color get _iconTint => _scheme.primaryContainer.withValues(alpha: 0.45);

  bool _isTablet(BuildContext context) => DeviceLayout.isTablet(context);

  double _sz(BuildContext context, double tablet, double phone) =>
      _isTablet(context) ? tablet : phone;

  double _sp(BuildContext context, double tablet, double phone) =>
      _isTablet(context) ? tablet : phone.sp;

  EdgeInsets _pageHorizontalPadding(BuildContext context) {
    final phone = context.theme.appTheme.spacing16;
    return EdgeInsets.symmetric(
      horizontal: _sz(context, 24, phone),
    );
  }

  FocusHighlightStrategy? _previousHighlightStrategy;
  bool _quickAddDraftApplied = false;

  /// In-route loader only (avoids root [Overlay] + route pop racing [_Theater] GlobalKeys).
  final ValueNotifier<bool> _createRouteLoadingOverlay = ValueNotifier<bool>(false);
  int _createRouteLoadingDepth = 0;

  void _acquireCreateRouteLoading() {
    _createRouteLoadingDepth++;
    if (_createRouteLoadingDepth == 1) {
      _createRouteLoadingOverlay.value = true;
    }
  }

  void _releaseCreateRouteLoading() {
    if (_createRouteLoadingDepth <= 0) return;
    _createRouteLoadingDepth--;
    if (_createRouteLoadingDepth == 0) {
      _createRouteLoadingOverlay.value = false;
    }
  }

  void _resetCreateRouteLoading() {
    _createRouteLoadingDepth = 0;
    _createRouteLoadingOverlay.value = false;
  }

  @override
  void initState() {
    super.initState();
    _previousHighlightStrategy = FocusManager.instance.highlightStrategy;
    FocusManager.instance.highlightStrategy = FocusHighlightStrategy.alwaysTouch;
    _loadParties();
    if (widget.invoiceType == InvoiceType.sales) {
      getIt<TaxSettingsService>().load().then((settings) {
        if (!mounted) return;
        _taxSettings = settings;
        _invoiceTaxKind = settings.taxKind;
        _invoiceTaxRate = settings.defaultTaxRate;
        // Tax is opt-in per invoice — org rate is used only when the user turns this on.
        _applyTaxNotifier.value = false;
        setState(() {});
        _calculateGrandTotal();
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      if (widget.invoiceToEdit == null && widget.invoiceToDuplicate == null) {
        final feature = widget.invoiceType == InvoiceType.purchase
            ? FreemiumFeature.purchaseInvoice
            : FreemiumFeature.salesInvoice;
        if (!await gateFreemiumFeature(context, feature)) {
          if (mounted) await context.router.maybePop();
          return;
        }
      }
      if (!mounted) return;
      // Categories + items are not prefetched here — Quick Add loads categories/items;
      // the per-line picker loads items via [_showItemPickerBottomSheet].
      if (widget.invoiceToEdit != null) {
        if (!_editLinePrefillApplied) {
          _applyLineItemsEditPrefill();
        }
      } else if (widget.invoiceToDuplicate == null) {
        if (!_quickAddDraftApplied) {
          final draft = QuickAddInvoiceDraftBridge.takeFor(widget.invoiceType);
          if (draft != null) {
            _applyQuickAddDraft(draft);
            _quickAddDraftApplied = true;
          } else if (_itemsNotifier.value.isEmpty) {
            _addNewItem();
          }
        }
      }
    });
    _itemsNotifier.addListener(_calculateGrandTotal);
    _itemsNotifier.addListener(_updateSelectedSummary);
    _setDiscountAmountNotifier.addListener(_calculateGrandTotal);
    _applyTaxNotifier.addListener(_calculateGrandTotal);
    _discountAmountController.addListener(_calculateGrandTotal);
    if (widget.invoiceToEdit != null) {
      _applyBasicEditPrefill(widget.invoiceToEdit!);
    } else if (widget.invoiceToDuplicate != null) {
      _applyBasicDuplicatePrefill(widget.invoiceToDuplicate!);
      // Apply lines here (not post-frame) so the first frame shows party + items + totals.
      // [BlocListener]<ItemCubit> often does not fire without a new emit, so post-frame alone was too late/empty.
      _applyLineItemsDuplicatePrefill();
    } else if (widget.selectedDate != null) {
      _dateController.text = widget.selectedDate.toString().split(' ')[0];
    }
    // Detach any scroll listener left from a previous hot-reload generation.
    _scrollController.removeListener(_handleScrollForBottomBar);
  }

  /// No-op — bottom checkout bar stays fixed. Kept so stale hot-reload listeners do not crash.
  void _handleScrollForBottomBar() {}

  void _applyBasicEditPrefill(InvoiceItem inv) {
    _partyController.text = inv.party ?? '';
    _partySearchController.text = inv.party ?? '';
    _selectedPartyName.value = inv.party;
    if (inv.date != null && inv.date!.isNotEmpty) {
      _dateController.text = inv.date!.split('T').first;
    }
    final hasDiscount =
        (inv.setDiscountAmount ?? 0) != 0 || (inv.discountAmount ?? 0) > 0 || (inv.totalDiscount ?? 0) > 0;
    _setDiscountAmountNotifier.value = hasDiscount;
    final amount = inv.discountAmount ?? inv.totalDiscount ?? 0.0;
    _discountAmountController.text = amount > 0 ? amount.toStringAsFixed(0) : '';
    _discountPercentController.text = (inv.discountPercent ?? 0) > 0 ? inv.discountPercent.toString() : '';
    _originalLineItems = List<ItemDetails>.from(inv.items ?? []);
  }

  void _applyBasicDuplicatePrefill(InvoiceItem inv) {
    _partyController.text = inv.party ?? '';
    _partySearchController.text = inv.party ?? '';
    _selectedPartyName.value = inv.party;
    if (widget.selectedDate != null) {
      _dateController.text = widget.selectedDate!.toString().split(' ')[0];
    } else if (inv.date != null && inv.date!.isNotEmpty) {
      _dateController.text = inv.date!.split('T').first.split(' ').first;
    } else {
      _dateController.text = DateTime.now().toIso8601String().split('T').first;
    }
    final hasDiscount =
        (inv.setDiscountAmount ?? 0) != 0 || (inv.discountAmount ?? 0) > 0 || (inv.totalDiscount ?? 0) > 0;
    _setDiscountAmountNotifier.value = hasDiscount;
    final amount = inv.discountAmount ?? inv.totalDiscount ?? 0.0;
    _discountAmountController.text = amount > 0 ? amount.toStringAsFixed(0) : '';
    _discountPercentController.text = (inv.discountPercent ?? 0) > 0 ? inv.discountPercent.toString() : '';
    _originalLineItems = [];
  }

  void _applyLineItemsDuplicatePrefill() {
    final inv = widget.invoiceToDuplicate;
    if (inv == null || _editLinePrefillApplied) return;

    for (final row in _itemsNotifier.value) {
      row.totalNotifier.removeListener(_calculateGrandTotal);
      row.setItemDiscountAmountNotifier.removeListener(_calculateGrandTotal);
      row.itemDiscountAmountController.removeListener(_calculateGrandTotal);
      row.dispose();
    }

    final lines = inv.items;
    if (lines == null || lines.isEmpty) {
      _editLinePrefillApplied = true;
      _addNewItem();
      return;
    }

    final newRows = <InvoiceItemData>[];
    for (final line in lines) {
      final d = InvoiceItemData(_availableItems.value);
      final name = line.item ?? '';
      if (name.isNotEmpty) {
        d.selectedItemName.value = name;
        d.searchController.text = name;
      }
      final rate = line.rate ?? 0;
      d.rateController.text = rate == rate.truncateToDouble() ? rate.toInt().toString() : rate.toString();
      final qty = line.quantity ?? 1;
      d.quantityController.text = qty == qty.truncateToDouble() ? qty.toInt().toString() : qty.toString();

      final disc = line.itemDiscountAmount ?? 0;
      if (disc > 0) {
        d.setItemDiscountAmountNotifier.value = true;
        d.itemDiscountAmountController.text = disc.toStringAsFixed(0);
      }

      d.totalNotifier.addListener(_calculateGrandTotal);
      d.setItemDiscountAmountNotifier.addListener(_calculateGrandTotal);
      d.itemDiscountAmountController.addListener(_calculateGrandTotal);
      d.refreshLineTotal();
      newRows.add(d);
    }
    _itemsNotifier.value = newRows;
    _editLinePrefillApplied = true;
    _calculateGrandTotal();
    _updateSelectedSummary();
  }

  void _applyLineItemsEditPrefill() {
    final inv = widget.invoiceToEdit;
    if (inv == null || _editLinePrefillApplied) return;

    for (final row in _itemsNotifier.value) {
      row.totalNotifier.removeListener(_calculateGrandTotal);
      row.setItemDiscountAmountNotifier.removeListener(_calculateGrandTotal);
      row.itemDiscountAmountController.removeListener(_calculateGrandTotal);
      row.dispose();
    }

    final lines = inv.items;
    if (lines == null || lines.isEmpty) {
      _editLinePrefillApplied = true;
      _addNewItem();
      return;
    }

    final newRows = <InvoiceItemData>[];
    for (final line in lines) {
      final d = InvoiceItemData(_availableItems.value, originalItemId: line.itemId);
      final name = line.item ?? '';
      if (name.isNotEmpty) {
        d.selectedItemName.value = name;
        d.searchController.text = name;
      }
      final rate = line.rate ?? 0;
      d.rateController.text = rate == rate.truncateToDouble() ? rate.toInt().toString() : rate.toString();
      final qty = line.quantity ?? 1;
      d.quantityController.text = qty == qty.truncateToDouble() ? qty.toInt().toString() : qty.toString();

      final disc = line.itemDiscountAmount ?? 0;
      if (disc > 0) {
        d.setItemDiscountAmountNotifier.value = true;
        d.itemDiscountAmountController.text = disc.toStringAsFixed(0);
      }

      d.totalNotifier.addListener(_calculateGrandTotal);
      d.setItemDiscountAmountNotifier.addListener(_calculateGrandTotal);
      d.itemDiscountAmountController.addListener(_calculateGrandTotal);
      newRows.add(d);
    }
    _itemsNotifier.value = newRows;
    _editLinePrefillApplied = true;
    _calculateGrandTotal();
    _updateSelectedSummary();
  }

  void _applyQuickAddDraft(QuickAddInvoiceDraft draft) {
    final summaries = draft.items.where((e) => e.quantity > 0).toList();
    if (summaries.isEmpty) return;

    final pickedParty = draft.partyName?.trim();
    if (pickedParty != null && pickedParty.isNotEmpty) {
      _selectedPartyName.value = pickedParty;
      _partySearchController.text = pickedParty;
      _partyController.text = pickedParty;
      _setPartyCurrency(draft.partyCurrency);
      unawaited(_refreshPartyLoyalty(pickedParty));
    }

    for (final row in _itemsNotifier.value) {
      row.totalNotifier.removeListener(_calculateGrandTotal);
      row.setItemDiscountAmountNotifier.removeListener(_calculateGrandTotal);
      row.itemDiscountAmountController.removeListener(_calculateGrandTotal);
      row.dispose();
    }

    final newRows = <InvoiceItemData>[];
    for (final s in summaries) {
      final row = InvoiceItemData(_availableItems.value);
      ItemModel? matched;
      for (final item in _availableItems.value) {
        if (item.name == s.name) {
          matched = item;
          break;
        }
      }

      if (matched != null) {
        row.selectItem(matched);
      } else {
        row.selectedItemName.value = s.name;
        row.searchController.text = s.name;
      }

      row.quantityController.text = s.quantity.toString();
      row.rateController.text = _formatInvoiceMoney(s.rate);
      final draftSubtotal = s.rate * s.quantity;
      row.totalNotifier.value = draftSubtotal;

      row.totalNotifier.addListener(_calculateGrandTotal);
      row.setItemDiscountAmountNotifier.addListener(_calculateGrandTotal);
      row.itemDiscountAmountController.addListener(_calculateGrandTotal);
      newRows.add(row);
    }

    if (newRows.isEmpty) {
      _addNewItem();
    } else {
      _itemsNotifier.value = newRows;
      _calculateGrandTotal();
      _updateSelectedSummary();
      if (mounted) setState(() {});
    }
  }

  List<Map<String, dynamic>> _createUpdateItemActions() {
    final actions = <Map<String, dynamic>>[];

    for (final row in _itemsNotifier.value) {
      final name = row.selectedItemName.value ?? '';
      if (name.isEmpty) continue;

      final qty = double.tryParse(row.quantityController.text) ?? 0;
      final rate = double.tryParse(row.rateController.text) ?? 0;
      final disc = row.setItemDiscountAmountNotifier.value
          ? (double.tryParse(row.itemDiscountAmountController.text) ?? 0.0)
          : 0.0;
      final oid = row.originalItemId;

      if (oid == null || oid.isEmpty) {
        actions.add({
          'action': 'add',
          'itemId': '',
          'item': name,
          'quantity': qty,
          'rate': rate,
          'amount': qty * rate,
          'itemDiscountAmount': disc,
        });
      } else {
        ItemDetails? orig;
        for (final o in _originalLineItems) {
          if (o.itemId == oid) {
            orig = o;
            break;
          }
        }
        orig ??= ItemDetails(itemId: oid, item: '', quantity: 0, rate: 0, amount: 0);

        final isUpdated = orig.item != name ||
            orig.quantity != qty ||
            (orig.rate ?? 0) != rate ||
            (orig.itemDiscountAmount ?? 0) != disc;
        if (isUpdated) {
          actions.add({
            'action': 'update',
            'itemId': oid,
            'item': name,
            'quantity': qty,
            'rate': rate,
            'amount': qty * rate,
            'itemDiscountAmount': disc,
          });
        }
      }
    }

    for (final originalItem in _originalLineItems) {
      final id = originalItem.itemId;
      if (id == null || id.isEmpty) continue;
      final stillExists = _itemsNotifier.value.any((r) => r.originalItemId == id);
      if (!stillExists) {
        actions.add({
          'action': 'delete',
          'itemId': id,
          'item': originalItem.item,
        });
      }
    }

    for (final deletedId in _deletedItemIds) {
      final alreadyAdded = actions.any(
        (a) => a['action'] == 'delete' && a['itemId'] == deletedId,
      );
      if (!alreadyAdded) {
        actions.add({
          'action': 'delete',
          'itemId': deletedId,
        });
      }
    }

    return actions;
  }

  void _confirmAndUpdateInvoice(_InvoiceCheckoutSnapshot checkout) {
    final inv = widget.invoiceToEdit;
    if (inv == null) return;

    final actions = _createUpdateItemActions();
    final setDiscount = _setDiscountAmountNotifier.value;
    final discountAmt =
        _discountAmountController.text.trim().isEmpty ? null : double.tryParse(_discountAmountController.text);
    final discountPct =
        _discountPercentController.text.trim().isEmpty ? null : double.tryParse(_discountPercentController.text);

    final paymentMode = checkout.showPaymentDetails;
    final paymentLines =
        paymentMode ? _paymentLinesFromCheckout(checkout) : null;

    final invoice = InvoiceItem(
      invoiceType: widget.invoiceType,
      action: 'submit',
      invoiceName: inv.invoiceName,
      party: _selectedPartyName.value ?? _partySearchController.text,
      date: _dateController.text.isNotEmpty ? _dateController.text : null,
      items: actions.map((m) => ItemDetails.fromJson(Map<String, dynamic>.from(m))).toList(),
      modifiedBy: 'hotelroyalrestro@gmail.com',
      setDiscountAmount: setDiscount ? 1 : 0,
      discountAmount: discountAmt,
      discountPercent: discountPct,
      paymentModeForUpdate: paymentMode,
      updatePaymentLines: paymentLines,
    );

    context.read<UpdateInvoiceCubit>().updateInvoice(params: invoice);
  }

  static const int _itemPickerPageSize = 10;

  void _showItemPickerBottomSheet(BuildContext context, InvoiceItemData itemData) {
    _dismissKeyboard();
    setState(() => _isItemPickerOpen = true);
    final itemCubit = context.read<ItemCubit>();
    itemCubit.getItems(
      params: ItemRequestParams(
        page: 1,
        forFilter: widget.invoiceType == InvoiceType.sales ? 'Sales' : "Purchases",
        perPage: _itemPickerPageSize,
        excludeZeroSales: false,
        sortBy: 'name',
        sortOrder: 'asc',
      ),
    );
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => _ItemPickerBottomSheet(
        invoiceType: widget.invoiceType,
        pageSize: _itemPickerPageSize,
        currencySymbol: _invoiceCurrencySymbol,
        onSelect: (ItemModel item) {
          final requested = double.tryParse(itemData.quantityController.text) ?? 1;
          if (widget.invoiceType == InvoiceType.sales &&
              !liveStockAllowsSale(
                itemName: item.name,
                requestedQty: requested <= 0 ? 1 : requested,
                itemType: item.itemType,
              )) {
            showLiveStockShortage(sheetContext, item.name);
            return;
          }
          itemData.selectItem(item);
          Navigator.pop(sheetContext);
        },
      ),
    ).then((_) {
      if (mounted) setState(() => _isItemPickerOpen = false);
    });
  }

  void _loadParties() {
    // Parties are loaded when opening the party picker bottom sheet (pagination + search).
  }

  void _showPartyPickerBottomSheet(BuildContext context) {
    _dismissKeyboard();
    setState(() => _isPartyPickerOpen = true);
    final isPurchase = widget.invoiceType == InvoiceType.purchase;
    final currentParty = _partyController.text.trim();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => PartyPickerSheet(
        role: isPurchase ? 'supplier' : 'customer',
        supplierIncludeEmployeeTab: isPurchase,
        selectedPartyName: currentParty.isEmpty ? null : currentParty,
        onSelect: (PartyItem party) {
          final name = party.name ?? '';
          _selectedPartyName.value = name;
          _partySearchController.text = name;
          _partyController.text = name;
          _setPartyCurrency(party.currency);
          unawaited(_refreshPartyLoyalty(name));
          Navigator.pop(sheetContext);
        },
      ),
    ).then((_) {
      if (mounted) setState(() => _isPartyPickerOpen = false);
    });
  }

  static List<ItemModel> mapToAvailableItems(ItemResponseModel response) {
    return response.data;
  }

  static List<String> mapToAvailableParties(PartyResponseModel response) {
    return response.data!
        .asMap()
        .entries
        .map((entry) {
          final partyData = entry.value;
          return partyData.name;
        })
        .where((name) => name != null)
        .cast<String>()
        .toList();
  }

  double _invoiceSubtotal() {
    var total = 0.0;
    for (final item in _itemsNotifier.value) {
      total += item.totalNotifier.value;
    }
    return total;
  }

  double _invoiceDiscountAmount([double? subtotal]) {
    if (!_setDiscountAmountNotifier.value) return 0.0;
    return double.tryParse(_discountAmountController.text) ?? 0.0;
  }

  double get _effectiveInvoiceTaxRate {
    if (_invoiceTaxRate > 0) return _invoiceTaxRate;
    return _taxSettings?.defaultTaxRate ?? 0;
  }

  String _invoiceTaxRowTitle(BuildContext context) {
    final country = getIt<AppCurrencyService>().country;
    return CountryTaxProfiles.of(country).labelForKind(_invoiceTaxKind);
  }

  SalesInvoiceTaxBreakdown? _salesTaxBreakdown({
    double? subtotal,
    double? discount,
  }) {
    if (widget.invoiceType != InvoiceType.sales ||
        !_applyTaxNotifier.value ||
        _effectiveInvoiceTaxRate <= 0) {
      return null;
    }
    final itemsTotal = subtotal ?? _invoiceSubtotal();
    final loyalty = _loyaltyDiscountAmount.clamp(0.0, itemsTotal);
    final afterLoyalty = (itemsTotal - loyalty).clamp(0.0, double.infinity);
    final discountAmount = discount ?? _invoiceDiscountAmount();
    final mode = _taxSettings?.taxMode ?? TaxMode.exclusive;
    return SalesInvoiceTaxCalculator(
      ratePercent: _effectiveInvoiceTaxRate,
      mode: mode,
    ).calculate(
      subtotal: afterLoyalty,
      discount: discountAmount,
    );
  }

  void _calculateGrandTotal() {
    final itemsTotal = _invoiceSubtotal();
    final loyalty = _loyaltyDiscountAmount.clamp(0.0, itemsTotal);
    final afterLoyalty = (itemsTotal - loyalty).clamp(0.0, double.infinity);
    final discount = _invoiceDiscountAmount();
    final breakdown = _salesTaxBreakdown(
      subtotal: itemsTotal,
      discount: discount,
    );
    if (breakdown != null) {
      _grandTotalNotifier.value = breakdown.total;
      return;
    }
    _grandTotalNotifier.value =
        (afterLoyalty - discount).clamp(0.0, double.infinity);
  }

  @override
  void dispose() {
    if (_previousHighlightStrategy != null) {
      FocusManager.instance.highlightStrategy = _previousHighlightStrategy!;
    }
    _itemsNotifier.removeListener(_calculateGrandTotal);
    _itemsNotifier.removeListener(_updateSelectedSummary);
    _setDiscountAmountNotifier.removeListener(_calculateGrandTotal);
    _applyTaxNotifier.removeListener(_calculateGrandTotal);
    _discountAmountController.removeListener(_calculateGrandTotal);

    final rows = List<InvoiceItemData>.from(_itemsNotifier.value);
    for (final item in rows) {
      item.totalNotifier.removeListener(_calculateGrandTotal);
      item.setItemDiscountAmountNotifier.removeListener(_calculateGrandTotal);
      item.itemDiscountAmountController.removeListener(_calculateGrandTotal);
    }

    _scrollController.removeListener(_handleScrollForBottomBar);
    _scrollController.dispose();
    _setDiscountAmountNotifier.dispose();
    _itemsNotifier.dispose();
    _availableItems.dispose();
    _selectedPartyName.dispose();
    _availableParties.dispose();
    _filteredParties.dispose();
    _showPartyDropdown.dispose();
    _grandTotalNotifier.dispose();
    _applyTaxNotifier.dispose();
    _selectedSummaryNotifier.dispose();
    _createRouteLoadingOverlay.dispose();

    // [State.dispose] runs while the route can still be animating out.
    // InputDecorator / material transitions merge [TextEditingController] into
    // a [_MergingListenable]; disposing those controllers synchronously here
    // triggers "used after being disposed" in [_AnimatedState.didUpdateWidget]
    // and can cascade into duplicate Overlay GlobalKey / _Theater errors.
    final itemsToDispose = rows;
    final partyCtrl = _partyController;
    final partySearchCtrl = _partySearchController;
    final accountCtrl = _accountController;
    final dateCtrl = _dateController;
    final currencyCtrl = _currencyController;
    final exchangeRateCtrl = _exchangeRateController;
    final priceListCtrl = _priceListController;
    final discountAmountCtrl = _discountAmountController;
    final discountPercentCtrl = _discountPercentController;
    final termsCtrl = _termsController;
    final createdByCtrl = _createdByController;
    final modifiedByCtrl = _modifiedByController;

    Future<void>.delayed(const Duration(milliseconds: 500), () {
      for (final item in itemsToDispose) {
        item.dispose();
      }
      partyCtrl.dispose();
      partySearchCtrl.dispose();
      accountCtrl.dispose();
      dateCtrl.dispose();
      currencyCtrl.dispose();
      exchangeRateCtrl.dispose();
      priceListCtrl.dispose();
      discountAmountCtrl.dispose();
      discountPercentCtrl.dispose();
      termsCtrl.dispose();
      createdByCtrl.dispose();
      modifiedByCtrl.dispose();
    });

    super.dispose();
  }

  void _addNewItem() {
    final currentItems = List<InvoiceItemData>.from(_itemsNotifier.value);
    final newItem = InvoiceItemData(_availableItems.value);

    // Add listeners to recalculate grand total when item total or discount changes
    newItem.totalNotifier.addListener(_calculateGrandTotal);
    newItem.setItemDiscountAmountNotifier.addListener(_calculateGrandTotal);
    newItem.itemDiscountAmountController.addListener(_calculateGrandTotal);

    currentItems.add(newItem);
    _itemsNotifier.value = currentItems;
  }

  /// Returns [null] if a new line was added, or the new quantity (int) if same item incremented.
  int? _addItemToInvoice(ItemModel item) {
    final items = _itemsNotifier.value;
    final existingIndex = items.indexWhere((row) => row.selectedItemName.value == item.name);
    if (existingIndex >= 0) {
      final row = items[existingIndex];
      final current = double.tryParse(row.quantityController.text) ?? 0;
      final q = current + 1;
      if (!_allowSalesQuantity(
        itemName: item.name,
        requestedQty: q,
        itemType: item.itemType,
      )) {
        return current.toInt();
      }
      final qInt = q.truncateToDouble() == q ? q.toInt() : q;
      row.quantityController.text = qInt.toString();
      _calculateGrandTotal();
      _updateSelectedSummary();
      return qInt.toInt();
    }
    if (!_allowSalesQuantity(
      itemName: item.name,
      requestedQty: 1,
      itemType: item.itemType,
    )) {
      return 0;
    }
    // Use first empty row (no item selected) instead of adding a new one
    final emptyIndex = items.indexWhere((row) {
      final name = row.selectedItemName.value;
      return name == null || name.isEmpty;
    });
    if (emptyIndex >= 0) {
      final row = items[emptyIndex];
      row.selectItem(item);
      _calculateGrandTotal();
      _updateSelectedSummary();
      return 1;
    }
    _addNewItem();
    final list = _itemsNotifier.value;
    if (list.isNotEmpty) list.last.selectItem(item);
    _calculateGrandTotal();
    _updateSelectedSummary();
    return null;
  }

  void _removeItem(int index) {
    final currentItems = List<InvoiceItemData>.from(_itemsNotifier.value);
    if (currentItems.length > 1) {
      final removed = currentItems[index];
      final oid = removed.originalItemId;
      if (oid != null && oid.isNotEmpty && !_deletedItemIds.contains(oid)) {
        _deletedItemIds.add(oid);
      }
      removed.totalNotifier.removeListener(_calculateGrandTotal);
      removed.setItemDiscountAmountNotifier.removeListener(_calculateGrandTotal);
      removed.itemDiscountAmountController.removeListener(_calculateGrandTotal);
      currentItems.removeAt(index);
      _itemsNotifier.value = currentItems;
      // Defer disposal to the next frame so the ValueListenableBuilder has
      // time to rebuild and remove the item's widgets from the tree first.
      // Calling removed.dispose() synchronously here disposes the
      // TextEditingControllers while their widgets are still in the element
      // tree, which causes "used after being disposed" errors during any
      // rebuild that occurs in the same frame (e.g. grand-total recalc).
      WidgetsBinding.instance.addPostFrameCallback((_) {
        removed.dispose();
      });
    }
  }

  void _updateSelectedSummary() {
    final list = <SelectedItemSummary>[];
    for (final row in _itemsNotifier.value) {
      final name = row.selectedItemName.value;
      if (name == null || name.isEmpty) continue;
      final q = (double.tryParse(row.quantityController.text) ?? 0).toInt();
      final rate = double.tryParse(row.rateController.text) ?? 0;
      if (q > 0) list.add(SelectedItemSummary(name: name, quantity: q, rate: rate));
    }
    _selectedSummaryNotifier.value = list;
  }

  void _increaseItemFromQuickAdd(String itemName) {
    final items = _itemsNotifier.value;
    final idx = items.indexWhere((row) => row.selectedItemName.value == itemName);
    if (idx < 0) return;
    final row = items[idx];
    final q = (double.tryParse(row.quantityController.text) ?? 0).toInt() + 1;
    if (!_allowSalesQuantity(itemName: itemName, requestedQty: q.toDouble())) {
      return;
    }
    row.quantityController.text = q.toString();
    _calculateGrandTotal();
    _updateSelectedSummary();
  }

  void _decreaseItemFromQuickAdd(String itemName) {
    final items = _itemsNotifier.value;
    final idx = items.indexWhere((row) => row.selectedItemName.value == itemName);
    if (idx < 0) return;
    final row = items[idx];
    final q = (double.tryParse(row.quantityController.text) ?? 0).toInt();
    if (q <= 1) {
      _removeItem(idx);
      _updateSelectedSummary();
    } else {
      row.quantityController.text = (q - 1).toString();
      _calculateGrandTotal();
      _updateSelectedSummary();
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(), // ✅ This disables future dates
    );
    if (picked != null) {
      _dateController.text = picked.toString().split(' ')[0];
    }
  }

  String _invoiceSummaryDiscountPercentLabel(double subtotal, double discountAmount) {
    if (subtotal <= 0 || discountAmount <= 0) return '0';
    final pct = (discountAmount / subtotal) * 100;
    if ((pct - pct.round()).abs() < 0.05) return '${pct.round()}';
    return pct.toStringAsFixed(2);
  }

  Future<void> _openInvoiceSummaryDiscountSheet(
    BuildContext sheetContext,
    void Function(void Function()) setModalState, {
    required double subtotal,
  }) async {
    final initial = _setDiscountAmountNotifier.value
        ? (double.tryParse(_discountAmountController.text) ?? 0.0)
        : 0.0;
    final next = await EditDiscountSheet.show(
      sheetContext,
      subTotal: subtotal,
      initialDiscountAmount: initial,
    );
    if (next == null || !mounted) return;
    setState(() {
      if (next <= 0) {
        _setDiscountAmountNotifier.value = false;
        _discountAmountController.clear();
      } else {
        _setDiscountAmountNotifier.value = true;
        _discountAmountController.text = _formatInvoiceMoney(next);
      }
      _calculateGrandTotal();
    });
    setModalState(() {});
  }

  Future<void> _openLoyaltyRedeemSheet(
    BuildContext sheetContext,
    void Function(void Function()) setModalState, {
    required double itemTotal,
  }) async {
    final snap = _partyLoyalty;
    if (snap == null || !snap.canRedeem) return;
    final factor = snap.program!.conversionFactor;
    final maxPoints = LoyaltyMath.maxRedeemablePoints(
      balancePoints: snap.points,
      eligibleAmount: itemTotal,
      conversionFactor: factor,
    );
    final controller = TextEditingController(
      text: _redeemLoyaltyPoints > 0 ? '$_redeemLoyaltyPoints' : '',
    );
    final selected = await showModalBottomSheet<int>(
      context: sheetContext,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final ime = MediaQuery.viewInsetsOf(ctx).bottom;
        final theme = Theme.of(ctx);
        return Padding(
          padding: EdgeInsets.only(bottom: ime),
          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Redeem loyalty points',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Balance: ${snap.points} pts · Max: $maxPoints pts'
                    ' (${_money(ctx, LoyaltyMath.amountFromPoints(maxPoints, factor))})',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 14),
                  CustomTextFormField(
                    controller: controller,
                    labelText: 'Points to redeem',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(ctx, 0),
                          child: const Text('Clear'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: CustomButtonWidget.primary(
                          title: 'Apply',
                          onPressed: () {
                            final raw = int.tryParse(controller.text.trim()) ?? 0;
                            Navigator.pop(ctx, raw.clamp(0, maxPoints));
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    if (selected == null || !mounted) return;
    setState(() {
      _redeemLoyaltyPoints = selected;
      _calculateGrandTotal();
    });
    setModalState(() {});
  }

  Future<void> _openInvoiceSummaryTaxSheet(
    BuildContext sheetContext,
    void Function(void Function()) setModalState,
  ) async {
    final country = getIt<AppCurrencyService>().country;
    final result = await EditInvoiceTaxSheet.show(
      sheetContext,
      country: country,
      initialApplyTax: _applyTaxNotifier.value,
      initialKind: _invoiceTaxKind,
      initialRatePercent: _effectiveInvoiceTaxRate,
    );
    if (result == null || !mounted) return;
    setState(() {
      _applyTaxNotifier.value = result.applyTax;
      _invoiceTaxKind = result.kind;
      _invoiceTaxRate = result.ratePercent;
      _calculateGrandTotal();
    });
    setModalState(() {});
  }

  Future<Map<String, double>?> _openInvoicePartialPaymentPage(
    BuildContext navigatorContext,
    PaymentMethodsCubit paymentMethodsCubit, {
    required double total,
    required Color accent,
    Map<String, double>? initial,
  }) {
    // Must use the cubit from the **create-invoice route** (summary sheet), not [sheetContext].read:
    // the modal overlay is not under that BlocProvider, so read() would hit the app-level cubit (never loaded).
    return Navigator.of(navigatorContext, rootNavigator: true).push<Map<String, double>?>(
      MaterialPageRoute<Map<String, double>?>(
        builder: (_) => BlocProvider<PaymentMethodsCubit>.value(
          value: paymentMethodsCubit,
          child: PartialPaymentPreviewPage(
            total: total,
            accent: accent,
            initialAmounts: initial,
            paymentMethodNames: null,
          ),
        ),
      ),
    );
  }

  void _createInvoice() {
    if (_formKey.currentState!.validate()) {
      _showInvoiceSummaryDialog();
    }
  }

  void _showInvoiceSummaryDialog() {
    final tenderAmountController = TextEditingController();
    final paymentMethodsCubit = context.read<PaymentMethodsCubit>();
    /// When false, payment method / tender UI is hidden; user picks via radios at bottom of card.
    bool showPaymentDetails = false;
    bool isPaid = true;
    bool multiplePayment = false;
    Map<String, double> multiplePaymentAmounts = <String, double>{};
    String selectedMethod = 'Cash';

    showModalBottomSheet<_InvoiceCheckoutSnapshot>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: false,
      builder: (sheetContext) {
        return BlocProvider<PaymentMethodsCubit>.value(
          value: paymentMethodsCubit,
          child: BlocBuilder<PaymentMethodsCubit, PaymentMethodsState>(
            builder: (context, pmState) {
            final paymentChips = pmState.paymentMethodNames();
            return StatefulBuilder(
              builder: (context, setModalState) {
            double subtotal = 0.0;
            for (final item in _itemsNotifier.value) {
              final rate = double.tryParse(item.rateController.text) ?? 0.0;
              final quantity = double.tryParse(item.quantityController.text) ?? 1.0;
              subtotal += rate * quantity;
            }
            final loyaltyDiscount = _loyaltyDiscountAmount.clamp(0.0, subtotal);
            final afterLoyalty =
                (subtotal - loyaltyDiscount).clamp(0.0, double.infinity);
            final totalDiscount =
                _setDiscountAmountNotifier.value ? (double.tryParse(_discountAmountController.text) ?? 0.0) : 0.0;
            final taxBreakdown = _salesTaxBreakdown(
              subtotal: subtotal,
              discount: totalDiscount,
            );
            final totalAfterDiscount = taxBreakdown?.total ??
                (afterLoyalty - totalDiscount).clamp(0, double.infinity).toDouble();
            final taxAmount = taxBreakdown?.tax ?? 0.0;
            final taxRateLabel = _effectiveInvoiceTaxRate <= 0
                ? '0'
                : TaxMath.formatRate(_effectiveInvoiceTaxRate).replaceAll('%', '');
            final loyaltyPercentLabel = subtotal <= 0 || loyaltyDiscount <= 0
                ? '0'
                : _invoiceSummaryDiscountPercentLabel(subtotal, loyaltyDiscount);
            final multiplePaymentSum = multiplePaymentAmounts.values.fold<double>(0, (a, b) => a + b);
            const kPaymentTotalTol = 1e-6;
            final tenderEntered = double.tryParse(tenderAmountController.text.trim()) ?? 0.0;
            final multiPaymentWithinGrandTotal = !multiplePayment ||
                multiplePaymentSum <= totalAfterDiscount + kPaymentTotalTol;
            final tenderWithinGrandTotal =
                tenderEntered <= totalAfterDiscount + kPaymentTotalTol;
            final canConfirmCheckout = !showPaymentDetails ||
                !isPaid ||
                (multiplePayment
                    ? (multiplePaymentSum > kPaymentTotalTol && multiPaymentWithinGrandTotal)
                    : (tenderEntered > kPaymentTotalTol && tenderWithinGrandTotal));
            final paidTowardsTotal = showPaymentDetails && isPaid
                ? (multiplePayment ? multiplePaymentSum : tenderEntered)
                : 0.0;
            final unpaidFromGrandTotal = showPaymentDetails
                ? (!isPaid
                    ? totalAfterDiscount
                    : (totalAfterDiscount - paidTowardsTotal).clamp(0.0, double.infinity))
                : 0.0;

            final sheetTablet = _isTablet(sheetContext);
            return _wrapInvoiceSummarySheet(
              sheetContext,
              Container(
              constraints: BoxConstraints(
                maxHeight: sheetTablet
                    ? (MediaQuery.sizeOf(sheetContext).height * 0.82).clamp(420.0, 640.0)
                    : MediaQuery.sizeOf(sheetContext).height * 0.96,
              ),
              decoration: BoxDecoration(
                color: sheetContext.theme.colorScheme.surfaceContainerLow,
                borderRadius: sheetTablet
                    ? BorderRadius.circular(_sz(sheetContext, 20, 20))
                    : BorderRadius.vertical(
                        top: Radius.circular(_sz(sheetContext, 20, 26.r)),
                      ),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    SizedBox(height: _sz(sheetContext, 12, 16)),
                    Container(
                      width: _sz(sheetContext, 40, 56.w),
                      height: _sz(sheetContext, 4, 4.h),
                      decoration: BoxDecoration(
                        color: sheetContext.theme.colorScheme.outlineVariant.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        _sz(sheetContext, 14, 14.w),
                        _sz(sheetContext, 8, 8.h),
                        _sz(sheetContext, 14, 14.w),
                        _sz(sheetContext, 6, 6.h),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(
                              minWidth: _sz(sheetContext, 40, 44),
                              minHeight: _sz(sheetContext, 40, 44),
                            ),
                            onPressed: () => Navigator.of(sheetContext).pop(),
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: _sz(sheetContext, 18, 18),
                            ),
                            visualDensity: VisualDensity.compact,
                          ),
                          Expanded(
                            child: Text(
                              sheetContext.l10n.checkoutInvoiceSummary,
                              style: sheetContext.theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              final party = (_selectedPartyName.value ?? '').trim();
                              final typeLabel =
                                  widget.invoiceType == InvoiceType.sales ? 'Sales invoice' : 'Purchase invoice';
                              final estimateLines = <EstimateInvoiceLine>[];
                              for (final item in _itemsNotifier.value) {
                                final name = (item.selectedItemName.value ?? item.searchController.text).trim();
                                final q = double.tryParse(item.quantityController.text) ?? 0;
                                final rate = double.tryParse(item.rateController.text) ?? 0;
                                if (name.isEmpty || q <= 0) continue;
                                final amount = rate * q;
                                estimateLines.add(
                                  EstimateInvoiceLine(
                                    particular: name,
                                    rate: rate,
                                    quantity: q,
                                    amount: amount,
                                  ),
                                );
                              }
                              if (estimateLines.isEmpty) {
                                ScaffoldMessenger.of(sheetContext).showSnackBar(
                                  SnackBar(content: Text(sheetContext.l10n.checkoutAddAtLeastOneLine)),
                                );
                                return;
                              }
                              final invNo = widget.invoiceToEdit?.invoiceName?.trim();
                              final numLabel = (invNo != null && invNo.isNotEmpty) ? invNo : 'Draft';
                              final customerLabel = party.isEmpty ? 'Cash Customer' : party;
                              final paymentSummary = _invoiceSummaryEstimatePaymentSummary(
                                showPaymentDetails: showPaymentDetails,
                                isPaid: isPaid,
                                multiplePayment: multiplePayment,
                                multiplePaymentSum: multiplePaymentSum,
                                selectedMethod: selectedMethod,
                                totalAfterDiscount: totalAfterDiscount,
                                currencySymbol: _invoiceCurrencySymbol,
                              );
                              final payRows = <EstimateInvoicePaymentRow>[];
                              double? payPaid;
                              double? payOut;
                              final estimatePayDateText = formatEstimateInvoiceDateFromRaw(_dateController.text);
                              if (showPaymentDetails) {
                                if (!isPaid) {
                                  payOut = totalAfterDiscount;
                                } else if (multiplePayment && multiplePaymentAmounts.isNotEmpty) {
                                  for (final e in multiplePaymentAmounts.entries) {
                                    if (e.value > 1e-6) {
                                      payRows.add(EstimateInvoicePaymentRow(
                                        label: e.key,
                                        amount: e.value,
                                        dateText: estimatePayDateText,
                                      ));
                                    }
                                  }
                                  payPaid = multiplePaymentSum;
                                  final left = (totalAfterDiscount - multiplePaymentSum).clamp(0.0, double.infinity);
                                  if (left > 1e-6) payOut = left;
                                } else {
                                  final t = tenderEntered > 1e-6 ? tenderEntered : totalAfterDiscount;
                                  payRows.add(EstimateInvoicePaymentRow(
                                    label: selectedMethod,
                                    amount: t,
                                    dateText: estimatePayDateText,
                                  ));
                                  payPaid = t;
                                  final left = (totalAfterDiscount - t).clamp(0.0, double.infinity);
                                  if (left > 1e-6) payOut = left;
                                }
                              }
                              final paymentRows = payRows.isEmpty ? null : payRows;
                              final rawBase = party.isNotEmpty ? party : 'invoice_estimate';
                              final cleaned = rawBase.replaceAll(RegExp(r'[^a-zA-Z0-9_-]+'), '_');
                              final fileBase = cleaned.isEmpty ? 'invoice_estimate' : cleaned;

                              showModalBottomSheet<void>(
                                context: sheetContext,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                useSafeArea: true,
                                builder: (ctx) => EstimateInvoiceSheet(
                                  data: EstimateInvoiceViewData(
                                    titleSuffix: '$typeLabel · Estimate',
                                    invoiceNumber: numLabel,
                                    invoiceDateText: formatEstimateInvoiceDateFromRaw(_dateController.text),
                                    headerLine: party.isEmpty ? typeLabel : '$typeLabel · Party: $party',
                                    customerLabel: customerLabel,
                                    lines: estimateLines,
                                    subTotal: subtotal,
                                    discountAmount: totalDiscount,
                                    totalAfterDiscount: totalAfterDiscount,
                                    taxAmount: taxAmount > 0.005 ? taxAmount : null,
                                    taxLabel: taxAmount > 0.005
                                        ? '${_invoiceTaxRowTitle(sheetContext)} (${taxRateLabel}%)'
                                        : null,
                                    paymentSummary: paymentSummary,
                                    kotLine: null,
                                    billedBy: sheetContext.loggedInUserFullName,
                                    fileBaseName: fileBase,
                                    paymentRows: paymentRows,
                                    paymentPaidTotal: payPaid,
                                    paymentOutstanding: payOut,
                                    currencyCode: _invoiceCurrencyCode,
                                  ),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              minimumSize: Size(
                                _sz(sheetContext, 92, 92.w),
                                _sz(sheetContext, 40, 40.h),
                              ),
                              side: BorderSide(
                                  color: sheetContext.theme.colorScheme.outlineVariant.withValues(alpha: 0.9)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(_sz(sheetContext, 10, 10.r)),
                              ),
                            ),
                            child: Text(sheetContext.l10n.checkoutEstimate),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.fromLTRB(
                          _sz(sheetContext, 16, 16.w),
                          _sz(sheetContext, 8, 8.h),
                          _sz(sheetContext, 16, 16.w),
                          _sz(sheetContext, 12, 12.h),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildSummarySheetCard(
                              sheetContext,
                              child: _buildSummarySection(
                                sheetContext,
                                sheetContext.l10n.checkoutPartyInformation,
                                [
                                  _buildSummaryRow(
                                    sheetContext,
                                    sheetContext.l10n.party,
                                    _selectedPartyName.value ?? sheetContext.l10n.invoiceCommonNotAvailable,
                                  ),
                                  _buildSummaryRow(
                                    sheetContext,
                                    sheetContext.l10n.date,
                                    _dateController.text.isEmpty
                                        ? sheetContext.l10n.invoiceCommonNotAvailable
                                        : sheetContext.l10n.localizeDigits(_dateController.text),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: _sz(sheetContext, 12, 12.h)),
                            _buildSummarySheetCard(
                              sheetContext,
                              child: _buildSummarySection(
                                sheetContext,
                                sheetContext.l10n.checkoutBillSummary,
                                [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: _sz(sheetContext, 10, 10.w),
                                      vertical: _sz(sheetContext, 8, 8.h),
                                    ),
                                    decoration: BoxDecoration(
                                      color: sheetContext.theme.colorScheme.primaryContainer.withValues(alpha: 0.35),
                                      borderRadius: BorderRadius.circular(_sz(sheetContext, 8, 8.r)),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.lightbulb_outline_rounded,
                                          color: sheetContext.theme.colorScheme.primary,
                                          size: _sp(sheetContext, 18, 18),
                                        ),
                                        SizedBox(width: _sz(sheetContext, 8, 8.w)),
                                        Expanded(
                                          child: Text(
                                            sheetContext.l10n.checkoutBillSummaryHint,
                                            style: sheetContext.theme.textTheme.labelMedium?.copyWith(
                                              fontSize: _sp(sheetContext, 13, 13),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: _sz(sheetContext, 10, 10.h)),
                                  _buildSummaryRow(
                                    sheetContext,
                                    sheetContext.l10n.checkoutItemTotal,
                                    _money(sheetContext, subtotal),
                                    isBold: true,
                                  ),
                                  if (LoyaltyFeatures.enabled)
                                    _buildSummaryLabelPercentRow(
                                      sheetContext,
                                      title: sheetContext.l10n.checkoutLoyaltyDiscountLabel,
                                      percent: loyaltyPercentLabel,
                                      amount: _money(sheetContext, loyaltyDiscount),
                                      amountColor: loyaltyDiscount > 0
                                          ? sheetContext.theme.colorScheme.error
                                          : null,
                                      onEdit: (_loyaltyEnabled &&
                                              (_partyLoyalty?.canRedeem ?? false))
                                          ? () => _openLoyaltyRedeemSheet(
                                                sheetContext,
                                                setModalState,
                                                itemTotal: subtotal,
                                              )
                                          : null,
                                    ),
                                  _buildSummaryRow(
                                    sheetContext,
                                    sheetContext.l10n.subtotal,
                                    _money(sheetContext, afterLoyalty),
                                    isBold: true,
                                  ),
                                  _buildSummaryLabelPercentRow(
                                    sheetContext,
                                    title: sheetContext.l10n.checkoutDiscountLabel,
                                    percent: _invoiceSummaryDiscountPercentLabel(
                                      afterLoyalty,
                                      totalDiscount,
                                    ),
                                    amount: _money(sheetContext, totalDiscount),
                                    amountColor: totalDiscount > 0
                                        ? sheetContext.theme.colorScheme.error
                                        : null,
                                    onEdit: () => _openInvoiceSummaryDiscountSheet(
                                      sheetContext,
                                      setModalState,
                                      subtotal: afterLoyalty,
                                    ),
                                  ),
                                  if (_showInvoiceTaxRow)
                                    _buildSummaryLabelPercentRow(
                                      sheetContext,
                                      title: _invoiceTaxRowTitle(sheetContext),
                                      percent: taxRateLabel,
                                      amount: _money(sheetContext, taxAmount),
                                      onEdit: () => _openInvoiceSummaryTaxSheet(
                                        sheetContext,
                                        setModalState,
                                      ),
                                    ),
                                  _buildSummaryRow(
                                    sheetContext,
                                    sheetContext.l10n.checkoutTotalAmount,
                                    _money(sheetContext, totalAfterDiscount),
                                    isBold: true,
                                  ),
                                  if (showPaymentDetails) ...[
                                    SizedBox(height: _sz(sheetContext, 8, 8.h)),
                                    _buildSummaryRow(
                                      sheetContext,
                                      sheetContext.l10n.checkoutPaymentStatus,
                                      isPaid ? sheetContext.l10n.paid : sheetContext.l10n.checkoutUnpaidCredit,
                                    ),
                                    if (isPaid) ...[
                                      if (multiplePayment && multiplePaymentAmounts.isNotEmpty)
                                        _buildSummaryRow(
                                          sheetContext,
                                          sheetContext.l10n.checkoutPaymentMethods,
                                          multiplePaymentAmounts.entries
                                              .where((e) => e.value > 0)
                                              .map((e) => '${e.key}: ${_money(sheetContext, e.value)}')
                                              .join(' · '),
                                        )
                                      else ...[
                                        _buildSummaryRow(sheetContext, sheetContext.l10n.checkoutPaymentMethod, selectedMethod),
                                        if (tenderEntered > 0)
                                          _buildSummaryRow(
                                            sheetContext,
                                            sheetContext.l10n.checkoutTenderAmount,
                                            _money(sheetContext, tenderEntered),
                                          ),
                                      ],
                                    ],
                                    SizedBox(height: _sz(sheetContext, 10, 10.h)),
                                    Text(
                                      sheetContext.l10n.checkoutRemainingUnpaid(_money(sheetContext, unpaidFromGrandTotal)),
                                      style: sheetContext.theme.textTheme.labelLarge?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: _sp(sheetContext, 14, 14),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            SizedBox(height: _sz(sheetContext, 12, 12.h)),
                            _buildSummarySheetCard(
                              sheetContext,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          sheetContext.l10n.checkoutPaymentMode,
                                          style: sheetContext.theme.textTheme.labelLarge?.copyWith(
                                            fontSize: _sp(sheetContext, 14, 14),
                                          ),
                                        ),
                                      ),
                                      Transform.scale(
                                        scale: 0.82,
                                        alignment: Alignment.centerRight,
                                        child: Switch.adaptive(
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          value: showPaymentDetails,
                                          onChanged: (v) {
                                            setModalState(() {
                                              showPaymentDetails = v;
                                              if (!v) {
                                                isPaid = false;
                                                multiplePayment = false;
                                                multiplePaymentAmounts = {};
                                                tenderAmountController.clear();
                                              } else {
                                                isPaid = true;
                                                multiplePayment = false;
                                                multiplePaymentAmounts = {};
                                                tenderAmountController.clear();
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (!showPaymentDetails) ...[
                                    SizedBox(height: _sz(sheetContext, 8, 8.h)),
                                    Text(
                                      sheetContext.l10n.checkoutPaymentModeHint,
                                      style: sheetContext.theme.textTheme.bodySmall?.copyWith(
                                        color: sheetContext.theme.colorScheme.onSurfaceVariant,
                                        fontSize: _sp(sheetContext, 13, 13),
                                      ),
                                    ),
                                  ],
                                  if (showPaymentDetails) ...[
                                    SizedBox(height: _sz(sheetContext, 10, 10.h)),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: isPaid
                                              ? CustomButtonWidget(
                                                  height: _sz(sheetContext, 42, 42),
                                                  borderRadius: _sz(sheetContext, 6, 6),
                                                  onPressed: () => setModalState(() => isPaid = true),
                                                  title: sheetContext.l10n.paid,
                                                )
                                              : CustomButtonWidget.outlined(
                                                  height: _sz(sheetContext, 42, 42),
                                                  borderRadius: _sz(sheetContext, 6, 6),
                                                  onPressed: () => setModalState(() => isPaid = true),
                                                  title: sheetContext.l10n.paid,
                                                ),
                                        ),
                                        SizedBox(width: _sz(sheetContext, 8, 8.w)),
                                        Expanded(
                                          child: isPaid
                                              ? CustomButtonWidget.outlined(
                                                  height: _sz(sheetContext, 42, 42),
                                                  borderRadius: _sz(sheetContext, 6, 6),
                                                  onPressed: () {
                                                    setModalState(() {
                                                      isPaid = false;
                                                      multiplePayment = false;
                                                      multiplePaymentAmounts = {};
                                                      tenderAmountController.clear();
                                                    });
                                                  },
                                                  title: sheetContext.l10n.checkoutUnpaidCredit,
                                                )
                                              : CustomButtonWidget(
                                                  height: _sz(sheetContext, 42, 42),
                                                  borderRadius: _sz(sheetContext, 6, 6),
                                                  onPressed: () {
                                                    setModalState(() {
                                                      isPaid = false;
                                                      multiplePayment = false;
                                                      multiplePaymentAmounts = {};
                                                      tenderAmountController.clear();
                                                    });
                                                  },
                                                  title: sheetContext.l10n.checkoutUnpaidCredit,
                                                ),
                                        ),
                                      ],
                                    ),
                                  ],
                                  if (showPaymentDetails && isPaid) ...[
                                    SizedBox(height: _sz(sheetContext, 12, 12.h)),
                                    if (!multiplePayment) ...[
                                      if (paymentChips.isEmpty)
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: _sz(sheetContext, 8, 8.h)),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: _sz(sheetContext, 18, 18.w),
                                                height: _sz(sheetContext, 18, 18.w),
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  color: sheetContext.theme.colorScheme.primary,
                                                ),
                                              ),
                                              SizedBox(width: _sz(sheetContext, 10, 10.w)),
                                              Text(
                                                sheetContext.l10n.checkoutLoadingPaymentMethods,
                                                style: sheetContext.theme.textTheme.bodySmall?.copyWith(
                                                  fontSize: _sp(sheetContext, 13, 13),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      else
                                        Wrap(
                                          spacing: _sz(sheetContext, 8, 8.w),
                                          runSpacing: _sz(sheetContext, 8, 8.h),
                                          children: paymentChips
                                              .map(
                                                (m) => _buildInvoicePaymentMethodChip(
                                                  context: sheetContext,
                                                  label: m,
                                                  selected: selectedMethod == m,
                                                  onTap: () => setModalState(() => selectedMethod = m),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      SizedBox(height: _sz(sheetContext, 14, 14.h)),
                                    ],
                                    Row(
                                      children: [
                                        Text(
                                          sheetContext.l10n.checkoutMultiplePayment,
                                          style: sheetContext.theme.textTheme.labelLarge?.copyWith(
                                            fontSize: _sp(sheetContext, 14, 14),
                                          ),
                                        ),
                                        SizedBox(width: _sz(sheetContext, 8, 8.w)),
                                        Icon(Icons.help_outline_rounded, size: _sz(sheetContext, 16, 16)),
                                        const Spacer(),
                                        if (multiplePayment)
                                          IconButton(
                                            onPressed: () async {
                                              final data = await _openInvoicePartialPaymentPage(
                                                sheetContext,
                                                paymentMethodsCubit,
                                                total: totalAfterDiscount,
                                                accent: sheetContext.theme.colorScheme.primary,
                                                initial: multiplePaymentAmounts,
                                              );
                                              if (!mounted || data == null) return;
                                              setModalState(() => multiplePaymentAmounts = data);
                                            },
                                            icon: Icon(
                                              Icons.edit_outlined,
                                              size: _sp(sheetContext, 20, 20),
                                              color: sheetContext.theme.colorScheme.primary,
                                            ),
                                            visualDensity: VisualDensity.compact,
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(
                                              minWidth: _sz(sheetContext, 36, 36.w),
                                              minHeight: _sz(sheetContext, 36, 36.h),
                                            ),
                                          ),
                                        Transform.scale(
                                          scale: 0.7,
                                          alignment: Alignment.centerRight,
                                          child: Switch.adaptive(
                                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            value: multiplePayment,
                                            onChanged: (v) async {
                                              if (!v) {
                                                setModalState(() {
                                                  multiplePayment = false;
                                                  multiplePaymentAmounts = {};
                                                });
                                                return;
                                              }
                                              setModalState(() => multiplePayment = true);
                                              final data = await _openInvoicePartialPaymentPage(
                                                sheetContext,
                                                paymentMethodsCubit,
                                                total: totalAfterDiscount,
                                                accent: sheetContext.theme.colorScheme.primary,
                                                initial: multiplePaymentAmounts,
                                              );
                                              if (!mounted) return;
                                              if (data == null) {
                                                setModalState(() {
                                                  multiplePayment = false;
                                                  multiplePaymentAmounts = {};
                                                });
                                              } else {
                                                setModalState(() => multiplePaymentAmounts = data);
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: _sz(sheetContext, 12, 12.w),
                                        vertical: _sz(sheetContext, 8, 8.h),
                                      ),
                                      decoration: BoxDecoration(
                                        color: sheetContext.theme.colorScheme.primaryContainer.withValues(alpha: 0.35),
                                        borderRadius: BorderRadius.circular(_sz(sheetContext, 8, 8.r)),
                                      ),
                                      child: Text(
                                        sheetContext.l10n.checkoutMultiplePaymentHint,
                                        style: sheetContext.theme.textTheme.labelMedium?.copyWith(
                                          fontSize: _sp(sheetContext, 13, 13),
                                        ),
                                      ),
                                    ),
                                    if (multiplePayment && multiplePaymentSum > 0) ...[
                                      SizedBox(height: _sz(sheetContext, 12, 12.h)),
                                      ...multiplePaymentAmounts.entries.map((e) {
                                        final m = e.key;
                                        final amount = e.value;
                                        if (amount <= 0) return const SizedBox.shrink();
                                        return Padding(
                                          padding: EdgeInsets.symmetric(vertical: _sz(sheetContext, 4, 4.h)),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  m,
                                                  style: sheetContext.theme.textTheme.labelLarge?.copyWith(
                                                    fontSize: _sp(sheetContext, 14, 14),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                _money(sheetContext, amount),
                                                style: sheetContext.theme.textTheme.labelLarge?.copyWith(
                                                  fontSize: _sp(sheetContext, 14, 14),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                      Padding(
                                        padding: EdgeInsets.only(top: _sz(sheetContext, 8, 8.h)),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                sheetContext.l10n.total,
                                                style: sheetContext.theme.textTheme.titleSmall
                                                    ?.copyWith(fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                            Text(
                                              _money(sheetContext, multiplePaymentSum),
                                              style: sheetContext.theme.textTheme.titleSmall
                                                  ?.copyWith(fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                    if (!multiplePayment) ...[
                                      SizedBox(height: _sz(sheetContext, 12, 12.h)),
                                      Text(
                                        sheetContext.l10n.checkoutTenderAmount,
                                        style: sheetContext.theme.textTheme.labelLarge?.copyWith(
                                          fontSize: _sp(sheetContext, 14, 14),
                                        ),
                                      ),
                                      SizedBox(height: _sz(sheetContext, 10, 10.h)),
                                      CustomTextFormField(
                                        controller: tenderAmountController,
                                        height: _sz(sheetContext, 48, 50.h),
                                        onChanged: (_) => setModalState(() {}),
                                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                        prefixText: '$_invoiceCurrencySymbol ',
                                        hint: '0.00',
                                        suffixIcon: IconButton(
                                          tooltip: sheetContext.l10n.checkoutFillRemainingBalance,
                                          icon: Transform.scale(
                                            scaleX: 0.9,
                                            child: Icon(
                                              Icons.calculate,
                                              size: _sp(sheetContext, 22, 22),
                                              color: sheetContext.theme.colorScheme.primary,
                                            ),
                                          ),
                                          visualDensity: VisualDensity.compact,
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(
                                            minWidth: _sz(sheetContext, 40, 40.w),
                                            minHeight: _sz(sheetContext, 40, 40.h),
                                          ),
                                          onPressed: () {
                                            final fill =
                                                totalAfterDiscount.clamp(0.0, double.infinity);
                                            if (fill <= 0) {
                                              tenderAmountController.clear();
                                            } else if (fill == fill.roundToDouble()) {
                                              tenderAmountController.text = '${fill.round()}';
                                            } else {
                                              tenderAmountController.text = fill.toStringAsFixed(1);
                                            }
                                            setModalState(() {});
                                          },
                                        ),
                                      ),
                                    ],
                                  ],
                                ],
                              ),
                            ),
                            SizedBox(height: _sz(sheetContext, 80, 80.h)),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(
                        _sz(sheetContext, 16, 16.w),
                        _sz(sheetContext, 10, 10.h),
                        _sz(sheetContext, 16, 16.w),
                        MediaQuery.paddingOf(sheetContext).bottom + _sz(sheetContext, 12, 12.h),
                      ),
                      decoration: BoxDecoration(
                        color: sheetContext.theme.colorScheme.surface,
                        border: Border(top: BorderSide(color: sheetContext.theme.colorScheme.outlineVariant.withValues(alpha: 0.6))),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(sheetContext.l10n.checkoutNetSalesAmount, style: sheetContext.theme.textTheme.labelMedium),
                                Text(
                                  _money(sheetContext, totalAfterDiscount),
                                  style: sheetContext.theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: _sz(sheetContext, 16, 16.w)),
                          Expanded(
                            flex: 2,
                            child: CustomButtonWidget(
                              title: widget.invoiceToEdit != null
                                  ? sheetContext.l10n.checkoutSaveInvoice
                                  : sheetContext.l10n.checkoutConfirmCheckout,
                              onPressed: canConfirmCheckout
                                  ? () async {
                                if (showPaymentDetails) {
                                  if (isPaid && multiplePayment) {
                                    if (multiplePaymentSum > totalAfterDiscount + kPaymentTotalTol) {
                                      ScaffoldMessenger.of(sheetContext).showSnackBar(
                                        SnackBar(
                                          content: Text('Payment amounts cannot exceed the invoice total'),
                                        ),
                                      );
                                      return;
                                    }
                                    if (multiplePaymentSum <= 0) {
                                      final data = await _openInvoicePartialPaymentPage(
                                        sheetContext,
                                        paymentMethodsCubit,
                                        total: totalAfterDiscount,
                                        accent: sheetContext.theme.colorScheme.primary,
                                        initial: multiplePaymentAmounts,
                                      );
                                      if (!mounted || data == null) return;
                                      final sum = data.values.fold<double>(0, (a, b) => a + b);
                                      if (sum <= 0) return;
                                      setModalState(() => multiplePaymentAmounts = data);
                                    }
                                  }
                                  if (isPaid && !multiplePayment) {
                                    final tenderRaw = tenderAmountController.text.trim();
                                    if (tenderRaw.isEmpty) {
                                      ScaffoldMessenger.of(sheetContext).showSnackBar(
                                        SnackBar(content: Text('Please enter tender amount')),
                                      );
                                      return;
                                    }
                                    final tender = double.tryParse(tenderRaw);
                                    if (tender == null) {
                                      ScaffoldMessenger.of(sheetContext).showSnackBar(
                                        SnackBar(content: Text('Enter a valid tender amount')),
                                      );
                                      return;
                                    }
                                    if (tender < 0) {
                                      ScaffoldMessenger.of(sheetContext).showSnackBar(
                                        SnackBar(content: Text('Tender amount cannot be negative')),
                                      );
                                      return;
                                    }
                                    if (tender > totalAfterDiscount + kPaymentTotalTol) {
                                      ScaffoldMessenger.of(sheetContext).showSnackBar(
                                        SnackBar(
                                          content: Text('Tender amount cannot exceed the invoice total'),
                                        ),
                                      );
                                      return;
                                    }
                                  }
                                }

                                double? singleTenderAmount;
                                if (showPaymentDetails && isPaid && !multiplePayment) {
                                  singleTenderAmount =
                                      double.tryParse(tenderAmountController.text.trim());
                                }
                                Navigator.of(sheetContext).pop(
                                  _InvoiceCheckoutSnapshot(
                                    showPaymentDetails: showPaymentDetails,
                                    isPaid: isPaid,
                                    multiplePayment: multiplePayment,
                                    multiplePaymentAmounts:
                                        Map<String, double>.from(multiplePaymentAmounts),
                                    selectedMethod: selectedMethod,
                                    singleTenderAmount: singleTenderAmount,
                                  ),
                                );
                              }
                                  : null,
                              backgroundColor: sheetContext.theme.colorScheme.primary,
                              titleColor: Colors.white,
                              borderRadius: _sz(sheetContext, 10, 10.r),
                              height: _sz(sheetContext, 48, 50.h),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            );
              },
            );
          },
        ),
        );
      },
    ).then((snapshot) {
      if (!mounted || snapshot == null) return;
      if (widget.invoiceToEdit != null) {
        _confirmAndUpdateInvoice(snapshot);
      } else {
        _confirmAndCreateInvoice(snapshot);
      }
    }).whenComplete(() {
      // Bottom sheet close animation (~300ms) can still update [TextField] listenables.
      Future<void>.delayed(const Duration(milliseconds: 400), tenderAmountController.dispose);
    });
  }

  Widget _buildInvoicePaymentMethodChip({
    required BuildContext context,
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: selected ? context.theme.colorScheme.primaryContainer : _cardBg,
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(
            color: selected ? context.theme.colorScheme.primary : _cardBorder,
          ),
        ),
        child: Text(
          label,
          style: context.theme.textTheme.labelMedium?.copyWith(
            color: selected
                ? context.theme.colorScheme.onPrimaryContainer
                : context.theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _wrapInvoiceSummarySheet(BuildContext context, Widget child) {
    if (!_isTablet(context)) return child;
    final sheetH = (MediaQuery.sizeOf(context).height * 0.82).clamp(420.0, 640.0);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: SizedBox(
            height: sheetH,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummarySheetCard(BuildContext ctx, {required Widget child}) {
    final scheme = ctx.theme.colorScheme;
    return Container(
      padding: EdgeInsets.all(_sz(ctx, 14, 14.w)),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(_sz(ctx, 14, 14.r)),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.6)),
      ),
      child: child,
    );
  }

  Widget _buildSummarySection(BuildContext ctx, String title, List<Widget> children) {
    final scheme = ctx.theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFonts.interStyle(
            fontWeight: FontWeight.w700,
            fontSize: _sp(ctx, 15, 15),
            color: scheme.onSurface,
          ),
        ),
        SizedBox(height: _sz(ctx, 12, 12.h)),
        ...children,
      ],
    );
  }

  Widget _buildSummaryRow(
    BuildContext ctx,
    String label,
    String value, {
    bool isBold = false,
    Color? valueColor,
  }) {
    final scheme = ctx.theme.colorScheme;
    final textStyle = isBold
        ? AppFonts.interStyle(fontWeight: FontWeight.w600, fontSize: _sp(ctx, 13, 13))
        : AppFonts.interStyle(fontWeight: FontWeight.w500, fontSize: _sp(ctx, 13, 13));
    return Padding(
      padding: EdgeInsets.only(bottom: _sz(ctx, 8, 8.h)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textStyle.copyWith(color: scheme.onSurfaceVariant),
            ),
          ),
          SizedBox(width: _sz(ctx, 12, 8.w)),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                value,
                textAlign: TextAlign.end,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textStyle.copyWith(color: valueColor ?? scheme.onSurface),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryLabelPercentRow(
    BuildContext ctx, {
    required String title,
    required String percent,
    required String amount,
    VoidCallback? onEdit,
    Color? amountColor,
  }) {
    final scheme = ctx.theme.colorScheme;
    final labelStyle = AppFonts.interStyle(
      fontWeight: FontWeight.w400,
      fontSize: _sp(ctx, 13, 13),
      color: scheme.onSurfaceVariant,
    );
    final amountStyle = AppFonts.interStyle(
      fontWeight: FontWeight.w500,
      fontSize: _sp(ctx, 13, 13),
      color: amountColor ?? scheme.onSurface,
    );
    final percentText = ctx.l10n.checkoutSummaryPercent(
      ctx.l10n.localizeDigits(percent),
    );

    return Padding(
      padding: EdgeInsets.only(bottom: _sz(ctx, 8, 8.h)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: labelStyle,
                  ),
                ),
                SizedBox(width: _sz(ctx, 6, 6.w)),
                Text(
                  percentText,
                  maxLines: 1,
                  style: labelStyle,
                ),
              ],
            ),
          ),
          SizedBox(width: _sz(ctx, 12, 8.w)),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (onEdit != null) ...[
                  TextButton(
                    onPressed: onEdit,
                    style: TextButton.styleFrom(
                      minimumSize: Size(0, _sz(ctx, 30, 30.h)),
                      padding: EdgeInsets.symmetric(horizontal: _sz(ctx, 4, 4.w)),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                    child: Text(
                      ctx.l10n.checkoutTapToEdit,
                      style: ctx.theme.textTheme.labelMedium?.copyWith(
                        color: scheme.primary,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        fontSize: _sp(ctx, 12, 12),
                      ),
                    ),
                  ),
                  SizedBox(width: _sz(ctx, 8, 8.w)),
                ],
                Flexible(
                  child: Text(
                    amount,
                    textAlign: TextAlign.end,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: amountStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _invoicePaymentDateForApi() {
    final raw = _dateController.text.trim();
    if (raw.isEmpty) {
      final n = DateTime.now();
      return '${n.year}-${n.month.toString().padLeft(2, '0')}-${n.day.toString().padLeft(2, '0')}';
    }
    return raw.split(' ').first;
  }

  String _generateInvoicePaymentReferenceId(String paymentMethod) {
    final random = Random();
    final prefixes = {
      'Transfer': 'TXN',
      'Cash': 'CSH',
      'Cheque': 'CHQ',
      'QR': 'QR',
      // 'Bank Transfer': 'TXN',
      // 'Fonepay': 'FNP',
      // 'Card': 'CRD',
    };
    final prefix = prefixes[paymentMethod] ??
        (paymentMethod.length >= 3
            ? paymentMethod.substring(0, 3).toUpperCase()
            : 'REF');
    final number = (10000 + random.nextInt(90000)).toString();
    return '$prefix-$number';
  }

  List<CreateInvoicePaymentLine>? _paymentLinesFromCheckout(_InvoiceCheckoutSnapshot checkout) {
    if (!checkout.showPaymentDetails || !checkout.isPaid) return null;

    final dateStr = _invoicePaymentDateForApi();

    if (checkout.multiplePayment) {
      final lines = <CreateInvoicePaymentLine>[];
      final entries = checkout.multiplePaymentAmounts.entries.toList()
        ..sort((a, b) => a.key.compareTo(b.key));
      for (final e in entries) {
        if (e.value <= 0) continue;
        lines.add(
          CreateInvoicePaymentLine(
            amount: e.value,
            paymentMethod: normalizePaymentMethodForApi(e.key),
            paymentDate: dateStr,
            referenceId: _generateInvoicePaymentReferenceId(e.key),
            clearanceDate: dateStr,
          ),
        );
      }
      return lines.isEmpty ? null : lines;
    }

    final tender = checkout.singleTenderAmount;
    if (tender == null || tender <= 0) return null;

    return [
      CreateInvoicePaymentLine(
        amount: tender,
        paymentMethod: normalizePaymentMethodForApi(checkout.selectedMethod),
        paymentDate: dateStr,
        referenceId: _generateInvoicePaymentReferenceId(checkout.selectedMethod),
        clearanceDate: dateStr,
      ),
    ];
  }

  bool _allowSalesQuantity({
    required String itemName,
    required double requestedQty,
    String? itemType,
  }) {
    if (widget.invoiceType != InvoiceType.sales) return true;
    final type = itemType ?? _itemTypeNamed(itemName);
    if (liveStockAllowsSale(
      itemName: itemName,
      requestedQty: requestedQty,
      itemType: type,
    )) {
      return true;
    }
    showLiveStockShortage(context, itemName);
    return false;
  }

  String? _itemTypeNamed(String name) {
    for (final item in _availableItems.value) {
      if (item.name == name) return item.itemType;
    }
    return null;
  }

  bool _invoiceLinesWithinStock() {
    if (widget.invoiceType != InvoiceType.sales) return true;
    final totals = <String, double>{};
    for (final row in _itemsNotifier.value) {
      final name = row.selectedItemName.value?.trim() ?? '';
      if (name.isEmpty) continue;
      final qty = double.tryParse(row.quantityController.text) ?? 0;
      if (qty <= 0) continue;
      totals[name] = (totals[name] ?? 0) + qty;
    }
    for (final entry in totals.entries) {
      if (!_allowSalesQuantity(itemName: entry.key, requestedQty: entry.value)) {
        return false;
      }
    }
    return true;
  }

  void _confirmAndCreateInvoice(_InvoiceCheckoutSnapshot checkout) {
    if (!_invoiceLinesWithinStock()) return;
    final items = _itemsNotifier.value
        .map((itemData) => CreateInvoiceItem(
              item: itemData.selectedItemName.value ?? '',
              rate: double.tryParse(itemData.rateController.text) ?? 0.0,
              quantity:
                  itemData.quantityController.text.isEmpty ? null : double.tryParse(itemData.quantityController.text),
              account: 'Sales',
              // description: itemData.descriptionController.text.isEmpty ? null : itemData.descriptionController.text,
              // unit: itemData.unitController.text.isEmpty ? null : itemData.unitController.text,
              setItemDiscountAmount: itemData.setItemDiscountAmountNotifier.value,
              itemDiscountAmount: itemData.itemDiscountAmountController.text.isEmpty
                  ? null
                  : double.tryParse(itemData.itemDiscountAmountController.text),
              // itemDiscountPercent: itemData.itemDiscountPercentController.text.isEmpty
              //     ? null
              //     : double.tryParse(itemData.itemDiscountPercentController.text),
            ))
        .toList();

    final paymentMode = checkout.showPaymentDetails;
    final paymentLines = paymentMode ? _paymentLinesFromCheckout(checkout) : null;

    final params = CreateInvoiceRequestParams(
      invoiceType: widget.invoiceType,
      party: _selectedPartyName.value ?? '',
      account: "Debtors",
      date: _dateController.text.isEmpty ? null : _dateController.text,
      currency: _invoiceCurrencyCode,
      setDiscountAmount: _setDiscountAmountNotifier.value,
      discountAmount:
          _discountAmountController.text.trim().isEmpty ? null : double.tryParse(_discountAmountController.text),
      discountPercent:
          _discountPercentController.text.trim().isEmpty ? null : double.tryParse(_discountPercentController.text),
      createdBy: "hotelroyalrestro@gmail.com",
      modifiedBy: "hotelroyalrestro@gmail.com",
      items: items,
      paymentMode: paymentMode,
      payment: paymentLines,
      applyTax: _applyTaxNotifier.value,
      taxRateOverride: _applyTaxNotifier.value && _effectiveInvoiceTaxRate > 0
          ? _effectiveInvoiceTaxRate
          : null,
      invoiceTaxKind: _applyTaxNotifier.value
          ? _invoiceTaxKind.storageValue
          : null,
      loyaltyProgram: LoyaltyFeatures.enabled ? _partyLoyalty?.program?.name : null,
      loyaltyPoints: LoyaltyFeatures.enabled && _redeemLoyaltyPoints > 0
          ? _redeemLoyaltyPoints
          : null,
      redeemLoyaltyPoints: LoyaltyFeatures.enabled && _redeemLoyaltyPoints > 0,
    );

    // Handle invoice creation here
    print('Invoice created: ${params.toJson()}');
    context.read<CreateInvoiceCubit>().createInvoice(params: params);
  }

  /// Pops first, then snack + [onComplete] on the root scaffold — avoids overlay / snack
  /// racing this route's teardown (same frame as [dispose] + text controllers).
  void _finishInvoiceFlowSuccess(BuildContext context, String message) {
    final router = context.router;
    final onComplete = widget.onComplete;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;
      _resetCreateRouteLoading();
      FocusManager.instance.primaryFocus?.unfocus();
      SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        router.maybePop().whenComplete(() {
          // Wait for the route exit animation to finish before calling
          // onComplete().  The default page transition is ~300 ms; 5 frames
          // (~83 ms at 60 fps) is too short and lets onComplete() fire while
          // the create-invoice route is still animating out.  That causes the
          // parent page to rebuild and insert new Overlay entries while this
          // route's entries are still alive, producing duplicate
          // _OverlayEntryWidgetState GlobalKey errors in _Theater.
          // A 400 ms delay gives the animation room to complete with margin.
          Future.delayed(const Duration(milliseconds: 400), onComplete);
        });
      });
    });
  }

  void _dismissKeyboard() {
    FocusScope.of(context).unfocus();
    SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
    // Hide all dropdowns
    for (var item in _itemsNotifier.value) {
      item.showDropdown.value = false;
    }
    _showPartyDropdown.value = false;
  }

  void _openQuickAddItems() {
    final quantities = <String, int>{};
    for (final row in _itemsNotifier.value) {
      final name = row.selectedItemName.value;
      if (name != null && name.isNotEmpty) {
        final q = (double.tryParse(row.quantityController.text) ?? 0).toInt();
        if (q > 0) quantities[name] = (quantities[name] ?? 0) + q;
      }
    }
    _updateSelectedSummary();
    QuickAddItemsPage.open(
      context,
      invoiceType: widget.invoiceType,
      onItemSelected: _addItemToInvoice,
      cartTotalNotifier: _grandTotalNotifier,
      initialQuantities: quantities.isEmpty ? null : quantities,
      selectedItemsNotifier: _selectedSummaryNotifier,
      onIncreaseItem: _increaseItemFromQuickAdd,
      onDecreaseItem: _decreaseItemFromQuickAdd,
      showDoneButton: true,
      showPartySelector: true,
      initialPartyName: _selectedPartyName.value,
      onPartySelected: (partyName, {String? currency}) {
        _selectedPartyName.value = partyName;
        _partySearchController.text = partyName;
        _partyController.text = partyName;
        _setPartyCurrency(currency);
        unawaited(_refreshPartyLoyalty(partyName));
      },
    );
  }

  Widget _buildSectionCard(String title, IconData icon, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: icon == Icons.circle ? 8.sp : 18.sp,
              color: context.theme.colorScheme.primary,
            ),
            SizedBox(width: 8.w),
            Text(
              title,
              style: context.theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: context.theme.colorScheme.primary,
              ),
            ),
          ],
        ),
        verticalMarginMedium,
        ...children,
      ],
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    String? hint,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: AppFonts.interStyle(color: _scheme.onSurfaceVariant.withValues(alpha: 0.7)),
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      ),
      validator: validator,
      maxLines: maxLines,
    );
  }

  Future<void> _openPurchasePriceCalculator(
    BuildContext context, {
    required TextEditingController rateController,
    ValueNotifier<int>? quantityNotifier,
    TextEditingController? quantityController,
    VoidCallback? onValuesChanged,
  }) async {
    if (widget.invoiceType != InvoiceType.purchase) return;

    FocusScope.of(context).unfocus();

    final rate = double.tryParse(rateController.text.trim()) ?? 0;
    final qty = quantityNotifier != null
        ? quantityNotifier.value
        : (int.tryParse(quantityController?.text.trim() ?? '') ?? 1);
    final initialTotal = rate > 0 && qty > 0 ? rate * qty : null;

    final result = await context.showPriceCalculator(
      totalAmount: initialTotal,
      currencySymbol: _invoiceCurrencySymbol,
    );
    if (result == null) return;

    rateController.text = _formatInvoiceMoney(result.perItemPrice);
    final newQty = result.quantity.round();
    if (quantityNotifier != null) {
      quantityNotifier.value = newQty > 0 ? newQty : 1;
    } else if (quantityController != null) {
      quantityController.text = newQty > 0 ? newQty.toString() : '1';
    }
    onValuesChanged?.call();
  }

  Widget? _purchaseCalculatorSuffix(
    BuildContext context, {
    required TextEditingController rateController,
    required bool showCalculate,
    ValueNotifier<int>? quantityNotifier,
    TextEditingController? quantityController,
    VoidCallback? onValuesChanged,
  }) {
    if (!showCalculate || widget.invoiceType != InvoiceType.purchase) {
      return const SizedBox.shrink();
    }
    return GestureDetector(
      onTap: () => _openPurchasePriceCalculator(
        context,
        rateController: rateController,
        quantityNotifier: quantityNotifier,
        quantityController: quantityController,
        onValuesChanged: onValuesChanged,
      ),
      child: Icon(Icons.calculate, size: 20),
    );
  }

  Widget _buildNumberField({
    required TextEditingController controller,
    required String label,
    String? hint,
    required bool showCalculate,
    bool integersOnly = false,
    TextEditingController? relatedController,
  }) {
    return CustomTextFormField(
      controller: controller,
      suffixIcon: _purchaseCalculatorSuffix(
        context,
        rateController: controller,
        showCalculate: showCalculate,
        quantityController: relatedController,
      ),
      labelText: label,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatter: integersOnly
          ? [FilteringTextInputFormatter.digitsOnly]
          : [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,15}'))],
      hint: hint ?? '',
    );
  }

  Widget _buildDateField() {
    return CustomTextFormField(
      controller: _dateController,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      labelText: context.l10n.date,
      hint: 'Select date',
      // suffixIcon: widget.invoiceType == InvoiceType.purchase
      //     ? IconButton(
      //         icon: Icon(Icons.calendar_today),
      //         onPressed: _selectDate,
      //       )
      //     : SizedBox.shrink(),
      // decoration: InputDecoration(
      //   labelText: 'Date',
      //   hintText: 'Select date',
      //   hintStyle: AppFonts.interStyle(color: Colors.grey[400]), // Light gray hint color
      //   border: const OutlineInputBorder(),
      //   contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      //   suffixIcon: IconButton(
      //     icon: Icon(Icons.calendar_today),
      //     onPressed: _selectDate,
      //   ),
      // ),
      readOnly: true,
      onTap: _selectDate, keyboardType: TextInputType.text,
    );
  }

  Widget _buildPartySearchDropdown() {
    return ValueListenableBuilder<String?>(
      valueListenable: _selectedPartyName,
      builder: (context, selectedPartyName, child) {
        return CustomTextFormField(
          controller: _partyController,
          prefixIcon: AppSearchIcon.inputDecoration(color: _scheme.onSurfaceVariant),
          suffixIcon: Icon(Icons.keyboard_arrow_down, color: _scheme.onSurfaceVariant),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          labelText: context.l10n.checkoutPartyRequired,
          readOnly: true,
          onTap: () => _showPartyPickerBottomSheet(context),
          validating: (value) {
            if (selectedPartyName == null || selectedPartyName.isEmpty) {
              return 'Please select a party';
            }
            return null;
          },
          hint: 'Select a party',
          keyboardType: TextInputType.text,
        );
      },
    );
  }

  Widget _buildDiscountSection() {
    return ValueListenableBuilder<bool>(
      valueListenable: _setDiscountAmountNotifier,
      builder: (context, setDiscountAmount, child) {
        return Column(
          children: [
            Row(
              children: [
                Checkbox(
                  value: setDiscountAmount,
                  onChanged: (value) {
                    _setDiscountAmountNotifier.value = value ?? false;
                    _calculateGrandTotal();
                  },
                ),
                Text('Set Discount Amount'),
              ],
            ),
            if (setDiscountAmount) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildNumberField(
                      showCalculate: false,
                      controller: _discountAmountController,
                      label: 'Discount Amount',
                      hint: '0.00',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildNumberField(
                      showCalculate: false,
                      controller: _discountPercentController,
                      label: 'Discount %',
                      hint: '0.00',
                    ),
                  ),
                ],
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildItemsList() {
    return ValueListenableBuilder<List<InvoiceItemData>>(
      valueListenable: _itemsNotifier,
      builder: (context, items, child) {
        if (items.isEmpty) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: _sz(context, 22, 22.h),
              horizontal: _sz(context, 12, 12.w),
            ),
            decoration: BoxDecoration(
              color: _scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(_sz(context, 12, 12.r)),
              border: Border.all(color: _cardBorder),
            ),
            child: Text(
              'No Items added yet. Tap Add Items.',
              textAlign: TextAlign.center,
              style: context.theme.textTheme.bodyMedium?.copyWith(
                color: _scheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...items.asMap().entries.map((entry) {
              final index = entry.key;
              final itemData = entry.value;
              return ListenableBuilder(
                // ObjectKey ensures Flutter creates a fresh element for each
                // InvoiceItemData rather than reusing the old element for the
                // next item after a removal.  Without a key, element reuse
                // calls didUpdateWidget with a disposed controller → crash.
                key: ObjectKey(itemData),
                listenable: Listenable.merge([itemData.totalNotifier, itemData.selectedItemName]),
                builder: (context, _) {
                  final quantity = (double.tryParse(itemData.quantityController.text) ?? 0).toInt();
                  final unitPrice = double.tryParse(itemData.rateController.text) ?? 0.0;
                  final itemTotal = itemData.totalNotifier.value;
                  final pickedName = itemData.selectedItemName.value?.trim();
                  final searchDraft = itemData.searchController.text.trim();
                  final lineTitle = (pickedName != null && pickedName.isNotEmpty)
                      ? pickedName
                      : (searchDraft.isNotEmpty ? searchDraft : 'Tap to choose item');
                  final lineTitleMuted = pickedName == null || pickedName.isEmpty;

                  return GestureDetector(
                    onTap: () => _showEditInvoiceItemSheet(itemData, index),
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: _sz(context, 10, 10.h)),
                      padding: EdgeInsets.all(_sz(context, 14, 12.w)),
                      decoration: BoxDecoration(
                        color: _cardBg,
                        borderRadius: BorderRadius.circular(_sz(context, 12, 12.r)),
                        border: Border.all(color: _cardBorder),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: _sz(context, 48, 48.w),
                            height: _sz(context, 48, 48.w),
                            decoration: BoxDecoration(
                              color: _iconTint,
                              borderRadius: BorderRadius.circular(_sz(context, 10, 10.r)),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.restaurant_menu_rounded,
                              size: _sp(context, 22, 20),
                              color: context.theme.colorScheme.primary,
                            ),
                          ),
                          SizedBox(width: _sz(context, 12, 12.w)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  lineTitle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: _sp(context, 16, 16),
                                    color: lineTitleMuted ? _scheme.onSurfaceVariant : null,
                                  ),
                                ),
                                SizedBox(height: _sz(context, 2, 2.h)),
                                Text(
                                  '${_money(context, unitPrice)} × ${context.l10n.formatCount(quantity)} = ${_money(context, itemTotal)}',
                                  style: context.theme.textTheme.labelMedium?.copyWith(
                                    color: _scheme.onSurfaceVariant,
                                    fontWeight: FontWeight.w600,
                                    fontSize: _sp(context, 13, 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: _sz(context, 10, 10.w),
                              vertical: _sz(context, 6, 6.h),
                            ),
                            decoration: BoxDecoration(
                              color: _scheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(_sz(context, 6, 6.r)),
                              border: Border.all(color: _cardBorder),
                            ),
                            child: Text(
                              '×${context.l10n.formatCount(quantity)}',
                              style: context.theme.textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: _sp(context, 13, 12),
                                color: _scheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                          SizedBox(width: _sz(context, 8, 6.w)),
                          GestureDetector(
                            onTap: () {
                              final actualIndex = _itemsNotifier.value.indexOf(itemData);
                              if (actualIndex >= 0) _removeItem(actualIndex);
                              _updateSelectedSummary();
                              _calculateGrandTotal();
                            },
                            child: Padding(
                              padding: EdgeInsets.all(_sz(context, 6, 6.r)),
                              child: AppDeleteIcon(
                                size: _sp(context, 22, 18),
                                color: context.theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ],
        );
      },
    );
  }

  void _showEditInvoiceItemSheet(InvoiceItemData itemData, int index) {
    final qty = (double.tryParse(itemData.quantityController.text) ?? 1).toInt();
    final rate = double.tryParse(itemData.rateController.text) ?? 0;
    final quantityNotifier = ValueNotifier<int>(qty <= 0 ? 1 : qty);
    final rateController = TextEditingController(text: _formatInvoiceMoney(rate));

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: false,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (sheetContext, setModalState) {
            final bottomInset = MediaQuery.viewInsetsOf(sheetContext).bottom;
            final bottomSafe = MediaQuery.paddingOf(sheetContext).bottom;
            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: sheetContext.theme.colorScheme.surface,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                ),
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      16.w,
                      16.h,
                      16.w,
                      bottomSafe + 12.h + bottomInset,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Edit Order Item',
                              style: sheetContext.theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              Navigator.of(sheetContext).pop();
                            },
                            child: Padding(
                              padding: EdgeInsets.all(8.r),
                              child: Icon(Icons.close_rounded, color: sheetContext.theme.colorScheme.onSurfaceVariant),
                            ),
                          ),
                        ],
                      ),
                      verticalMarginMedium,
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: sheetContext.theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: sheetContext.theme.colorScheme.outlineVariant.withValues(alpha: 0.6),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 44.w,
                              height: 44.w,
                              decoration: BoxDecoration(
                                color: sheetContext.theme.colorScheme.primaryContainer.withValues(alpha: 0.45),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              alignment: Alignment.center,
                              child: Icon(Icons.restaurant_menu_rounded, size: 20.sp),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                itemData.selectedItemName.value ?? 'Item ${index + 1}',
                                style: sheetContext.theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            ValueListenableBuilder<int>(
                              valueListenable: quantityNotifier,
                              builder: (context, quantity, _) {
                                return Row(
                                  children: [
                                    GestureDetector(
                                      onTap: quantity > 1 ? () => quantityNotifier.value = quantity - 1 : null,
                                      child: Container(
                                        width: 25.w,
                                        height: 25.w,
                                        decoration: BoxDecoration(
                                          color: context.theme.colorScheme.primary,
                                          borderRadius: BorderRadius.circular(6.r),
                                        ),
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.remove_rounded,
                                          color: sheetContext.theme.colorScheme.onPrimary,
                                          size: context.theme.appTheme.spacing16,
                                        ),
                                      ),
                                    ),
                                    horizontalMarginMedium,
                                    Text(
                                      '$quantity',
                                      style: sheetContext.theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    horizontalMarginMedium,
                                    GestureDetector(
                                      onTap: () {
                                        final name = itemData.selectedItemName.value?.trim() ?? '';
                                        if (!_allowSalesQuantity(
                                          itemName: name,
                                          requestedQty: (quantity + 1).toDouble(),
                                        )) {
                                          return;
                                        }
                                        quantityNotifier.value = quantity + 1;
                                      },
                                      child: Container(
                                        width: 25.w,
                                        height: 25.w,
                                        decoration: BoxDecoration(
                                          color: context.theme.colorScheme.primary,
                                          borderRadius: BorderRadius.circular(6.r),
                                        ),
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.add_rounded,
                                          color: sheetContext.theme.colorScheme.onPrimary,
                                          size: context.theme.appTheme.spacing16,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 14.h),
                      CustomTextFormField(
                        controller: rateController,
                        labelText: 'Price',
                        hint: 'Enter price',
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatter: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,15}')),
                        ],
                        prefixText: '$_invoiceCurrencySymbol ',
                        suffixIcon: _purchaseCalculatorSuffix(
                          sheetContext,
                          rateController: rateController,
                          showCalculate: true,
                          quantityNotifier: quantityNotifier,
                          onValuesChanged: () => setModalState(() {}),
                        ),
                      ),
                      SizedBox(height: 14.h),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButtonWidget.outlined(
                              title: 'Cancel',
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                Navigator.of(sheetContext).pop();
                              },
                              height: 46.h,
                              borderRadius: 10.r,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: CustomButtonWidget(
                              title: 'Update',
                              onPressed: () {
                                final parsedRate = double.tryParse(rateController.text.trim());
                                if (parsedRate == null || parsedRate < 0) {
                                  ScaffoldMessenger.of(sheetContext).showSnackBar(
                                    SnackBar(content: Text('Please enter a valid price')),
                                  );
                                  return;
                                }
                                final name = itemData.selectedItemName.value?.trim() ?? '';
                                if (!_allowSalesQuantity(
                                  itemName: name,
                                  requestedQty: quantityNotifier.value.toDouble(),
                                )) {
                                  return;
                                }
                                itemData.quantityController.text = quantityNotifier.value.toString();
                                itemData.rateController.text = _formatInvoiceMoney(parsedRate);
                                final lineDiscount = itemData.setItemDiscountAmountNotifier.value
                                    ? (double.tryParse(itemData.itemDiscountAmountController.text) ?? 0.0)
                                    : 0.0;
                                itemData.totalNotifier.value = (parsedRate * quantityNotifier.value) - lineDiscount;
                                _calculateGrandTotal();
                                _updateSelectedSummary();
                                if (mounted) setState(() {});
                                FocusManager.instance.primaryFocus?.unfocus();
                                Navigator.of(sheetContext).pop();
                              },
                              height: 46.h,
                              borderRadius: 10.r,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            );
          },
        );
      },
    );
  }

  Widget _buildItemCard(InvoiceItemData itemData, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       'Item ${index + 1}',
        //       style: context.theme.textTheme.titleMedium?.copyWith(
        //         fontWeight: FontWeight.w700,
        //         color: context.theme.colorScheme.outline
        //       ),
        //     ),
        //     if (_itemsNotifier.value.length > 1)
        //       IconButton(
        //         onPressed: () => _removeItem(index),
        //         icon: Icon(Icons.delete),
        //       ),
        //   ],
        // ),
        // const SizedBox(height: 16),

        // Item Search Dropdown
        _buildItemSearchDropdown(itemData, index),

        verticalMarginSmall,
        Row(
          children: [
            Expanded(
              child: _buildNumberField(
                controller: itemData.rateController,
                label: 'Rate *',
                showCalculate: true,
                hint: '0',
                integersOnly: false,
                relatedController: itemData.quantityController, // Pass the quantity controller
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildNumberField(
                showCalculate: false,
                controller: itemData.quantityController,
                label: 'Quantity',
                hint: '1',
                integersOnly: true,
              ),
            ),
          ],
        ),
        verticalMarginMedium,

        // Total Display
        ValueListenableBuilder<double>(
          valueListenable: itemData.totalNotifier,
          builder: (context, total, child) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: context.theme.colorScheme.outlineVariant),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${context.l10n.checkoutItemTotal}:',
                    style: context.theme.textTheme.titleMedium,
                  ),
                  Text(
                    _money(context, total),
                    style: context.theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700, color: context.theme.colorScheme.primary),
                  ),
                ],
              ),
            );
          },
        ),

        verticalMarginSmall,
        // _buildItemDiscountSection(itemData),

        Divider().pOnly(top: context.theme.appTheme.spacing12, bottom: context.theme.appTheme.spacing12)
      ],
    );
  }

  Widget _buildItemSearchDropdown(InvoiceItemData itemData, int i) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // verticalMarginMedium,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Item ${i + 1} *',
              style: AppFonts.interStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _scheme.onSurface,
              ),
            ),
            if (_itemsNotifier.value.length > 1)
              GestureDetector(
                onTap: () => _removeItem(i),
                child: AppDeleteIcon(
                  size: context.theme.appTheme.spacing16,
                ),
              ),
          ],
        ),
        verticalMarginMedium,
        // Search Field — tap opens item picker bottom sheet
        Column(
          children: [
            ValueListenableBuilder<String?>(
              valueListenable: itemData.selectedItemName,
              builder: (context, selectedItemName, child) {
                return TextFormField(
                  controller: itemData.searchController,
                  decoration: InputDecoration(
                    hintText: 'Search and select an item',
                    hintStyle: AppFonts.interStyle(color: _scheme.onSurfaceVariant.withValues(alpha: 0.7)),
                    filled: true,
                    fillColor: _scheme.surfaceContainerHighest,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: _cardBorder),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: _cardBorder),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: _scheme.primary),
                    ),
                    prefixIcon: AppSearchIcon.inputDecoration(color: _scheme.onSurfaceVariant),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: _scheme.onSurfaceVariant,
                      ),
                      onPressed: () => _showItemPickerBottomSheet(context, itemData),
                    ),
                  ),
                  readOnly: true,
                  onTap: () => _showItemPickerBottomSheet(context, itemData),
                  validator: (value) {
                    if (selectedItemName == null) {
                      return 'Please select an item';
                    }
                    return null;
                  },
                );
              },
            ),
          ],
        ),
        verticalMarginSmall,
        // Selected Item Info
        // ValueListenableBuilder<String?>(
        //   valueListenable: itemData.selectedItemName,
        //   builder: (context, selectedItemName, child) {
        //     if (selectedItemName == null) {
        //       return const SizedBox.shrink();
        //     }
        //
        //     return Container(
        //       width: double.infinity,
        //       padding: const EdgeInsets.all(12),
        //       decoration: BoxDecoration(
        //         color: Colors.green[50],
        //         borderRadius: BorderRadius.circular(8),
        //         border: Border.all(color: Colors.green[200]!),
        //       ),
        //       child: Row(
        //         children: [
        //           Icon(Icons.check_circle, color: Colors.green[600], size: 18),
        //           const SizedBox(width: 8),
        //           Expanded(
        //             child: Text(
        //               'Selected: $selectedItemName',
        //               style: AppFonts.interStyle(
        //                 fontSize: 12,
        //                 color: Colors.black87,
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     );
        //   },
        // ),
      ],
    );
  }

  Widget _buildItemDiscountSection(InvoiceItemData itemData) {
    return ValueListenableBuilder<bool>(
      valueListenable: itemData.setItemDiscountAmountNotifier,
      builder: (context, setItemDiscount, child) {
        return Column(
          children: [
            Row(
              children: [
                Transform.translate(
                  offset: const Offset(-12, 0), // Shift left by 12 pixels
                  child: Checkbox(
                    value: setItemDiscount,
                    onChanged: (value) {
                      itemData.setItemDiscountAmountNotifier.value = value ?? false;
                    },
                  ),
                ),
                Text('Set Item Discount'),
              ],
            ),
            if (setItemDiscount) ...[
              verticalMarginSmall,
              Row(
                children: [
                  Expanded(
                    child: _buildNumberField(
                      showCalculate: false,
                      controller: itemData.itemDiscountAmountController,
                      label: 'Item Discount Amount',
                      hint: '0',
                      integersOnly: true, // Only integers for discount
                    ),
                  ),
                  // const SizedBox(width: 16),
                  // Expanded(
                  //   child: _buildNumberField(
                  //     controller: itemData.itemDiscountPercentController,
                  //     label: 'Item Discount %',
                  //     hint: '0.00',
                  //   ),
                  // ),
                ],
              ),
            ],
          ],
        );
      },
    );
  }

  bool get _showInvoiceTaxRow => widget.invoiceType == InvoiceType.sales;

  Widget _buildGrandTotalCard() {
    // Use [_grandTotalNotifier] only — avoids Listenable.merge with TextEditingController,
    // which could still be listened to by AnimatedSwitcher exits after dispose.
    return ValueListenableBuilder<double>(
      valueListenable: _grandTotalNotifier,
      builder: (context, grandTotal, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(_sz(context, 12, 12)),
              decoration: BoxDecoration(
                color: context.theme.colorScheme.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(_sz(context, 8, 8)),
                border: Border.all(
                  color: context.theme.colorScheme.outlineVariant
                      .withValues(alpha: 0.45),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${context.l10n.grandTotal}:',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: _sp(context, 18, 20),
                          color: context.theme.colorScheme.onSurface,
                        ),
                  ),
                  Text(
                    _money(context, grandTotal),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: _sp(context, 20, 24),
                          color: context.theme.colorScheme.onSurface,
                        ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _createRouteLoadingOverlay,
      builder: (context, showCreateRouteLoading, _) {
        return Stack(
          children: [
            Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: _scheme.surfaceContainerLow,
              appBar: AppBar(
                leading: const AppBarIosBackButton(),
                title: Text(widget.invoiceToEdit != null
                    ? context.l10n.checkoutEditInvoice
                    : context.l10n.checkoutCreateInvoice),
                actions: [
                  FilledButton.icon(
                    onPressed: _openQuickAddItems,
                    label: Text(context.l10n.checkoutAddItems),
                    style: FilledButton.styleFrom(
                      backgroundColor: context.theme.colorScheme.primary,
                      foregroundColor: context.theme.colorScheme.onPrimary,
                      textStyle: context.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(_sz(context, 8, 6.r)),
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                  SizedBox(width: _sz(context, 8, 8.w)),
                ],
              ),
              body: MultiBlocListener(
            listeners: [
              BlocListener<ItemCubit, ItemState>(
                listener: (context, state) {
                  state.maybeWhen(
                    loading: () {
                      if (!_isItemPickerOpen) _acquireCreateRouteLoading();
                    },
                    success: (response, hasMore) {
                      if (!_isItemPickerOpen) {
                        _releaseCreateRouteLoading();
                        final itemList = mapToAvailableItems(response);
                        _availableItems.value = itemList;
                        for (var item in _itemsNotifier.value) {
                          item.updateAvailableItems(itemList);
                        }
                        if (!_quickAddDraftApplied &&
                            widget.invoiceToEdit == null &&
                            widget.invoiceToDuplicate == null) {
                          final draft = QuickAddInvoiceDraftBridge.takeFor(widget.invoiceType);
                          if (draft != null) {
                            _applyQuickAddDraft(draft);
                            _quickAddDraftApplied = true;
                            return;
                          }
                        }
                        if (widget.invoiceToEdit != null && !_editLinePrefillApplied) {
                          _applyLineItemsEditPrefill();
                        } else if (widget.invoiceToDuplicate != null && !_editLinePrefillApplied) {
                          _applyLineItemsDuplicatePrefill();
                        } else if (_itemsNotifier.value.isEmpty) {
                          _addNewItem();
                        }
                      }
                    },
                    error: (message) {
                      if (!_isItemPickerOpen) {
                        _releaseCreateRouteLoading();
                        if (widget.invoiceToEdit != null && !_editLinePrefillApplied) {
                          _applyLineItemsEditPrefill();
                        } else if (widget.invoiceToDuplicate != null && !_editLinePrefillApplied) {
                          _applyLineItemsDuplicatePrefill();
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(message),
                            backgroundColor: context.theme.colorScheme.error,
                          ),
                        );
                      }
                    },
                    orElse: () {},
                  );
                },
              ),
              BlocListener<PartyCubit, PartyState>(
                listener: (context, state) {
                  state.maybeWhen(
                    loading: () {},
                    success: (response) {
                      if (!_isPartyPickerOpen) {
                        final partyList = mapToAvailableParties(response.data);
                        _availableParties.value = partyList;
                        _filteredParties.value = partyList;
                      }
                    },
                    error: (message) {
                      if (!_isPartyPickerOpen) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Party loading error: $message'),
                            backgroundColor: context.theme.colorScheme.error,
                          ),
                        );
                      }
                    },
                    orElse: () {},
                  );
                },
              ),
              BlocListener<CreateInvoiceCubit, CreateInvoiceState>(
                listener: (context, state) {
                  state.maybeWhen(
                    loading: () {
                      _acquireCreateRouteLoading();
                      // Loading already handled by ItemCubit
                    },
                    success: (response) {
                      _finishInvoiceFlowSuccess(context, response.message);
                    },
                    error: (message) {
                      _releaseCreateRouteLoading();
                      context.showKiiSnackBarError(message);
                    },
                    orElse: () {},
                  );
                },
              ),
              if (widget.invoiceToEdit != null)
                BlocListener<UpdateInvoiceCubit, UpdateInvoiceState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      loading: () => _acquireCreateRouteLoading(),
                      success: (response) {
                        _finishInvoiceFlowSuccess(context, response.message);
                      },
                      error: (message) {
                        _releaseCreateRouteLoading();
                        context.showKiiSnackBarError(message);
                      },
                      orElse: () {},
                    );
                  },
                ),
            ],
            child: GestureDetector(
              onTap: _dismissKeyboard,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: _pageHorizontalPadding(context).copyWith(
                          top: _sz(context, 16, context.theme.appTheme.spacing16),
                          bottom: _sz(context, 16, context.theme.appTheme.spacing16),
                        ),
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSectionCard(
                                context.l10n.checkoutBasicInformation,
                                Icons.circle,
                                [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(flex: 1, child: _buildPartySearchDropdown()),
                                      horizontalMarginMedium,
                                      Expanded(flex: 1, child: _buildDateField()),
                                    ],
                                  ),
                                ],
                              ),
                              verticalMarginXLarge,
                              _buildSectionCard(
                                context.l10n.checkoutItemsSection,
                                Icons.circle,
                                [_buildItemsList()],
                              ),
                              verticalMarginMedium,
                              // _buildDiscountSection(),
                              // const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SafeArea(
                      top: false,
                      child: Container(
                        width: double.infinity,
                        padding: _pageHorizontalPadding(context).copyWith(
                          top: _sz(context, 8, 8.h),
                          bottom: _sz(context, 8, 8.h),
                        ),
                        decoration: BoxDecoration(
                          color: _cardBg,
                          border: Border(top: BorderSide(color: _cardBorder)),
                          boxShadow: [
                            BoxShadow(
                              color: _scheme.shadow.withValues(alpha: 0.08),
                              blurRadius: 8,
                              offset: const Offset(0, -2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildGrandTotalCard(),
                            SizedBox(height: 10.h),
                            CustomButtonWidget(
                              width: double.infinity,
                              onPressed: _createInvoice,
                              title: widget.invoiceToEdit != null
                                  ? context.l10n.checkoutSaveInvoice
                                  : context.l10n.checkoutCreateInvoice,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
            if (showCreateRouteLoading)
              Positioned.fill(
                child: AbsorbPointer(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const ModalBarrier(
                        dismissible: false,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: context.theme.colorScheme.surface,
                          borderRadius: allRadiusLarge,
                        ),
                        padding: symmetricPaddingMedium,
                        child: const CircularProgressIndicator(),
                      ),
                    ],
                  ),
                ),
              ),
            const KeyboardDoneBar(),
          ],
        );
      },
    );
  }
}

/// Bottom sheet content for selecting an item with pagination.
class _ItemPickerBottomSheet extends StatefulWidget {
  final InvoiceType invoiceType;
  final int pageSize;
  final String currencySymbol;
  final void Function(ItemModel item) onSelect;

  const _ItemPickerBottomSheet({
    required this.invoiceType,
    required this.pageSize,
    required this.currencySymbol,
    required this.onSelect,
  });

  @override
  State<_ItemPickerBottomSheet> createState() => _ItemPickerBottomSheetState();
}

class _ItemPickerBottomSheetState extends State<_ItemPickerBottomSheet> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _searchDebounce;
  static const Duration _searchDebounceDuration = Duration(milliseconds: 500);
  String? _lastSearchRequest;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(_searchDebounceDuration, () {
      if (!mounted) return;
      final search = value.trim();
      if (search == (_lastSearchRequest ?? '')) return;
      _lastSearchRequest = search.isEmpty ? null : search;
      _fetchItems(search: _lastSearchRequest);
    });
  }

  void _fetchItems({String? search}) {
    context.read<ItemCubit>().getItems(
          params: ItemRequestParams(
            page: 1,
            forFilter: widget.invoiceType == InvoiceType.sales ? 'Sales' : 'Purchases',
            perPage: widget.pageSize,
            excludeZeroSales: false,
            sortBy: 'name',
            sortOrder: 'asc',
            search: (search == null || search.isEmpty) ? null : search,
          ),
        );
  }

  void _onScroll() {
    final cubit = context.read<ItemCubit>();
    if (!cubit.hasMore || cubit.isLoadingMore) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 100) {
      cubit.loadMoreItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
              child: Row(
                children: [
                  Text(
                    'Select item',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
              child: ListenableBuilder(
                listenable: _searchController,
                builder: (context, _) {
                  return TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: context.l10n.itemPickerSearchHint,
                      hintStyle: AppFonts.interStyle(color: scheme.onSurfaceVariant, fontSize: 14),
                      prefixIcon: AppSearchIcon.inputDecoration(size: 22, color: scheme.onSurfaceVariant),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.clear, size: 20, color: scheme.onSurfaceVariant),
                              onPressed: () {
                                _searchDebounce?.cancel();
                                _searchController.clear();
                                _lastSearchRequest = null;
                                _fetchItems();
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: scheme.surfaceContainerHighest,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    onChanged: _onSearchChanged,
                  );
                },
              ),
            ),
            Divider(height: 1, color: scheme.outlineVariant.withValues(alpha: 0.5)),
            Flexible(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                ),
                child: BlocBuilder<ItemCubit, ItemState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () => Center(child: Text('Loading…')),
                      loading: () => Center(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      noInternet: () => Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.wifi_off, size: 48, color: scheme.onSurfaceVariant),
                            const SizedBox(height: 12),
                            Text('No internet', style: AppFonts.interStyle(color: scheme.onSurfaceVariant)),
                          ],
                        ),
                      ),
                      error: (message) => Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(message, textAlign: TextAlign.center),
                        ),
                      ),
                      success: (response, hasMore) {
                        final items = response.data;
                        if (items.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.all(24),
                              child: Text('No items found'),
                            ),
                          );
                        }
                        return ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount: items.length + (hasMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == items.length) {
                              return Padding(
                                padding: EdgeInsets.all(16),
                                child: Center(child: CircularProgressIndicator()),
                              );
                            }
                            final item = items[index];
                            final sku = itemSku(item);
                            final subtitleParts = <String>[
                              'Rate: ${widget.currencySymbol} ${item.rate.toStringAsFixed(2)}',
                              if (sku != null) 'SKU: $sku',
                            ];
                            return ListTile(
                              title: Text(item.name, style: AppFonts.interStyle(fontSize: 15)),
                              subtitle: Text(
                                subtitleParts.join(' · '),
                                style: AppFonts.interStyle(fontSize: 12, color: scheme.onSurfaceVariant),
                              ),
                              leading: CircleAvatar(
                                radius: 18,
                                backgroundColor: theme.colorScheme.primaryContainer,
                                child: Text(
                                  item.name.isNotEmpty ? item.name[0].toUpperCase() : '?',
                                  style: AppFonts.interStyle(
                                    fontSize: 14,
                                    color: theme.colorScheme.onPrimaryContainer,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              onTap: () => widget.onSelect(item),
                            );
                          },
                        );
                      },
                      loadingMore: (_) => const SizedBox.shrink(),
                      detailSuccess: (_) => const SizedBox.shrink(),
                      created: (_) => const SizedBox.shrink(),
                      updated: (_) => const SizedBox.shrink(),
                      deleted: () => const SizedBox.shrink(),
                      mergeItemsSuccess: (_) => const SizedBox.shrink(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InvoiceItemData {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController quantityController = TextEditingController(text: '1'); // Initialize as integer
  final TextEditingController accountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController itemDiscountAmountController = TextEditingController();
  final TextEditingController itemDiscountPercentController = TextEditingController();

  final ValueNotifier<bool> setItemDiscountAmountNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<String?> selectedItemName = ValueNotifier<String?>(null);
  final ValueNotifier<List<ItemModel>> availableItems = ValueNotifier<List<ItemModel>>([]);
  final ValueNotifier<List<ItemModel>> filteredItems = ValueNotifier<List<ItemModel>>([]);
  final ValueNotifier<bool> showDropdown = ValueNotifier<bool>(false);
  final ValueNotifier<double> totalNotifier = ValueNotifier<double>(0.0);

  /// When editing an existing invoice line, the server line id for update/delete diffs.
  final String? originalItemId;

  InvoiceItemData(List<ItemModel> items, {this.originalItemId}) {
    availableItems.value = items;
    filteredItems.value = items;
    searchController.addListener(_filterItems);
    rateController.addListener(_calculateTotal);
    quantityController.addListener(_calculateTotal);
    itemDiscountAmountController.addListener(_calculateTotal);
    setItemDiscountAmountNotifier.addListener(_calculateTotal);
  }

  /// Call after programmatically setting rate/qty/discount so [totalNotifier] matches.
  void refreshLineTotal() => _calculateTotal();

  void _filterItems() {
    final query = searchController.text;
    filteredItems.value = availableItems.value.where((item) {
      return itemMatchesSearch(item, query);
    }).toList();
  }

  void _calculateTotal() {
    final rate = double.tryParse(rateController.text) ?? 0.0;
    final quantity = double.tryParse(quantityController.text) ?? 0.0;
    final subtotal = rate * quantity;

    // Apply discount if set
    double discount = 0.0;
    if (setItemDiscountAmountNotifier.value) {
      discount = double.tryParse(itemDiscountAmountController.text) ?? 0.0;
    }

    totalNotifier.value = subtotal - discount;
  }

  void selectItem(ItemModel item) {
    selectedItemName.value = item.name;
    searchController.text = item.name;
    rateController.text = item.rate.toInt().toString(); // Display as integer
    showDropdown.value = false;
    _calculateTotal(); // Recalculate total with new rate
  }

  void toggleDropdown() {
    showDropdown.value = !showDropdown.value;
  }

  void showDropdownOnTap() {
    showDropdown.value = true;
  }

  void updateAvailableItems(List<ItemModel> items) {
    availableItems.value = items;
    filteredItems.value = items;
  }

  void dispose() {
    searchController.dispose();
    rateController.dispose();
    quantityController.dispose();
    accountController.dispose();
    descriptionController.dispose();
    unitController.dispose();
    itemDiscountAmountController.dispose();
    itemDiscountPercentController.dispose();
    setItemDiscountAmountNotifier.dispose();
    selectedItemName.dispose();
    availableItems.dispose();
    filteredItems.dispose();
    showDropdown.dispose();
    totalNotifier.dispose();
  }
}

/// Full-screen page for price calculator so keyboard resizing works reliably.
class PriceCalculatorPage extends StatefulWidget {
  final double? initialTotalAmount;
  final String? currencySymbol;

  const PriceCalculatorPage({
    super.key,
    this.initialTotalAmount,
    this.currencySymbol,
  });

  @override
  State<PriceCalculatorPage> createState() => _PriceCalculatorPageState();
}

class _PriceCalculatorPageState extends State<PriceCalculatorPage> {
  final TextEditingController _totalController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  double? perItemPrice;

  String get _symbol =>
      widget.currencySymbol ?? AppCurrencyFormatter.symbol;

  @override
  void initState() {
    super.initState();
    if (widget.initialTotalAmount != null) {
      _totalController.text = widget.initialTotalAmount!.toInt().toString();
      _calculatePerItemPrice();
    }
  }

  @override
  void dispose() {
    _totalController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _calculatePerItemPrice() {
    if (_totalController.text.isEmpty || _quantityController.text.isEmpty) {
      setState(() => perItemPrice = null);
      return;
    }
    final total = double.tryParse(_totalController.text);
    final quantity = double.tryParse(_quantityController.text);
    if (total != null && quantity != null && quantity > 0 && total > 0) {
      setState(() => perItemPrice = total / quantity);
    } else {
      setState(() => perItemPrice = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Calculate Per Item Price'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter total amount and quantity to calculate price per item',
              style: AppFonts.interStyle(
                fontSize: 13,
                color: colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Total Amount',
              style: AppFonts.interStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            CustomTextFormField(
              controller: _totalController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatter: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              onChanged: (value) => _calculatePerItemPrice(),
              hint: 'Enter Total Amount',
              labelText: 'Total Amount',
            ),
            const SizedBox(height: 20),
            Text(
              'Quantity',
              style: AppFonts.interStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            CustomTextFormField(
              controller: _quantityController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatter: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              onChanged: (value) => _calculatePerItemPrice(),
              hint: 'Enter Quantity',
              labelText: 'Total Quantity',
            ),
            const SizedBox(height: 24),
            if (perItemPrice != null)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.primary,
                      colorScheme.secondary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      context.l10n.formatMoneyWithSymbol(_symbol, perItemPrice!),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: AppFonts.interStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: colorScheme.onPrimary,
                        letterSpacing: -1,
                      ),
                    ),
                  ),
                ),
              ),
            if (perItemPrice != null) const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: colorScheme.outline),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: AppFonts.interStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: perItemPrice != null && _quantityController.text.isNotEmpty
                        ? () {
                            final quantity = double.tryParse(_quantityController.text) ?? 1.0;
                            Navigator.pop(
                              context,
                              PriceCalculationResult(
                                perItemPrice: perItemPrice!,
                                quantity: quantity,
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: colorScheme.primary,
                      disabledBackgroundColor: colorScheme.primary.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'OK',
                      style: AppFonts.interStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PriceCalculationResult {
  final double perItemPrice;
  final double quantity;

  PriceCalculationResult({
    required this.perItemPrice,
    required this.quantity,
  });
}

extension PriceCalculatorExtension on BuildContext {
  Future<PriceCalculationResult?> showPriceCalculator({
    double? totalAmount,
    String? currencySymbol,
  }) {
    return Navigator.of(this).push<PriceCalculationResult>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => PriceCalculatorPage(
          initialTotalAmount: totalAmount,
          currencySymbol: currencySymbol,
        ),
      ),
    );
  }
}
