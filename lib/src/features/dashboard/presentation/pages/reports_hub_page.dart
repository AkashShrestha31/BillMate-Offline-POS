import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/helpers/freemium_navigation.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/features/dashboard/presentation/widgets/more_hub_page_layout.dart';
import 'package:hotel/src/features/reports/data/models/request/analytics_report_request.dart';
import 'package:hotel/src/features/reports/data/models/request/profit_loss_report_request.dart';
import 'package:hotel/src/features/reports/data/models/request/statement_report_request.dart';
import 'package:hotel/src/features/reports/presentation/bloc/analytics_report/analytics_report_cubit.dart';
import 'package:hotel/src/features/reports/presentation/bloc/profit_loss_report/profit_loss_report_cubit.dart';
import 'package:hotel/src/features/reports/presentation/bloc/statement_report/statement_report_cubit.dart';
import 'package:hotel/src/features/reports/presentation/pages/analytics_report_page.dart';
import 'package:hotel/src/features/reports/presentation/pages/profit_loss_report_page.dart';
import 'package:hotel/src/features/reports/presentation/pages/statement_report_page.dart';

class ReportsHubPage extends StatelessWidget {
  const ReportsHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MoreHubPage(
      title: context.l10n.report,
      children: [
        MoreHubTile(
          icon: Icons.account_balance_wallet_outlined,
          title: context.l10n.profitAndLoss,
          onTap: () async {
            if (!await gateFreemiumFeature(
              context,
              FreemiumFeature.reportProfitLoss,
            )) {
              return;
            }
            if (!context.mounted) return;
            await Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => BlocProvider<ProfitLossReportCubit>(
                  create: (_) => getIt<ProfitLossReportCubit>()
                    ..load(ProfitLossReportRequest.initial()),
                  child: const ProfitLossReportPage(),
                ),
              ),
            );
          },
        ),
        MoreHubTile(
          icon: Icons.receipt_long_outlined,
          title: context.l10n.statementReport,
          onTap: () async {
            if (!await gateFreemiumFeature(
              context,
              FreemiumFeature.reportStatement,
            )) {
              return;
            }
            if (!context.mounted) return;
            await Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => BlocProvider<StatementReportCubit>(
                  create: (_) => getIt<StatementReportCubit>()
                    ..load(StatementReportRequest.initial()),
                  child: const StatementReportPage(),
                ),
              ),
            );
          },
        ),
        MoreHubTile(
          icon: Icons.analytics_outlined,
          title: context.l10n.analytics,
          onTap: () async {
            if (!await gateFreemiumFeature(
              context,
              FreemiumFeature.reportAnalytics,
            )) {
              return;
            }
            if (!context.mounted) return;
            await Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => BlocProvider<AnalyticsReportCubit>(
                  create: (_) => getIt<AnalyticsReportCubit>()
                    ..load(AnalyticsReportRequest.initial()),
                  child: const AnalyticsReportPage(),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
