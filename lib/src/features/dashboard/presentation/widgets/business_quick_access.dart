import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/helpers/freemium_navigation.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/layout/device_layout.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/features/hotel_summary/data/models/request/daily_cash_summary_query_params.dart';
import 'package:hotel/src/features/hotel_summary/presentation/cubit/daily_cash_summary_cubit.dart';
import 'package:hotel/src/features/liquor/presentation/liquor_price_calculator.dart';
import 'package:hotel/src/features/reconciliation/presentation/pages/standard_reconciliation_page.dart';
import 'package:hotel/src/features/dashboard/presentation/widgets/quick_action_icon_text.dart';
import 'package:hotel/src/features/opening/presentation/pages/opening_page.dart';
import 'package:hotel/src/core/constants/permission_api_keys.dart';
import 'package:hotel/src/features/dashboard/data/explore_features_visibility_storage.dart';
import 'package:hotel/src/features/dashboard/domain/explore_feature_entry.dart';
import 'package:hotel/src/features/dashboard/presentation/widgets/explore_features_customize_sheet.dart';
import 'package:hotel/src/features/org/domain/org_switch_coordinator.dart';
import 'package:hotel/src/features/org/domain/organization_business_type.dart';
import 'package:hotel/src/features/org/domain/organization_business_type_reader.dart';
import 'package:hotel/src/features/permission/data/models/response/user_permissions_response_model.dart';
import 'package:hotel/src/features/permission/presentation/cubit/user_permissions_cubit.dart';

// Model class for items
class BusinessMenuItem {
  final IconData icon;
  final String label;
  final Color iconColor;
  final List<Color> gradientColors;
  final VoidCallback? onTap;

  const BusinessMenuItem({
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.gradientColors,
    this.onTap,
  });
}

class BusinessMenuGrid extends StatelessWidget {
  final List<BusinessMenuItem> items;
  final String? title;
  final String? seeAllLabel;
  final VoidCallback? onSeeAll;
  final int itemsPerRow;
  final double itemSize;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double spacing;
  final bool distributeEvenly;
  /// On tablet, overrides auto column count (e.g. sidebar explore grid).
  final int? tabletItemsPerRow;

  const BusinessMenuGrid({
    super.key,
    required this.items,
    this.title,
    this.seeAllLabel,
    this.onSeeAll,
    this.itemsPerRow = 4,
    this.itemSize = 75,
    this.margin,
    this.padding,
    this.spacing = 20,
    this.distributeEvenly = false,
    this.tabletItemsPerRow,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  title!,
                  style: context.theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: scheme.onSurface,
                  ),
                ),
              ),
              if (onSeeAll != null && seeAllLabel != null)
                TextButton(
                  onPressed: onSeeAll,
                  style: TextButton.styleFrom(
                    foregroundColor: scheme.primary,
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                  child: Text(
                    seeAllLabel!,
                    style: context.theme.textTheme.bodyMedium?.copyWith(
                      color: scheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          verticalMarginLarge,
        ],
        _buildGrid(),
      ],
    );
  }

  Widget _buildGrid() {
    if (items.isEmpty) {
      return Builder(
        builder: (context) {
          final scheme = Theme.of(context).colorScheme;
          return Center(
            child: Column(
              children: [
                Icon(
                  Icons.apps_rounded,
                  size: 48,
                  color: scheme.onSurfaceVariant.withValues(alpha: 0.55),
                ),
                const SizedBox(height: 16),
                Text(
                  'No items to display',
                  style: AppFonts.interStyle(
                    fontSize: 16,
                    color: scheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = DeviceLayout.isTablet(context);
        final availableWidth = constraints.maxWidth;

        if (isTablet) {
          return _buildTabletGrid(availableWidth);
        }

        var perRow = itemsPerRow;
        var rowSpacing = spacing;
        final even = distributeEvenly;
        double? tileWidth;

        final numberOfRows = (items.length / perRow).ceil();

        return Column(
          children: List.generate(numberOfRows, (rowIndex) {
            final startIndex = rowIndex * perRow;
            final endIndex = (startIndex + perRow).clamp(0, items.length);
            final rowItems = items.sublist(startIndex, endIndex);

            return Padding(
              padding: EdgeInsets.only(
                bottom: rowIndex < numberOfRows - 1 ? rowSpacing : 0,
              ),
              child: even
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var i = 0; i < perRow; i++)
                          Expanded(
                            child: i < rowItems.length
                                ? Align(
                                    alignment: Alignment.topCenter,
                                    child: _buildMenuItem(
                                      rowItems[i],
                                      startIndex + i,
                                      tileWidth: tileWidth,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                      ],
                    )
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (var i = 0; i < rowItems.length; i++) ...[
                            if (i > 0) SizedBox(width: rowSpacing),
                            _buildMenuItem(
                              rowItems[i],
                              startIndex + i,
                              tileWidth: tileWidth,
                            ),
                          ],
                        ],
                      ),
                    ),
            );
          }),
        );
      },
    );
  }

  Widget _buildTabletGrid(double availableWidth) {
    var perRow = tabletItemsPerRow ?? itemsPerRow;
    if (perRow <= 0) perRow = 4;
    if (items.length <= 4 && tabletItemsPerRow == null) {
      perRow = items.length;
    }
    perRow = perRow.clamp(1, items.length);

    const rowSpacing = 16.0;
    const cellHeight = 96.0;
    final rowCount = (items.length / perRow).ceil();
    final cellCount = rowCount * perRow;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: perRow,
        crossAxisSpacing: rowSpacing,
        mainAxisSpacing: rowSpacing,
        mainAxisExtent: cellHeight,
      ),
      itemCount: cellCount,
      itemBuilder: (context, index) {
        if (index >= items.length) {
          return const SizedBox.shrink();
        }
        return Align(
          alignment: Alignment.topCenter,
          child: _buildMenuItem(
            items[index],
            index,
            animate: false,
          ),
        );
      },
    );
  }

  Widget _buildMenuItem(
    BusinessMenuItem item,
    int index, {
    double? tileWidth,
    bool animate = true,
  }) {
    final child = _MenuItemWidget(
      item: item,
      itemSize: tileWidth ?? itemSize,
    );
    if (!animate) {
      return child;
    }
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: child,
    );
  }
}

