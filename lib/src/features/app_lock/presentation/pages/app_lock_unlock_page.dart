import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/constants/app_constants.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/features/app_lock/domain/app_lock_service.dart';
import 'package:hotel/src/features/app_lock/presentation/widgets/app_pin_keypad_view.dart';
import 'package:hotel/src/features/app_lock/presentation/widgets/app_pin_lockout_handler.dart';
import 'package:hotel/src/core/l10n/platform_app_localizations.dart';

enum _UnlockMethod { biometric, pin }

/// App lock screen: biometrics first when enabled, PIN as fallback.
class AppLockUnlockPage extends StatefulWidget {
  const AppLockUnlockPage({
    super.key,
    required this.onUnlocked,
    this.appLockService,
    this.showBiometric = false,
  });

  final VoidCallback onUnlocked;
  final AppLockService? appLockService;
  final bool showBiometric;

  @override
  State<AppLockUnlockPage> createState() => _AppLockUnlockPageState();
}

class _AppLockUnlockPageState extends State<AppLockUnlockPage> {
  late final AppLockService _service = widget.appLockService ?? AppLockService();

  String? _errorText;
  bool _initializing = true;
  bool _biometricAvailable = false;
  bool _authenticating = false;
  _UnlockMethod _method = _UnlockMethod.pin;
  int _pinKey = 0;
  final _failureTracker = AppPinFailureTracker();

  @override
  void initState() {
    super.initState();
    _initUnlockMethod();
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

  Future<void> _initUnlockMethod() async {
    final canUseBiometric = widget.showBiometric &&
        await _service.isBiometricUnlockEnabled();

    if (!mounted) return;
    _applyState(() {
      _biometricAvailable = canUseBiometric;
      _method =
          canUseBiometric ? _UnlockMethod.biometric : _UnlockMethod.pin;
      _initializing = false;
    });

    if (canUseBiometric) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _tryBiometric());
    }
  }

  Future<void> _tryBiometric() async {
    if (_authenticating || _method != _UnlockMethod.biometric) return;

    _applyState(() => _authenticating = true);
    try {
      final ok = await _service.authenticateWithBiometrics(
        reason: context.l10n.platformBiometricUnlockReason,
      );
      if (!mounted) return;
      if (ok) widget.onUnlocked();
    } finally {
      if (mounted) {
        _applyState(() => _authenticating = false);
      }
    }
  }

  void _showPinUnlock() {
    if (_method == _UnlockMethod.pin) return;
    _applyState(() {
      _method = _UnlockMethod.pin;
      _authenticating = false;
      _errorText = null;
    });
  }

  Future<void> _verifyPin(String pin) async {
    final ok = await _service.verifyPin(pin);
    if (!mounted) return;
    if (ok) {
      _failureTracker.reset();
      widget.onUnlocked();
      return;
    }
    if (_failureTracker.recordFailure()) {
      await handleAppPinLockout(context, appLockService: _service);
      return;
    }
    _applyState(() {
      _errorText = context.l10n.appPinIncorrectWithAttempts(
        _failureTracker.remainingAttempts,
      );
      _pinKey++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: _buildUnlockBody(context),
    );
  }

  Widget _buildUnlockBody(BuildContext context) {
    if (_initializing) {
      return Scaffold(
        backgroundColor: appPinScaffoldColor(context),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_method == _UnlockMethod.biometric && _biometricAvailable) {
      return _buildBiometricUnlock(context);
    }

    return Scaffold(
      backgroundColor: appPinScaffoldColor(context),
      body: AppPinKeypadView(
        key: ValueKey<int>(_pinKey),
        title: context.l10n.enterPasscode,
        subtitle: context.l10n.tapDigitsToUnlock(
          AppConstants.APP_LOCK_PIN_LENGTH,
        ),
        errorText: _errorText,
        enabled: !_authenticating,
        showBiometric: false,
        onCompleted: _verifyPin,
      ),
    );
  }

  Widget _buildBiometricUnlock(BuildContext context) {
    final scheme = context.theme.colorScheme;
    final primary = scheme.primary;

    return Scaffold(
      backgroundColor: appPinScaffoldColor(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Container(
              width: 88.w,
              height: 88.w,
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: primary.withValues(alpha: 0.24),
                    blurRadius: 28,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Icon(
                Icons.fingerprint_rounded,
                color: primary,
                size: 44.sp,
              ),
            ),
            SizedBox(height: 28.h),
            SizedBox(
              width: double.infinity,
              child: Text(
                context.l10n.unlockWithBiometrics,
                textAlign: TextAlign.center,
                style: AppFonts.interStyle(
                  color: scheme.onSurface,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  context.l10n.platformBiometricUnlockReason,
                  textAlign: TextAlign.center,
                  style: AppFonts.interStyle(
                    color: scheme.onSurfaceVariant,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            if (_authenticating) ...[
              SizedBox(height: 28.h),
              SizedBox(
                width: 28.w,
                height: 28.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: primary,
                ),
              ),
            ],
            const Spacer(flex: 3),
            TextButton(
              onPressed: _authenticating ? null : _tryBiometric,
              child: Text(context.l10n.tryAgain),
            ),
            TextButton(
              onPressed: _authenticating ? null : _showPinUnlock,
              child: Text(context.l10n.usePinInstead),
            ),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }
}
