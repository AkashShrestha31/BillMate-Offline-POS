import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/l10n/app_localizations.dart';
import 'package:hotel/src/core/config/app_platform_config.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/helpers/subscription_plan_localization.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/services/billing/subscription_plan.dart';
import 'package:hotel/src/core/services/billing/subscription_service.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/widget/app_splash_image.dart';
import 'package:hotel/src/features/settings/presentation/pages/terms_of_service_page.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class PremiumPaywallPage extends StatefulWidget {
  const PremiumPaywallPage({super.key, this.fromSettings = false});

  /// When opened from settings, allow going back without purchasing.
  final bool fromSettings;

  @override
  State<PremiumPaywallPage> createState() => _PremiumPaywallPageState();
}

class _PremiumPaywallPageState extends State<PremiumPaywallPage> {
  final _billing = getIt<SubscriptionService>();
  SubscriptionPlanKind _selected = SubscriptionPlanKind.yearly;
  bool _handledPremiumActivation = false;

  @override
  void initState() {
    super.initState();
    _billing.addListener(_onBillingChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _billing.refreshPaywallStore();
      if (!mounted) return;
      await _billing.refreshEntitlement();
      if (!mounted) return;
      if (_billing.hasPremiumAccess) {
        await _finishAfterPremiumActivated();
      }
    });
  }

  @override
  void dispose() {
    _billing.removeListener(_onBillingChanged);
    super.dispose();
  }

  void _onBillingChanged() {
    if (!mounted || !_billing.hasPremiumAccess) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_billing.hasPremiumAccess) return;
      unawaited(_finishAfterPremiumActivated());
    });
  }

  Future<void> _finishAfterPremiumActivated() async {
    if (_handledPremiumActivation || !mounted) return;
    _handledPremiumActivation = true;

    if (widget.fromSettings) {
      context.router.maybePop(true);
      return;
    }
    await context.router.replace(const MainRoute());
  }

  Future<void> _onSubscribe() async {
    if (!_billing.canPurchasePlan(_selected)) return;

    final started = await _billing.purchasePlan(_selected);
    if (!mounted) return;
    if (_billing.hasPremiumAccess) {
      await _finishAfterPremiumActivated();
      return;
    }
    if (!started || _billing.storeUnavailable) {
      _showMessage(context.l10n.contactSomethingWrong);
    }
  }

  Future<void> _onRestore() async {
    await _billing.restorePurchases();
    if (!mounted) return;
    if (_billing.hasPremiumAccess) {
      if (widget.fromSettings) {
        _showMessage(context.l10n.premiumPurchaseRestored);
      }
      await _finishAfterPremiumActivated();
      return;
    }
    _showMessage(context.l10n.premiumNoActiveSubscription);
  }

  bool _canContinuePurchase() => _billing.canPurchasePlan(_selected);

  String? _purchaseStatusMessage(AppLocalizations l10n) {
    if (_billing.isLoadingProducts ||
        _billing.isSyncingEntitlements ||
        _billing.isPurchasing) {
      return null;
    }
    if (_billing.storeUnavailable || !_canContinuePurchase()) {
      return l10n.contactSomethingWrong;
    }
    return null;
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final l10n = context.l10n;

    return PopScope(
      canPop: widget.fromSettings,
      child: Scaffold(
        body: SafeArea(
          child: ListenableBuilder(
            listenable: _billing,
            builder: (context, _) {
              if (_billing.hasPremiumAccess) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (context.mounted) {
                    unawaited(_finishAfterPremiumActivated());
                  }
                });
                return const Center(child: CircularProgressIndicator());
              }

              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (widget.fromSettings)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () => context.router.maybePop(),
                          icon: Icon(Icons.close_rounded, size: 24.sp),
                        ),
                      )
                    else
                      SizedBox(height: 8.h),
                    if (AppPlatformConfig.splashAsset != null)
                      Center(
                        child: AppSplashImage(height: 140.r, width: 140.r),
                      )
                    else
                      Icon(
                        Icons.workspace_premium_rounded,
                        size: 116.sp,
                        color: primary,
                      ),
                    SizedBox(height: 20.h),
                    Text(
                      l10n.premiumUnlockTitle(AppPlatformConfig.appName),
                      textAlign: TextAlign.center,
                      style: AppFonts.interStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      l10n.premiumTagline,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.45,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 28.h),
                    _FeatureRow(
                      icon: Icons.receipt_long_outlined,
                      label: l10n.premiumFeatureUnlimitedInvoices,
                    ),
                    _FeatureRow(
                      icon: Icons.inventory_2_outlined,
                      label: l10n.premiumFeatureInventoryStock,
                    ),
                    _FeatureRow(
                      icon: Icons.analytics_outlined,
                      label: l10n.premiumFeatureReportsAnalytics,
                    ),
                    _FeatureRow(
                      icon: Icons.cloud_off_outlined,
                      label: l10n.premiumFeatureOfflineLocal,
                    ),
                    SizedBox(height: 28.h),
                    ..._billing.plans.map((plan) {
                      final selected = plan.kind == _selected;
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: _PlanCard(
                          plan: plan,
                          selected: selected,
                          onTap: () => setState(() => _selected = plan.kind),
                        ),
                      );
                    }),
                    if (_purchaseStatusMessage(l10n) case final message?)
                      Padding(
                        padding: EdgeInsets.only(top: 4.h, bottom: 8.h),
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.error,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    SizedBox(height: 8.h),
                    FilledButton(
                      onPressed: _billing.isPurchasing || !_canContinuePurchase()
                          ? null
                          : _onSubscribe,
                      style: FilledButton.styleFrom(
                        minimumSize: Size(double.infinity, 52.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                      child: _billing.isPurchasing
                          ? SizedBox(
                              height: 22.w,
                              width: 22.w,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                              ),
                            )
                          : Text(
                              l10n.premiumContinueWith(
                                l10n.planTitle(_selected),
                              ),
                              style: AppFonts.interStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                              ),
                            ),
                    ),
                    SizedBox(height: 12.h),
                    _PremiumLegalFooter(
                      selectedPlan: _selected,
                      isRestoring: _billing.isRestoring,
                      onRestore: _onRestore,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _PremiumLegalFooter extends StatelessWidget {
  const _PremiumLegalFooter({
    required this.selectedPlan,
    required this.isRestoring,
    required this.onRestore,
  });

  final SubscriptionPlanKind selectedPlan;
  final bool isRestoring;
  final VoidCallback onRestore;

  Future<void> _openPrivacyPolicy(BuildContext context) async {
    final uri = Uri.parse(AppPlatformConfig.privacyPolicyUrl);
    if (!await canLaunchUrl(uri)) {
      if (context.mounted) {
        context.showKiiSnackBarError(context.l10n.tryAgain);
      }
      return;
    }
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _openTermsOfUse(BuildContext context) async {
    final externalUrl = AppPlatformConfig.externalTermsOfUseUrl;
    if (externalUrl != null) {
      final uri = Uri.parse(externalUrl);
      if (!await canLaunchUrl(uri)) {
        if (context.mounted) {
          context.showKiiSnackBarError(context.l10n.tryAgain);
        }
        return;
      }
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      return;
    }
    if (!context.mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const TermsOfServicePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final linkColor = theme.colorScheme.primary;
    final muted = theme.colorScheme.onSurfaceVariant;
    final legalText = selectedPlan == SubscriptionPlanKind.lifetime
        ? l10n.premiumPaywallLifetimeLegal
        : l10n.premiumPaywallSubscriptionLegal;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextButton(
          onPressed: isRestoring ? null : onRestore,
          style: TextButton.styleFrom(
            foregroundColor: muted,
            padding: EdgeInsets.symmetric(vertical: 4.h),
          ),
          child: isRestoring
              ? SizedBox(
                  height: 18.w,
                  width: 18.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: muted,
                  ),
                )
              : Text(
                  l10n.premiumRestorePreviousPurchase,
                  style: AppFonts.interStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: muted,
                  ),
                ),
        ),
        SizedBox(height: 4.h),
        Text(
          legalText,
          textAlign: TextAlign.center,
          style: theme.textTheme.labelSmall?.copyWith(
            color: muted,
            height: 1.45,
            fontSize: 11.sp,
          ),
        ),
        SizedBox(height: 10.h),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              l10n.premiumPaywallAgreePrefix,
              style: theme.textTheme.labelSmall?.copyWith(
                color: muted,
                fontSize: 11.sp,
                height: 1.45,
              ),
            ),
            _LegalLinkButton(
              label: l10n.premiumPaywallTermsOfUse,
              color: linkColor,
              onPressed: () => _openTermsOfUse(context),
            ),
            Text(
              l10n.premiumPaywallAgreeConjunction,
              style: theme.textTheme.labelSmall?.copyWith(
                color: muted,
                fontSize: 11.sp,
                height: 1.45,
              ),
            ),
            _LegalLinkButton(
              label: l10n.premiumPaywallPrivacyPolicy,
              color: linkColor,
              onPressed: () => _openPrivacyPolicy(context),
            ),
            Text(
              '.',
              style: theme.textTheme.labelSmall?.copyWith(
                color: muted,
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _LegalLinkButton extends StatelessWidget {
  const _LegalLinkButton({
    required this.label,
    required this.color,
    required this.onPressed,
  });

  final String label;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        foregroundColor: color,
      ),
      child: Text(
        label,
        style: AppFonts.interStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          color: color,
          decoration: TextDecoration.underline,
          decorationColor: color,
        ),
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Icon(icon, size: 22.sp, color: theme.colorScheme.primary),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.plan,
    required this.selected,
    required this.onTap,
  });

  final SubscriptionPlan plan;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final l10n = context.l10n;
    final title = l10n.planTitle(plan.kind);
    final subtitle = l10n.planSubtitle(plan.kind);
    final badge = l10n.planBadge(plan.kind);
    final localizedPerMonth = l10n.planPricePerMonthLabel(plan.kind);
    final pricePerMonthLabel = localizedPerMonth ?? plan.pricePerMonthLabel;

    return Material(
      color: selected
          ? primary.withValues(alpha: 0.08)
          : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.45),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(
          color: selected ? primary : theme.dividerColor.withValues(alpha: 0.35),
          width: selected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Row(
            children: [
              Icon(
                selected
                    ? Icons.radio_button_checked_rounded
                    : Icons.radio_button_off_rounded,
                color: selected ? primary : theme.colorScheme.outline,
                size: 22.sp,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: AppFonts.interStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (badge != null) ...[
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(999.r),
                            ),
                            child: Text(
                              badge,
                              style: AppFonts.interStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700,
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    plan.priceLabel,
                    style: AppFonts.interStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  if (pricePerMonthLabel != null)
                    Text(
                      pricePerMonthLabel,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontSize: 11.sp,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