class _MenuItemWidget extends StatefulWidget {
  final BusinessMenuItem item;
  final double itemSize;

  const _MenuItemWidget({
    required this.item,
    required this.itemSize,
  });

  @override
  State<_MenuItemWidget> createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<_MenuItemWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {});
        _animationController.forward();
      },
      onTapUp: (_) {
        setState(() {});
        _animationController.reverse();
        widget.item.onTap?.call();
      },
      onTapCancel: () {
        setState(() {});
        _animationController.reverse();
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: SizedBox(
              width: widget.itemSize,
              child: QuickActionIconText(
                icon: widget.item.icon,
                label: widget.item.label,
                containerSize: DeviceLayout.isTablet(context) ? 48 : null,
              ),
            ),
          );
        },
      ),
    );
  }
}

// Helper class to create predefined business menu items
class BusinessMenuItems {
  static BusinessMenuItem employee({
    VoidCallback? onTap,
    required String label,
  }) =>
      BusinessMenuItem(
        icon: FontAwesomeIcons.person,
        label: label,
        iconColor: Colors.white,
        gradientColors: [],
        onTap: onTap,
      );

  static BusinessMenuItem reconciliation({
    VoidCallback? onTap,
    required String label,
  }) =>
      BusinessMenuItem(
        icon: FontAwesomeIcons.random,
        label: label,
        iconColor: Colors.white,
        gradientColors: [],
        onTap: onTap,
      );

  // static BusinessMenuItem sales({VoidCallback? onTap}) => BusinessMenuItem(
  //       icon: FontAwesomeIcons.chartLine,
  //       label: 'Sales',
  //       iconColor: Colors.white,
  //       gradientColors: [],
  //       onTap: onTap,
  //     );

  // static BusinessMenuItem purchase({VoidCallback? onTap}) => BusinessMenuItem(
  //       icon: FontAwesomeIcons.cartShopping,
  //       label: 'Expenses',
  //       iconColor: Colors.white,
  //       gradientColors: [],
  //       onTap: onTap,
  //     );
  static BusinessMenuItem closing({
    VoidCallback? onTap,
    required String label,
  }) =>
      BusinessMenuItem(
        icon: FontAwesomeIcons.shopify,
        label: label,
        iconColor: Colors.white,
        gradientColors: [],
        onTap: onTap,
      );

  static BusinessMenuItem opening({
    VoidCallback? onTap,
    required String label,
  }) =>
      BusinessMenuItem(
        icon: Icons.point_of_sale,
        label: label,
        iconColor: Colors.white,
        gradientColors: [],
        onTap: onTap,
      );

