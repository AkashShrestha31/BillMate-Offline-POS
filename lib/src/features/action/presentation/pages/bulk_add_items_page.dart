import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/core/widget/pdf_export_option_tile.dart';
import 'package:hotel/src/core/widget/searchable_select_bottom_sheet.dart';
import 'package:hotel/src/features/action/data/models/request/bulk_create_items_request.dart';
import 'package:hotel/src/features/action/data/models/response/item_response_model.dart';
import 'package:hotel/src/features/action/presentation/cubit/item_cubit.dart';
import 'package:hotel/src/core/constants/item_form_constants.dart';
import 'package:hotel/src/features/category/presentation/cubit/category_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _BulkItemRow {
  _BulkItemRow({String name = '', String rate = ''}) {
    nameController = TextEditingController(text: name);
    rateController = TextEditingController(text: rate);
  }

  late final TextEditingController nameController;
  late final TextEditingController rateController;

  void dispose() {
    nameController.dispose();
    rateController.dispose();
  }
}

@RoutePage()
class BulkAddItemsPage extends StatefulWidget {
  const BulkAddItemsPage({super.key});

  @override
  State<BulkAddItemsPage> createState() => _BulkAddItemsPageState();
}

class _BulkAddItemsPageState extends State<BulkAddItemsPage> {
  static const String _draftCacheKey = 'bulk_add_items_draft_v1';

  final _formKey = GlobalKey<FormState>();
  final List<_BulkItemRow> _rows = [_BulkItemRow(), _BulkItemRow()];

  String _selectedItemType = 'Product';
  String _selectedPurpose = 'Sales';
  String? _selectedUnit = 'Unit';
  String? _selectedCategory;
  final _unitDisplayController = TextEditingController(text: 'Unit');
  final _purposeDisplayController = TextEditingController(text: 'Sales');
  final _categoryDisplayController = TextEditingController();
  bool _submitting = false;
  bool _categoriesLoading = false;
  bool _hasCachedDraft = false;
  bool _isApplyingDraft = false;
  List<MapEntry<String, String>> _categoryOptions = const [];

