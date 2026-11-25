import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/helpers/utility.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/features/liquor/liquor.dart';
import 'package:hotel/src/core/widget/app_search_icon.dart';
import 'package:hotel/src/features/liquor/presentation/widgets/add_product_bottom_sheet.dart';
import 'package:hotel/constants.dart';

enum ProductType {
  liquor,
  beer,
  others;

  static ProductType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'liquor':
        return ProductType.liquor;
      case 'beer':
        return ProductType.beer;
      default:
        return ProductType.others;
    }
  }
}

class PriceResults {
  final double? price30ml;
  final double? price45ml;
  final double? price60ml;
  final double? price90ml;
  final double? price180ml;
  final double? priceHalf;

  const PriceResults({
    this.price30ml,
    this.price45ml,
    this.price60ml,
    this.price90ml,
    this.price180ml,
    this.priceHalf,
  });

  bool get hasResults => price30ml != null;

  PriceResults clear() => const PriceResults();
}

@RoutePage()
class LiquorPricePage extends StatefulWidget {
  const LiquorPricePage({super.key});

  @override
  _LiquorPricePageState createState() => _LiquorPricePageState();
}

class _LiquorPricePageState extends State<LiquorPricePage> {
  bool _autoAddSheetOpened = false;

  // Controllers
  final TextEditingController _purchasePriceController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  // ValueNotifiers for state management
  final ValueNotifier<List<LiquorItem>> productsNotifier = ValueNotifier([]);
  final ValueNotifier<List<LiquorItem>> filteredProductsNotifier = ValueNotifier([]);
  final ValueNotifier<LiquorItem?> selectedProductNotifier = ValueNotifier(null);
  final ValueNotifier<PriceResults> priceResultsNotifier = ValueNotifier(const PriceResults());

  @override
  void initState() {
    super.initState();
    _loadProducts();
    selectedProductNotifier.addListener(_onSelectedProductChanged);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSelectedProductChanged() {
    final product = selectedProductNotifier.value;
    if (product != null) {
      _purchasePriceController.text = (product.purchasePrice + product.marginAmount).toString();
      _clearFields();
    }
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) {
      filteredProductsNotifier.value = productsNotifier.value;
    } else {
      filteredProductsNotifier.value = productsNotifier.value.where((product) {
        return product.name.toLowerCase().contains(query) ||
            product.brand.toLowerCase().contains(query) ||
            product.category.toLowerCase().contains(query);
      }).toList();
    }
  }

  @override
  void dispose() {
    _purchasePriceController.dispose();
    _searchController.dispose();
    productsNotifier.dispose();
    filteredProductsNotifier.dispose();
    selectedProductNotifier.dispose();
    priceResultsNotifier.dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    final liquorCubit = context.read<LiquorCubit>();
    liquorCubit.getLiquorItems(
      params: LiquorRequestParams(page: 1, perPage: 100),
    );
  }

  void calculatePrices() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (selectedProductNotifier.value == null) return;

    double purchasePrice = double.tryParse(_purchasePriceController.text) ?? 0;

    double roundPrice(double price) {
      if (price <= 5) return 5;
      if (price <= 10) return 10;
      return (price / 5).ceil() * 5;
    }

    // Calculate based on actual ml from 750ml bottle
    final priceHalf = roundPrice((purchasePrice / 750) * 375); // 375ml = Half bottle
    final price180ml = roundPrice((purchasePrice / 750) * 180); // 180ml = Quarter
    final price90ml = roundPrice((purchasePrice / 750) * 90); // 90ml = Triple shot
    final price60ml = roundPrice((purchasePrice / 750) * 60); // 60ml = Double shot
    final price45ml = roundPrice((purchasePrice / 750) * 45); // 45ml
    final price30ml = roundPrice((purchasePrice / 750) * 30); // 30ml = Single shot