  // static BusinessMenuItem settle({VoidCallback? onTap}) => BusinessMenuItem(
  //       icon: Icons.inventory_rounded,
  //       label: 'Settlement',
  //       iconColor: Colors.white,
  //       gradientColors: [Colors.teal.shade400, Colors.cyan.shade500],
  //       onTap: onTap,
  //     );
  static BusinessMenuItem order({
    VoidCallback? onTap,
    required String label,
  }) =>
      BusinessMenuItem(
        icon: Icons.receipt_long,
        label: label,
        iconColor: Colors.white,
        gradientColors: [Colors.teal.shade400, Colors.cyan.shade500],
        onTap: onTap,
      );

  static BusinessMenuItem inventory({
    VoidCallback? onTap,
    required String label,
  }) =>
      BusinessMenuItem(
        icon: FontAwesomeIcons.handshake,
        label: label,
        iconColor: Colors.white,
        gradientColors: [],
        onTap: onTap,
      );

  static BusinessMenuItem customers({
    VoidCallback? onTap,
    required String label,
  }) =>
      BusinessMenuItem(
        icon: Icons.people_alt_rounded,
        label: label,
        iconColor: Colors.white,
        gradientColors: [],
        onTap: onTap,
      );

  static BusinessMenuItem settings({
    VoidCallback? onTap,
    required String label,
  }) =>
      BusinessMenuItem(
        icon: Icons.settings_rounded,
        label: label,
        iconColor: Colors.white,
        gradientColors: [],
        onTap: onTap,
      );

  static BusinessMenuItem calculator({
    VoidCallback? onTap,
    required String label,
  }) =>
      BusinessMenuItem(
        icon: FontAwesomeIcons.calculator,
        label: label,
        iconColor: Colors.white,
        gradientColors: [],
        onTap: onTap,
      );

  static BusinessMenuItem more({
    VoidCallback? onTap,
    required String label,
  }) =>
      BusinessMenuItem(
        icon: Icons.apps_rounded,
        label: label,
        iconColor: Colors.white,
        gradientColors: [],
        onTap: onTap,
      );

  static BusinessMenuItem quickExpenses({
    VoidCallback? onTap,
    required String label,
  }) =>
      BusinessMenuItem(
        icon: FontAwesomeIcons.solidChartBar,
        label: label,
        iconColor: Colors.white,
        gradientColors: [],
        onTap: onTap,
      );

  static BusinessMenuItem quickSales({
    VoidCallback? onTap,
    required String label,
  }) =>
      BusinessMenuItem(
        icon: Icons.shopping_bag_outlined,
        label: label,
        iconColor: Colors.white,
        gradientColors: [],
        onTap: onTap,
      );

  static BusinessMenuItem quickExpense({
    VoidCallback? onTap,
    required String label,
  }) =>
      BusinessMenuItem(
        icon: Icons.receipt_long_outlined,
        label: label,
        iconColor: Colors.white,
        gradientColors: [],
        onTap: onTap,
      );

  static BusinessMenuItem quickInvoice({
    VoidCallback? onTap,
    required String label,
  }) =>
      BusinessMenuItem(
        icon: Icons.description_outlined,
        label: label,
        iconColor: Colors.white,
        gradientColors: [],
        onTap: onTap,
      );

  static BusinessMenuItem quickReports({
    VoidCallback? onTap,
    required String label,
  }) =>
      BusinessMenuItem(
        icon: Icons.bar_chart_outlined,
        label: label,
        iconColor: Colors.white,
        gradientColors: [],
        onTap: onTap,
      );

  static BusinessMenuItem addEmployee({
    VoidCallback? onTap,
    required String label,
  }) =>
      BusinessMenuItem(
        icon: FontAwesomeIcons.users,
        label: label,
        iconColor: Colors.white,
        gradientColors: [],
        onTap: onTap,
      );

  static BusinessMenuItem addParty({
    VoidCallback? onTap,
    required String label,
  }) =>
      BusinessMenuItem(
        icon: FontAwesomeIcons.user,
        label: label,
        iconColor: Colors.white,
        gradientColors: [],
        onTap: onTap,
      );
}

class BusinessDashboard extends StatefulWidget {
  const BusinessDashboard({
    super.key,
    this.tabletItemsPerRow,
    this.embedded = false,
  });

  /// Column count for the explore grid on tablet (default 4 full-width, 2 sidebar).
  final int? tabletItemsPerRow;

  /// When true, uses tighter padding for a side panel on tablet landscape.
  final bool embedded;

  @override
  State<BusinessDashboard> createState() => _BusinessDashboardState();
}

class _BusinessDashboardState extends State<BusinessDashboard> {
  Set<String> _hiddenIds = {};
  bool _loadedPrefs = false;
  String? _businessType;

