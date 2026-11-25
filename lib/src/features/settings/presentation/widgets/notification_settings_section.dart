import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/services/notifications/shift_notification_service.dart';
import 'package:hotel/src/features/settings/domain/shift_notification_settings.dart';
import 'package:hotel/src/features/dashboard/presentation/widgets/more_settings_widgets.dart';
import 'package:hotel/src/features/settings/domain/shift_notification_settings_storage.dart';

/// More page: daily opening / closing shift reminder notifications.
class NotificationSettingsSection extends StatefulWidget {
  const NotificationSettingsSection({super.key, this.embedded = false});

  final bool embedded;

  @override
  State<NotificationSettingsSection> createState() => _NotificationSettingsSectionState();
}

class _NotificationSettingsSectionState extends State<NotificationSettingsSection> {
  ShiftNotificationSettings _settings = ShiftNotificationSettings.defaults;
  bool _loading = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final settings = await ShiftNotificationSettingsStorage.load();
    if (!mounted) return;
    setState(() {
      _settings = settings;
      _loading = false;
    });
  }

  Future<void> _persist(
    ShiftNotificationSettings updated, {
    bool showSavedMessage = true,
  }) async {
    setState(() {
      _settings = updated;
      _saving = true;
    });

    final service = getIt<ShiftNotificationService>();
    if (updated.openingEnabled ||
        updated.closingEnabled ||
        updated.activityEnabled) {
      final granted = await service.ensurePermission();
      if (!granted) {
        if (mounted) {
          context.showKiiSnackBarWarning(
            context.l10n.notificationPermissionHint,
          );
          await _load();
          setState(() => _saving = false);
        }
        return;
      }
    }

    await service.applySettings(updated);

    if (!mounted) return;
    setState(() => _saving = false);
    if (showSavedMessage) {
      context.showKiiSnackBarSuccess(context.l10n.notificationSettingsSaved);
    }
  }

  Widget _reminderSwitchTile({
    required BuildContext context,
    required ThemeData theme,
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool>? onChanged,
  }) {
    return ListTile(
      contentPadding: MoreSettingsLayout.tilePadding(context),
      leading: MoreIconBox(icon: icon),
      title: Text(title, style: MoreSettingsLayout.tileTitle(theme)),
      subtitle: Text(subtitle, style: MoreSettingsLayout.tileSubtitle(theme)),
      trailing: MoreSettingsSwitch(value: value, onChanged: onChanged),
      onTap: onChanged == null ? null : () => onChanged!(!value),
    );
  }

  Future<void> _pickTime({
    required TimeOfDay initial,
    required ValueChanged<TimeOfDay> onSelected,
  }) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
    );
    if (picked == null || !mounted) return;
    onSelected(picked);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const SizedBox.shrink();

    final theme = context.theme;

    final body = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _reminderSwitchTile(
          context: context,
          theme: theme,
          icon: Icons.wb_sunny_outlined,
          title: context.l10n.openingReminder,
          subtitle: context.l10n.dailyAtTime(_settings.openingTimeLabel),
          value: _settings.openingEnabled,
          onChanged: _saving
              ? null
              : (enabled) => _persist(_settings.copyWith(openingEnabled: enabled)),
        ),
        if (_settings.openingEnabled)
          ListTile(
            contentPadding: EdgeInsets.only(
              left: MoreSettingsLayout.dividerIndent(context),
              right: MoreSettingsLayout.sz(context, 16, 16.w),
            ),
            title: Text(
              context.l10n.openingTime,
              style: theme.textTheme.bodyMedium,
            ),
            trailing: Text(
              _settings.openingTimeLabel,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: _saving
                ? null
                : () => _pickTime(
                      initial: _settings.openingTime,
                      onSelected: (time) => _persist(
                        _settings.copyWith(openingTime: time),
                        showSavedMessage: false,
                      ),
                    ),
          ),
        const MoreSettingsDivider(),
        _reminderSwitchTile(
          context: context,
          theme: theme,
          icon: Icons.nightlight_round,
          title: context.l10n.closingReminder,
          subtitle: context.l10n.dailyAtTime(_settings.closingTimeLabel),
          value: _settings.closingEnabled,
          onChanged: _saving
              ? null
              : (enabled) => _persist(_settings.copyWith(closingEnabled: enabled)),
        ),
        if (_settings.closingEnabled)
          ListTile(
            contentPadding: EdgeInsets.only(
              left: MoreSettingsLayout.dividerIndent(context),
              right: MoreSettingsLayout.sz(context, 16, 16.w),
            ),
            title: Text(
              context.l10n.closingTime,
              style: theme.textTheme.bodyMedium,
            ),
            trailing: Text(
              _settings.closingTimeLabel,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: _saving
                ? null
                : () => _pickTime(
                      initial: _settings.closingTime,
                      onSelected: (time) => _persist(
                        _settings.copyWith(closingTime: time),
                        showSavedMessage: false,
                      ),
                    ),
          ),
        const MoreSettingsDivider(),
        _reminderSwitchTile(
          context: context,
          theme: theme,
          icon: Icons.receipt_long_outlined,
          title: context.l10n.activityReminder,
          subtitle: context.l10n.dailyAtTime(_settings.activityTimeLabel),
          value: _settings.activityEnabled,
          onChanged: _saving
              ? null
              : (enabled) =>
                  _persist(_settings.copyWith(activityEnabled: enabled)),
        ),
        if (_settings.activityEnabled)
          ListTile(
            contentPadding: EdgeInsets.only(
              left: MoreSettingsLayout.dividerIndent(context),
              right: MoreSettingsLayout.sz(context, 16, 16.w),
            ),
            title: Text(
              context.l10n.activityReminderTime,
              style: theme.textTheme.bodyMedium,
            ),
            trailing: Text(
              _settings.activityTimeLabel,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: _saving
                ? null
                : () => _pickTime(
                      initial: _settings.activityTime,
                      onSelected: (time) => _persist(
                        _settings.copyWith(activityTime: time),
                        showSavedMessage: false,
                      ),
                    ),
          ),
      ],
    );

    if (widget.embedded) return body;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w),
          child: Text(
            context.l10n.notifications,
            style: MoreSettingsLayout.sectionLabel(theme),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(8.sp),
          ),
          child: body,
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
