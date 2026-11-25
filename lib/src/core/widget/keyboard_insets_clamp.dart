import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

/// Stale [MediaQuery.viewInsets.bottom] after login/setup leaves a white gap on
/// the dashboard. Only pass keyboard insets through while a text field has focus.
class KeyboardInsetsClamp extends StatefulWidget {
  const KeyboardInsetsClamp({super.key, required this.child});

  final Widget child;

  @override
  State<KeyboardInsetsClamp> createState() => _KeyboardInsetsClampState();
}

class _KeyboardInsetsClampState extends State<KeyboardInsetsClamp>
    with WidgetsBindingObserver {
  static final KeyboardVisibilityController _keyboard =
      KeyboardVisibilityController();

  StreamSubscription<bool>? _keyboardSub;
  bool _rebuildScheduled = false;

  @override
  void initState() {
    super.initState();
    _keyboardSub = _keyboard.onChange.listen((_) => _scheduleRebuild());
    FocusManager.instance.addListener(_onFocusChanged);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _keyboardSub?.cancel();
    FocusManager.instance.removeListener(_onFocusChanged);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _onFocusChanged() => _scheduleRebuild();

  void _scheduleRebuild() {
    if (!mounted || _rebuildScheduled) return;
    _rebuildScheduled = true;

    final phase = SchedulerBinding.instance.schedulerPhase;
    if (phase == SchedulerPhase.idle ||
        phase == SchedulerPhase.postFrameCallbacks) {
      _rebuildScheduled = false;
      setState(() {});
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _rebuildScheduled = false;
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void didChangeMetrics() => _scheduleRebuild();

  static bool _textFieldHasFocus() {
    final node = FocusManager.instance.primaryFocus;
    if (node == null || !node.hasFocus) return false;
    final ctx = node.context;
    if (ctx == null) return false;
    return ctx.findAncestorWidgetOfExactType<EditableText>() != null;
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final bottom = _textFieldHasFocus() ? mq.viewInsets.bottom : 0.0;
    return MediaQuery(
      data: mq.copyWith(
        viewInsets: mq.viewInsets.copyWith(bottom: bottom),
      ),
      child: widget.child,
    );
  }
}
