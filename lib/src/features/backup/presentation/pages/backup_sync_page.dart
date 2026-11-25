import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/l10n/app_localizations.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:hotel/src/features/backup/domain/auto_backup_coordinator.dart';
import 'package:hotel/src/features/backup/domain/google_drive_backup_service.dart';
import 'package:hotel/src/features/backup/domain/models/drive_last_sync_info.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/features/backup/presentation/widgets/backup_auto_settings_card.dart';
import 'package:hotel/src/features/backup/presentation/widgets/backup_sync_sheets.dart';
import 'package:hotel/src/features/backup/presentation/widgets/restore_from_drive_sheet.dart';
import 'package:intl/intl.dart';

class BackupSyncPage extends StatefulWidget {
  const BackupSyncPage({super.key});

  @override
  State<BackupSyncPage> createState() => _BackupSyncPageState();
}

class _BackupSyncPageState extends State<BackupSyncPage>
    with SingleTickerProviderStateMixin {
  final _backupService = getIt<GoogleDriveBackupService>();
  final _autoBackup = getIt<AutoBackupCoordinator>();

  late final AnimationController _syncSpinController;

  bool _loading = true;
  bool _refreshing = false;
  bool _working = false;
  DriveLastSyncInfo? _syncInfo;
  String? _activeOrgName;

  @override
  void initState() {
    super.initState();
    _syncSpinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _refresh();
  }

  @override
  void dispose() {
    _syncSpinController.dispose();
    super.dispose();
  }

  void _setSpinning(bool active) {
    if (active) {
      if (!_syncSpinController.isAnimating) {
        _syncSpinController.repeat();
      }
    } else {
      _syncSpinController.stop();
      _syncSpinController.reset();
    }
  }

  Future<void> _refresh() async {
    if (_refreshing) return;
    setState(() => _refreshing = true);
    _setSpinning(true);

    final syncInfo = await _backupService.loadSyncInfo();
    final orgName = await OrgStorage.getOrgName();

    if (!mounted) return;
    setState(() {
      _syncInfo = syncInfo;
      _activeOrgName = orgName;
      _loading = false;
      _refreshing = false;
    });
    if (!_working) _setSpinning(false);
  }

  Future<void> _signIn() async {
    setState(() => _working = true);
    _setSpinning(true);
    try {
      await _backupService.signIn();
      await _refresh();
      if (!mounted) return;
      context.showKiiSnackBarSuccess(context.l10n.googleDriveSignInSuccess);
    } catch (e) {
      if (!mounted) return;
      context.showKiiSnackBarError(_errorMessage(e));
    } finally {
      if (mounted) {
        setState(() => _working = false);
        _setSpinning(false);
      }
    }
  }

  Future<void> _signOut() async {
    final confirmed = await showBackupSignOutSheet(
      context: context,
      l10n: context.l10n,
    );
    if (!confirmed || !mounted) return;

    setState(() => _working = true);
    try {
      await _backupService.signOut();
      await _refresh();
      if (!mounted) return;
      context.showKiiSnackBarSuccess(context.l10n.googleDriveSignOutSuccess);
    } catch (e) {
      if (!mounted) return;
      context.showKiiSnackBarError(_errorMessage(e));
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }

  Future<void> _restoreFromDrive() async {
    if (_working) return;
    HapticFeedback.selectionClick();
    final restored = await RestoreFromDriveSheet.show(context);
    if (!mounted || restored == null) return;
    await _refresh();
    if (!mounted) return;
    context.showKiiSnackBarSuccess(
      context.l10n.restoreFromGoogleDriveSuccess(
        restored.orgName.trim().isNotEmpty
            ? restored.orgName
            : context.l10n.backupSyncUnknownOrganization,
      ),
    );
  }

  Future<void> _backupNow() async {
    if (_working) return;

    final settings = await _autoBackup.loadSettings();
    final wifiBlock = await _autoBackup.wifiGateMessage(settings);
    if (wifiBlock != null && mounted) {
      final bypass = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(context.l10n.backupWifiOnlyTitle),
          content: Text(wifiBlock),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(context.l10n.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(context.l10n.backupWifiOnlyContinue),
            ),
          ],
        ),
      );
      if (bypass != true || !mounted) return;
    }

    HapticFeedback.lightImpact();
    setState(() => _working = true);
    _setSpinning(true);

    try {
      final result = await showBackupProgressSheet(
        context: context,
        l10n: context.l10n,
        humanizeStep: _humanizeStep,
        runBackup: (onProgress) => _backupService.backupActiveOrganization(
          onProgress: onProgress,
        ),
      );

      await _refresh();
      if (!mounted || result == null) return;
      HapticFeedback.mediumImpact();
      if (result.skipped) {
        context.showKiiSnackBarSuccess(
          'Already up to date — no new changes to back up.',
        );
      } else if (result.incremental) {
        context.showKiiSnackBarSuccess(
          'Incremental backup: ${result.recordCount} change(s) in '
          '${result.tableCount} table(s) synced.',
        );
      } else {
        context.showKiiSnackBarSuccess(context.l10n.backupSyncCompletedHint);
      }
    } catch (e) {
      await _refresh();
      if (!mounted) return;
      context.showKiiSnackBarError(_errorMessage(e));
    } finally {
      if (mounted) {
        setState(() => _working = false);
        _setSpinning(false);
      }
    }
  }

  String _humanizeStep(String step) {
    if (step == 'export') return context.l10n.backupSyncStepExport;
    if (step == 'up_to_date') return 'No new changes';
    if (step == 'download') return 'Downloading existing backup';
    if (step == 'merge') return 'Merging changes';
    if (step == 'meta' || step == 'done') return 'Finishing';
    if (step.endsWith('.json') || step.endsWith('.json.gz')) {
      return context.l10n.backupSyncStepUploadFile(step);
    }
    return context.l10n.backupSyncStepUploadTable(step);
  }

  String _errorMessage(Object error) {
    if (error is MissingPluginException) {
      return context.l10n.googleDriveBackupPluginError;
    }
    final raw = error.toString();
    if (raw.contains('cancelled') || raw.contains('canceled')) {
      return context.l10n.googleDriveSignInCancelled;
    }
    if (raw.contains('MissingPluginException')) {
      return context.l10n.googleDriveBackupPluginError;
    }
    return context.l10n.googleDriveBackupFailed(raw);
  }

  String _formatDateTime(DateTime value) =>
      DateFormat.yMMMd().add_jm().format(value.toLocal());

  String _orgLabel(AppLocalizations l10n) {
    final name = _activeOrgName?.trim();
    if (name != null && name.isNotEmpty) return name;
    return l10n.backupSyncUnknownOrganization;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;
    final syncInfo = _syncInfo;
    final isSignedIn = syncInfo?.isSignedIn == true;
    final isBusy = _working || _refreshing;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        title: Text(
          l10n.backupSyncPageTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(12, 16, 12, 24),
                children: [
                  _StatusHero(
                    orgName: _orgLabel(l10n),
                    syncInfo: syncInfo,
                    isSignedIn: isSignedIn,
                    isBusy: isBusy,
                    isWorking: _working,
                    spinController: _syncSpinController,
                    formatDateTime: _formatDateTime,
                    onTap: isBusy ? null : _refresh,
                  ),
                  const SizedBox(height: 16),
                  BackupAutoSettingsCard(
                    coordinator: _autoBackup,
                    isSignedIn: isSignedIn,
                    onSettingsChanged: _refresh,
                  ),
                  const SizedBox(height: 16),
                  _ActionsCard(
                    isSignedIn: isSignedIn,
                    isBusy: isBusy,
                    accountEmail: syncInfo?.accountEmail,
                    onBackup: _backupNow,
                    onRestore: _restoreFromDrive,
                    onSignIn: _signIn,
                    onSignOut: _signOut,
                  ),
                ],
              ),
            ),
    );
  }
}

