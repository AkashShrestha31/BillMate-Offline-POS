import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/constants/item_form_constants.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/core/widget/searchable_select_bottom_sheet.dart';
import 'package:hotel/src/features/liquor/data/models/request/liquor_create_request_params.dart';
import 'package:hotel/src/features/liquor/presentation/cubit/liquor_cubit.dart';

/// Opens the add-product form as a modal bottom sheet.
/// Returns `true` when the user saved a product.
Future<bool> showAddProductBottomSheet(
  BuildContext context, {
  String initialCategory = 'Liquors',
}) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: true,
    enableDrag: true,
    builder: (sheetContext) => _AddProductSheet(
      initialCategory: initialCategory,
    ),
  );
  return result ?? false;
}

class _AddProductSheet extends StatefulWidget {
  const _AddProductSheet({required this.initialCategory});

  final String initialCategory;

  @override
  State<_AddProductSheet> createState() => _AddProductSheetState();
}

class _AddProductSheetState extends State<_AddProductSheet> {
  static const _defaultVolume = '750ml';
  static const _categories = ItemFormConstants.categories;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _categoryController = TextEditingController();
  final _purchasePriceController = TextEditingController();
  final _sellingPriceController = TextEditingController();

  late String _category;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _category = _categories.contains(widget.initialCategory)
        ? widget.initialCategory
        : 'Liquors';
    _categoryController.text = _category;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _categoryController.dispose();
    _purchasePriceController.dispose();
    _sellingPriceController.dispose();
    super.dispose();
  }

  Future<void> _pickCategory() async {
    final l10n = context.l10n;
    final maxHeight = MediaQuery.sizeOf(context).height * 0.6;
    final picked = await showModalBottomSheet<String>(
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
                title: l10n.itemSelectCategory,
                searchHint: l10n.itemSearchCategories,
                options: _categories.map((c) => MapEntry(c, c)).toList(),
                currentValue: _category,
              ),
            ),
          ),
        );
      },
    );
    if (picked != null && mounted) {
      setState(() {
        _category = picked;
        _categoryController.text = picked;
      });
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate() || _saving) return;

    setState(() => _saving = true);

    final now = DateTime.now();
    final fiveYearsLater = DateTime(now.year + 5, now.month, now.day);
    final effectiveFrom =
        '${now.year.toString().padLeft(4, '0')}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.day.toString().padLeft(2, '0')}';
    final effectiveTo =
        '${fiveYearsLater.year.toString().padLeft(4, '0')}-'
        '${fiveYearsLater.month.toString().padLeft(2, '0')}-'
        '${fiveYearsLater.day.toString().padLeft(2, '0')}';

    final purchase = int.parse(_purchasePriceController.text.trim());
    final selling = int.parse(_sellingPriceController.text.trim());

    context.read<LiquorCubit>().createLiquorItem(
          params: LiquorCreateRequestParams(
            name: _nameController.text.trim(),
            category: _category,
            brand: _brandController.text.trim(),
            volume: _defaultVolume,
            categoryDescription: '',
            description: '',
            pricing: PricingInfo(
              purchasePrice: purchase,
              sellingPrice: selling,
              effectiveFrom: effectiveFrom,
              effectiveTo: effectiveTo,
              location: 'Main Bar',
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = context.l10n;

    return BlocListener<LiquorCubit, LiquorState>(
      listener: (context, state) {
        state.maybeWhen(
          created: (_) {
            if (!mounted) return;
            Navigator.pop(context, true);
          },
          error: (message) {
            if (!mounted) return;
            setState(() => _saving = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
          orElse: () {},
        );
      },
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: SafeArea(
          top: false,
          child: Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            decoration: AppBottomSheetTheme.sheetDecoration(context),
            child: AppBottomSheetShell(
              title: 'Add Product',
              showCloseButton: !_saving,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextFormField(
                        controller: _nameController,
                        labelText: 'Product Name',
                        hint: 'Product Name',
                        prefixIcon: Icon(
                          Icons.inventory_2_outlined,
                          color: scheme.onSurfaceVariant,
                        ),
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        enabled: !_saving,
                        validating: (v) =>
                            v?.trim().isEmpty == true ? 'Required' : null,
                      ),
                      SizedBox(height: 12.h),
                      CustomTextFormField(
                        controller: _brandController,
                        labelText: 'Brand',
                        hint: 'Brand',
                        prefixIcon: Icon(
                          Icons.branding_watermark_outlined,
                          color: scheme.onSurfaceVariant,
                        ),
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        enabled: !_saving,
                        validating: (v) =>
                            v?.trim().isEmpty == true ? 'Required' : null,
                      ),
                      SizedBox(height: 12.h),
                      CustomTextFormField(
                        controller: _categoryController,
                        labelText: l10n.category,
                        hint: l10n.itemSelectCategory,
                        prefixIcon: Icon(
                          Icons.category_outlined,
                          color: scheme.onSurfaceVariant,
                        ),
                        suffixIcon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: scheme.onSurfaceVariant,
                        ),
                        readOnly: true,
                        enabled: !_saving,
                        onTap: _saving ? null : _pickCategory,
                      ),
                      SizedBox(height: 12.h),
                      CustomTextFormField(
                        controller: _purchasePriceController,
                        labelText: 'Purchase Price',
                        hint: 'Purchase Price',
                        prefixIcon: Icon(
                          Icons.currency_rupee,
                          color: scheme.onSurfaceVariant,
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: false,
                        ),
                        inputFormatter: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        textInputAction: TextInputAction.next,
                        enabled: !_saving,
                        validating: (v) {
                          if (v == null || v.trim().isEmpty) return 'Required';
                          return int.tryParse(v.trim()) == null
                              ? 'Invalid'
                              : null;
                        },
                      ),
                      SizedBox(height: 12.h),
                      CustomTextFormField(
                        controller: _sellingPriceController,
                        labelText: 'Selling Price',
                        hint: 'Selling Price',
                        prefixIcon: Icon(
                          Icons.currency_rupee,
                          color: scheme.onSurfaceVariant,
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: false,
                        ),
                        inputFormatter: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        textInputAction: TextInputAction.done,
                        enabled: !_saving,
                        validating: (v) {
                          if (v == null || v.trim().isEmpty) return 'Required';
                          return int.tryParse(v.trim()) == null
                              ? 'Invalid'
                              : null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButtonWidget.outlined(
                              height: 48.h,
                              borderRadius: 8.r,
                              title: 'Cancel',
                              onPressed: _saving
                                  ? null
                                  : () => Navigator.pop(context),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: CustomButtonWidget(
                              height: 48.h,
                              borderRadius: 8.r,
                              title: 'Save',
                              loading: _saving,
                              onPressed: _saving ? null : _save,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
