import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/constants.dart';
import 'package:hotel/src/core/constants/item_form_constants.dart';
import 'package:hotel/src/core/constants/margin_constants.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/widget/app_delete_icon.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/services/app_loading_overlay.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/core/widget/searchable_select_bottom_sheet.dart';
import 'package:hotel/src/features/liquor/data/models/request/liquor_update_request_params.dart';
import 'package:hotel/src/features/liquor/data/models/response/liquor_response_model.dart';
import 'package:hotel/src/features/liquor/presentation/cubit/liquor_cubit.dart';

@RoutePage()
class EditProductPage extends StatefulWidget {
  final LiquorItem liquorItem;

  const EditProductPage({super.key, required this.liquorItem});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _categoryController = TextEditingController();
  final _volumeController = TextEditingController();
  final _purchasePriceController = TextEditingController();
  final _sellingPriceController = TextEditingController();

  static const _volumes = [
    '180ml',
    '375ml',
    '500ml',
    '650ml',
    '750ml',
    '790ml',
    '1L',
    '1.5L',
    '1.75L',
  ];

  late final List<String> _categories;
  late String _selectedCategory;
  late String _selectedVolume;
  bool _itemIsActive = true;

  @override
  void initState() {
    super.initState();
    _categories = List<String>.from(ItemFormConstants.categories);
    _populateFields();
  }

  void _populateFields() {
    final item = widget.liquorItem;

    _nameController.text = item.name;
    _brandController.text = item.brand;
    _purchasePriceController.text = _formatPriceForField(item.purchasePrice);
    _sellingPriceController.text = _formatPriceForField(item.sellingPrice);

    _selectedVolume = _volumes.contains(item.volume) ? item.volume : '750ml';
    _volumeController.text = _selectedVolume;

    if (_categories.contains(item.category)) {
      _selectedCategory = item.category;
    } else {
      _categories.add(item.category);
      _selectedCategory = item.category;
    }
    _categoryController.text = _selectedCategory;

    _itemIsActive = item.isActive;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _categoryController.dispose();
    _volumeController.dispose();
    _purchasePriceController.dispose();
    _sellingPriceController.dispose();
    super.dispose();
  }

  String _formatPriceForField(double v) {
    if (v == v.roundToDouble()) return v.toInt().toString();
    return v.toString();
  }

  void _onPriceEdited() => setState(() {});

  Color _fieldIconColor(ColorScheme scheme) =>
      scheme.brightness == Brightness.dark
          ? Colors.white
          : scheme.onSurfaceVariant;

