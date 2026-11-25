import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Clears focus and hides the soft keyboard (fixes stale [MediaQuery.viewInsets]).
Future<void> dismissKeyboard({Duration settleDelay = Duration.zero}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  await SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
  if (settleDelay > Duration.zero) {
    await Future<void>.delayed(settleDelay);
  }
}
