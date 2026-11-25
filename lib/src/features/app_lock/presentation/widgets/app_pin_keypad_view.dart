import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/constants/app_constants.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/features/app_lock/domain/app_lock_service.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

/// Passcode screen with dot indicators and a phone-style numeric keypad.
class AppPinKeypadView extends StatefulWidget {
  const AppPinKeypadView({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onCompleted,
    this.pinLength = AppConstants.APP_LOCK_PIN_LENGTH,
    this.errorText,
    this.enabled = true,
    this.showBiometric = false,
    this.biometricKind = AppLockBiometricKind.none,
    this.onBiometric,
    this.biometricLabel,
  });

  final String title;
  final String subtitle;
  final int pinLength;
  final ValueChanged<String> onCompleted;
  final String? errorText;
  final bool enabled;
  final bool showBiometric;
  final AppLockBiometricKind biometricKind;
  final VoidCallback? onBiometric;
  final String? biometricLabel;

  @override
  State<AppPinKeypadView> createState() => _AppPinKeypadViewState();
}

class _AppPinPalette {
  const _AppPinPalette({
    required this.background,
    required this.keyFill,
    required this.title,
    required this.subtitle,
    required this.dotEmpty,
    required this.dotFilled,
    required this.digit,
    required this.letters,
    required this.iconMuted,
    required this.shieldBackground,
  });

  factory _AppPinPalette.of(ColorScheme scheme) {
    final isDark = scheme.brightness == Brightness.dark;
    if (isDark) {
      return const _AppPinPalette(
        background: Color(0xFF000000),
        keyFill: Color(0xFF1C1C1E),
        title: Colors.white,
        subtitle: Color(0xFF8E8E93),
        dotEmpty: Color(0xFF48484A),
        dotFilled: Colors.white,
        digit: Colors.white,
        letters: Color(0x73FFFFFF),
        iconMuted: Color(0xD9FFFFFF),
        shieldBackground: Color(0xFF1C1C1E),
      );
    }

    return _AppPinPalette(
      background: scheme.surface,
      keyFill: const Color(0xFFE5E5EA),
      title: scheme.onSurface,
      subtitle: scheme.onSurfaceVariant,
      dotEmpty: scheme.outlineVariant,
      dotFilled: scheme.onSurface,
      digit: scheme.onSurface,
      letters: scheme.onSurfaceVariant.withValues(alpha: 0.85),
      iconMuted: scheme.onSurface.withValues(alpha: 0.72),
      shieldBackground: scheme.surfaceContainerHighest,
    );
  }

  final Color background;
  final Color keyFill;
  final Color title;
  final Color subtitle;
  final Color dotEmpty;
  final Color dotFilled;
  final Color digit;
  final Color letters;
  final Color iconMuted;
  final Color shieldBackground;
}

