import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Clears stale iOS keyboard insets: [unfocus] alone is often not enough; the
/// engine keeps [MediaQuery.viewInsets] until the text input connection is closed.
class KeyboardResumeObserver extends StatefulWidget {
  const KeyboardResumeObserver({super.key, required this.child});

  final Widget child;

  @override
  State<KeyboardResumeObserver> createState() => _KeyboardResumeObserverState();
}

class _KeyboardResumeObserverState extends State<KeyboardResumeObserver>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _tearDownTextInput() {
    FocusManager.instance.primaryFocus?.unfocus();
    SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
  }

  void _iosTearDownOnResume() {
    if (defaultTargetPlatform != TargetPlatform.iOS) return;
    _tearDownTextInput();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _tearDownTextInput();
    });
    Future<void>.delayed(const Duration(milliseconds: 120), () {
      if (mounted) _tearDownTextInput();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (defaultTargetPlatform != TargetPlatform.iOS) return;

    switch (state) {
      /// Dismiss when fully backgrounded (avoids stale viewInsets on resume).
      case AppLifecycleState.paused:
        _tearDownTextInput();
        break;
      case AppLifecycleState.resumed:
        _iosTearDownOnResume();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.translucent,
      child: widget.child,
    );
  }
}
