import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:hotel/src/core/services/notifications/shift_notification_background.dart';
import 'package:hotel/src/features/opening/presentation/helpers/shift_opening_dialog_helper.dart';
import 'package:hotel/src/features/settings/domain/invoice_activity_reminder_copy.dart';
import 'package:hotel/src/features/settings/domain/shift_notification_settings.dart';
import 'package:hotel/src/features/settings/domain/shift_notification_settings_storage.dart';
import 'package:hotel/src/features/settings/domain/shift_reminder_copy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Schedules daily local notifications for opening, closing, and activity reminders.
class ShiftNotificationService {
  ShiftNotificationService();

  static const int openingNotificationId = 1001;
  static const int closingNotificationId = 1002;
  static const int activityNotificationId = 1003;
  static const String androidChannelId = 'shift_reminders';
  static const String androidChannelName = 'Shift reminders';

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;
  String? _pendingLaunchPayload;
  String? _recentlyHandledPayload;
  DateTime? _recentlyHandledAt;
  DateTime? _suppressMonitorUntil;
  bool _tapInFlight = false;

  static const _tapDedupWindow = Duration(seconds: 5);
  static const _monitorSuppressWindow = Duration(seconds: 20);

  Future<void> initialize() async {
    if (_initialized) return;

    const androidSettings = AndroidInitializationSettings('ic_stat_notification');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    await _plugin.initialize(
      const InitializationSettings(android: androidSettings, iOS: iosSettings),
      onDidReceiveNotificationResponse: _onNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: shiftNotificationTapBackground,
    );

    if (Platform.isAndroid) {
      final androidPlugin =
          _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      await androidPlugin?.createNotificationChannel(
        const AndroidNotificationChannel(
          androidChannelId,
          androidChannelName,
          description: 'Daily reminders to open or close the cash register',
          importance: Importance.high,
          playSound: true,
          enableVibration: true,
        ),
      );
    }

    await _configureLocalTimeZone();
    _initialized = true;

    final launchDetails = await _plugin.getNotificationAppLaunchDetails();
    if (launchDetails?.didNotificationLaunchApp ?? false) {
      _pendingLaunchPayload = launchDetails?.notificationResponse?.payload;
    }

    _pendingLaunchPayload ??= await _readBackgroundTapPayload();

    await rescheduleFromStorage();
  }

  /// Call after the first app frame so the router has a valid context.
  Future<void> handlePendingLaunchAction() async {
    var payload = _pendingLaunchPayload;
    _pendingLaunchPayload = null;
    payload ??= await _readBackgroundTapPayload();
    await onNotificationTapped(payload);
  }

  /// Single entry for notification taps — dedupes cold start + foreground callbacks.
  Future<void> onNotificationTapped(String? payload) async {
    if (payload == null || payload.isEmpty) return;
    if (_tapInFlight) return;

    final now = DateTime.now();
    if (_recentlyHandledPayload == payload &&
        _recentlyHandledAt != null &&
        now.difference(_recentlyHandledAt!) < _tapDedupWindow) {
      return;
    }

    _tapInFlight = true;
    _recentlyHandledPayload = payload;
    _recentlyHandledAt = now;
    _suppressMonitorUntil = now.add(_monitorSuppressWindow);
    _pendingLaunchPayload = null;

    try {
      await ShiftOpeningDialogHelper.handlePayload(payload);
    } finally {
      _tapInFlight = false;
    }
  }

  /// Prevents the in-app monitor from showing a second dialog after a notification tap.
  bool shouldSuppressMonitorPrompt() {
    final until = _suppressMonitorUntil;
    return until != null && DateTime.now().isBefore(until);
  }

  Future<bool> ensurePermission() async {
    final granted = await requestNotificationPermissionIfNeeded();
    if (!granted) return false;

    return _ensureAndroidExactAlarmPermission();
  }

  /// Requests the platform notification permission only when it is missing.
  ///
  /// This intentionally excludes Android's exact-alarm permission, which is
  /// requested separately only when reminder scheduling needs it.
  Future<bool> requestNotificationPermissionIfNeeded() async {
    if (!_initialized) await initialize();

    if (Platform.isIOS) {
      final ios = _plugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
      final current = await ios?.checkPermissions();
      if (current?.isEnabled ?? false) return true;

      final granted = await ios?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
          false;
      return granted;
    }

    final status = await Permission.notification.status;
    if (status.isGranted) return true;
    if (status.isPermanentlyDenied || status.isRestricted) return false;

    final requested = await Permission.notification.request();
    return requested.isGranted;
  }

  Future<bool> _hasNotificationPermission() async {
    if (Platform.isIOS) {
      final ios = _plugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
      final settings = await ios?.checkPermissions();
      return settings?.isEnabled ?? false;
    }
    final status = await Permission.notification.status;
    return status.isGranted;
  }

