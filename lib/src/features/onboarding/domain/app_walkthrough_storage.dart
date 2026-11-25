import 'package:shared_preferences/shared_preferences.dart';

/// Persists whether the pre-login feature walkthrough has been completed.
class AppWalkthroughStorage {
  AppWalkthroughStorage._();

  static const _completedKey = 'app_walkthrough_completed_v1';

  static Future<bool> shouldShow() async {
    final prefs = await SharedPreferences.getInstance();
    return !(prefs.getBool(_completedKey) ?? false);
  }

  static Future<void> markCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_completedKey, true);
  }
}
