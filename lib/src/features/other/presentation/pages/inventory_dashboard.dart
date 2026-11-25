import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/scaffold_wrapper.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/other/data/models/item_counter_request_params.dart';
import 'package:hotel/src/features/other/data/models/item_counter_response_model.dart';
import 'package:hotel/src/features/other/presentation/bloc/item_counter_cubit.dart';
import 'package:hotel/src/core/widget/app_search_icon.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';

@RoutePage()
class InventoryDashboardPage extends StatefulWidget {
  const InventoryDashboardPage({super.key});

  @override
  State<InventoryDashboardPage> createState() => _InventoryDashboardState();
}

class _InventoryDashboardState extends State<InventoryDashboardPage> {
  final TextEditingController _searchController = TextEditingController();
  List<ItemCount> _allItems = [];
  List<ItemCount> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_performSearch);
    context
        .read<ItemCounterCubit>()
        .getItemCounter(params: ItemCounterRequestParams());
  }

  @override
  void dispose() {
    _searchController.removeListener(_performSearch);
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = _allItems.where((item) {
        return item.item.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      appBar: AppBar(
        leading: AppBarIosBackButton(color: Colors.grey.shade800),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.grey[800]),
      ),
      body: BlocBuilder<ItemCounterCubit, ItemCounterState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => Container(),
            loading: () => Center(child: CircularProgressIndicator()),
            success: (responseData) {
              // Initialize items only once
              if (_allItems.isEmpty) {
                _allItems = responseData.data.itemCounts;
                _filteredItems = List.from(_allItems);
              }

              return RefreshIndicator(
                onRefresh: () async {
                  _searchController.clear();
                  await context
                      .read<ItemCounterCubit>()
                      .getItemCounter(params: ItemCounterRequestParams());
                },
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSearchField(),
                          _buildHeader(),
                        ],
                      ),
                    ),
                    _filteredItems.isEmpty && _searchController.text.isNotEmpty
                        ? SliverFillRemaining(
                            child: _buildNoResults(),
                          )
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final item = _filteredItems[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      context.router.push(PartyInvoiceRoute(
                                          itemName: item.item,
                                          invoiceType: InvoiceType.purchase));
                                    },
                                    child: _InventoryItemCard(
                                      itemName: item.item,
                                      sold: item.totalSold,
                                      purchased: item.totalPurchased,
                                    ),
                                  ),
                                );
                              },
                              childCount: _filteredItems.length,
                            ),
                          ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[100],
          hintText: context.l10n.inventorySearchHint,
          hintStyle: AppFonts.interStyle(color: Colors.grey[600]),
          prefixIcon: AppSearchIcon.inputDecoration( color: Colors.grey[600]),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey[600]),
                  onPressed: () {
                    _searchController.clear();
                    _performSearch();
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
        style: AppFonts.interStyle(color: Colors.grey[800]),
        onChanged: (_) => _performSearch(),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.inventoryTitle,
            style: AppFonts.interStyle(
              color: Colors.grey[800],
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.inventorySubtitle,
            style: AppFonts.interStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            context.l10n.itemNoItemsFound,
            style: AppFonts.interStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
          Text(
            context.l10n.stockTryDifferentSearch,
            style: AppFonts.interStyle(
              color: Colors.grey[500],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _InventoryItemCard extends StatelessWidget {
  final String itemName;
  final dynamic sold;
  final dynamic purchased;

  const _InventoryItemCard({
    required this.itemName,
    required this.sold,
    required this.purchased,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[50]!.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[100]!),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue[100]!, Colors.blue[50]!],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.inventory_rounded,
                    size: 22,
                    color: Colors.blue[800],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    itemName,
                    style: AppFonts.interStyle(
                      color: Colors.blueGrey[800],
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatTile(
                  context,
                  icon: Icons.trending_up_rounded,
                  value: sold,
                  label: context.l10n.inventorySold,
                  color: Colors.green[700]!,
                  bgColor: Colors.green[50]!,
                ),
                _buildStatTile(
                  context,
                  icon: Icons.warehouse_rounded,
                  value: purchased,
                  label: context.l10n.inventoryPurchased,
                  color: Colors.orange[700]!,
                  bgColor: Colors.orange[50]!,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatTile(
    BuildContext context, {
    required IconData icon,
    required dynamic value,
    required String label,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.1))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.localizeDigits(value.toString()),
                style: AppFonts.interStyle(
                  color: color,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                label,
                style: AppFonts.interStyle(
                  color: Colors.grey[600],
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
