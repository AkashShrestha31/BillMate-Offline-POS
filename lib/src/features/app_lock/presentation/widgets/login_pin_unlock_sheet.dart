import 'package:flutter/material.dart';
import 'package:hotel/src/core/constants/app_constants.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/features/app_lock/domain/app_lock_service.dart';
import 'package:hotel/src/features/app_lock/presentation/widgets/app_pin_keypad_view.dart';
import 'package:hotel/src/features/app_lock/presentation/widgets/app_pin_lockout_handler.dart';

Future<bool?> showLoginPinUnlockSheet(
  BuildContext context, {
  AppLockService? appLockService,
}) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: appPinScaffoldColor(context),
    builder: (ctx) => SizedBox(
      height: MediaQuery.sizeOf(ctx).height * 0.92,
      child: _LoginPinUnlockSheet(
        appLockService: appLockService,
      ),
    ),
  );
}

class _LoginPinUnlockSheet extends StatefulWidget {
  const _LoginPinUnlockSheet({
    this.appLockService,
  });

  final AppLockService? appLockService;

  @override
  State<_LoginPinUnlockSheet> createState() => _LoginPinUnlockSheetState();
}

class _LoginPinUnlockSheetState extends State<_LoginPinUnlockSheet> {
  late final AppLockService _service = widget.appLockService ?? AppLockService();
  String? _errorText;
  int _pinKey = 0;
  final _failureTracker = AppPinFailureTracker();

  Future<void> _verifyPin(String pin) async {
    final ok = await _service.verifyPin(pin);
    if (!mounted) return;
    if (ok) {
      _failureTracker.reset();
      Navigator.of(context).pop(true);
      return;
    }
    if (_failureTracker.recordFailure()) {
      await handleAppPinLockout(
        context,
        appLockService: _service,
        signOut: false,
      );
      if (!mounted) return;
      Navigator.of(context).pop(false);
      return;
    }
    setState(() {
      _errorText = context.l10n.appPinIncorrectWithAttempts(
        _failureTracker.remainingAttempts,
      );
      _pinKey++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppPinKeypadView(
      key: ValueKey<int>(_pinKey),
      title: context.l10n.enterPasscode,
      subtitle: context.l10n.tapDigitsToUnlock(
        AppConstants.APP_LOCK_PIN_LENGTH,
      ),
      errorText: _errorText,
      onCompleted: _verifyPin,
    );
  }
}
