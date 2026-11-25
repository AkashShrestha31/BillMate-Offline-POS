import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/constants.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/helpers/item_image_helper.dart';
import 'package:hotel/src/features/action/data/models/response/item_response_model.dart';
import 'package:hotel/src/features/action/presentation/cubit/item_cubit.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/invoice/presentation/pages/login/quick_add_items_page.dart';
import 'package:hotel/src/features/order/presentation/models/restaurant_cart_line.dart';
import 'package:hotel/src/features/order/presentation/utils/order_ui_helpers.dart';

/// Horizontal favorite items on the home dashboard.
class DashboardFavoritesStrip extends StatefulWidget {
  const DashboardFavoritesStrip({super.key});

  @override
  State<DashboardFavoritesStrip> createState() =>
      _DashboardFavoritesStripState();
}

class _DashboardFavoritesStripState extends State<DashboardFavoritesStrip> {
  List<ItemModel> _items = [];
  int _loadGen = 0;
  StreamSubscription<int>? _favoriteSub;

  @override
  void initState() {
    super.initState();
    _load();
    _favoriteSub = context.read<ItemCubit>().favoriteChanges.listen((_) {
      _load();
    });
  }

  @override
  void dispose() {
    _favoriteSub?.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    final gen = ++_loadGen;
    final items = await context.read<ItemCubit>().fetchFavoriteItems(
          forFilter: 'Sales',
        );
    if (!mounted || gen != _loadGen) return;
    setState(() => _items = items);
  }

  Future<void> _open(QuickAddItemsPage page) async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => page.wrappedRoute(context),
      ),
    );
    if (mounted) _load();
  }

  void _manage() {
    _open(
      const QuickAddItemsPage(
        invoiceType: InvoiceType.sales,
        fromQuickSales: true,
        startOnFavorites: true,
      ),
    );
  }

  void _add(ItemModel item) {
    _open(
      QuickAddItemsPage(
        invoiceType: InvoiceType.sales,
        fromQuickSales: true,
        initialRestaurantCartJson: RestaurantCartLine.encodeList([
          RestaurantCartLine(
            name: item.name,
            quantity: 1,
            rate: item.rate,
            imageUrl: item.image,
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_items.isEmpty) return const SizedBox.shrink();
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final l10n = context.l10n;

    return Padding(
      padding: EdgeInsets.only(top: 4.h, bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.invoiceQuickFavorites,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              TextButton(
                onPressed: _manage,
                style: TextButton.styleFrom(
                  foregroundColor: scheme.primary,
                  padding:
                      EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
                  minimumSize: const Size(0, 36),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  l10n.invoiceQuickManageFavorites,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: scheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 184.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.hardEdge,
              itemCount: _items.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final item = _items[index];
                return _DashboardFavoriteCard(
                  item: item,
                  image: _favoriteImage(item.image, theme),
                  priceLabel: l10n.formatCurrency(
                    '$currencySymbol ${item.rate.toStringAsFixed(2)}',
                  ),
                  onAdd: () => _add(item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget? _favoriteImage(String? raw, ThemeData theme) {
  if (raw == null || raw.trim().isEmpty) return null;
  final resolved = resolveOrderItemImageUrl(raw) ?? raw.trim();
  if (!ItemImageHelper.hasDisplayableImage(resolved)) return null;
  if (ItemImageHelper.isNetworkUrl(resolved)) {
    return Image.network(
      resolved,
      fit: BoxFit.cover,
      width: double.infinity,
      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
    );
  }
  return ItemImageHelper.buildImage(
    resolved,
    fit: BoxFit.cover,
    width: double.infinity,
    errorBuilder: (_, __, ___) => const SizedBox.shrink(),
  );
}

class _DashboardFavoriteCard extends StatelessWidget {
  const _DashboardFavoriteCard({
    required this.item,
    required this.image,
    required this.priceLabel,
    required this.onAdd,
  });

  final ItemModel item;
  final Widget? image;
  final String priceLabel;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Material(
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.45)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onAdd,
        child: SizedBox(
          width: 140.w,
          child: Padding(
            padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80.h,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: ColoredBox(
                            color: scheme.surfaceContainerHighest,
                            child: image ??
                                Icon(
                                  Icons.inventory_2_outlined,
                                  color: scheme.onSurfaceVariant,
                                ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 6.r,
                        right: 6.r,
                        child: Material(
                          color: scheme.primary,
                          shape: const CircleBorder(),
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: onAdd,
                            child: SizedBox(
                              width: 28.h,
                              height: 28.h,
                              child: Icon(
                                Icons.add,
                                size: 18,
                                color: scheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  item.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
              8.verticalSpace,
                Text(
                  priceLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: scheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
