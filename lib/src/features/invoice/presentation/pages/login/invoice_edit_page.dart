import 'dart:convert';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/services/app_loading_overlay.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/app_delete_icon.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/features/action/data/models/request/item_request_params.dart';
import 'package:hotel/src/features/action/data/models/request/party_request_params.dart';
import 'package:hotel/src/features/action/data/models/response/item_response_model.dart';
import 'package:hotel/src/features/action/presentation/cubit/item_cubit.dart';
import 'package:hotel/src/features/action/presentation/cubit/party_cubit.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_sales_response_model.dart';
import 'package:hotel/src/features/invoice/presentation/cubits/update_invoice/update_invoice_cubit.dart';
import 'package:hotel/constants.dart';
import 'package:hotel/src/features/invoice/presentation/pages/login/quick_add_items_page.dart'
    show QuickAddItemsPage, SelectedItemSummary;
import 'package:hotel/src/core/helpers/item_search_helper.dart';
import 'package:hotel/src/core/widget/app_search_icon.dart';

// Custom Decimal Input Formatter - FOR RATE ONLY
class DecimalTextInputFormatter extends TextInputFormatter {
  final int decimalRange;

  DecimalTextInputFormatter({this.decimalRange = 2});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    if (newValue.text == '.') {
      return newValue;
    }

    final regex = RegExp(r'^\d*\.?\d{0,' + decimalRange.toString() + r'}$');

    if (regex.hasMatch(newValue.text)) {
      return newValue;
    }

    return oldValue;
  }
}

// Data Models
class InvoiceFormState {
  final String? invoiceName;
  final String? party;
  final String? date;
  final List<InvoiceItemData> items;
  final List<ItemDetails> originalItems;
  final List<String> deletedItemIds;

  InvoiceFormState({
    this.invoiceName,
    this.party,
    this.date,
    List<InvoiceItemData>? items,
    List<ItemDetails>? originalItems,
    List<String>? deletedItemIds,
  })  : items = items ?? [InvoiceItemData()],
        originalItems = originalItems ?? [],
        deletedItemIds = deletedItemIds ?? [];

  InvoiceFormState copyWith({
    String? invoiceName,
    String? party,
    String? date,
    List<InvoiceItemData>? items,
    List<ItemDetails>? originalItems,
    List<String>? deletedItemIds,
  }) {
    return InvoiceFormState(
      invoiceName: invoiceName ?? this.invoiceName,
      party: party ?? this.party,
      date: date ?? this.date,
      items: items ?? this.items,
      originalItems: originalItems ?? this.originalItems,
      deletedItemIds: deletedItemIds ?? this.deletedItemIds,
    );
  }

  double get grandTotal {
    return items.fold(0.0, (sum, item) => sum + item.total);
  }

  bool get isValid {
    return party?.isNotEmpty == true &&
        date?.isNotEmpty == true &&
        items.isNotEmpty &&
        items.every((item) => item.isValid);
  }

  bool hasChanges(InvoiceItem? originalInvoice) {
    if (originalInvoice == null) return true;

    final originalDate = originalInvoice.date?.split('T').first;
    if (party != originalInvoice.party || date != originalDate) {
      return true;
    }

    if (items.length != (originalInvoice.items?.length ?? 0)) {
      return true;
    }

    if (deletedItemIds.isNotEmpty) {
      return true;
    }

    for (final item in items) {
      if (item.isNew) {
        return true;
      }

      final originalItem = originalItems.firstWhere(
            (orig) => orig.itemId == item.originalItemId,
        orElse: () => ItemDetails(itemId: '', item: '', quantity: 0, rate: 0, amount: 0),
      );

      if (originalItem.item != item.itemName ||
          originalItem.quantity != item.quantity ||
          (originalItem.rate ?? 0) != item.rate ||
          (originalItem.itemDiscountAmount ?? 0) != item.discount) {
        return true;
      }
    }

    for (final originalItem in originalItems) {
      final stillExists = items.any(
            (item) => item.originalItemId == originalItem.itemId,
      );
      if (!stillExists) {
        return true;
      }
    }

    return false;
  }
}

class InvoiceItemData {
  final String itemId;
  final String itemName;
  final double quantity;
  final double rate;
  final double discount;
  final bool isNew;
  final String? originalItemId;
  bool showDropdown;

  InvoiceItemData({
    this.itemId = '',
    this.itemName = '',
    this.quantity = 1.0,
    this.rate = 0.0,
    this.discount = 0.0,
    this.isNew = true,
    this.originalItemId,
    this.showDropdown = false,
  });

  double get amount => quantity * rate;
  double get total => amount - discount;
  bool get isValid => itemName.isNotEmpty && quantity > 0 && rate >= 0;

  InvoiceItemData copyWith({
    String? itemId,
    String? itemName,
    double? quantity,
    double? rate,
    double? discount,
    bool? isNew,
    String? originalItemId,
    bool? showDropdown,
  }) {
    return InvoiceItemData(
      itemId: itemId ?? this.itemId,
      itemName: itemName ?? this.itemName,
      quantity: quantity ?? this.quantity,
      rate: rate ?? this.rate,
      discount: discount ?? this.discount,
      isNew: isNew ?? this.isNew,
      originalItemId: originalItemId ?? this.originalItemId,
      showDropdown: showDropdown ?? this.showDropdown,
    );
  }

