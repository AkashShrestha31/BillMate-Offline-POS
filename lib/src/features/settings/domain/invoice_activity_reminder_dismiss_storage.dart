import 'package:shared_preferences/shared_preferences.dart';

/// Tracks dismissals for sales/purchase activity reminders.
///
/// - [dismissForToday]: persists for the calendar day ("Skip for today").
/// - [dismissForSession]: in-memory only; clears when the process restarts
///   ("Cancel" / after opening add-record flow).
class InvoiceActivityReminderDismissStorage {
  InvoiceActivityReminderDismissStorage._();

  static const _dismissedDateKey = 'invoice_activity_reminder_dismissed_date';

  static bool _sessionDismissed = false;

  static String _todayYmd() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  static bool get isDismissedForSession => _sessionDismissed;

  static void dismissForSession() {
    _sessionDismissed = true;
  }

  static Future<bool> isDismissedForToday() async {
    if (_sessionDismissed) return true;
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_dismissedDateKey) == _todayYmd();
  }

  static Future<void> dismissForToday() async {
    _sessionDismissed = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_dismissedDateKey, _todayYmd());
  }
}