  @override
  void initState() {
    super.initState();
    _loadHiddenPrefs();
    _loadBusinessType();
    OrgSwitchCoordinator.notifier.addListener(_onOrgSwitch);
  }

  @override
  void dispose() {
    OrgSwitchCoordinator.notifier.removeListener(_onOrgSwitch);
    super.dispose();
  }

  void _onOrgSwitch() {
    _loadBusinessType();
  }

  Future<void> _loadBusinessType() async {
    final type = await OrganizationBusinessTypeReader.current();
    if (!mounted) return;
    setState(() => _businessType = type);
  }

  Future<void> _loadHiddenPrefs() async {
    final hidden = await ExploreFeaturesVisibilityStorage.getHiddenIds();
    if (!mounted) return;
    setState(() {
      _hiddenIds = hidden;
      _loadedPrefs = true;
    });
  }

  Future<void> _saveHiddenPrefs(Set<String> hidden) async {
    await ExploreFeaturesVisibilityStorage.setHiddenIds(hidden);
    if (!mounted) return;
    setState(() => _hiddenIds = hidden);
  }

  bool _isAllowedByOrg(
    UserPermissionsState permState,
    ExploreFeatureToggleItem entry,
  ) {
    final featureName = entry.permissionFeatureName;
    if (featureName == null) return true;
    if (permState is! UserPermissionsSuccess) return true;
    if (permState.data.features.isEmpty) return true;
    return permState.data.hasFeaturePermission(
      featureName,
      PermissionApiKeys.show,
    );
  }

  bool _isAllowedForBusinessType(ExploreFeatureToggleItem entry) {
    if (entry.id != ExploreFeatureIds.calculator) return true;
    return OrganizationBusinessType.supportsLiquorCalculator(_businessType);
  }

  List<ExploreFeatureToggleItem> _toggleMetadata(BuildContext context) {
    final l10n = context.l10n;
    return [
      ExploreFeatureToggleItem(
        id: ExploreFeatureIds.reconciliation,
        label: l10n.statisticsMenuCheck,
        icon: FontAwesomeIcons.random,
        permissionFeatureName: PermissionApiKeys.reconciliation,
      ),
      ExploreFeatureToggleItem(
        id: ExploreFeatureIds.opening,
        label: l10n.opening,
        icon: Icons.point_of_sale,
        permissionFeatureName: PermissionApiKeys.opening,
      ),
      ExploreFeatureToggleItem(
        id: ExploreFeatureIds.closing,
        label: l10n.closing,
        icon: FontAwesomeIcons.shopify,
        permissionFeatureName: PermissionApiKeys.closing,
      ),
      ExploreFeatureToggleItem(
        id: ExploreFeatureIds.calculator,
        label: l10n.statisticsMenuCalculator,
        icon: FontAwesomeIcons.calculator,
        permissionFeatureName: PermissionApiKeys.calculator,
      ),
      ExploreFeatureToggleItem(
        id: ExploreFeatureIds.inventory,
        label: l10n.statisticsMenuInventory,
        icon: FontAwesomeIcons.handshake,
        permissionFeatureName: PermissionApiKeys.inventoryManagement,
      ),
      ExploreFeatureToggleItem(
        id: ExploreFeatureIds.addEmployee,
        label: l10n.statisticsMenuAddEmployeeSingle,
        icon: FontAwesomeIcons.users,
      ),
      ExploreFeatureToggleItem(
        id: ExploreFeatureIds.addParty,
        label: l10n.statisticsMenuAddPartySingle,
        icon: FontAwesomeIcons.user,
      ),
    ];
  }

