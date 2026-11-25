import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/constants/app_constants.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/features/app_lock/domain/app_lock_coordinator.dart';
import 'package:hotel/src/features/app_lock/domain/app_lock_settings.dart';
import 'package:hotel/src/features/app_lock/domain/app_lock_service.dart';
import 'package:hotel/src/features/app_lock/presentation/pages/app_lock_pin_setup_page.dart';
import 'package:hotel/src/features/app_lock/presentation/pages/app_lock_verify_pin_page.dart';
import 'package:hotel/src/features/app_lock/presentation/widgets/disable_app_pin_confirm_sheet.dart';
import 'package:hotel/src/features/dashboard/presentation/widgets/more_settings_widgets.dart';
import 'package:hotel/src/features/org/domain/org_switch_coordinator.dart';
import 'package:hotel/src/core/l10n/platform_app_localizations.dart';

/// More page: PIN and biometric unlock for the current org + login.
class AppLockSettingsSection extends StatefulWidget {
  const AppLockSettingsSection({super.key, this.embedded = false});

  final bool embedded;

  @override
  State<AppLockSettingsSection> createState() => _AppLockSettingsSectionState();
}

class _AppLockSettingsSectionState extends State<AppLockSettingsSection> {
  final _service = AppLockService();

  AppLockSettings _settings = AppLockSettings.defaults;
  bool _loading = true;
  bool _busy = false;
  bool _biometricAvailable = false;

  @override
  void initState() {
    super.initState();
    OrgSwitchCoordinator.notifier.addListener(_load);
    _load();
  }

  @override
  void dispose() {
    OrgSwitchCoordinator.notifier.removeListener(_load);
    super.dispose();
  }

  Future<void> _load() async {
    final settings = await _service.loadSettings();
    final biometricAvailable = await _service.isBiometricUnlockAvailable();
    if (!mounted) return;
    setState(() {
      _settings = settings;
      _biometricAvailable = biometricAvailable;
      _loading = false;
    });
  }

  Future<void> _persist(AppLockSettings updated, {String? successMessage}) async {
    setState(() {
      _settings = updated;
      _busy = true;
    });
    await _service.saveSettings(updated);
    if (!mounted) return;
    setState(() => _busy = false);
    if (successMessage != null) {
      context.showKiiSnackBarSuccess(successMessage);
    }
  }

  Future<void> _enablePin() async {
    final created = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => const AppLockPinSetupPage(),
      ),
    );
    if (!mounted) return;
    if (created != true) {
      await _load();
      return;
    }
    await _persist(
      _settings.copyWith(pinEnabled: true),
      successMessage: context.l10n.appPinSetSuccess,
    );
    AppLockCoordinator.markSessionUnlocked();
  }

  Future<void> _disablePin() async {
    final confirmed = await showDisableAppPinConfirmSheet(context);
    if (confirmed != true || !mounted) return;

    final verified = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => AppLockVerifyPinPage(
          appLockService: _service,
          title: context.l10n.verifyPinToRemoveTitle,
          subtitle: context.l10n.verifyPinToRemoveSubtitle(
            AppConstants.APP_LOCK_PIN_LENGTH,
          ),
        ),
      ),
    );
    if (verified != true || !mounted) return;

    await _service.removePin();
    if (!mounted) return;
    await _persist(
      AppLockSettings.defaults,
      successMessage: context.l10n.appPinRemoved,
    );
    AppLockCoordinator.requestEvaluation();
  }

  Future<void> _onPinToggled(bool enabled) async {
    if (_busy) return;
    if (enabled) {
      await _enablePin();
      return;
    }
    await _disablePin();
  }

  Future<void> _onBiometricToggled(bool enabled) async {
    if (_busy) return;
    if (enabled) {
      if (!_settings.pinEnabled || !await _service.hasPin()) {
        if (!mounted) return;
        context.showKiiSnackBarWarning(context.l10n.biometricRequiresPin);
        return;
      }
      if (!await _service.isBiometricUnlockAvailable()) {
        if (!mounted) return;
        context.showKiiSnackBarWarning(context.l10n.biometricNotAvailable);
        await _load();
        return;
      }
      final reason = context.l10n.platformBiometricUnlockReason;
      final ok = await _service.authenticateWithBiometrics(reason: reason);
      if (!ok || !mounted) return;
      await _persist(
        _settings.copyWith(biometricEnabled: true),
        successMessage: context.l10n.appLockSettingsSaved,
      );
      return;
    }

    await _persist(
      _settings.copyWith(biometricEnabled: false),
      successMessage: context.l10n.appLockSettingsSaved,
    );
  }

  Future<void> _changePin() async {
    final pinLength = AppConstants.APP_LOCK_PIN_LENGTH;
    final verified = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => AppLockVerifyPinPage(
          appLockService: _service,
          title: context.l10n.verifyPinToChangeTitle,
          subtitle: context.l10n.verifyPinToChangeSubtitle(pinLength),
        ),
      ),
    );
    if (verified != true || !mounted) return;

    final changed = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => AppLockPinSetupPage(
          mode: AppLockPinSetupMode.change,
          appLockService: _service,
        ),
      ),
    );
    if (changed == true && mounted) {
      context.showKiiSnackBarSuccess(context.l10n.appPinSetSuccess);
    }
  }

  IconData _biometricIcon() => Icons.fingerprint_rounded;

  String _biometricTitle(BuildContext context) => context.l10n.useBiometricUnlock;

  @override
  Widget build(BuildContext context) {
    if (_loading) return const SizedBox.shrink();

    final theme = context.theme;
    final pinLength = AppConstants.APP_LOCK_PIN_LENGTH;

    final body = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MoreSwitchTile(
          icon: Icons.pin_outlined,
          title: context.l10n.appPin,
          subtitle: context.l10n.appPinSubtitle(pinLength),
          value: _settings.pinEnabled,
          busy: _busy,
          onChanged: _busy ? null : _onPinToggled,
        ),
        if (_settings.pinEnabled) ...[
          const MoreSettingsDivider(),
          MoreNavTile(
            icon: Icons.password_rounded,
            title: context.l10n.changeAppPin,
            onTap: _busy ? null : _changePin,
          ),
        ],
        if (_biometricAvailable) ...[
          const MoreSettingsDivider(),
          MoreSwitchTile(
            icon: _biometricIcon(),
            title: _biometricTitle(context),
            subtitle: context.l10n.useBiometricUnlockSubtitle,
            value: _settings.biometricEnabled,
            busy: _busy,
            onChanged: (_busy || !_settings.pinEnabled) ? null : _onBiometricToggled,
          ),
        ],
      ],
    );

    if (widget.embedded) return body;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w),
          child: Text(
            context.l10n.security,
            style: MoreSettingsLayout.sectionLabel(theme),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(8.sp),
          ),
          child: body,
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
