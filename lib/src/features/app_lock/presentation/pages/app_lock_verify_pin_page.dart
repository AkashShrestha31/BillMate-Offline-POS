import 'package:flutter/material.dart';
import 'package:hotel/src/core/constants/app_constants.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/features/app_lock/domain/app_lock_service.dart';
import 'package:hotel/src/features/app_lock/presentation/widgets/app_pin_keypad_view.dart';
import 'package:hotel/src/features/app_lock/presentation/widgets/app_pin_lockout_handler.dart';

class AppLockVerifyPinPage extends StatefulWidget {
  const AppLockVerifyPinPage({
    super.key,
    this.appLockService,
    this.title,
    this.subtitle,
  });

  final AppLockService? appLockService;
  final String? title;
  final String? subtitle;

  @override
  State<AppLockVerifyPinPage> createState() => _AppLockVerifyPinPageState();
}

class _AppLockVerifyPinPageState extends State<AppLockVerifyPinPage> {
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
      await handleAppPinLockout(context, appLockService: _service);
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
    final l10n = context.l10n;
    final pinLength = AppConstants.APP_LOCK_PIN_LENGTH;
    final pageColor = appPinScaffoldColor(context);

    return Scaffold(
      backgroundColor: pageColor,
      appBar: AppBar(
        backgroundColor: pageColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: AppBarIosBackButton(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      body: AppPinKeypadView(
        key: ValueKey<int>(_pinKey),
        title: widget.title ?? l10n.enterPasscode,
        subtitle: widget.subtitle ?? l10n.tapDigitsToUnlock(pinLength),
        errorText: _errorText,
        onCompleted: _verifyPin,
      ),
    );
  }
}
