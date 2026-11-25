import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel/src/core/l10n/app_language_option.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists and applies the app UI language ([MaterialApp.locale]).
@lazySingleton
class AppLocaleService extends ChangeNotifier {
  static const _prefKey = 'app_ui_language_code_v1';
  static const _languagesAsset = 'assets/l10n/languages.json';

  String _languageCode = 'en';
  bool _hasSavedPreference = false;
  List<AppLanguageOption> _languages = const [
    AppLanguageOption(code: 'en', name: 'English', nativeName: 'English'),
  ];

  String get languageCode => _languageCode;
  bool get hasSavedPreference => _hasSavedPreference;
  Locale get locale => Locale(_languageCode);
  List<AppLanguageOption> get languages => List.unmodifiable(_languages);

  List<Locale> get supportedLocales =>
      _languages.map((l) => Locale(l.code)).toList();

  AppLanguageOption? get currentLanguage {
    for (final l in _languages) {
      if (l.code == _languageCode) return l;
    }
    return null;
  }

  Future<void> load() async {
    _languages = await _loadLanguagesFromAsset();
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_prefKey)?.trim();
    _hasSavedPreference = saved != null &&
        saved.isNotEmpty &&
        _languages.any((l) => l.code == saved);
    if (_hasSavedPreference) {
      _languageCode = saved!;
    } else {
      _languageCode = 'en';
    }
    notifyListeners();
  }

  /// Whether the user has explicitly chosen a UI language (SharedPreferences).
  static Future<bool> isPreferenceSaved() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_prefKey)?.trim();
    if (saved == null || saved.isEmpty) return false;
    final languages = await _loadLanguagesFromAsset();
    return languages.any((l) => l.code == saved);
  }

  /// Updates locale in memory only (first-run picker preview).
  void previewLanguage(String code) {
    final normalized = code.trim().toLowerCase();
    if (!_languages.any((l) => l.code == normalized)) return;
    if (normalized == _languageCode) return;
    _languageCode = normalized;
    notifyListeners();
  }

  Future<void> updateLanguage(String code) async {
    final normalized = code.trim().toLowerCase();
    if (!_languages.any((l) => l.code == normalized)) {
      throw ArgumentError('Unsupported language: $code');
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, normalized);

    // Preview may already match [normalized]; still persist first-run choice.
    if (normalized == _languageCode && _hasSavedPreference) return;

    _languageCode = normalized;
    _hasSavedPreference = true;
    notifyListeners();
  }

  static Future<List<AppLanguageOption>> _loadLanguagesFromAsset() async {
    try {
      final raw = await rootBundle.loadString(_languagesAsset);
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      final list = decoded['languages'] as List<dynamic>? ?? [];
      return list
          .map((e) {
            final m = Map<String, dynamic>.from(e as Map);
            return AppLanguageOption(
              code: (m['code'] as String).trim().toLowerCase(),
              name: m['name'] as String,
              nativeName: m['nativeName'] as String,
            );
          })
          .where((l) => l.code.isNotEmpty)
          .toList();
    } catch (_) {
      return const [
        AppLanguageOption(code: 'en', name: 'English', nativeName: 'English'),
      ];
    }
  }
}