class _StatusHero extends StatelessWidget {
  const _StatusHero({
    required this.orgName,
    required this.syncInfo,
    required this.isSignedIn,
    required this.isBusy,
    required this.isWorking,
    required this.spinController,
    required this.formatDateTime,
    required this.onTap,
  });

  final String orgName;
  final DriveLastSyncInfo? syncInfo;
  final bool isSignedIn;
  final bool isBusy;
  final bool isWorking;
  final AnimationController spinController;
  final String Function(DateTime) formatDateTime;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;
    final info = syncInfo;
    final pendingChanges = info?.pendingChanges;
    final primary = colorScheme.primary;
    final hasSynced = info?.hasSynced == true;
    final statusColor = !isSignedIn
        ? colorScheme.onSurfaceVariant
        : (hasSynced ? Colors.green : Colors.orange);

    return Material(
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(12.sp),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      RotationTransition(
                        turns: spinController,
                        child: Icon(
                          Icons.cloud_sync_rounded,
                          size: 40,
                          color: primary,
                        ),
                      ),
                      Positioned(
                        right: -2,
                        bottom: -2,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: statusColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: colorScheme.surface, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orgName,
                          style: AppFonts.interStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _statusLine(l10n, info),
                          style: AppFonts.interStyle(
                            fontSize: 14,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        if (isSignedIn && info?.accountEmail != null) ...[
                          const SizedBox(height: 6),
                          Text(
                            l10n.googleDriveBackupSubtitleSignedIn(
                              info!.accountEmail!,
                            ),
                            style: AppFonts.interStyle(
                              fontSize: 12,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                        if (isSignedIn && hasSynced && pendingChanges != null) ...[
                          const SizedBox(height: 6),
                          Text(
                            pendingChanges == 0
                                ? 'Pending changes: none (incremental backup ready)'
                                : 'Pending changes: $pendingChanges row(s)',
                            style: AppFonts.interStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: pendingChanges == 0
                                  ? Colors.green.shade400
                                  : Colors.orange.shade400,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (!isBusy)
                    Icon(
                      Icons.refresh_rounded,
                      size: 20,
                      color: colorScheme.outline,
                    ),
                ],
              ),
              if (isWorking) ...[
                const SizedBox(height: 12),
                Text(
                  l10n.backupSyncInProgress,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: primary,
                  ),
                ),
              ],
              if (info?.lastError != null &&
                  info!.lastError!.isNotEmpty &&
                  !isWorking) ...[
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.errorContainer.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        size: 18,
                        color: theme.colorScheme.error,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          l10n.backupSyncLastError(info!.lastError!),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _statusLine(AppLocalizations l10n, DriveLastSyncInfo? info) {
    if (!isSignedIn) return l10n.backupSyncSignInHint;
    if (info?.hasSynced == true && info?.syncedAt != null) {
      return l10n.googleDriveLastBackup(formatDateTime(info!.syncedAt!));
    }
    return l10n.backupSyncNeverSynced;
  }
}

class _ActionsCard extends StatelessWidget {
  const _ActionsCard({
    required this.isSignedIn,
    required this.isBusy,
    required this.accountEmail,
    required this.onBackup,
    required this.onRestore,
    required this.onSignIn,
    required this.onSignOut,
  });

  final bool isSignedIn;
  final bool isBusy;
  final String? accountEmail;
  final VoidCallback onBackup;
  final VoidCallback onRestore;
  final VoidCallback onSignIn;
  final VoidCallback onSignOut;

  bool get _actionsEnabled => isSignedIn && !isBusy;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final primary = colorScheme.primary;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12.sp),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _ActionTile(
            icon: Icons.cloud_upload_outlined,
            iconColor: primary,
            title: l10n.googleDriveBackupNow,
            subtitle: l10n.backupSyncActiveOrganizationHint,
            onTap: _actionsEnabled ? onBackup : null,
            showChevron: true,
          ),
          const Divider(height: 1, indent: 56),
          _ActionTile(
            icon: Icons.restore_rounded,
            iconColor: Theme.of(context).colorScheme.secondary,
            title: l10n.restoreFromGoogleDrive,
            subtitle: l10n.restoreFromGoogleDriveHint,
            onTap: _actionsEnabled ? onRestore : null,
            showChevron: true,
          ),
          if (isSignedIn) ...[
            const Divider(height: 1, indent: 56),
            _ActionTile(
              icon: Icons.logout_rounded,
              iconColor: colorScheme.onSurfaceVariant,
              title: l10n.googleDriveSignOut,
              subtitle: accountEmail ?? l10n.backupSyncGoogleAccount,
              onTap: isBusy ? null : onSignOut,
              showChevron: false,
            ),
          ] else ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: CustomButtonWidget(
                onPressed: isBusy ? null : onSignIn,
                title: l10n.googleDriveSignIn,
                width: double.infinity,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.showChevron,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final enabled = onTap != null;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap == null
            ? null
            : () {
                HapticFeedback.selectionClick();
                onTap!();
              },
        child: Opacity(
          opacity: enabled ? 1 : 0.45,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: iconColor, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppFonts.interStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: AppFonts.interStyle(
                          fontSize: 12,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (showChevron)
                  Icon(
                    Icons.chevron_right_rounded,
                    color: colorScheme.outline,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
