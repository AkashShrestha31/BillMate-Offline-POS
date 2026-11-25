import 'package:flutter/material.dart';

/// An extension on [BuildContext] to access theme properties more easily.
extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
}
