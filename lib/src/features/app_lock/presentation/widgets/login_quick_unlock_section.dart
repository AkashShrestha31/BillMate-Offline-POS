import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/features/app_lock/domain/app_lock_service.dart';
import 'package:hotel/src/features/app_lock/presentation/widgets/login_pin_unlock_sheet.dart';
import 'package:hotel/src/core/l10n/platform_app_localizations.dart';

/// Quick sign-in with PIN/biometrics when already configured on this device.
class LoginQuickUnlockSection extends StatefulWidget {
  const LoginQuickUnlockSection({
    super.key,
    required this.email,
    required this.onQuickSignIn,
    this.appLockService,
  });

  final String email;
  final Future<void> Function(String email) onQuickSignIn;
  final AppLockService? appLockService;

  @override
  State<LoginQuickUnlockSection> createState() =>
      _LoginQuickUnlockSectionState();
}

class _LoginQuickUnlockSectionState extends State<LoginQuickUnlockSection> {
  late final AppLockService _service = widget.appLockService ?? AppLockService();

  bool _loading = true;
  bool _quickUnlockConfigured = false;
  bool _biometricEnabled = false;
  bool _busy = false;
  int _loadGeneration = 0;

  String get _email => widget.email.trim().toLowerCase();

  @override
  void didUpdateWidget(covariant LoginQuickUnlockSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.email.trim().toLowerCase() != _email) {
      _load();
    }
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _applyState(VoidCallback update) {
    if (!mounted) return;

    final phase = SchedulerBinding.instance.schedulerPhase;
    if (phase == SchedulerPhase.idle ||
        phase == SchedulerPhase.postFrameCallbacks) {
      setState(update);
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(update);
    });
  }

  Future<void> _load() async {
    final generation = ++_loadGeneration;

    if (_email.isEmpty) {
      _applyState(() {
        _loading = false;
        _quickUnlockConfigured = false;
      });
      return;
    }

    _applyState(() => _loading = true);

    final configured = await _service.isQuickUnlockConfiguredForEmail(_email);
    final biometricEnabled = await _service.isBiometricUnlockEnabled();

    if (!mounted || generation != _loadGeneration) return;
    _applyState(() {
      _loading = false;
      _quickUnlockConfigured = configured;
      _biometricEnabled = biometricEnabled;
    });
  }

  Future<void> _signInWithBiometric() async {
    if (_busy) return;
    _applyState(() => _busy = true);
    try {
      final ok = await _service.authenticateWithBiometrics(
        reason: context.l10n.platformBiometricUnlockReason,
      );
      if (!mounted) return;
      if (ok) await widget.onQuickSignIn(_email);
    } finally {
      if (mounted) {
        _applyState(() => _busy = false);
      }
    }
  }

  Future<void> _signInWithPin() async {
    if (_busy) return;
    final ok = await showLoginPinUnlockSheet(
      context,
      appLockService: _service,
    );
    if (!mounted) return;
    if (ok == true) {
      await widget.onQuickSignIn(_email);
      return;
    }
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading || _email.isEmpty || !_quickUnlockConfigured) {
      return const SizedBox.shrink();
    }

    final theme = context.theme;
    final scheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: Text(
            context.l10n.orContinueWithPassword,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          context.l10n.quickUnlockAsUser(_email),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: scheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 12.h),
        if (_biometricEnabled) ...[
          CustomButtonWidget(
            onPressed: _signInWithBiometric,
            loading: _busy,
            title: context.l10n.signInWithBiometric,
            icon: const Icon(Icons.fingerprint_rounded),
          ),
          TextButton(
            onPressed: _busy ? null : _signInWithPin,
            child: Text(
              context.l10n.usePinInstead,
              textAlign: TextAlign.center,
              style: AppFonts.interStyle(
                color: scheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ] else
          OutlinedButton.icon(
            onPressed: _busy ? null : _signInWithPin,
            icon: const Icon(Icons.pin_outlined),
            label: Text(context.l10n.signInWithPin),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
      ],
    );
  }
}