class _AppPinKeypadViewState extends State<AppPinKeypadView>
    with SingleTickerProviderStateMixin {
  static const _dialLetters = <String, String>{
    '2': 'ABC',
    '3': 'DEF',
    '4': 'GHI',
    '5': 'JKL',
    '6': 'MNO',
    '7': 'PQRS',
    '8': 'TUV',
    '9': 'WXYZ',
  };

  String _pin = '';
  late final AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
  }

  @override
  void didUpdateWidget(covariant AppPinKeypadView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.errorText != null &&
        widget.errorText != oldWidget.errorText &&
        _pin.isNotEmpty) {
      _clearPin(shake: true);
    }
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _clearPin({bool shake = false}) {
    setState(() => _pin = '');
    if (shake) {
      _shakeController.forward(from: 0);
      HapticFeedback.mediumImpact();
    }
  }

  void _appendDigit(String digit) {
    if (!widget.enabled || _pin.length >= widget.pinLength) return;
    HapticFeedback.selectionClick();
    setState(() => _pin += digit);
    if (_pin.length == widget.pinLength) {
      widget.onCompleted(_pin);
    }
  }

  void _backspace() {
    if (_pin.isEmpty) return;
    HapticFeedback.selectionClick();
    setState(() => _pin = _pin.substring(0, _pin.length - 1));
  }

  IconData _biometricIcon() {
    return switch (widget.biometricKind) {
      AppLockBiometricKind.face => Icons.face_rounded,
      AppLockBiometricKind.fingerprint => Icons.fingerprint_rounded,
      _ => Icons.lock_open_rounded,
    };
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.theme.colorScheme;
    final primary = scheme.primary;
    final palette = _AppPinPalette.of(scheme);

    return ColoredBox(
      color: palette.background,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 36.h),
            _ShieldBadge(
              color: primary,
              background: palette.shieldBackground,
            ),
            SizedBox(height: 28.h),
            Text(
              widget.title,
              style: AppFonts.interStyle(
                color: palette.title,
                fontSize: 26.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                widget.subtitle,
                textAlign: TextAlign.center,
                style: AppFonts.interStyle(
                  color: palette.subtitle,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            if (widget.errorText != null) ...[
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  widget.errorText!,
                  textAlign: TextAlign.center,
                  style: AppFonts.interStyle(
                    color: scheme.error,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
            SizedBox(height: 28.h),
            AnimatedBuilder(
              animation: _shakeController,
              builder: (context, child) {
                final t = _shakeController.value;
                final offset = t == 0 ? 0.0 : 8 * (1 - t) * (t < 0.5 ? 1 : -1);
                return Transform.translate(
                  offset: Offset(offset, 0),
                  child: child,
                );
              },
              child: _PinDots(
                length: widget.pinLength,
                filled: _pin.length,
                dotEmpty: palette.dotEmpty,
                dotFilled: palette.dotFilled,
              ),
            ),
            const Spacer(),
            _NumericKeypad(
              enabled: widget.enabled,
              palette: palette,
              primary: primary,
              showBiometric: widget.showBiometric,
              biometricIcon: _biometricIcon(),
              onDigit: _appendDigit,
              onBackspace: _backspace,
              onBiometric: widget.onBiometric,
            ),
            if (widget.showBiometric && widget.onBiometric != null) ...[
              SizedBox(height: 16.h),
              TextButton(
                onPressed: widget.enabled ? widget.onBiometric : null,
                child: Text(
                  widget.biometricLabel ?? context.l10n.useBiometricInstead,
                  style: AppFonts.interStyle(
                    color: primary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }
}

class _ShieldBadge extends StatelessWidget {
  const _ShieldBadge({
    required this.color,
    required this.background,
  });

  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72.w,
      height: 72.w,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.28),
            blurRadius: 28,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Icon(
        Icons.shield_outlined,
        color: color,
        size: 36.sp,
      ),
    );
  }
}

class _PinDots extends StatelessWidget {
  const _PinDots({
    required this.length,
    required this.filled,
    required this.dotEmpty,
    required this.dotFilled,
  });

  final int length;
  final int filled;
  final Color dotEmpty;
  final Color dotFilled;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        final isFilled = index < filled;
        return Container(
          width: 14.w,
          height: 14.w,
          margin: EdgeInsets.symmetric(horizontal: 8.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isFilled ? dotFilled : dotEmpty,
          ),
        );
      }),
    );
  }
}

class _NumericKeypad extends StatelessWidget {
  const _NumericKeypad({
    required this.enabled,
    required this.palette,
    required this.primary,
    required this.showBiometric,
    required this.biometricIcon,
    required this.onDigit,
    required this.onBackspace,
    this.onBiometric,
  });

  final bool enabled;
  final _AppPinPalette palette;
  final Color primary;
  final bool showBiometric;
  final IconData biometricIcon;
  final ValueChanged<String> onDigit;
  final VoidCallback onBackspace;
  final VoidCallback? onBiometric;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          _keyRow(['1', '2', '3']),
          SizedBox(height: 12.h),
          _keyRow(['4', '5', '6']),
          SizedBox(height: 12.h),
          _keyRow(['7', '8', '9']),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: showBiometric && onBiometric != null
                    ? _KeypadButton.icon(
                        enabled: enabled,
                        palette: palette,
                        icon: biometricIcon,
                        iconColor: primary,
                        onTap: onBiometric!,
                      )
                    : const SizedBox.shrink(),
              ),
              Expanded(
                child: _KeypadButton.digit(
                  enabled: enabled,
                  palette: palette,
                  digit: '0',
                  onTap: () => onDigit('0'),
                ),
              ),
              Expanded(
                child: _KeypadButton.icon(
                  enabled: enabled,
                  palette: palette,
                  icon: Icons.backspace_outlined,
                  iconColor: palette.iconMuted,
                  onTap: onBackspace,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _keyRow(List<String> digits) {
    return Row(
      children: digits
          .map(
            (digit) => Expanded(
              child: _KeypadButton.digit(
                enabled: enabled,
                palette: palette,
                digit: digit,
                letters: _AppPinKeypadViewState._dialLetters[digit],
                onTap: () => onDigit(digit),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _KeypadButton extends StatelessWidget {
  const _KeypadButton.digit({
    required this.enabled,
    required this.palette,
    required this.digit,
    required this.onTap,
    this.letters,
  })  : icon = null,
        iconColor = null;

  const _KeypadButton.icon({
    required this.enabled,
    required this.palette,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  })  : digit = null,
        letters = null;

  final bool enabled;
  final _AppPinPalette palette;
  final String? digit;
  final String? letters;
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6.w),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? onTap : null,
          customBorder: const CircleBorder(),
          splashColor: palette.digit.withValues(alpha: 0.08),
          highlightColor: palette.digit.withValues(alpha: 0.05),
          child: Ink(
            height: 72.w,
            decoration: BoxDecoration(
              color: palette.keyFill,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: icon != null
                  ? Icon(icon, color: iconColor, size: 28.sp)
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          digit!,
                          style: AppFonts.interStyle(
                            color: palette.digit,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w400,
                            height: 1,
                          ),
                        ),
                        if (letters != null) ...[
                          SizedBox(height: 2.h),
                          Text(
                            letters!,
                            style: AppFonts.interStyle(
                              color: palette.letters,
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                              height: 1,
                            ),
                          ),
                        ],
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Scaffold background that matches [AppPinKeypadView] for the current theme.
Color appPinScaffoldColor(BuildContext context) {
  return _AppPinPalette.of(context.theme.colorScheme).background;
}