    priceResultsNotifier.value = PriceResults(
      price30ml: price30ml,
      price45ml: price45ml,
      price60ml: price60ml,
      price90ml: price90ml,
      price180ml: price180ml,
      priceHalf: priceHalf,
    );
  }

  void _navigateToSettings() async {
    context.router.push(ProductSettingsRoute(products: productsNotifier.value));
  }

  Future<void> _openAddProduct({bool auto = false}) async {
    if (auto) {
      if (_autoAddSheetOpened) return;
      _autoAddSheetOpened = true;
    }
    final saved = await showAddProductBottomSheet(context);
    if (saved && mounted) {
      _loadProducts();
    }
  }

  void _clearFields() {
    priceResultsNotifier.value = priceResultsNotifier.value.clear();
  }

  void _showProductSearchDialog() {
    _searchController.clear();
    filteredProductsNotifier.value = productsNotifier.value;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        final theme = Theme.of(sheetContext);
        final maxHeight = MediaQuery.sizeOf(sheetContext).height * 0.75;

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(sheetContext).bottom,
          ),
          child: Container(
            height: maxHeight,
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.outlineVariant,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 12, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Select Product',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(sheetContext).pop(),
                        icon: Icon(Icons.close_rounded),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      prefixIcon: AppSearchIcon.inputDecoration(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: ValueListenableBuilder<List<LiquorItem>>(
                    valueListenable: filteredProductsNotifier,
                    builder: (context, filteredProducts, child) {
                      if (filteredProducts.isEmpty) {
                        return Center(
                          child: Text(
                            'No products found',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        );
                      }

                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: filteredProducts.length,
                        separatorBuilder: (_, __) => const Divider(height: 1, indent: 72),
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          final isSelected =
                              selectedProductNotifier.value?.id == product.id;

                          return ListTile(
                            onTap: () {
                              selectedProductNotifier.value = product;
                              Navigator.of(sheetContext).pop();
                            },
                            selected: isSelected,
                            leading: CircleAvatar(
                              backgroundColor: theme.colorScheme.primaryContainer,
                              child: Icon(
                                Icons.local_drink_rounded,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            title: Text(
                              product.name,
                              style: AppFonts.interStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              '${product.brand} • ${product.volume} • '
                              '$currencySymbol ${(product.purchasePrice + product.marginAmount).toStringAsFixed(0)}',
                            ),
                            trailing: isSelected
                                ? Icon(
                                    Icons.check_circle_rounded,
                                    color: theme.colorScheme.primary,
                                  )
                                : null,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LiquorCubit, LiquorState>(
      builder: (context, state) {
        return state.maybeWhen(
          success: (products) {
            productsNotifier.value = products.data.items;
            filteredProductsNotifier.value = products.data.items;
            if (selectedProductNotifier.value == null && products.data.items.isNotEmpty) {
              selectedProductNotifier.value = products.data.items[0];
            }
            return productsNotifier.value.isEmpty
                ? _buildEmptyState()
                : Scaffold(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    appBar: AppBar(
                      leading: const AppBarIosBackButton(),
                      title: Text(context.l10n.statisticsMenuCalculator),
                      elevation: 0,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      surfaceTintColor: Colors.transparent,
                      actions: [
                        IconButton(
                          onPressed: _navigateToSettings,
                          icon: Icon(Icons.settings),
                        ),
                        ValueListenableBuilder<PriceResults>(
                          valueListenable: priceResultsNotifier,
                          builder: (context, results, child) {
                            if (!results.hasResults) return const SizedBox.shrink();
                            return IconButton(
                              onPressed: _clearFields,
                              icon: Icon(Icons.refresh_rounded),
                              tooltip: 'Reset',
                            );
                          },
                        ),
                      ],
                    ),
                    body: RefreshIndicator(
                      onRefresh: _loadProducts,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.l10n.liquorPricesSubtitle,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildProductSelector(),
                            const SizedBox(height: 24),
                            _buildPriceDisplay(),
                            const SizedBox(height: 24),
                            _buildCalculateButton(),
                            const SizedBox(height: 24),
                            ValueListenableBuilder<PriceResults>(
                              valueListenable: priceResultsNotifier,
                              builder: (context, results, child) {
                                if (!results.hasResults) return const SizedBox.shrink();
                                return _buildResultsCard(results);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          },
          loading: () => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
          error: (message) => Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: $message'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _loadProducts(),
                    child: Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
          updated: (liquorItem) {
            _loadProducts();
            return const CircularProgressIndicator();
          },
          created: (liquorItem) {
            _loadProducts();
            return const CircularProgressIndicator();
          },
          deleted: (liquorItem) {
            _loadProducts();
            return const CircularProgressIndicator();
          },
          orElse: () => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
        );
      },
      listener: (BuildContext context, LiquorState state) {},
    );
  }

  Widget _buildProductSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product',
          style: AppFonts.interStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder<LiquorItem?>(
          valueListenable: selectedProductNotifier,
          builder: (context, selectedProduct, child) {
            return InkWell(
              onTap: _showProductSearchDialog,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.local_drink, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: selectedProduct != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  selectedProduct.name,
                                  style: AppFonts.interStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '${selectedProduct.brand} • ${selectedProduct.volume}',
                                  style: AppFonts.interStyle(
                                    fontSize: 12,
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            )
                          : Text('Select a product'),
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPriceDisplay() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Full Bottle Price (750ml)',
          style: AppFonts.interStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder<LiquorItem?>(
          valueListenable: selectedProductNotifier,
          builder: (context, selectedProduct, child) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.theme.colorScheme.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: context.theme.colorScheme.primary.withValues(alpha: 0.35)),
              ),
              child: Text(
                selectedProduct != null ? '$currencySymbol ${_purchasePriceController.text}' : '$currencySymbol 0.00',
                style: AppFonts.interStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCalculateButton() {
    return ValueListenableBuilder<LiquorItem?>(
      valueListenable: selectedProductNotifier,
      builder: (context, selectedProduct, child) {
        return SizedBox(
          width: double.infinity,
          child: CustomButtonWidget(
            onPressed: selectedProduct != null ? calculatePrices : null,
            title: 'Calculate',
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    if (!_autoAddSheetOpened) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _openAddProduct(auto: true);
      });
    }

    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        leading: const AppBarIosBackButton(),
        title: Text(
          context.l10n.statisticsMenuCalculator,
          style: AppFonts.interStyle(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        foregroundColor: theme.colorScheme.onSurface,
        actions: [
          IconButton(
            tooltip: 'Manage products',
            onPressed: _navigateToSettings,
            icon: Icon(Icons.settings_outlined, color: theme.colorScheme.onSurface),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.local_bar_rounded,
                        size: 56,
                        color: primary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'No products yet',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Add your first liquor product to start calculating pour prices.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton.icon(
                  onPressed: _openAddProduct,
                  icon: Icon(Icons.add_rounded),
                  label: Text('Add product'),
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsCard(PriceResults results) {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.theme.colorScheme.primary.withValues(alpha: 0.12),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.analytics, color: context.theme.colorScheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: ValueListenableBuilder<LiquorItem?>(
                    valueListenable: selectedProductNotifier,
                    builder: (context, selectedProduct, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Price Breakdown',
                            style: AppFonts.interStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            selectedProduct?.name ?? '',
                            style: AppFonts.interStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildPriceRow('30 ML', results.price30ml!),
                _buildPriceRow('45 ML', results.price45ml!),
                _buildPriceRow('60 ML', results.price60ml!),
                _buildPriceRow('90 ML', results.price90ml!),
                _buildPriceRow('180 ML (Quarter)', results.price180ml!),
                _buildPriceRow('375 ML (Half)', results.priceHalf!),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, double price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(Icons.local_drink, size: 18, color: Theme.of(context).colorScheme.onSurfaceVariant),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: AppFonts.interStyle(fontSize: 14),
            ),
          ),
          Text(
            '$currencySymbol ${Utility.formatIndianNumber(price.ceil())}',
            style: AppFonts.interStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          IconButton(
            onPressed: () => _showJiggerInfo(label),
            icon: Icon(
              Icons.info_outline,
              size: 18,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  void _showJiggerInfo(String label) {
    String getJiggerInfo(String measureLabel) {
      if (measureLabel.contains('30 ML')) return '1 x 30ml';
      if (measureLabel.contains('45 ML')) return '1 x 30ml + 1 x 15ml';
      if (measureLabel.contains('60 ML')) return '1 x 60ml + 1 x 5ml';
      if (measureLabel.contains('90 ML')) {
        return '1 x 60ml + 1 x 30ml + Added(1 x 7.5ml)';
      }
      if (measureLabel.contains('180 ML')) return '3 x 60ml + Added(1 x 15ml)';
      if (measureLabel.contains('375 ML')) {
        return '6 x 60ml + 1 x 30ml+ Added( 1 x 30ml)';
      }
      return '';
    }

    String getPegInfo(String measureLabel) {
      if (measureLabel.contains('30 ML')) return 'Single shot / Small peg';
      if (measureLabel.contains('60 ML')) return 'Double shot / Medium peg';
      if (measureLabel.contains('90 ML')) {
        return 'Triple shot / Large peg / Patiala peg';
      }
      if (measureLabel.contains('180 ML')) return 'Quarter';
      if (measureLabel.contains('375 ML')) return 'Half';
      return '';
    }

    final pegInfo = getPegInfo(label);
    final jiggerInfo = getJiggerInfo(label);
    final scheme = Theme.of(context).colorScheme;

    showModalBottomSheet<void>(
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
                title: label,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Jigger Measure',
                      style: AppFonts.interStyle(
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      jiggerInfo,
                      style: AppFonts.interStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: scheme.onSurface,
                      ),
                    ),
                    if (pegInfo.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: scheme.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: scheme.outlineVariant.withValues(alpha: 0.5),
                            ),
                          ),
                          child: Text(
                            pegInfo,
                            style: AppFonts.interStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: scheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    CustomButtonWidget(
                      title: 'Close',
                      onPressed: () => Navigator.pop(sheetContext),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