  BusinessMenuItem? _menuItemFor(BuildContext context, String id) {
    final l10n = context.l10n;
    switch (id) {
      case ExploreFeatureIds.reconciliation:
        return BusinessMenuItems.reconciliation(
          label: l10n.statisticsMenuCheck,
          onTap: () => _navigateToReconciliation(context),
        );
      case ExploreFeatureIds.opening:
        return BusinessMenuItems.opening(
          label: l10n.opening,
          onTap: () => _navigateToOpening(context),
        );
      case ExploreFeatureIds.closing:
        return BusinessMenuItems.closing(
          label: l10n.closing,
          onTap: () {
            context.read<DailyCashSummaryCubit>().getDailySummaries(
                  params: DailyCashSummaryQueryParams(
                    startDate:
                        '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-01',
                    endDate:
                        '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}',
                    limit: 50,
                    offset: 0,
                  ),
                );
          },
        );
      case ExploreFeatureIds.calculator:
        return BusinessMenuItems.calculator(
          label: l10n.statisticsMenuCalculator,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LiquorPricePage(),
              ),
            );
          },
        );
      case ExploreFeatureIds.inventory:
        return BusinessMenuItems.inventory(
          label: l10n.statisticsMenuInventory,
          onTap: () => context.router.push(ItemDetailsRoute()),
        );
      case ExploreFeatureIds.addEmployee:
        return BusinessMenuItems.addEmployee(
          label: l10n.statisticsMenuAddEmployee,
          onTap: () async {
            if (!await gateFreemiumFeature(context, FreemiumFeature.employee)) {
              return;
            }
            if (!context.mounted) return;
            await context.router.push(EmployeeFormRoute());
          },
        );
      case ExploreFeatureIds.addParty:
        return BusinessMenuItems.addParty(
          label: l10n.statisticsMenuAddParty,
          onTap: () async {
            if (!await gateFreemiumFeature(
              context,
              FreemiumFeature.party,
              partyRole: 'customer',
            )) {
              return;
            }
            if (!context.mounted) return;
            await context.router.push(PartyEditRoute());
          },
        );
      default:
        return null;
    }
  }

  void _openCustomizeSheet(
    BuildContext context,
    List<ExploreFeatureToggleItem> allowed,
  ) {
    showExploreFeaturesCustomizeSheet(
      context: context,
      entries: allowed,
      hiddenIds: _hiddenIds,
      onChanged: _saveHiddenPrefs,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPermissionsCubit, UserPermissionsState>(
      builder: (context, permState) {
        final all = _toggleMetadata(context);
        final allowed = all
            .where((e) => _isAllowedByOrg(permState, e))
            .where(_isAllowedForBusinessType)
            .toList();
        final visible = <BusinessMenuItem>[];
        for (final entry in allowed) {
          if (_hiddenIds.contains(entry.id)) continue;
          final item = _menuItemFor(context, entry.id);
          if (item != null) visible.add(item);
        }

        final isTablet = DeviceLayout.isTablet(context);
        final exploreColumns = widget.tabletItemsPerRow ??
            (isTablet ? (widget.embedded ? 3 : 4) : 4);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    context.l10n.statisticsExploreFeatures,
                    style: context.theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: isTablet ? FontWeight.w600 : null,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: context.l10n.statisticsShowOrHideFeatures,
                  onPressed: allowed.isEmpty
                      ? null
                      : () => _openCustomizeSheet(context, allowed),
                  icon: Icon(
                    Icons.tune_rounded,
                    color: Theme.of(context).colorScheme.primary,
                    size: context.theme.appTheme.spacing18,
                  ),
                ),
              ],
            ),
            SizedBox(height: isTablet ? 12 : 16),
            if (!_loadedPrefs)
              Padding(
                padding: EdgeInsets.symmetric(vertical: isTablet ? 16 : 24),
                child: Center(
                  child: SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              )
            else if (visible.isEmpty)
              _buildExploreEmptyHint(context, allowed.isNotEmpty)
            else if (isTablet && widget.embedded)
              Container(
                padding: const EdgeInsets.all(16),
                clipBehavior: Clip.none,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .outlineVariant
                        .withValues(alpha: 0.45),
                  ),
                ),
                child: BusinessMenuGrid(
                  items: visible,
                  itemsPerRow: exploreColumns,
                  tabletItemsPerRow: exploreColumns,
                  distributeEvenly: true,
                ),
              )
            else
              BusinessMenuGrid(
                items: visible,
                itemsPerRow: exploreColumns,
                tabletItemsPerRow: exploreColumns,
                distributeEvenly: true,
              ),
          ],
        );
      },
    );
  }

  Widget _buildExploreEmptyHint(BuildContext context, bool canCustomize) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            Icons.apps_rounded,
            size: 40,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 12),
          Text(
            canCustomize
                ? context.l10n.statisticsAllFeaturesHidden
                : context.l10n.statisticsNoFeaturesForOrg,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          if (canCustomize) ...[
            const SizedBox(height: 8),
            Text(
              context.l10n.statisticsTapTuneToShow,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _navigateToReconciliation(BuildContext context) async {
    if (!await gateFreemiumFeature(context, FreemiumFeature.stock)) {
      return;
    }
    if (!context.mounted) return;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StandardReconciliationPage(),
      ),
    );
  }

  void _navigateToOpening(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OpeningPage()),
    );
  }
}
