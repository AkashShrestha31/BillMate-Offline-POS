import 'package:shared_preferences/shared_preferences.dart';

/// Tracks per-day "don't show again today" choices for shift reminders.
class ShiftReminderDismissStorage {
  ShiftReminderDismissStorage._();

  static const _openingDismissedDateKey = 'shift_reminder_opening_dismissed_date';
  static const _closingDismissedDateKey = 'shift_reminder_closing_dismissed_date';

  static String _todayYmd() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  static Future<bool> isOpeningDismissedForToday() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_openingDismissedDateKey) == _todayYmd();
  }

  static Future<bool> isClosingDismissedForToday() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_closingDismissedDateKey) == _todayYmd();
  }

  static Future<void> dismissOpeningForToday() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_openingDismissedDateKey, _todayYmd());
  }

  static Future<void> dismissClosingForToday() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_closingDismissedDateKey, _todayYmd());
  }
}
