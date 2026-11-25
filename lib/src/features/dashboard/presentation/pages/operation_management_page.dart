import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/helpers/freemium_navigation.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/features/dashboard/presentation/widgets/more_hub_page_layout.dart';
import 'package:hotel/src/features/hotel_summary/data/models/request/daily_cash_summary_query_params.dart';
import 'package:hotel/src/features/hotel_summary/presentation/cubit/daily_cash_summary_cubit.dart';
import 'package:hotel/src/features/role/presentation/pages/roles_list_page.dart';

class OperationManagementPage extends StatelessWidget {
  const OperationManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DailyCashSummaryCubit>(),
      child: BlocListener<DailyCashSummaryCubit, DailyCashSummaryState>(
        listener: (context, state) {
          state.maybeWhen(
            summariesLoaded: (response) =>
                context.router.push(OpeningAmountRoute(response: response)),
            orElse: () {},
          );
        },
        child: MoreHubPage(
          title: context.l10n.operationManagement,
          children: [
            MoreHubTile(
              icon: Icons.inventory_outlined,
              title: context.l10n.statisticsMenuInventory,
              subtitle: context.l10n.itemsListSubtitle,
              onTap: () => context.router.push(ItemDetailsRoute()),
            ),
            MoreHubTile(
              icon: Icons.inventory_2_outlined,
              title: context.l10n.stock,
              subtitle: context.l10n.stockCountsSubtitle,
              onTap: () async {
                if (!await gateFreemiumFeature(context, FreemiumFeature.stock)) {
                  return;
                }
                if (!context.mounted) return;
                await context.router.push(PreviousStockRoute());
              },
            ),
            MoreHubTile(
              icon: Icons.contacts_outlined,
              title: context.l10n.contacts,
              onTap: () => context.router.push(ContactListRoute()),
            ),
            MoreHubTile(
              icon: Icons.category_outlined,
              title: context.l10n.categories,
              onTap: () => context.router.push(CategoriesListRoute()),
            ),
            MoreHubTile(
              icon: Icons.payments_outlined,
              title: context.l10n.payment,
              onTap: () => context.router.push(const PaymentMethodsListRoute()),
            ),
            MoreHubTile(
              icon: Icons.badge_outlined,
              title: context.l10n.partyRolesTitle,
              subtitle: context.l10n.partyRolesMoreSubtitle,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const RolesListPage(),
                ),
              ),
            ),
            MoreHubTile(
              icon: Icons.people_alt_outlined,
              title: context.l10n.closing,
              onTap: () {
                final now = DateTime.now();
                context.read<DailyCashSummaryCubit>().getDailySummaries(
                      params: DailyCashSummaryQueryParams(
                        startDate:
                            '${now.year}-${now.month.toString().padLeft(2, '0')}-01',
                        endDate:
                            '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}',
                        limit: 50,
                        offset: 0,
                      ),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
