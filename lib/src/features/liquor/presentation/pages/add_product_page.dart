import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/constants/item_form_constants.dart';
import 'package:hotel/src/core/constants/margin_constants.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/services/app_loading_overlay.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

import '../../data/models/request/liquor_create_request_params.dart';
import '../cubit/liquor_cubit.dart';

@RoutePage()
class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  // Form key and controllers
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _purchasePriceController = TextEditingController();
  final _sellingPriceController = TextEditingController();

  // ValueNotifiers for state management
  final ValueNotifier<String> selectedCategoryNotifier = ValueNotifier('Liquors');
  final ValueNotifier<String> selectedVolumeNotifier = ValueNotifier('750ml');

  // Dropdown options — same picklist as item create / edit UI
  final List<String> categories = List<String>.from(ItemFormConstants.categories);
  final List<String> volumes = ['375ml', '750ml', '1L', '1.75L'];
  final List<String> locations = ['Main Bar', 'VIP', 'Pool Side Bar', 'Rooftop'];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();

    _purchasePriceController.dispose();
    _sellingPriceController.dispose();

    selectedCategoryNotifier.dispose();
    selectedVolumeNotifier.dispose();
    super.dispose();
  }
  //
  // void _onLiquorStateChange(LiquorState state) {
  //   state.when(
  //     initial: () => isLoadingNotifier.value = false,
  //     loading: () => isLoadingNotifier.value = true,
  //     noInternet: () {
  //       isLoadingNotifier.value = false;
  //       _showErrorSnackBar('No internet connection');
  //     },
  //     error: (message) {
  //       isLoadingNotifier.value = false;
  //       _showErrorSnackBar(message);
  //     },
  //     success: (response) => isLoadingNotifier.value = false,
  //     created: (response) {
  //       isLoadingNotifier.value = false;
  //       _showSuccessSnackBar('Product created successfully');
  //       Navigator.pop(context, true);
  //     },
  //     updated: (response) => isLoadingNotifier.value = false,
  //     deleted: () => isLoadingNotifier.value = false,
  //   );
  // }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      final now = DateTime.now();
      final fiveYearsLater = DateTime(now.year + 5, now.month, now.day);
      final effectiveFrom =
          "${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
      final effectiveTo =
          "${fiveYearsLater.year.toString().padLeft(4, '0')}-${fiveYearsLater.month.toString().padLeft(2, '0')}-${fiveYearsLater.day.toString().padLeft(2, '0')}";

      final createParams = LiquorCreateRequestParams(
        name: _nameController.text.trim(),
        category: selectedCategoryNotifier.value,
        brand: _nameController.text.trim(),
        volume: selectedVolumeNotifier.value,
        categoryDescription: '',
        pricing: PricingInfo(
            purchasePrice: int.parse(_purchasePriceController.text),
            sellingPrice: int.parse(_sellingPriceController.text),
            effectiveFrom: effectiveFrom,
            effectiveTo: effectiveTo,
            notes: '',
            location: "Main Bar"),
        description: '',
      );

      context.read<LiquorCubit>().createLiquorItem(params: createParams);
    }
  }

  Future<void> _selectDate(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context),
          child: child!,
        );
      },
    );
    if (picked != null) {
      controller.text = picked.toString().split(' ')[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LiquorCubit, LiquorState>(
          listener: (context, state) {
            state.when(
              initial: () => AppLoadingOverlay.of(context).hide(),
              loading: () => AppLoadingOverlay.of(context).show(),
              noInternet: () {
                AppLoadingOverlay.of(context).hide();
              },
              error: (message) {
                AppLoadingOverlay.of(context).hide();
                context.showKiiSnackBarError(message);
              },
              success: (response) => AppLoadingOverlay.of(context).hide(),
              created: (response) {
                AppLoadingOverlay.of(context).hide();
                context.showKiiSnackBarSuccess(response.data);
                context.router.pushAndPopUntil(
                  LiquorPriceRoute(),
                  predicate: (route) => route.isFirst, // Keep only the first/root route
                );
              },
              updated: (response) {

              },
              deleted: (response) => AppLoadingOverlay.of(context).hide(),
            );
          },

        )
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          leading: const AppBarIosBackButton(),
          title: Text(
            'Add Product',
            style: AppFonts.interStyle(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.surface,
          surfaceTintColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Basic Information Section
                _buildSectionHeader('Basic Information', Icons.info_outline),
                const SizedBox(height: 16),

                _buildTextField(
                  controller: _nameController,
                  label: 'Product Name',
                  hint: 'Enter product name',
                  icon: Icons.liquor,
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: ValueListenableBuilder<String>(
                        valueListenable: selectedCategoryNotifier,
                        builder: (context, selectedCategory, child) {
                          return _buildDropdownField<String>(
                            value: selectedCategory,
                            items: categories,
                            label: 'Category',
                            icon: Icons.category,
                            onChanged: (value) => selectedCategoryNotifier.value = value!,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ValueListenableBuilder<String>(
                        valueListenable: selectedVolumeNotifier,
                        builder: (context, selectedVolume, child) {
                          return _buildDropdownField<String>(
                            value: selectedVolume,
                            items: volumes,
                            label: 'Volume',
                            icon: Icons.straighten,
                            onChanged: (value) => selectedVolumeNotifier.value = value!,
                          );
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Pricing Information Section
                _buildSectionHeader('Pricing Information', Icons.currency_rupee),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _purchasePriceController,
                        label: 'Purchase Price',
                        hint: '0.00',
                        icon: Icons.shopping_cart,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value?.isEmpty == true) return 'Required';
                          if (double.tryParse(value!) == null) return 'Invalid number';
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        controller: _sellingPriceController,
                        label: 'Selling Price',
                        hint: '0.00',
                        icon: Icons.sell,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value?.isEmpty == true) return 'Required';
                          if (double.tryParse(value!) == null) return 'Invalid number';
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                verticalMarginXLarge,
                CustomButtonWidget(
                  title: 'Add',
                  onPressed: () => _saveProduct(),
                  width: context.width,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    final primary = Theme.of(context).colorScheme.primary;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: AppFonts.interStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
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
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return CustomTextFormField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      hint: hint,
      labelText: label,
      maxLines: maxLines,
      validating: validator,
      textCapitalization: TextCapitalization.words,
    );
  }

  Widget _buildDropdownField<T>({
    required T value,
    required List<T> items,
    required String label,
    required IconData icon,
    required void Function(T?) onChanged,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return DropdownButtonFormField<T>(
      value: value,
      items: items.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(item.toString()),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: scheme.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
        filled: true,
        fillColor: scheme.surfaceContainerHighest,
      ),
    );
  }
}
