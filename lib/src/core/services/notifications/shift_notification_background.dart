import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists notification tap payload when the app process is not running.
@pragma('vm:entry-point')
void shiftNotificationTapBackground(NotificationResponse response) {
  final payload = response.payload;
  if (payload == null || payload.isEmpty) return;
  SharedPreferences.getInstance().then((prefs) {
    prefs.setString(_pendingTapPayloadKey, payload);
  });
}

const String shiftNotificationPendingTapPayloadKey = 'shift_notification_pending_tap_payload';

/// Internal alias for the background handler isolate.
const String _pendingTapPayloadKey = shiftNotificationPendingTapPayloadKey;
