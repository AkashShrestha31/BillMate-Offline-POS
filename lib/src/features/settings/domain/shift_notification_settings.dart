import 'package:flutter/material.dart';

/// User preferences for daily opening / closing / activity reminders.
class ShiftNotificationSettings {
  const ShiftNotificationSettings({
    required this.openingEnabled,
    required this.closingEnabled,
    required this.activityEnabled,
    required this.openingTime,
    required this.closingTime,
    required this.activityTime,
  });

  final bool openingEnabled;
  final bool closingEnabled;
  final bool activityEnabled;
  final TimeOfDay openingTime;
  final TimeOfDay closingTime;
  final TimeOfDay activityTime;

  static const TimeOfDay defaultOpeningTime = TimeOfDay(hour: 8, minute: 0);
  static const TimeOfDay defaultClosingTime = TimeOfDay(hour: 22, minute: 0);
  static const TimeOfDay defaultActivityTime = TimeOfDay(hour: 15, minute: 0);

  static const ShiftNotificationSettings defaults = ShiftNotificationSettings(
    openingEnabled: false,
    closingEnabled: false,
    activityEnabled: true,
    openingTime: defaultOpeningTime,
    closingTime: defaultClosingTime,
    activityTime: defaultActivityTime,
  );

  ShiftNotificationSettings copyWith({
    bool? openingEnabled,
    bool? closingEnabled,
    bool? activityEnabled,
    TimeOfDay? openingTime,
    TimeOfDay? closingTime,
    TimeOfDay? activityTime,
  }) {
    return ShiftNotificationSettings(
      openingEnabled: openingEnabled ?? this.openingEnabled,
      closingEnabled: closingEnabled ?? this.closingEnabled,
      activityEnabled: activityEnabled ?? this.activityEnabled,
      openingTime: openingTime ?? this.openingTime,
      closingTime: closingTime ?? this.closingTime,
      activityTime: activityTime ?? this.activityTime,
    );
  }

  String formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  String get openingTimeLabel => formatTime(openingTime);
  String get closingTimeLabel => formatTime(closingTime);
  String get activityTimeLabel => formatTime(activityTime);
}