  Future<String?> _showSelectSheet({
    required String title,
    required String searchHint,
    required List<String> options,
    required String currentValue,
  }) {
    final maxHeight = MediaQuery.sizeOf(context).height * 0.6;
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(ctx).bottom),
          child: SafeArea(
            top: false,
            child: Container(
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              constraints: BoxConstraints(maxHeight: maxHeight),
              decoration: AppBottomSheetTheme.sheetDecoration(ctx),
              child: SearchableSelectBottomSheet(
                title: title,
                searchHint: searchHint,
                options: options.map((c) => MapEntry(c, c)).toList(),
                currentValue: currentValue,
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickCategory() async {
    final l10n = context.l10n;
    final picked = await _showSelectSheet(
      title: l10n.itemSelectCategory,
      searchHint: l10n.itemSearchCategories,
      options: _categories,
      currentValue: _selectedCategory,
    );
    if (picked != null && mounted) {
      setState(() {
        _selectedCategory = picked;
        _categoryController.text = picked;
      });
    }
  }

  Future<void> _pickVolume() async {
    final picked = await _showSelectSheet(
      title: 'Select volume',
      searchHint: 'Search volumes…',
      options: _volumes,
      currentValue: _selectedVolume,
    );
    if (picked != null && mounted) {
      setState(() {
        _selectedVolume = picked;
        _volumeController.text = picked;
      });
    }
  }

  Future<void> _confirmDelete() async {
    HapticFeedback.lightImpact();
    if (!mounted) return;
    final scheme = Theme.of(context).colorScheme;
    final productName = widget.liquorItem.name;

    final ok = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(sheetContext).bottom,
          ),
          child: SafeArea(
            top: false,
            child: Container(
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              decoration: AppBottomSheetTheme.sheetDecoration(sheetContext),
              child: AppBottomSheetShell(
                title: 'Delete product?',
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Remove "$productName"? This cannot be undone.',
                      style: Theme.of(sheetContext).textTheme.bodyMedium?.copyWith(
                            color: scheme.onSurfaceVariant,
                            height: 1.4,
                          ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButtonWidget.outlined(
                            title: 'Cancel',
                            height: 48,
                            borderRadius: 8,
                            onPressed: () => Navigator.pop(sheetContext, false),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomButtonWidget(
                            title: 'Delete',
                            height: 48,
                            borderRadius: 8,
                            backgroundColor: scheme.error,
                            titleColor: scheme.onError,
                            onPressed: () => Navigator.pop(sheetContext, true),
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

    if (ok == true && mounted) {
      context.read<LiquorCubit>().deleteLiquorItem(params: widget.liquorItem.id);
    }
  }

  Widget _buildMarginInsight() {
    final p = double.tryParse(_purchasePriceController.text) ?? 0.0;
    final s = double.tryParse(_sellingPriceController.text) ?? 0.0;
    final m = s - p;
    final pct = p > 0 ? (m / p) * 100 : 0.0;
    final scheme = Theme.of(context).colorScheme;
    final marginStyle =
        Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: m >= 0
            ? scheme.primaryContainer.withValues(alpha: 0.45)
            : scheme.errorContainer.withValues(alpha: 0.45),
        border: Border.all(
          color: m >= 0
              ? scheme.primary.withValues(alpha: 0.4)
              : scheme.error.withValues(alpha: 0.45),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.insights_rounded,
                size: 20,
                color: _fieldIconColor(scheme),
              ),
              const SizedBox(width: 8),
              Text(
                'Margin preview',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            p <= 0 && s <= 0
                ? 'Enter purchase and selling prices'
                : m >= 0
                    ? '$currencySymbol ${m.toStringAsFixed(2)}  (${pct.toStringAsFixed(1)}% on cost)'
                    : 'Selling is below cost by $currencySymbol ${(-m).toStringAsFixed(2)}',
            style: marginStyle?.copyWith(
              color: m >= 0 ? scheme.onSurface : scheme.error,
            ),
          ),
        ],
      ),
    );
  }

  bool _validateEditProductInputs() {
    if (_nameController.text.trim().isEmpty) {
      _showSnackBar('Product name is required', isError: true);
      return false;
    }
    if (_brandController.text.trim().isEmpty) {
      _showSnackBar('Brand name is required', isError: true);
      return false;
    }
    if (double.tryParse(_purchasePriceController.text.trim()) == null) {
      _showSnackBar('Enter a valid purchase price', isError: true);
      return false;
    }
    if (double.tryParse(_sellingPriceController.text.trim()) == null) {
      _showSnackBar('Enter a valid selling price', isError: true);
      return false;
    }
    return true;
  }

  void _updateProduct() {
    if (!_validateEditProductInputs()) return;

    HapticFeedback.mediumImpact();
    final purchasePrice =
        double.tryParse(_purchasePriceController.text.trim()) ?? 0;
    final sellingPrice =
        double.tryParse(_sellingPriceController.text.trim()) ?? 0;
    final marginAmount = sellingPrice - purchasePrice;
    final marginPct =
        purchasePrice > 0 ? (marginAmount / purchasePrice) * 100 : null;

    final updateParams = LiquorUpdateRequestParams(
      itemId: widget.liquorItem.id,
      itemName: _nameController.text.trim(),
      volume: _selectedVolume,
      itemIsActive: _itemIsActive ? 1 : 0,
      categoryId: widget.liquorItem.categoryId,
      categoryName: _selectedCategory,
      brandId: widget.liquorItem.brandId,
      brandName: _brandController.text.trim(),
      pricingId: widget.liquorItem.pricingId,
      purchasePrice: purchasePrice.round(),
      sellingPrice: sellingPrice.round(),
      marginAmount: marginAmount.round(),
      marginPercentage: marginPct,
      pricingIsActive: widget.liquorItem.pricingIsActive,
    );

    context.read<LiquorCubit>().updateLiquorItem(params: updateParams);
  }

  void _showSnackBar(String message, {bool isError = false}) {
    final scheme = Theme.of(context).colorScheme;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? scheme.error : scheme.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final iconColor = _fieldIconColor(scheme);
    final l10n = context.l10n;

    return MultiBlocListener(
      listeners: [
        BlocListener<LiquorCubit, LiquorState>(
          listener: (context, state) {
            state.when(
              initial: () => AppLoadingOverlay.of(context).hide(),
              loading: () => AppLoadingOverlay.of(context).show(),
              noInternet: () {
                AppLoadingOverlay.of(context).hide();
                _showSnackBar('No internet connection', isError: true);
              },
              error: (message) {
                AppLoadingOverlay.of(context).hide();
                context.showKiiSnackBarError(message);
              },
              success: (response) => AppLoadingOverlay.of(context).hide(),
              created: (response) => AppLoadingOverlay.of(context).hide(),
              updated: (response) {
                AppLoadingOverlay.of(context).hide();
                context.showKiiSnackBarSuccess(response.data);
                context.router.pushAndPopUntil(
                  LiquorPriceRoute(),
                  predicate: (route) => route.isFirst,
                );
              },
              deleted: (response) {
                AppLoadingOverlay.of(context).hide();
                context.showKiiSnackBarSuccess(response.data);
                context.router.pushAndPopUntil(
                  LiquorPriceRoute(),
                  predicate: (route) => route.isFirst,
                );
              },
            );
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: scheme.surface,
        appBar: AppBar(
          leading: const AppBarIosBackButton(),
          title: Text(
            'Edit Product',
            style: AppFonts.interStyle(
              fontWeight: FontWeight.w600,
              color: scheme.onSurface,
            ),
          ),
          elevation: 0,
          backgroundColor: scheme.surface,
          surfaceTintColor: Colors.transparent,
          foregroundColor: scheme.onSurface,
          actions: [
            IconButton(
              tooltip: 'Delete product',
              onPressed: _confirmDelete,
              icon: AppDeleteIcon(color: scheme.error),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('Basic Information', Icons.info_outline),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _nameController,
                label: 'Product Name',
                hint: 'Enter product name',
                icon: Icons.liquor,
                iconColor: iconColor,
                textInputAction: TextInputAction.next,
                validator: (value) =>
                    value?.trim().isEmpty == true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _brandController,
                label: 'Brand Name',
                hint: 'Enter brand name',
                icon: Icons.branding_watermark_outlined,
                iconColor: iconColor,
                textInputAction: TextInputAction.next,
                validator: (value) =>
                    value?.trim().isEmpty == true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              _buildSelectField(
                controller: _categoryController,
                label: l10n.category,
                hint: l10n.itemSelectCategory,
                icon: Icons.category_outlined,
                iconColor: iconColor,
                onTap: _pickCategory,
              ),
              const SizedBox(height: 16),
              _buildSelectField(
                controller: _volumeController,
                label: 'Volume',
                hint: 'Select volume',
                icon: Icons.straighten,
                iconColor: iconColor,
                onTap: _pickVolume,
              ),
              const SizedBox(height: 24),
              _buildSectionHeader(
                'Pricing Information',
                Icons.currency_rupee,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _purchasePriceController,
                label: 'Purchase Price',
                hint: 'Enter purchase price',
                icon: Icons.shopping_cart_outlined,
                iconColor: iconColor,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                inputFormatter: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d*\.?\d{0,15}'),
                  ),
                ],
                onChanged: (_) => _onPriceEdited(),
                validator: (value) {
                  if (value?.trim().isEmpty == true) return 'Required';
                  if (double.tryParse(value!) == null) return 'Invalid number';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _sellingPriceController,
                label: 'Selling Price',
                hint: 'Enter selling price',
                icon: Icons.sell_outlined,
                iconColor: iconColor,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.done,
                inputFormatter: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d*\.?\d{0,15}'),
                  ),
                ],
                onChanged: (_) => _onPriceEdited(),
                validator: (value) {
                  if (value?.trim().isEmpty == true) return 'Required';
                  if (double.tryParse(value!) == null) return 'Invalid number';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              _buildMarginInsight(),
              const SizedBox(height: 24),
              _buildSectionHeader('Status', Icons.toggle_on_outlined),
              const SizedBox(height: 16),
              Material(
                color: scheme.surfaceContainerHigh,
                elevation: 0,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    HapticFeedback.selectionClick();
                    setState(() => _itemIsActive = !_itemIsActive);
                  },
                  child: SwitchListTile(
                    title: const Text('Item Active'),
                    subtitle: const Text(
                      'Tap row or switch to enable / disable',
                    ),
                    value: _itemIsActive,
                    onChanged: (value) {
                      HapticFeedback.selectionClick();
                      setState(() => _itemIsActive = value);
                    },
                  ),
                ),
              ),
              verticalMarginXLarge,
              CustomButtonWidget(
                title: 'Update',
                onPressed: _updateProduct,
                width: context.width,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: _fieldIconColor(scheme),
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: AppFonts.interStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: scheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required Color iconColor,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    TextInputAction? textInputAction,
    TextCapitalization textCapitalization = TextCapitalization.words,
    List<TextInputFormatter>? inputFormatter,
    ValueChanged<String>? onChanged,
  }) {
    return CustomTextFormField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      validating: validator,
      hint: hint,
      labelText: label,
      prefixIcon: Icon(icon, color: iconColor),
      textInputAction: textInputAction ?? TextInputAction.next,
      textCapitalization: textCapitalization,
      inputFormatter: inputFormatter,
      onChanged: onChanged,
    );
  }

  Widget _buildSelectField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return CustomTextFormField(
      controller: controller,
      labelText: label,
      hint: hint,
      prefixIcon: Icon(icon, color: iconColor),
      suffixIcon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: scheme.onSurfaceVariant,
      ),
      readOnly: true,
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
    );
  }
}