  @override
  void initState() {
    super.initState();
    _attachRowListeners();
    _loadDraftFromCache();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<CategoryCubit>()
          .loadCategories(sortBy: 'name', sortOrder: 'asc');
    });
  }

  @override
  void dispose() {
    _detachRowListeners();
    for (final row in _rows) {
      row.dispose();
    }
    _unitDisplayController.dispose();
    _purposeDisplayController.dispose();
    _categoryDisplayController.dispose();
    super.dispose();
  }

  void _attachRowListeners() {
    for (final row in _rows) {
      row.nameController.addListener(_onDraftChanged);
      row.rateController.addListener(_onDraftChanged);
    }
  }

  void _detachRowListeners() {
    for (final row in _rows) {
      row.nameController.removeListener(_onDraftChanged);
      row.rateController.removeListener(_onDraftChanged);
    }
  }

  bool _hasMeaningfulDraftInput() {
    final hasRowInput = _rows.any(
      (row) =>
          row.nameController.text.trim().isNotEmpty ||
          row.rateController.text.trim().isNotEmpty,
    );
    final hasDefaultsChanged = _selectedItemType != 'Product' ||
        _selectedPurpose != 'Sales' ||
        (_selectedUnit ?? '') != 'Unit' ||
        (_selectedCategory ?? '').trim().isNotEmpty;
    return hasRowInput || hasDefaultsChanged;
  }

  Map<String, dynamic> _buildDraftPayload() {
    return {
      'itemType': _selectedItemType,
      'purpose': _selectedPurpose,
      'unit': _selectedUnit,
      'category': _selectedCategory,
      'rows': _rows
          .map(
            (row) => {
              'name': row.nameController.text,
              'rate': row.rateController.text,
            },
          )
          .toList(),
    };
  }

  Future<void> _saveDraftToCache() async {
    if (_isApplyingDraft) return;
    final prefs = await SharedPreferences.getInstance();
    if (!_hasMeaningfulDraftInput()) {
      await prefs.remove(_draftCacheKey);
      if (mounted && _hasCachedDraft) {
        setState(() => _hasCachedDraft = false);
      }
      return;
    }

    await prefs.setString(_draftCacheKey, jsonEncode(_buildDraftPayload()));
    if (mounted && !_hasCachedDraft) {
      setState(() => _hasCachedDraft = true);
    }
  }

  Future<void> _loadDraftFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_draftCacheKey);
    if (!mounted) return;

    if (raw == null || raw.trim().isEmpty) {
      setState(() => _hasCachedDraft = false);
      return;
    }

    setState(() => _hasCachedDraft = true);
  }

  Future<void> _clearDraftCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_draftCacheKey);
    if (mounted) {
      setState(() => _hasCachedDraft = false);
    }
  }

  void _onDraftChanged() {
    _saveDraftToCache();
  }

  Future<void> _restoreFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_draftCacheKey);
    if (raw == null || raw.trim().isEmpty) {
      if (mounted) context.showKiiSnackBarError(context.l10n.itemBulkNoDraft);
      return;
    }

    try {
      final data = jsonDecode(raw);
      if (data is! Map<String, dynamic>) {
        context.showKiiSnackBarError(context.l10n.itemBulkInvalidDraft);
        return;
      }

      final rowMaps = (data['rows'] as List?)
              ?.whereType<Map>()
              .map((e) => Map<String, dynamic>.from(e))
              .toList() ??
          const <Map<String, dynamic>>[];

      _isApplyingDraft = true;
      _detachRowListeners();
      for (final row in _rows) {
        row.dispose();
      }
      _rows.clear();

      for (final row in rowMaps) {
        _rows.add(
          _BulkItemRow(
            name: row['name']?.toString() ?? '',
            rate: row['rate']?.toString() ?? '',
          ),
        );
      }
      if (_rows.isEmpty) {
        _rows.addAll([_BulkItemRow(), _BulkItemRow()]);
      }
      _attachRowListeners();

      setState(() {
        _selectedItemType = data['itemType']?.toString() ?? 'Product';
        _selectedPurpose = data['purpose']?.toString() ?? 'Sales';
        _selectedUnit = data['unit']?.toString().isNotEmpty == true
            ? data['unit']?.toString()
            : 'Unit';
        _selectedCategory = data['category']?.toString();

        _unitDisplayController.text = _selectedUnit ?? 'Unit';
        _purposeDisplayController.text = _selectedPurpose;
        _categoryDisplayController.text = _selectedCategory ?? '';
      });

      context.showKiiSnackBarSuccess(context.l10n.itemBulkDraftRestored);
    } catch (_) {
      context.showKiiSnackBarError(context.l10n.itemBulkDraftRestoreFailed);
    } finally {
      _isApplyingDraft = false;
    }
  }

  void _addRow() {
    setState(() => _rows.add(_BulkItemRow()));
    _rows.last.nameController.addListener(_onDraftChanged);
    _rows.last.rateController.addListener(_onDraftChanged);
    _onDraftChanged();
  }

  void _removeRow(int index) {
    if (_rows.length <= 1) return;
    setState(() {
      _rows[index].nameController.removeListener(_onDraftChanged);
      _rows[index].rateController.removeListener(_onDraftChanged);
      _rows[index].dispose();
      _rows.removeAt(index);
    });
    _onDraftChanged();
  }

  Future<void> _pickFromList({
    required String title,
    required List<String> options,
    required String? current,
    required void Function(String) onPick,
  }) async {
    final theme = Theme.of(context);
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(title,
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w600)),
                verticalMarginSmall,
                const Divider(),
                verticalMarginMedium,
                ...options
                    .map((option) => [
                          PdfExportOptionTile(
                            icon: current == option
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            title: ctx.l10n.localizedItemPickerOption(option),
                            color: current == option ? Colors.green : null,
                            onTap: () => Navigator.pop(ctx, option),
                          ),
                          verticalMarginLarge,
                        ])
                    .expand((e) => e)
                    .toList()
                  ..removeLast(),
              ],
            ),
          ),
        ),
      ),
    );
    if (selected != null && mounted) {
      setState(() => onPick(selected));
      _onDraftChanged();
    }
  }

  Future<void> _showSelectBottomSheet({
    required String title,
    required String searchHint,
    required List<MapEntry<String, String>> options,
    required String? currentValue,
    required void Function(String?) onSelected,
    required void Function(String) setDisplayText,
  }) async {
    final theme = Theme.of(context);
    final maxHeight = MediaQuery.of(context).size.height * 0.6;
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(ctx).bottom),
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            constraints: BoxConstraints(maxHeight: maxHeight),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SearchableSelectBottomSheet(
              title: title,
              searchHint: searchHint,
              options: options,
              currentValue: currentValue,
            ),
          ),
        ),
      ),
    );

    if (selected != null && mounted) {
      setState(() {
        onSelected(selected);
        setDisplayText(selected);
      });
      _onDraftChanged();
    }
  }

  String _localizedPickerDisplay(String value) =>
      context.l10n.localizedItemPickerOption(value);

  Widget _selectField({
    required String label,
    required bool required,
    required String value,
    required String hint,
    required VoidCallback onTap,
    bool localizeValue = false,
  }) {
    final theme = Theme.of(context);
    final isPlaceholder = value.isEmpty;
    final displayValue =
        isPlaceholder ? hint : (localizeValue ? _localizedPickerDisplay(value) : value);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(label,
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
            if (required)
              Text(
                ' *',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.error,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    displayValue,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: isPlaceholder
                          ? theme.colorScheme.onSurfaceVariant
                          : null,
                    ),
                  ),
                ),
                Icon(Icons.keyboard_arrow_down_rounded,
                    color: theme.colorScheme.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _submit() async {
    try {
      if (_selectedUnit == null || _selectedUnit!.isEmpty) {
        context.showKiiSnackBarError(context.l10n.itemSelectUnitRequired);
        return;
      }
      if (_selectedCategory == null || _selectedCategory!.trim().isEmpty) {
        context.showKiiSnackBarError(context.l10n.itemSelectCategoryRequired);
        return;
      }
      final createdBy = context.employeeData?.email?.toString();
      final items = <ItemModel>[];

      for (final row in _rows) {
        final name = row.nameController.text.trim();
        final rateText = row.rateController.text.trim();

        if (name.isEmpty && rateText.isEmpty) continue;

        if (name.isEmpty) {
          context.showKiiSnackBarError(context.l10n.itemValidationName);
          return;
        }

        final rate = rateText.isEmpty ? 0.0 : double.tryParse(rateText);
        if (rate == null) {
          context.showKiiSnackBarError(context.l10n.itemValidationNumber);
          return;
        }

        items.add(
          ItemModel(
            name: name,
            itemType: _selectedItemType,
            forFilter: _selectedPurpose,
            unit: _selectedUnit!,
            rate: rate,
            category: _selectedCategory,
            createdBy: createdBy,
            incomeAccount: 'Sales',
            expenseAccount: 'Cost of Goods Sold',
          ),
        );
      }

      if (items.isEmpty) {
        context.showKiiSnackBarError(context.l10n.itemBulkAtLeastOne);
        return;
      }

      setState(() => _submitting = true);
      final error = await context.read<ItemCubit>().bulkCreateItems(
            request: BulkCreateItemsRequest(items: items),
          );
      if (!mounted) return;
      setState(() => _submitting = false);

      if (error != null) {
        context.showKiiSnackBarError(error);
        return;
      }

      await _clearDraftCache();
      context.showKiiSnackBarSuccess(
        context.l10n.itemBulkCreatedCount(context.l10n.formatCount(items.length)),
      );
      context.router.maybePop(true);
    } catch (e) {
      if (!mounted) return;
      setState(() => _submitting = false);
      context.showKiiSnackBarError(context.l10n.itemBulkCreateFailed('$e'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: const AppBarIosBackButton(),
        title: Text(context.l10n.itemBulkAddTitle),
        actions: [
          if (_hasCachedDraft)
            IconButton(
              tooltip: context.l10n.itemBulkRefillTooltip,
              onPressed: _restoreFromCache,
              icon: const Icon(Icons.restore_rounded, size: 20),
            ),
        ],
      ),
      body: BlocListener<CategoryCubit, CategoryState>(
        listener: (context, state) {
          state.maybeWhen(
            loading: () => setState(() => _categoriesLoading = true),
            loaded: (categories) {
              setState(() {
                _categoriesLoading = false;
                _categoryOptions =
                    categories.map((c) => MapEntry(c.name, c.name)).toList();
              });
            },
            error: (message) {
              setState(() => _categoriesLoading = false);
              context.showKiiSnackBarError(message);
            },
            orElse: () {},
          );
        },
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [

              _selectField(
                label: context.l10n.itemTypeField,
                required: true,
                value: _selectedItemType,
                hint: context.l10n.itemSelectType,
                localizeValue: true,
                onTap: () => _pickFromList(
                  title: context.l10n.itemSelectItemType,
                  options: ItemFormConstants.itemTypes,
                  current: _selectedItemType,
                  onPick: (v) => _selectedItemType = v,
                ),
              ),
              const SizedBox(height: 16),
              _selectField(
                label: context.l10n.itemUnitLabel,
                required: true,
                value: _selectedUnit ?? '',
                hint: context.l10n.itemSelectUnit,
                localizeValue: true,
                onTap: () => _pickFromList(
                  title: context.l10n.itemSelectUnit,
                  options: ItemFormConstants.unitOptions,
                  current: _selectedUnit,
                  onPick: (v) {
                    _selectedUnit = v;
                    _unitDisplayController.text = v;
                  },
                ),
              ),
              const SizedBox(height: 16),
              _selectField(
                label: context.l10n.itemPurposeLabel,
                required: true,
                value: _selectedPurpose,
                hint: context.l10n.itemSelectPurpose,
                localizeValue: true,
                onTap: () => _pickFromList(
                  title: context.l10n.itemSelectPurpose,
                  options: ItemFormConstants.purposeOptions,
                  current: _selectedPurpose,
                  onPick: (v) {
                    _selectedPurpose = v;
                    _purposeDisplayController.text = v;
                  },
                ),
              ),
              const SizedBox(height: 16),
              _selectField(
                label: context.l10n.category,
                required: true,
                value: _categoryDisplayController.text,
                hint: _categoriesLoading
                    ? context.l10n.itemBulkLoadingCategories
                    : context.l10n.itemSelectCategory,
                onTap: _categoriesLoading
                    ? () {}
                    : () {
                        if (_categoryOptions.isEmpty) {
                          context
                              .read<CategoryCubit>()
                              .loadCategories(sortBy: 'name', sortOrder: 'asc');
                          context.showKiiSnackBarError(
                              context.l10n.itemBulkCategoriesLoading);
                          return;
                        }
                        _showSelectBottomSheet(
                          title: context.l10n.itemSelectCategory,
                          searchHint: context.l10n.itemSearchCategories,
                          options: _categoryOptions,
                          currentValue: _selectedCategory,
                          onSelected: (v) => _selectedCategory = v,
                          setDisplayText: (label) =>
                              _categoryDisplayController.text = label,
                        );
                      },
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      context.l10n.itemsTitle,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _addRow,
                    icon: const Icon(Icons.add),
                    label: Text(context.l10n.itemBulkAddRow),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ...List.generate(_rows.length, (index) {
                final row = _rows[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Text(
                              context.l10n.itemBulkRowLabel(
                                context.l10n.formatCount(index + 1),
                              ),
                              style: theme.textTheme.titleSmall),
                          const Spacer(),
                          if (_rows.length > 1)
                            IconButton(
                              icon: const Icon(Icons.close, size: 20),
                              onPressed: () => _removeRow(index),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: row.nameController,
                        labelText: context.l10n.name,
                        hint: context.l10n.itemNameHint,
                        validating: (v) {
                          final rate = row.rateController.text.trim();
                          if ((v == null || v.trim().isEmpty) &&
                              rate.isNotEmpty) {
                            return context.l10n.itemBulkNameRequired;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: row.rateController,
                        labelText: context.l10n.itemRateLabel,
                        hint: '0.00',
                        keyboardType: TextInputType.number,
                        validating: (v) {
                          final name = row.nameController.text.trim();
                          if (name.isEmpty) return null;
                          if (v == null || v.trim().isEmpty) return null;
                          if (double.tryParse(v) == null)
                            return context.l10n.itemBulkInvalidNumber;
                          return null;
                        },
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 16),
              CustomButtonWidget(
                width: context.width,
                onPressed: _submitting ? null : _submit,
                title: _submitting
                    ? context.l10n.itemBulkCreating
                    : context.l10n.itemBulkCreateItems,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
