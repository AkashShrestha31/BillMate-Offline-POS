import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

/// Shows a "Done" bar above the keyboard on iOS when the number keypad is open.
/// The number keypad on iOS does not have a built-in Done button, so this provides
/// a way for users to dismiss the keyboard.
/// Hides when keyboard is dismissed (viewInsets.bottom == 0) or when no field has focus.
class KeyboardDoneBar extends StatefulWidget {
  const KeyboardDoneBar({super.key});

  @override
  State<KeyboardDoneBar> createState() => _KeyboardDoneBarState();
}

class _KeyboardDoneBarState extends State<KeyboardDoneBar> {
  @override
  void initState() {
    super.initState();
    FocusManager.instance.addListener(_onFocusOrInsetsChange);
  }

  @override
  void dispose() {
    FocusManager.instance.removeListener(_onFocusOrInsetsChange);
    super.dispose();
  }

  void _onFocusOrInsetsChange() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform != TargetPlatform.iOS) return const SizedBox.shrink();

    final viewInsets = MediaQuery.of(context).viewInsets;
    // Hide when keyboard is gone or when no field is focused (avoids bar stuck on screen)
    if (viewInsets.bottom <= 0) return const SizedBox.shrink();
    if (FocusManager.instance.primaryFocus == null) return const SizedBox.shrink();

    // Position the bar flush on top of the keyboard (no gap)
    const barHeight = 44.0;

    return Positioned(
      left: 0,
      right: 0,
      bottom: viewInsets.bottom,
      height: barHeight,
      child: Material(
        elevation: 1,
        color: Colors.grey[200],
        child: InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
          },
          child: Container(
            width: double.infinity,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              context.l10n.done,
              style: AppFonts.interStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.blue[600],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
