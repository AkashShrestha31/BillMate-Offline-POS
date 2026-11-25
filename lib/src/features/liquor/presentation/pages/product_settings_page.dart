import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/features/liquor/presentation/liquor_price_calculator.dart';
import 'package:hotel/src/features/liquor/presentation/widgets/add_product_bottom_sheet.dart';
import 'package:hotel/constants.dart';

import '../../data/models/response/liquor_response_model.dart';

@RoutePage()
class ProductSettingsPage extends StatefulWidget {
  final List<LiquorItem> products;

  const ProductSettingsPage({super.key, required this.products});

  @override
  State<ProductSettingsPage> createState() => _ProductSettingsPageState();
}

class _ProductSettingsPageState extends State<ProductSettingsPage> {
  bool _autoAddSheetOpened = false;

  @override
  void initState() {
    super.initState();
    if (widget.products.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _openAddProduct(auto: true));
    }
  }

  Future<void> _openAddProduct({bool auto = false}) async {
    if (auto) {
      if (_autoAddSheetOpened) return;
      _autoAddSheetOpened = true;
    }
    final saved = await showAddProductBottomSheet(context);
    if (!mounted) return;
    if (saved) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product added')),
      );
      context.router.maybePop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        leading: const AppBarIosBackButton(),
        title: Text(
          'Products',
          style: AppFonts.interStyle(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        actions: [
          IconButton(
            tooltip: 'Add product',
            onPressed: _openAddProduct,
            icon: Icon(Icons.add, color: Theme.of(context).colorScheme.primary),
          ),
        ],
      ),
      body: widget.products.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: widget.products.length,
              itemBuilder: (context, index) {
                return _buildProductCard(widget.products[index]);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Column(
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
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Add your first product to manage liquor pricing.',
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
    );
  }

  Widget _buildProductCard(LiquorItem product) {
    final primary = Theme.of(context).colorScheme.primary;
    final isLiquor = ProductType.fromString(product.brand) == ProductType.liquor;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.45),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  isLiquor ? Icons.liquor : Icons.sports_bar,
                  color: primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: AppFonts.interStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${product.brand} • ${product.volume}',
                      style: AppFonts.interStyle(
                        fontSize: 13,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        product.brand,
                        style: AppFonts.interStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Edit product',
                onPressed: () {
                  context.router.push(EditProductRoute(
                    liquorItem: product,
                  ));
                },
                icon: Icon(Icons.edit_outlined, color: primary),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Purchase Price',
                        style: AppFonts.interStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        '$currencySymbol ${product.purchasePrice.toStringAsFixed(0)}',
                        style: AppFonts.interStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 30,
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Selling Price',
                        style: AppFonts.interStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        '$currencySymbol ${(product.purchasePrice + product.profitMargin).toStringAsFixed(0)}',
                        style: AppFonts.interStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
