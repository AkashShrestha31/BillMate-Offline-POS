import 'package:flutter/material.dart';
import 'package:hotel/src/features/settings/domain/shift_notification_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists opening / closing / activity reminder preferences on device.
class ShiftNotificationSettingsStorage {
  ShiftNotificationSettingsStorage._();

  static const _openingEnabledKey = 'shift_notification_opening_enabled';
  static const _closingEnabledKey = 'shift_notification_closing_enabled';
  static const _activityEnabledKey = 'shift_notification_activity_enabled';
  static const _openingHourKey = 'shift_notification_opening_hour';
  static const _openingMinuteKey = 'shift_notification_opening_minute';
  static const _closingHourKey = 'shift_notification_closing_hour';
  static const _closingMinuteKey = 'shift_notification_closing_minute';
  static const _activityHourKey = 'shift_notification_activity_hour';
  static const _activityMinuteKey = 'shift_notification_activity_minute';

  static Future<ShiftNotificationSettings> load() async {
    final prefs = await SharedPreferences.getInstance();
    return ShiftNotificationSettings(
      openingEnabled: prefs.getBool(_openingEnabledKey) ?? false,
      closingEnabled: prefs.getBool(_closingEnabledKey) ?? false,
      // Default on so daily users get nudged until they opt out.
      activityEnabled: prefs.getBool(_activityEnabledKey) ?? true,
      openingTime: TimeOfDay(
        hour: prefs.getInt(_openingHourKey) ??
            ShiftNotificationSettings.defaultOpeningTime.hour,
        minute: prefs.getInt(_openingMinuteKey) ??
            ShiftNotificationSettings.defaultOpeningTime.minute,
      ),
      closingTime: TimeOfDay(
        hour: prefs.getInt(_closingHourKey) ??
            ShiftNotificationSettings.defaultClosingTime.hour,
        minute: prefs.getInt(_closingMinuteKey) ??
            ShiftNotificationSettings.defaultClosingTime.minute,
      ),
      activityTime: TimeOfDay(
        hour: prefs.getInt(_activityHourKey) ??
            ShiftNotificationSettings.defaultActivityTime.hour,
        minute: prefs.getInt(_activityMinuteKey) ??
            ShiftNotificationSettings.defaultActivityTime.minute,
      ),
    );
  }

  static Future<void> save(ShiftNotificationSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_openingEnabledKey, settings.openingEnabled);
    await prefs.setBool(_closingEnabledKey, settings.closingEnabled);
    await prefs.setBool(_activityEnabledKey, settings.activityEnabled);
    await prefs.setInt(_openingHourKey, settings.openingTime.hour);
    await prefs.setInt(_openingMinuteKey, settings.openingTime.minute);
    await prefs.setInt(_closingHourKey, settings.closingTime.hour);
    await prefs.setInt(_closingMinuteKey, settings.closingTime.minute);
    await prefs.setInt(_activityHourKey, settings.activityTime.hour);
    await prefs.setInt(_activityMinuteKey, settings.activityTime.minute);
  }
}
