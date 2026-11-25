import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/l10n/app_localizations.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/features/backup/domain/auto_backup_coordinator.dart';
import 'package:hotel/src/features/backup/domain/models/backup_settings.dart';

class BackupAutoSettingsCard extends StatefulWidget {
  const BackupAutoSettingsCard({
    super.key,
    required this.coordinator,
    required this.isSignedIn,
    required this.onSettingsChanged,
  });

  final AutoBackupCoordinator coordinator;
  final bool isSignedIn;
  final VoidCallback onSettingsChanged;

  @override
  State<BackupAutoSettingsCard> createState() => _BackupAutoSettingsCardState();
}

class _BackupAutoSettingsCardState extends State<BackupAutoSettingsCard> {
  BackupSettings _settings = BackupSettings.defaults;
  AutoBackupRunResult? _lastAutoRun;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final settings = await widget.coordinator.loadSettings();
    final lastRun = await widget.coordinator.getLastAutoRun();
    if (!mounted) return;
    setState(() {
      _settings = settings;
      _lastAutoRun = lastRun;
      _loading = false;
    });
  }

  Future<void> _save(BackupSettings settings) async {
    HapticFeedback.selectionClick();
    await widget.coordinator.saveSettings(settings);
    if (!mounted) return;
    setState(() => _settings = settings);
    widget.onSettingsChanged();
  }

  Future<void> _pickFrequency(AppLocalizations l10n) async {
    final picked = await showModalBottomSheet<BackupFrequency>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (ctx) => _PickerSheet<BackupFrequency>(
        title: l10n.backupAutoFrequencyTitle,
        options: BackupFrequency.values,
        label: _frequencyLabel,
        selected: _settings.frequency,
      ),
    );
    if (picked == null || !mounted) return;
    await _save(_settings.copyWith(frequency: picked));
  }

  Future<void> _pickDirection(AppLocalizations l10n) async {
    final picked = await showModalBottomSheet<BackupSyncDirection>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (ctx) => _PickerSheet<BackupSyncDirection>(
        title: l10n.backupAutoSyncDirectionTitle,
        options: BackupSyncDirection.values,
        label: _directionLabel,
        selected: _settings.syncDirection,
      ),
    );
    if (picked == null || !mounted) return;
    await _save(_settings.copyWith(syncDirection: picked));
  }

  String _frequencyLabel(BackupFrequency value) {
    final l10n = AppLocalizations.of(context)!;
    return switch (value) {
      BackupFrequency.off => l10n.backupAutoFrequencyOff,
      BackupFrequency.daily => l10n.backupAutoFrequencyDaily,
      BackupFrequency.weekly => l10n.backupAutoFrequencyWeekly,
      BackupFrequency.monthly => l10n.backupAutoFrequencyMonthly,
    };
  }

  String _directionLabel(BackupSyncDirection value) {
    final l10n = AppLocalizations.of(context)!;
    return switch (value) {
      BackupSyncDirection.uploadOnly => l10n.backupAutoDirectionUpload,
      BackupSyncDirection.downloadOnly => l10n.backupAutoDirectionDownload,
      BackupSyncDirection.both => l10n.backupAutoDirectionBoth,
    };
  }

  String? _lastAutoRunLine(AppLocalizations l10n) {
    final run = _lastAutoRun;
    if (run == null) return null;
    final message = run.message?.trim();
    return switch (run.outcome) {
      AutoBackupOutcome.uploaded => l10n.backupAutoLastUploaded(message ?? ''),
      AutoBackupOutcome.downloaded => l10n.backupAutoLastDownloaded(message ?? ''),
      AutoBackupOutcome.failed => l10n.backupAutoLastFailed(message ?? ''),
      AutoBackupOutcome.skipped => message != null && message.isNotEmpty
          ? l10n.backupAutoLastSkipped(message)
          : null,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final enabled = widget.isSignedIn && !_loading;
    final lastLine = _lastAutoRunLine(l10n);

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12.sp),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              l10n.backupAutoSettingsTitle,
              style: AppFonts.interStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurfaceVariant,
                letterSpacing: 0.3,
              ),
            ),
          ),
          _SwitchTile(
            title: l10n.backupAutoBackupTitle,
            subtitle: l10n.backupAutoBackupHint,
            value: _settings.autoBackupEnabled,
            enabled: enabled,
            onChanged: (v) => _save(_settings.copyWith(autoBackupEnabled: v)),
          ),
          const Divider(height: 1, indent: 16),
          _SwitchTile(
            title: l10n.backupWifiOnlyTitle,
            subtitle: l10n.backupWifiOnlyHint,
            value: _settings.wifiOnly,
            enabled: enabled,
            onChanged: (v) => _save(_settings.copyWith(wifiOnly: v)),
          ),
          const Divider(height: 1, indent: 16),
          _OptionTile(
            title: l10n.backupAutoFrequencyTitle,
            value: _frequencyLabel(_settings.frequency),
            enabled: enabled && _settings.autoBackupEnabled,
            onTap: () => _pickFrequency(l10n),
          ),
          const Divider(height: 1, indent: 16),
          _OptionTile(
            title: l10n.backupAutoSyncDirectionTitle,
            value: _directionLabel(_settings.syncDirection),
            enabled: enabled && _settings.autoBackupEnabled,
            onTap: () => _pickDirection(l10n),
          ),
          if (lastLine != null) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
              child: Text(
                lastLine,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.enabled,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final bool enabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Opacity(
      opacity: enabled ? 1 : 0.45,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Text(
          title,
          style: AppFonts.interStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: AppFonts.interStyle(
            fontSize: 12,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        trailing: Transform.scale(
          scale: 0.82,
          alignment: Alignment.centerRight,
          child: Switch(
            value: value,
            onChanged: enabled ? onChanged : null,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.title,
    required this.value,
    required this.enabled,
    required this.onTap,
  });

  final String title;
  final String value;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Opacity(
      opacity: enabled ? 1 : 0.45,
      child: ListTile(
        title: Text(
          title,
          style: AppFonts.interStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: AppFonts.interStyle(
                fontSize: 14,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.chevron_right_rounded, color: colorScheme.outline),
          ],
        ),
        onTap: enabled
            ? () {
                HapticFeedback.selectionClick();
                onTap();
              }
            : null,
      ),
    );
  }
}

class _PickerSheet<T> extends StatelessWidget {
  const _PickerSheet({
    required this.title,
    required this.options,
    required this.label,
    required this.selected,
  });

  final String title;
  final List<T> options;
  final String Function(T) label;
  final T selected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: AppFonts.interStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          ...options.map(
            (option) => ListTile(
              title: Text(
                label(option),
                style: AppFonts.interStyle(color: colorScheme.onSurface),
              ),
              trailing: option == selected
                  ? Icon(
                      Icons.check_rounded,
                      color: colorScheme.primary,
                    )
                  : null,
              onTap: () => Navigator.pop(context, option),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