  Future<bool> _ensureAndroidExactAlarmPermission() async {
    if (!Platform.isAndroid) return true;

    final android =
        _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (android == null) return true;

    final canExact = await android.canScheduleExactNotifications();
    if (canExact != false) return true;

    await android.requestExactAlarmsPermission();
    final afterRequest = await android.canScheduleExactNotifications();
    return afterRequest != false;
  }

  Future<void> rescheduleFromStorage() async {
    final settings = await ShiftNotificationSettingsStorage.load();
    if (!settings.openingEnabled &&
        !settings.closingEnabled &&
        !settings.activityEnabled) {
      await _cancelAllScheduled();
      return;
    }
    if (!await _hasNotificationPermission()) {
      log('ShiftNotificationService: reminders enabled but notification permission missing');
      return;
    }
    await applySettings(settings, persist: false);
  }

  Future<void> applySettings(
    ShiftNotificationSettings settings, {
    bool persist = true,
  }) async {
    if (persist) {
      await ShiftNotificationSettingsStorage.save(settings);
    }

    await _cancelAllScheduled();

    if (!_initialized) await initialize();

    if (!settings.openingEnabled &&
        !settings.closingEnabled &&
        !settings.activityEnabled) {
      return;
    }

    if (!await _hasNotificationPermission()) {
      log('ShiftNotificationService: skipping schedule — no notification permission');
      return;
    }

    if (Platform.isAndroid) {
      await _ensureAndroidExactAlarmPermission();
    }

    if (settings.openingEnabled) {
      await _scheduleDaily(
        id: openingNotificationId,
        title: ShiftReminderCopy.openingNotificationTitle,
        body: ShiftReminderCopy.openingNotificationBody,
        time: settings.openingTime,
        payload: ShiftNotificationPayload.opening,
      );
    }

    if (settings.closingEnabled) {
      await _scheduleDaily(
        id: closingNotificationId,
        title: ShiftReminderCopy.closingNotificationTitle,
        body: ShiftReminderCopy.closingNotificationBody,
        time: settings.closingTime,
        payload: ShiftNotificationPayload.closing,
      );
    }

    if (settings.activityEnabled) {
      await _scheduleDaily(
        id: activityNotificationId,
        title: InvoiceActivityReminderCopy.notificationTitle,
        body: InvoiceActivityReminderCopy.notificationBody,
        time: settings.activityTime,
        payload: ShiftNotificationPayload.activity,
      );
    }

    await _logPendingSchedules();
  }

  Future<void> _cancelAllScheduled() async {
    try {
      await _plugin.cancel(openingNotificationId);
      await _plugin.cancel(closingNotificationId);
      await _plugin.cancel(activityNotificationId);
    } on PlatformException catch (e, st) {
      log('ShiftNotificationService: cancel failed (${e.message}) — $st');
    }
  }

  Future<void> _scheduleDaily({
    required int id,
    required String title,
    required String body,
    required TimeOfDay time,
    required String payload,
  }) async {
    final scheduled = _nextInstanceOf(time);
    final scheduleMode = await _resolveAndroidScheduleMode();

    const androidDetails = AndroidNotificationDetails(
      androidChannelId,
      androidChannelName,
      channelDescription: 'Daily reminders to open or close the cash register',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      visibility: NotificationVisibility.public,
      category: AndroidNotificationCategory.reminder,
      icon: 'ic_stat_notification',
      color: Color(0xFF14A05F),
    );
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    const details = NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      scheduled,
      details,
      androidScheduleMode: scheduleMode,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: payload,
    );

    log('ShiftNotificationService: scheduled id=$id at $scheduled mode=$scheduleMode');
  }

  Future<AndroidScheduleMode> _resolveAndroidScheduleMode() async {
    if (!Platform.isAndroid) return AndroidScheduleMode.exactAllowWhileIdle;

    final android =
        _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    final canExact = await android?.canScheduleExactNotifications();
    if (canExact == true) {
      return AndroidScheduleMode.exactAllowWhileIdle;
    }
    return AndroidScheduleMode.inexactAllowWhileIdle;
  }

  tz.TZDateTime _nextInstanceOf(TimeOfDay time) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    try {
      final timeZoneName = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timeZoneName));
      log('ShiftNotificationService: timezone set to $timeZoneName');
    } catch (e) {
      log('ShiftNotificationService: timezone fallback — $e');
    }
  }

  Future<void> _logPendingSchedules() async {
    final pending = await _plugin.pendingNotificationRequests();
    log('ShiftNotificationService: ${pending.length} pending notification(s)');
    for (final item in pending) {
      log('  id=${item.id} title=${item.title} body=${item.body}');
    }
  }

  Future<String?> _readBackgroundTapPayload() async {
    final prefs = await SharedPreferences.getInstance();
    final payload = prefs.getString(shiftNotificationPendingTapPayloadKey);
    if (payload == null || payload.isEmpty) return null;
    await prefs.remove(shiftNotificationPendingTapPayloadKey);
    return payload;
  }

  void _onNotificationResponse(NotificationResponse response) {
    unawaited(onNotificationTapped(response.payload));
  }
}
