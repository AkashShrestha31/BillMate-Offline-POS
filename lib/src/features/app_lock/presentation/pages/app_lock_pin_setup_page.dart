import 'package:flutter/material.dart';
import 'package:hotel/src/core/constants/app_constants.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/features/app_lock/domain/app_lock_service.dart';
import 'package:hotel/src/features/app_lock/presentation/widgets/app_pin_keypad_view.dart';

enum AppLockPinSetupMode { create, change }

class AppLockPinSetupPage extends StatefulWidget {
  final AppLockPinSetupMode mode;
  final AppLockService? appLockService;
  final String? quickUnlockEmail;

  const AppLockPinSetupPage({
    super.key,
    this.mode = AppLockPinSetupMode.create,
    this.appLockService,
    this.quickUnlockEmail,
  });

  @override
  State<AppLockPinSetupPage> createState() => _AppLockPinSetupPageState();
}

class _AppLockPinSetupPageState extends State<AppLockPinSetupPage> {
  late final AppLockService _service = widget.appLockService ?? AppLockService();

  bool _confirming = false;
  String? _firstPin;
  String? _errorText;

  Future<void> _onPinCompleted(String pin) async {
    if (!_confirming) {
      setState(() {
        _firstPin = pin;
        _confirming = true;
        _errorText = null;
      });
      return;
    }

    if (pin != _firstPin) {
      setState(() {
        _errorText = context.l10n.appPinMismatch;
        _confirming = false;
        _firstPin = null;
      });
      return;
    }

    await _service.setPin(pin, email: widget.quickUnlockEmail);
    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final title = _confirming
        ? context.l10n.confirmAppPin
        : (widget.mode == AppLockPinSetupMode.change
            ? context.l10n.changeAppPin
            : context.l10n.setUpAppPin);
    final subtitle = _confirming
        ? context.l10n.confirmPasscodeHint
        : context.l10n.createPasscodeHint(AppConstants.APP_LOCK_PIN_LENGTH);

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
        key: ValueKey<bool>(_confirming),
        title: title,
        subtitle: subtitle,
        errorText: _errorText,
        onCompleted: _onPinCompleted,
      ),
    );
  }
}
