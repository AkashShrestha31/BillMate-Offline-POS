import 'package:flutter/material.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/features/app_lock/presentation/widgets/app_lock_setup_flow_layout.dart';
import 'package:hotel/src/features/app_lock/domain/app_lock_coordinator.dart';
import 'package:hotel/src/features/app_lock/domain/app_lock_service.dart';
import 'package:hotel/src/features/app_lock/domain/app_lock_settings.dart';
import 'package:hotel/src/features/app_lock/presentation/pages/app_lock_pin_setup_page.dart';
import 'package:hotel/src/core/l10n/platform_app_localizations.dart';

/// PIN setup followed by optional biometric enablement.
class AppLockSetupFlowPage extends StatefulWidget {
  const AppLockSetupFlowPage({
    super.key,
    this.appLockService,
    this.quickUnlockEmail,
  });

  final AppLockService? appLockService;
  final String? quickUnlockEmail;

  @override
  State<AppLockSetupFlowPage> createState() => _AppLockSetupFlowPageState();
}

class _AppLockSetupFlowPageState extends State<AppLockSetupFlowPage> {
  late final AppLockService _service = widget.appLockService ?? AppLockService();
  bool _active = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startPinSetup());
  }

  @override
  void dispose() {
    _active = false;
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  bool get _isAlive => mounted && _active;

  Future<void> _startPinSetup() async {
    final navigator = Navigator.of(context, rootNavigator: true);
    FocusManager.instance.primaryFocus?.unfocus();

    final created = await navigator.push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => AppLockPinSetupPage(
          appLockService: _service,
          quickUnlockEmail: widget.quickUnlockEmail,
        ),
      ),
    );
    if (!_isAlive) return;
    if (created != true) {
      navigator.pop(false);
      return;
    }

    await _service.saveSettings(
      const AppLockSettings(pinEnabled: true, biometricEnabled: false),
    );

    if (!await _service.isBiometricUnlockAvailable()) {
      if (!_isAlive) return;
      AppLockCoordinator.markSessionUnlocked();
      navigator.pop(true);
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();
    if (!_isAlive) return;

    final l10n = context.l10n;
    final enableBiometric = await showAppLockChoiceSheet(
      context,
      title: l10n.enableBiometricTitle,
      message: l10n.enableBiometricAfterPinMessage,
      primaryLabel: l10n.setUpNow,
      secondaryLabel: l10n.notNow,
    );

    if (!_isAlive) return;
    if (enableBiometric == true) {
      final reason = l10n.platformBiometricUnlockReason;
      final ok = await _service.authenticateWithBiometrics(reason: reason);
      if (ok) {
        await _service.saveSettings(
          const AppLockSettings(pinEnabled: true, biometricEnabled: true),
        );
      }
    }

    if (!_isAlive) return;
    AppLockCoordinator.markSessionUnlocked();
    navigator.pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

Future<bool?> showAppLockSetupPromptSheet(BuildContext context) {
  FocusManager.instance.primaryFocus?.unfocus();
  return showAppLockChoiceSheet(
    context,
    title: context.l10n.setUpQuickUnlockAfterLoginTitle,
    message: context.l10n.setUpQuickUnlockAfterLoginMessage,
    primaryLabel: context.l10n.setUpNow,
    secondaryLabel: context.l10n.notNow,
  );
}

Future<bool?> showAppLockChoiceSheet(
  BuildContext context, {
  required String title,
  required String message,
  required String primaryLabel,
  required String secondaryLabel,
}) {
  final isTablet = AppLockSetupFlowLayout.isTablet(context);

  Widget sheetContent(BuildContext ctx, {required bool asBottomSheet}) {
    final horizontalPadding = AppLockSetupFlowLayout.sheetHorizontalPadding(ctx);
    final bottomInset = MediaQuery.viewPaddingOf(ctx).bottom;

    final body = Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppLockSetupFlowLayout.sheetHorizontalMargin(ctx),
        vertical: AppLockSetupFlowLayout.sheetVerticalMargin(ctx),
      ),
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        AppLockSetupFlowLayout.sheetTopPadding(
          ctx,
          asBottomSheet: asBottomSheet,
        ),
        horizontalPadding,
        AppLockSetupFlowLayout.sheetBottomPadding(
          ctx,
          bottomInset,
          asBottomSheet: asBottomSheet,
        ),
      ),
      decoration: isTablet
          ? BoxDecoration(
              color: Theme.of(ctx).colorScheme.surface,
              borderRadius: BorderRadius.circular(
                AppLockSetupFlowLayout.sheetBorderRadius(ctx),
              ),
            )
          : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: ctx.theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: AppLockSetupFlowLayout.spacingAfterTitle(ctx)),
          Text(
            message,
            style: ctx.theme.textTheme.bodyMedium?.copyWith(
              color: ctx.theme.colorScheme.onSurfaceVariant,
              height: 1.45,
            ),
          ),
          SizedBox(height: AppLockSetupFlowLayout.spacingBeforeButtons(ctx)),
          CustomButtonWidget(
            title: primaryLabel,
            onPressed: () => Navigator.of(ctx, rootNavigator: true).pop(true),
            useFixedSizes: isTablet,
            height: AppLockSetupFlowLayout.primaryButtonHeight(ctx),
            borderRadius: AppLockSetupFlowLayout.buttonRadius(ctx),
          ),
          SizedBox(height: AppLockSetupFlowLayout.spacingBetweenButtons(ctx)),
          CustomButtonWidget.outlined(
            title: secondaryLabel,
            onPressed: () => Navigator.of(ctx, rootNavigator: true).pop(false),
            useFixedSizes: isTablet,
            height: AppLockSetupFlowLayout.secondaryButtonHeight(ctx),
            borderRadius: AppLockSetupFlowLayout.buttonRadius(ctx),
          ),
        ],
      ),
    );

    final constrainedBody = ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: AppLockSetupFlowLayout.maxContentWidth(ctx),
      ),
      child: body,
    );

    if (asBottomSheet) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(ctx).bottom),
        child: SafeArea(
          top: false,
          child: constrainedBody,
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(ctx).bottom),
      child: SafeArea(
        child: Center(child: constrainedBody),
      ),
    );
  }

  if (isTablet) {
    return showDialog<bool>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: true,
      builder: (ctx) => sheetContent(ctx, asBottomSheet: false),
    );
  }

  return showModalBottomSheet<bool>(
    context: context,
    useRootNavigator: true,
    showDragHandle: true,
    useSafeArea: false,
    isScrollControlled: true,
    builder: (ctx) => sheetContent(ctx, asBottomSheet: true),
  );
}