  Map<String, dynamic> toAction() {
    return {
      'itemId': originalItemId ?? itemId,
      'item': itemName,
      'quantity': quantity,
      'rate': rate,
      'amount': amount,
      'itemDiscountAmount': discount,
    };
  }
}

// Main Widget
@RoutePage()
class InvoiceEditPage extends StatefulWidget implements AutoRouteWrapper {
  final InvoiceItem? invoice;
  final Function()? onSave;
  final InvoiceType invoiceType;

  const InvoiceEditPage({
    super.key,
    this.invoice,
    this.onSave,
    required this.invoiceType,
  });

  @override
  State<InvoiceEditPage> createState() => _InvoiceEditPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UpdateInvoiceCubit>(),
      child: this,
    );
  }
}

class _InvoiceEditPageState extends State<InvoiceEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _invoiceNameController = TextEditingController();
  final _partyController = TextEditingController();
  final _dateController = TextEditingController();
  final _discountAmountController = TextEditingController();
  final _discountPercentController = TextEditingController();
  final _setDiscountAmountNotifier = ValueNotifier<bool>(false);
  final _grandTotalNotifier = ValueNotifier<double>(0.0);
  final _selectedSummaryNotifier = ValueNotifier<List<SelectedItemSummary>>([]);
  late ValueNotifier<List<InvoiceItemData>> _itemsNotifier;

  InvoiceFormState _formState = InvoiceFormState();
  List<String> _availableParties = [];
  List<String> _filteredParties = [];
  List<ItemModel> _availableItems = [];
  bool _showPartyDropdown = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _itemsNotifier = ValueNotifier<List<InvoiceItemData>>(List.from(_formState.items));
    _loadData();
    _initializeForm();
    _partyController.addListener(_filterParties);
  }

  @override
  void dispose() {
    _invoiceNameController.dispose();
    _partyController.dispose();
    _dateController.dispose();
    _discountAmountController.dispose();
    _discountPercentController.dispose();
    _setDiscountAmountNotifier.dispose();
    _grandTotalNotifier.dispose();
    _selectedSummaryNotifier.dispose();
    _itemsNotifier.dispose();
    super.dispose();
  }

  void _updateSelectedSummary() {
    final list = <SelectedItemSummary>[];
    for (final item in _formState.items) {
      if (item.itemName.isEmpty) continue;
      final q = item.quantity.toInt();
      if (q > 0) list.add(SelectedItemSummary(name: item.itemName, quantity: q, rate: item.rate));
    }
    _selectedSummaryNotifier.value = list;
  }

  void _refreshGrandTotalNotifier() {
    final subtotal = _formState.items.fold(0.0, (sum, item) => sum + item.total);
    final discount = _invoiceDiscountAmount;
    _grandTotalNotifier.value = subtotal - discount;
  }

  /// Returns new quantity if same item incremented, null if new line added.
  int? _addItemToInvoiceFromQuickAdd(ItemModel item) {
    final items = List<InvoiceItemData>.from(_formState.items);
    final existingIndex = items.indexWhere((row) => row.itemName == item.name);
    if (existingIndex >= 0) {
      final row = items[existingIndex];
      final newQty = row.quantity + 1;
      items[existingIndex] = row.copyWith(quantity: newQty);
      _formState = _formState.copyWith(items: items);
      _itemsNotifier.value = items;
      _updateSelectedSummary();
      _refreshGrandTotalNotifier();
      return newQty.toInt();
    }
    final emptyIndex = items.indexWhere((row) => row.itemName.isEmpty);
    if (emptyIndex >= 0) {
      items[emptyIndex] = InvoiceItemData(
        itemName: item.name,
        rate: item.rate,
        quantity: 1,
        isNew: true,
      );
      _formState = _formState.copyWith(items: items);
      _itemsNotifier.value = items;
      _updateSelectedSummary();
      _refreshGrandTotalNotifier();
      return 1;
    }
    items.add(InvoiceItemData(
      itemName: item.name,
      rate: item.rate,
      quantity: 1,
      isNew: true,
    ));
    _formState = _formState.copyWith(items: items);
    _itemsNotifier.value = items;
    _updateSelectedSummary();
    _refreshGrandTotalNotifier();
    return null;
  }

  void _increaseItemFromQuickAdd(String itemName) {
    final items = List<InvoiceItemData>.from(_formState.items);
    final idx = items.indexWhere((row) => row.itemName == itemName);
    if (idx < 0) return;
    final row = items[idx];
    items[idx] = row.copyWith(quantity: row.quantity + 1);
    _formState = _formState.copyWith(items: items);
    _itemsNotifier.value = items;
    _updateSelectedSummary();
    _refreshGrandTotalNotifier();
  }

  void _decreaseItemFromQuickAdd(String itemName) {
    final items = List<InvoiceItemData>.from(_formState.items);
    final idx = items.indexWhere((row) => row.itemName == itemName);
    if (idx < 0) return;
    final row = items[idx];
    if (row.quantity <= 1) {
      if (items.length <= 1) return;
      items.removeAt(idx);
      List<String> deletedIds = List.from(_formState.deletedItemIds);
      if (!row.isNew && row.originalItemId != null && row.originalItemId!.isNotEmpty) {
        deletedIds.add(row.originalItemId!);
      }
      _formState = _formState.copyWith(items: items, deletedItemIds: deletedIds);
    } else {
      items[idx] = row.copyWith(quantity: row.quantity - 1);
      _formState = _formState.copyWith(items: items);
    }
    _itemsNotifier.value = items;
    _updateSelectedSummary();
    _refreshGrandTotalNotifier();
  }

  void _loadData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ItemCubit>().getItems(
        params: ItemRequestParams(
          page: 1,
          perPage: 1000,
          excludeZeroSales: false,
          sortBy: 'name',
          sortOrder: 'asc',
        ),
      );
      context.read<PartyCubit>().getParties(
        params: PartyRequestParams(perPage: 1000),
      );
    });
  }

  void _initializeForm() {
    if (widget.invoice == null) return;

    final invoice = widget.invoice!;

    final items = invoice.items
            ?.map((item) => InvoiceItemData(
          itemId: item.itemId ?? '',
          itemName: item.item ?? '',
          quantity: item.quantity ?? 1.0,
          rate: item.rate ?? 0.0,
          discount: item.itemDiscountAmount ?? 0.0,
          isNew: false,
          originalItemId: item.itemId,
        ))
            .toList() ??
        [InvoiceItemData()];
    _formState = InvoiceFormState(
      invoiceName: invoice.invoiceName,
      party: invoice.party,
      date: invoice.date?.split('T').first,
      originalItems: List.from(invoice.items ?? []),
      items: items,
    );
    _itemsNotifier.value = List.from(items);

    _updateControllers();
  }

  void _updateControllers() {
    _invoiceNameController.text = _formState.invoiceName ?? '';
    _partyController.text = _formState.party ?? '';
    _dateController.text = _formState.date ?? '';
    final inv = widget.invoice;
    if (inv != null) {
      final hasDiscount = (inv.setDiscountAmount ?? 0) != 0 ||
          (inv.discountAmount ?? 0) > 0 ||
          (inv.totalDiscount ?? 0) > 0;
      _setDiscountAmountNotifier.value = hasDiscount;
      final amount = inv.discountAmount ?? inv.totalDiscount ?? 0.0;
      _discountAmountController.text = amount > 0 ? amount.toStringAsFixed(0) : '';
      _discountPercentController.text = (inv.discountPercent ?? 0) > 0 ? inv.discountPercent.toString() : '';
    }
  }

  void _filterParties() {
    final query = _partyController.text.toLowerCase();
    setState(() {
      _filteredParties = _availableParties.where((party) => party.toLowerCase().contains(query)).toList();
    });
  }

  void _selectParty(String party) {
    setState(() {
      _formState = _formState.copyWith(party: party);
      _partyController.text = party;
      _showPartyDropdown = false;
    });
  }

  void _addItem() {
    final updatedItems = List<InvoiceItemData>.from(_formState.items);
    updatedItems.add(InvoiceItemData());
    _formState = _formState.copyWith(items: updatedItems);
    _itemsNotifier.value = updatedItems;
  }

  void _removeItem(int index) {
    if (_formState.items.length <= 1) return;

    final itemToRemove = _formState.items[index];
    final updatedItems = List<InvoiceItemData>.from(_formState.items);
    updatedItems.removeAt(index);

    List<String> updatedDeletedIds = List.from(_formState.deletedItemIds);
    if (!itemToRemove.isNew && itemToRemove.originalItemId != null) {
      updatedDeletedIds.add(itemToRemove.originalItemId!);
    }

    _formState = _formState.copyWith(
      items: updatedItems,
      deletedItemIds: updatedDeletedIds,
    );
    _itemsNotifier.value = updatedItems;
  }

  void _updateItem(int index, InvoiceItemData updatedItem) {
    final updatedItems = List<InvoiceItemData>.from(_formState.items);
    updatedItems[index] = updatedItem;
    _formState = _formState.copyWith(items: updatedItems);
    _itemsNotifier.value = updatedItems;
  }

  void _selectItemForIndex(int index, ItemModel item) {
    final currentItem = _formState.items[index];
    final updatedItem = currentItem.copyWith(
      itemName: item.name,
      rate: item.rate,
      showDropdown: false,
    );
    _updateItem(index, updatedItem);
  }

  List<Map<String, dynamic>> _createItemActions() {
    List<Map<String, dynamic>> actions = [];

    for (final item in _formState.items) {
      if (item.isNew) {
        actions.add({
          'action': 'add',
          ...item.toAction(),
        });
      } else {
        final originalItem = _formState.originalItems.firstWhere(
              (orig) => orig.itemId == item.originalItemId,
          orElse: () => ItemDetails(itemId: '', item: '', quantity: 0, rate: 0, amount: 0),
        );

        final bool isUpdated = originalItem.item != item.itemName ||
            originalItem.quantity != item.quantity ||
            (originalItem.rate ?? 0) != item.rate ||
            (originalItem.itemDiscountAmount ?? 0) != item.discount;

        if (isUpdated) {
          actions.add({
            'action': 'update',
            ...item.toAction(),
          });
        }
      }
    }

    for (final originalItem in _formState.originalItems) {
      final stillExists = _formState.items.any(
            (item) => item.originalItemId == originalItem.itemId,
      );

      if (!stillExists) {
        actions.add({
          'action': 'delete',
          'itemId': originalItem.itemId,
          'item': originalItem.item,
        });
      }
    }

    for (final deletedId in _formState.deletedItemIds) {
      final alreadyAdded = actions.any(
            (action) => action['action'] == 'delete' && action['itemId'] == deletedId,
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

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      setState(() {
        _formState = _formState.copyWith(date: date.toString().split(' ')[0]);
        _dateController.text = _formState.date!;
      });
    }
  }

  void _saveInvoice() {
    _updateFormState();
    if (!_formKey.currentState!.validate() || !_formState.isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all required fields correctly'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    _showInvoiceSummary();
  }

  void _updateFormState() {
    _formState = _formState.copyWith(
      invoiceName: _invoiceNameController.text.isEmpty ? null : _invoiceNameController.text,
      party: _partyController.text.isEmpty ? null : _partyController.text,
      date: _dateController.text.isEmpty ? null : _dateController.text,
    );
  }

  void _showInvoiceSummary() {
    final itemActions = _createItemActions();

    double subtotal = 0.0;
    for (final action in itemActions) {
      if (action['action'] != 'delete') {
        final quantity = action['quantity'] ?? 1.0;
        final rate = action['rate'] ?? 0.0;
        subtotal += (quantity * rate);
      }
    }
    final totalDiscount = _invoiceDiscountAmount;
    final grandTotal = subtotal - totalDiscount;

    showDialog(
      context: context,
      builder: (context) => _InvoiceSummaryDialog(
        formState: _formState,
        itemActions: itemActions,
        subtotal: subtotal,
        totalDiscount: totalDiscount,
        grandTotal: grandTotal,
        onConfirm: () => _confirmSave(itemActions),
      ),
    );
  }

  void _confirmSave(List<Map<String, dynamic>> itemActions) {
    Navigator.of(context).pop();

    final items = itemActions
        .where((action) => action['action'] != 'delete')
        .map((action) => ItemDetails(
      item: action['item'] ?? '',
      quantity: action['quantity'],
      rate: action['rate'],
      amount: action['amount'],
      itemId: '',
      itemDiscountAmount: action['itemDiscountAmount'] > 0 ? action['itemDiscountAmount'] : null,
    ))
        .toList();

    final setDiscount = _setDiscountAmountNotifier.value;
    final discountAmt = _discountAmountController.text.trim().isEmpty
        ? null
        : double.tryParse(_discountAmountController.text);
    final discountPct = _discountPercentController.text.trim().isEmpty
        ? null
        : double.tryParse(_discountPercentController.text);

    final invoice = InvoiceItem(
      invoiceType: widget.invoiceType,
      action: "update",
      invoiceName: _formState.invoiceName,
      party: _formState.party,
      date: _formState.date != null ? "${_formState.date}T06:10:10.000" : null,
      items: itemActions.map((map) => ItemDetails.fromJson(map)).toList(),
      modifiedBy: "hotelroyalrestro@gmail.com",
      setDiscountAmount: setDiscount ? 1 : 0,
      discountAmount: discountAmt,
      discountPercent: discountPct,
    );

    _prettyPrintJson(invoice.toJson());
    context.read<UpdateInvoiceCubit>().updateInvoice(params: invoice);
  }

  void _prettyPrintJson(Map<String, dynamic> json) {
    const encoder = JsonEncoder.withIndent('  ');
    print(encoder.convert(json));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarIosBackButton(),
        title: Text(widget.invoice == null ? 'Create Invoice' : 'Edit Invoice'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.grid_view),
            tooltip: 'Quick add items',
            onPressed: () {
              final quantities = <String, int>{};
              for (final item in _formState.items) {
                if (item.itemName.isNotEmpty) {
                  final q = item.quantity.toInt();
                  if (q > 0) quantities[item.itemName] = (quantities[item.itemName] ?? 0) + q;
                }
              }
              _updateSelectedSummary();
              _refreshGrandTotalNotifier();
              QuickAddItemsPage.open(
                context,
                invoiceType: widget.invoiceType,
                onItemSelected: _addItemToInvoiceFromQuickAdd,
                cartTotalNotifier: _grandTotalNotifier,
                initialQuantities: quantities.isEmpty ? null : quantities,
                selectedItemsNotifier: _selectedSummaryNotifier,
                onIncreaseItem: _increaseItemFromQuickAdd,
                onDecreaseItem: _decreaseItemFromQuickAdd,
              );
            },
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return MultiBlocListener(
      listeners: [
        BlocListener<ItemCubit, ItemState>(
          listener: (context, state) {
            state.maybeWhen(
              loading: () {
                AppLoadingOverlay.of(context).show();
                setState(() => _isLoading = true);
              },
              success: (response,hasMore) {
                AppLoadingOverlay.of(context).hide();
                setState(() {
                  _isLoading = false;
                  _availableItems = response.data;
                });
              },
              error: (message) {
                AppLoadingOverlay.of(context).hide();
                setState(() => _isLoading = false);
                _showErrorSnackBar('Items error: $message');
              },
              orElse: () {},
            );
          },
        ),
        BlocListener<PartyCubit, PartyState>(
          listener: (context, state) {
            state.maybeWhen(
              success: (response) {
                setState(() {
                  _availableParties = response.data.data!
                      .map((party) => party.name)
                      .where((name) => name != null)
                      .cast<String>()
                      .toList();
                  _filteredParties = _availableParties;
                });
              },
              error: (message) => _showErrorSnackBar('Parties error: $message'),
              orElse: () {},
            );
          },
        ),
        BlocListener<UpdateInvoiceCubit, UpdateInvoiceState>(
          listener: (context, state) {
            state.maybeWhen(
              loading: () => AppLoadingOverlay.of(context).show(),
              success: (response) {
                context.showKiiSnackBarSuccess(response.message);
                widget.onSave?.call();
                context.router.popUntil((route) {
                  return route.isFirst;
                });
              },
              error: (message) {
                AppLoadingOverlay.of(context).hide();
                _showErrorSnackBar('Save error: $message');
              },
              orElse: () {},
            );
          },
        ),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          _showPartyDropdown = false;
          final updatedItems = _formState.items.map((item) => item.copyWith(showDropdown: false)).toList();
          _formState = _formState.copyWith(items: updatedItems);
          _itemsNotifier.value = updatedItems;
          setState(() {}); // refresh party dropdown visibility
        },
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildBasicInfoSection(),
                      const SizedBox(height: 24),
                      _buildItemsSection(),
                      const SizedBox(height: 24),
                      _buildDiscountSection(),
                      const SizedBox(height: 24),
                      _buildGrandTotalCard(),
                    ],
                  ),
                ),
              ),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInfoSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Basic Information',
            style: AppFonts.interStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildPartyDropdown(),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _invoiceNameController,
                  decoration: InputDecoration(
                    labelText: 'Invoice Name (Optional)',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: 'Date *',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                  validator: (value) => value?.isEmpty == true ? 'Date is required' : null,
                  onTap: _selectDate,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPartyDropdown() {
    return Column(
      children: [
        TextFormField(
          controller: _partyController,
          decoration: InputDecoration(
            labelText: 'Party *',
            border: const OutlineInputBorder(),
            prefixIcon: AppSearchIcon.inputDecoration(),
            suffixIcon: IconButton(
              icon: Icon(_showPartyDropdown ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              onPressed: () => setState(() => _showPartyDropdown = !_showPartyDropdown),
            ),
          ),
          validator: (value) => value?.isEmpty == true ? 'Party is required' : null,
          onTap: () {
            setState(() => _showPartyDropdown = true);
          },
        ),
        if (_showPartyDropdown && _filteredParties.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            constraints: const BoxConstraints(maxHeight: 200),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _filteredParties.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredParties[index]),
                  onTap: () => _selectParty(_filteredParties[index]),
                  leading: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.orange[100],
                    child: Text(
                      _filteredParties[index][0].toUpperCase(),
                      style: AppFonts.interStyle(
                        fontSize: 12,
                        color: Colors.orange[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildItemsSection() {
    return ValueListenableBuilder<List<InvoiceItemData>>(
      valueListenable: _itemsNotifier,
      builder: (context, items, _) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Items',
                  style: AppFonts.interStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: _addItem,
                  icon: Icon(Icons.add),
                  label: Text('Add Item'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return _ItemCard(
                  item: items[index],
                  index: index,
                  availableItems: _availableItems,
                  canRemove: items.length > 1,
                  onRemove: () => _removeItem(index),
                  onUpdate: (updatedItem) => _updateItem(index, updatedItem),
                  onSelectItem: (item) => _selectItemForIndex(index, item),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDiscountSection() {
    return ValueListenableBuilder<bool>(
      valueListenable: _setDiscountAmountNotifier,
      builder: (context, setDiscountAmount, _) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                Checkbox(
                  value: setDiscountAmount,
                  onChanged: (value) {
                    _setDiscountAmountNotifier.value = value ?? false;
                  },
                ),
                  Text('Set Discount Amount'),
                ],
              ),
              if (setDiscountAmount) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _discountAmountController,
                        decoration: InputDecoration(
                          labelText: 'Discount Amount',
                          border: OutlineInputBorder(),
                          hintText: '0',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _discountPercentController,
                        decoration: InputDecoration(
                          labelText: 'Discount %',
                          border: OutlineInputBorder(),
                          hintText: '0',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  double get _invoiceDiscountAmount =>
      _setDiscountAmountNotifier.value
          ? (double.tryParse(_discountAmountController.text) ?? 0.0)
          : 0.0;

  Widget _buildGrandTotalCard() {
    return ListenableBuilder(
      listenable: Listenable.merge([
        _itemsNotifier,
        _setDiscountAmountNotifier,
        _discountAmountController,
      ]),
      builder: (context, _) {
        final items = _itemsNotifier.value;
        final subtotal = items.fold(0.0, (sum, item) => sum + (item.rate * item.quantity));
        final discount = _invoiceDiscountAmount;
        final grandTotal = subtotal - discount;
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Subtotal:', style: AppFonts.interStyle(fontSize: 16)),
                  Text('$currencySymbol ${subtotal.toStringAsFixed(2)}', style: AppFonts.interStyle(fontSize: 16)),
                ],
              ),
              if (discount > 0) ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Discount:', style: AppFonts.interStyle(fontSize: 16, color: Colors.red)),
                    Text('- $currencySymbol ${discount.toStringAsFixed(2)}', style: AppFonts.interStyle(fontSize: 16, color: Colors.red)),
                  ],
                ),
              ],
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Grand Total:',
                    style: AppFonts.interStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$currencySymbol ${grandTotal.toStringAsFixed(2)}',
                    style: AppFonts.interStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  bool get _hasDiscountChanges {
    final inv = widget.invoice;
    if (inv == null) return _setDiscountAmountNotifier.value;
    final origSet = (inv.setDiscountAmount ?? 0) != 0 ||
        (inv.discountAmount ?? 0) > 0 ||
        (inv.totalDiscount ?? 0) > 0;
    final origAmount = inv.discountAmount ?? inv.totalDiscount ?? 0.0;
    final currSet = _setDiscountAmountNotifier.value;
    final currAmount = double.tryParse(_discountAmountController.text) ?? 0.0;
    return currSet != origSet || (currAmount != origAmount);
  }

  Widget _buildSaveButton() {
    return ListenableBuilder(
      listenable: Listenable.merge([
        _itemsNotifier,
        _setDiscountAmountNotifier,
        _discountAmountController,
      ]),
      builder: (context, _) {
        final hasChanges = _formState.hasChanges(widget.invoice) || _hasDiscountChanges;

        return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!hasChanges)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Text(
                    'No changes detected',
                    style: AppFonts.interStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          CustomButtonWidget(
            width: context.width,
            title: "Update Invoice",
            onPressed: (_isLoading || !hasChanges) ? null : _saveInvoice,
          ),
        ],
      ),
    );
      },
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }
}

// Item Card Widget
class _ItemCard extends StatefulWidget {
  final InvoiceItemData item;
  final int index;
  final List<ItemModel> availableItems;
  final bool canRemove;
  final VoidCallback onRemove;
  final Function(InvoiceItemData) onUpdate;
  final Function(ItemModel) onSelectItem;

  const _ItemCard({
    required this.item,
    required this.index,
    required this.availableItems,
    required this.canRemove,
    required this.onRemove,
    required this.onUpdate,
    required this.onSelectItem,
  });

  @override
  State<_ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<_ItemCard> {
  final _searchController = TextEditingController();
  final _rateController = TextEditingController();
  final _quantityController = TextEditingController();
  final _discountController = TextEditingController();
  List<ItemModel> _filteredItems = [];

  bool _isEditingRate = false;
  bool _isEditingQuantity = false;
  bool _isEditingDiscount = false;

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.item.itemName;
    _rateController.text = widget.item.rate == 0 ? '' : widget.item.rate.toString();
    _quantityController.text = widget.item.quantity == 0 ? '' : widget.item.quantity.toInt().toString();
    _discountController.text = widget.item.discount == 0 ? '' : widget.item.discount.toInt().toString();
    _filteredItems = widget.availableItems;
    _searchController.addListener(_filterItems);
  }

  @override
  void didUpdateWidget(_ItemCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.availableItems != widget.availableItems) {
      _filteredItems = widget.availableItems;
    }

    if (!_isEditingRate && oldWidget.item.rate != widget.item.rate) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _rateController.text = widget.item.rate == 0 ? '' : widget.item.rate.toString();
      });
    }

    if (!_isEditingQuantity && oldWidget.item.quantity != widget.item.quantity) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _quantityController.text = widget.item.quantity.toInt().toString();
      });
    }

    if (!_isEditingDiscount && oldWidget.item.discount != widget.item.discount) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _discountController.text = widget.item.discount.toInt().toString();
      });
    }

    if (oldWidget.item.itemName != widget.item.itemName) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _searchController.text = widget.item.itemName;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _rateController.dispose();
    _quantityController.dispose();
    _discountController.dispose();
    super.dispose();
  }

  void _filterItems() {
    final query = _searchController.text;
    setState(() {
      _filteredItems = widget.availableItems.where((item) => itemMatchesSearch(item, query)).toList();
    });
  }

  void _selectItem(ItemModel item) {
    _searchController.text = item.name;
    final updatedItem = widget.item.copyWith(
      itemName: item.name,
      rate: item.rate,
      showDropdown: false,
    );
    widget.onUpdate(updatedItem);
  }

  void _toggleDropdown() {
    final updatedItem = widget.item.copyWith(showDropdown: !widget.item.showDropdown);
    widget.onUpdate(updatedItem);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Item ${widget.index + 1}',
                style: AppFonts.interStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  if (!widget.item.isNew)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'EXISTING',
                        style: AppFonts.interStyle(
                          fontSize: 10,
                          color: Colors.blue[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  const SizedBox(width: 8),
                  if (widget.canRemove)
                    IconButton(
                      icon: const AppDeleteIcon(color: Colors.red),
                      onPressed: widget.onRemove,
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Select Item *',
            style: AppFonts.interStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Column(
            children: [
              TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search and select an item',
                  filled: true,

                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  prefixIcon: AppSearchIcon.inputDecoration( color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(
                      widget.item.showDropdown ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    onPressed: _toggleDropdown,
                  ),
                ),
                readOnly: false,
                validator: (value) => widget.item.itemName.isEmpty ? 'Please select an item' : null,
                onTap: () {
                  final updatedItem = widget.item.copyWith(showDropdown: true);
                  widget.onUpdate(updatedItem);
                },
              ),
              if (widget.item.showDropdown && _filteredItems.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  constraints: const BoxConstraints(maxHeight: 150),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];
                      return ListTile(
                        title: Text(item.name, style: AppFonts.interStyle(fontSize: 14)),
                        subtitle: Text(
                          'Rate: $currencySymbol ${item.rate.toStringAsFixed(2)}',
                          style: AppFonts.interStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                        onTap: () => _selectItem(item),
                        dense: true,
                        leading: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.blue[100],
                          child: Text(
                            item.name[0].toUpperCase(),
                            style: AppFonts.interStyle(
                              fontSize: 12,
                              color: Colors.blue[800],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              if (widget.item.itemName.isNotEmpty && !widget.item.showDropdown) ...[
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green[600], size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Selected: ${widget.item.itemName}',
                          style: AppFonts.interStyle(
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _quantityController,
                  decoration: InputDecoration(
                    labelText: 'Quantity *',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    final qty = double.tryParse(value ?? '');
                    return qty == null || qty <= 0 ? 'Valid quantity required' : null;
                  },
                  onTap: () => setState(() => _isEditingQuantity = true),
                  onChanged: (value) {
                    setState(() => _isEditingQuantity = true);
                  },
                  onEditingComplete: () {
                    setState(() => _isEditingQuantity = false);
                    final value = _quantityController.text;
                    if (value.isNotEmpty) {
                      final updatedItem = widget.item.copyWith(quantity: double.tryParse(value) ?? 1.0);
                      widget.onUpdate(updatedItem);
                    }
                  },
                  onTapOutside: (_) {
                    setState(() => _isEditingQuantity = false);
                    final value = _quantityController.text;
                    if (value.isNotEmpty) {
                      final updatedItem = widget.item.copyWith(quantity: double.tryParse(value) ?? 1.0);
                      widget.onUpdate(updatedItem);
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: _rateController,
                  decoration: InputDecoration(
                    labelText: 'Rate *',
                    border: const OutlineInputBorder(),
                    prefixText: '$currencySymbol ',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
                  validator: (value) {
                    final rate = double.tryParse(value ?? '');
                    return rate == null || rate < 0 ? 'Valid rate required' : null;
                  },
                  onTap: () => setState(() => _isEditingRate = true),
                  onChanged: (value) {
                    setState(() => _isEditingRate = true);
                  },
                  onEditingComplete: () {
                    setState(() => _isEditingRate = false);
                    final value = _rateController.text;
                    if (value.isNotEmpty) {
                      final updatedItem = widget.item.copyWith(rate: double.tryParse(value) ?? 0.0);
                      widget.onUpdate(updatedItem);
                    }
                  },
                  onTapOutside: (_) {
                    setState(() => _isEditingRate = false);
                    final value = _rateController.text;
                    if (value.isNotEmpty) {
                      final updatedItem = widget.item.copyWith(rate: double.tryParse(value) ?? 0.0);
                      widget.onUpdate(updatedItem);
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: _discountController,
                  decoration: InputDecoration(
                    labelText: 'Discount',
                    border: const OutlineInputBorder(),
                    prefixText: '$currencySymbol ',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onTap: () => setState(() => _isEditingDiscount = true),
                  onChanged: (value) {
                    setState(() => _isEditingDiscount = true);
                  },
                  onEditingComplete: () {
                    setState(() => _isEditingDiscount = false);
                    final value = _discountController.text;
                    if (value.isEmpty) {
                      final updatedItem = widget.item.copyWith(discount: 0.0);
                      widget.onUpdate(updatedItem);
                    } else {
                      final updatedItem = widget.item.copyWith(discount: double.tryParse(value) ?? 0.0);
                      widget.onUpdate(updatedItem);
                    }
                  },
                  onTapOutside: (_) {
                    setState(() => _isEditingDiscount = false);
                    final value = _discountController.text;
                    if (value.isEmpty) {
                      final updatedItem = widget.item.copyWith(discount: 0.0);
                      widget.onUpdate(updatedItem);
                    } else {
                      final updatedItem = widget.item.copyWith(discount: double.tryParse(value) ?? 0.0);
                      widget.onUpdate(updatedItem);
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Amount:'),
                    Text('$currencySymbol ${widget.item.amount.toStringAsFixed(2)}'),
                  ],
                ),
                if (widget.item.discount > 0) ...[
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Discount:'),
                      Text('$currencySymbol ${widget.item.discount.toStringAsFixed(2)}'),
                    ],
                  ),
                ],
                const Divider(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total:', style: AppFonts.interStyle(fontWeight: FontWeight.bold)),
                    Text(
                      '$currencySymbol ${widget.item.total.toStringAsFixed(2)}',
                      style: AppFonts.interStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Invoice Summary Dialog
class _InvoiceSummaryDialog extends StatelessWidget {
  final InvoiceFormState formState;
  final List<Map<String, dynamic>> itemActions;
  final double subtotal;
  final double totalDiscount;
  final double grandTotal;
  final VoidCallback onConfirm;

  const _InvoiceSummaryDialog({
    required this.formState,
    required this.itemActions,
    required this.subtotal,
    required this.totalDiscount,
    required this.grandTotal,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        width: double.maxFinite,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue[600],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.receipt_long, color: Colors.white, size: 24),
                  const SizedBox(width: 12),
                  Text(
                    'Invoice Summary',
                    style: AppFonts.interStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSummarySection(
                      'Basic Information',
                      Icons.info_outline,
                      [
                        _buildSummaryRow('Party', formState.party ?? 'Not selected'),
                        _buildSummaryRow('Date', formState.date ?? 'Not set'),
                        if (formState.invoiceName?.isNotEmpty == true)
                          _buildSummaryRow('Invoice Name', formState.invoiceName!),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildSummarySection(
                      'Item Actions (${itemActions.length})',
                      Icons.shopping_cart_outlined,
                      itemActions.map((action) => _buildItemActionCard(action)).toList(),
                    ),
                    const SizedBox(height: 20),
                    _buildFinancialSummary(),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                border: Border(top: BorderSide(color: Colors.grey[200]!)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text('Cancel', style: AppFonts.interStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: onConfirm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle_outline),
                          SizedBox(width: 8),
                          Text('Confirm & Update', style: AppFonts.interStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
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

  Widget _buildSummarySection(String title, IconData icon, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Colors.blue[700]),
            const SizedBox(width: 8),
            Text(
              title,
              style: AppFonts.interStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue[700],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text('$label:', style: AppFonts.interStyle(fontWeight: FontWeight.w500, color: Colors.black54)),
          ),
          Expanded(
            child: Text(value, style: AppFonts.interStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
          ),
        ],
      ),
    );
  }

  Widget _buildItemActionCard(Map<String, dynamic> action) {
    final actionType = action['action'];
    Color actionColor;
    IconData actionIcon;
    String actionText;

    switch (actionType) {
      case 'add':
        actionColor = Colors.green;
        actionIcon = Icons.add_circle;
        actionText = 'ADD';
        break;
      case 'update':
        actionColor = Colors.orange;
        actionIcon = Icons.edit;
        actionText = 'UPDATE';
        break;
      case 'delete':
        actionColor = Colors.red;
        actionIcon = Icons.delete;
        actionText = 'DELETE';
        break;
      default:
        actionColor = Colors.grey;
        actionIcon = Icons.check_circle;
        actionText = 'NO CHANGE';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: actionColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: actionColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: actionColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    actionIcon == Icons.delete
                        ? const AppDeleteIcon(color: Colors.white, size: 14)
                        : Icon(actionIcon, color: Colors.white, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      actionText,
                      style: AppFonts.interStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  action['item'] ?? 'Unknown Item',
                  style: AppFonts.interStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    decoration: actionType == 'delete' ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
            ],
          ),
          if (actionType != 'delete') ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _buildDetailItem('Quantity', '${action['quantity']}')),
                Expanded(child: _buildDetailItem('Rate', '$currencySymbol ${action['rate']?.toStringAsFixed(2) ?? '0.00'}')),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(child: _buildDetailItem('Amount', '$currencySymbol ${action['amount']?.toStringAsFixed(2) ?? '0.00'}')),
                Expanded(
                    child: _buildDetailItem(
                        'Discount', '$currencySymbol ${action['itemDiscountAmount']?.toStringAsFixed(2) ?? '0.00'}')),
              ],
            ),
            const Divider(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Net Total:', style: AppFonts.interStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                Text(
                  '$currencySymbol ${((action['quantity'] ?? 0) * (action['rate'] ?? 0) - (action['itemDiscountAmount'] ?? 0)).toStringAsFixed(2)}',
                  style: AppFonts.interStyle(fontWeight: FontWeight.bold, fontSize: 16, color: actionColor),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppFonts.interStyle(fontSize: 11, color: Colors.grey[600], fontWeight: FontWeight.w500)),
        Text(value, style: AppFonts.interStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
      ],
    );
  }

  Widget _buildFinancialSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subtotal:', style: AppFonts.interStyle(fontSize: 16)),
              Text('$currencySymbol ${subtotal.toStringAsFixed(2)}', style: AppFonts.interStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Discount:', style: AppFonts.interStyle(fontSize: 16)),
              Text('$currencySymbol ${totalDiscount.toStringAsFixed(2)}', style: AppFonts.interStyle(fontSize: 16)),
            ],
          ),
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Grand Total:', style: AppFonts.interStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(
                '$currencySymbol ${grandTotal.toStringAsFixed(2)}',
                style: AppFonts.interStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue[800]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}