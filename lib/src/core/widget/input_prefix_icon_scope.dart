import 'package:flutter/material.dart';

/// Supplies the current prefix-icon color for fields such as [CustomTextFormField].
class InputPrefixIconScope extends InheritedWidget {
  const InputPrefixIconScope({
    super.key,
    required this.color,
    required super.child,
  });

  final Color color;

  static Color? maybeColorOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InputPrefixIconScope>()
        ?.color;
  }

  @override
  bool updateShouldNotify(InputPrefixIconScope oldWidget) {
    return color != oldWidget.color;
  }
}
