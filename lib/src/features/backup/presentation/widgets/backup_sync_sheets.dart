import 'package:flutter/material.dart';
import 'package:hotel/l10n/app_localizations.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';

import 'package:hotel/src/features/backup/domain/google_drive_backup_service.dart';

Future<bool> showBackupSignOutSheet({
  required BuildContext context,
  required AppLocalizations l10n,
}) {
  return showAppBottomSheet<bool>(
    context: context,
    title: l10n.googleDriveSignOut,
    shrinkWrap: true,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            l10n.backupSyncSignOutConfirm,
            style: AppFonts.interStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: CustomButtonWidget.outlined(
                onPressed: () => Navigator.pop(context, false),
                title: l10n.cancel,
                width: double.infinity,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomButtonWidget(
                onPressed: () => Navigator.pop(context, true),
                title: l10n.googleDriveSignOut,
                width: double.infinity,
              ),
            ),
          ],
        ),
      ],
    ),
  ).then((value) => value == true);
}

Future<GoogleDriveBackupResult?> showBackupProgressSheet({
  required BuildContext context,
  required AppLocalizations l10n,
  required String Function(String step) humanizeStep,
  required Future<GoogleDriveBackupResult> Function(
    void Function(String step, double progress) onProgress,
  ) runBackup,
}) async {
  final result = await showAppBottomSheet<Object?>(
    context: context,
    title: l10n.backupSyncInProgress,
    shrinkWrap: true,
    isDismissible: false,
    enableDrag: false,
    showCloseButton: false,
    child: _BackupProgressContent(
      l10n: l10n,
      humanizeStep: humanizeStep,
      runBackup: runBackup,
    ),
  );

  if (result != null && result is! GoogleDriveBackupResult) {
    throw result;
  }
  return result as GoogleDriveBackupResult?;
}

class _BackupProgressContent extends StatefulWidget {
  const _BackupProgressContent({
    required this.l10n,
    required this.humanizeStep,
    required this.runBackup,
  });

  final AppLocalizations l10n;
  final String Function(String step) humanizeStep;
  final Future<GoogleDriveBackupResult> Function(
    void Function(String step, double progress) onProgress,
  ) runBackup;

  @override
  State<_BackupProgressContent> createState() => _BackupProgressContentState();
}

class _BackupProgressContentState extends State<_BackupProgressContent> {
  String _step = '';
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    _step = widget.l10n.googleDriveBackupStarting;
    WidgetsBinding.instance.addPostFrameCallback((_) => _startBackup());
  }

  Future<void> _startBackup() async {
    try {
      final result = await widget.runBackup((step, progress) {
        if (!mounted) return;
        setState(() {
          _step = widget.humanizeStep(step);
          _progress = progress;
        });
      });
      if (mounted) Navigator.pop(context, result);
    } catch (error) {
      if (mounted) Navigator.pop(context, error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final percent = (_progress * 100).clamp(0, 100).round();
    final primary = Theme.of(context).colorScheme.primary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                _step,
                style: AppFonts.interStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              widget.l10n.backupSyncProgressPercent(percent),
              style: AppFonts.interStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            minHeight: 8,
            value: _progress > 0 ? _progress : null,
            backgroundColor: primary.withValues(alpha: 0.12),
            color: primary,
          ),
        ),
      ],
    );
  }
}
