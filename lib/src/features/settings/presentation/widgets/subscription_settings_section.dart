import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hotel/l10n/app_localizations.dart';
import 'package:hotel/src/core/config/app_billing_config.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/helpers/subscription_plan_localization.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/services/billing/subscription_plan.dart';
import 'package:hotel/src/core/services/billing/subscription_service.dart';
import 'package:hotel/src/features/dashboard/presentation/widgets/more_settings_widgets.dart';

/// More page: subscription status and upgrade entry (iOS when billing enabled).
class SubscriptionSettingsSection extends StatefulWidget {
  const SubscriptionSettingsSection({super.key, this.embedded = false});

  final bool embedded;

  @override
  State<SubscriptionSettingsSection> createState() =>
      _SubscriptionSettingsSectionState();
}

class _SubscriptionSettingsSectionState
    extends State<SubscriptionSettingsSection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIt<SubscriptionService>().refreshEntitlement();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!AppBillingConfig.showBillingUi) {
      return const SizedBox.shrink();
    }

    final billing = getIt<SubscriptionService>();
    final l10n = context.l10n;

    return ListenableBuilder(
      listenable: billing,
      builder: (context, _) {
        final theme = context.theme;
        final isPremium = billing.hasPremiumAccess;
        final monthly = '\$${AppBillingConfig.monthlyUsd.toStringAsFixed(2)}';
        final yearly = '\$${AppBillingConfig.yearlyUsd.toStringAsFixed(2)}';
        final subtitle = isPremium
            ? _premiumSubtitle(l10n, billing)
            : l10n.subscriptionPremiumPricing(monthly, yearly);

        final tile = ListTile(
          contentPadding: MoreSettingsLayout.tilePadding(context),
          leading: MoreIconBox(
            icon: isPremium
                ? Icons.verified_rounded
                : Icons.workspace_premium_outlined,
          ),
          title: Text(
            isPremium ? l10n.subscriptionPremiumLabel : l10n.subscriptionUpgradeTitle,
            style: MoreSettingsLayout.tileTitle(theme),
          ),
          subtitle: Text(
            subtitle,
            style: MoreSettingsLayout.tileSubtitle(theme),
          ),
          trailing: isPremium
              ? null
              : Icon(
                  Icons.chevron_right_rounded,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
          onTap: () {
            context.router.push(
              PremiumPaywallRoute(fromSettings: true),
            );
          },
        );

        if (widget.embedded) return tile;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                l10n.subscriptionSectionTitle,
                style: MoreSettingsLayout.sectionLabel(theme),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: tile,
            ),
          ],
        );
      },
    );
  }

  String _premiumSubtitle(AppLocalizations l10n, SubscriptionService billing) {
    final kind = SubscriptionPlan.kindForPlanLabel(billing.activePlanDisplayLabel);
    final planLabel = kind != null
        ? l10n.planDisplayLabel(kind)
        : (billing.activePlanDisplayLabel ?? l10n.subscriptionPremiumLabel);
    final expiresAt = billing.subscriptionExpiresAt;
    if (expiresAt != null && !billing.isLifetimeActive) {
      final date =
          '${expiresAt.year}-${expiresAt.month.toString().padLeft(2, '0')}-${expiresAt.day.toString().padLeft(2, '0')}';
      return l10n.subscriptionPremiumActiveUntil(planLabel, date);
    }
    return l10n.subscriptionPremiumActive(planLabel);
  }
}
