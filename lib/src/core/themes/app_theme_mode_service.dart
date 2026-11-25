import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists and applies the app [ThemeMode] (system / light / dark).
@lazySingleton
class AppThemeModeService extends ChangeNotifier {
  static const _prefKey = 'app_theme_mode_v1';

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  bool get followsSystemTheme => _themeMode == ThemeMode.system;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _themeMode = _parse(prefs.getString(_prefKey)) ?? ThemeMode.system;
    notifyListeners();
  }

  Future<void> setDarkMode(bool enabled) async {
    await setThemeMode(enabled ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (mode == _themeMode) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, _encode(mode));

    _themeMode = mode;
    notifyListeners();
  }

  static ThemeMode? _parse(String? raw) {
    switch (raw) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      case 'system':
        return ThemeMode.system;
      default:
        return null;
    }
  }

  static String _encode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
      case ThemeMode.light:
        return 'light';
    }
  }
}
