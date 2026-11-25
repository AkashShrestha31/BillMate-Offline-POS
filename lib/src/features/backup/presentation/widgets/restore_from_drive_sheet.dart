import 'package:flutter/material.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/layout/device_layout.dart';
import 'package:hotel/src/core/themes/app_colors.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/features/backup/domain/google_drive_restore_service.dart';
import 'package:hotel/src/features/backup/domain/models/drive_org_backup_summary.dart';
import 'package:intl/intl.dart';

class RestoreFromDriveSheet extends StatefulWidget {
  const RestoreFromDriveSheet({super.key});

  static Future<GoogleDriveRestoreResult?> show(BuildContext context) {
    final isTablet = DeviceLayout.isTablet(context);

    if (isTablet) {
      return showDialog<GoogleDriveRestoreResult?>(
        context: context,
        barrierDismissible: true,
        builder: (_) => const RestoreFromDriveSheet(),
      );
    }

    return showModalBottomSheet<GoogleDriveRestoreResult?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const RestoreFromDriveSheet(),
    );
  }

  @override
  State<RestoreFromDriveSheet> createState() => _RestoreFromDriveSheetState();
}

class _RestoreFromDriveSheetState extends State<RestoreFromDriveSheet> {
  final _restoreService = getIt<GoogleDriveRestoreService>();

  bool _loading = true;
  bool _restoring = false;
  bool _needsSignIn = false;
  String? _error;
  List<DriveOrgBackupSummary> _backups = [];
  String? _progressStep;
  double _progress = 0;

  EdgeInsets _insets(bool isTablet, double h, double v) => EdgeInsets.symmetric(
        horizontal: isTablet ? h : h.w,
        vertical: isTablet ? v : v.h,
      );

  @override
  void initState() {
    super.initState();
    _loadBackups();
  }

  Future<void> _loadBackups() async {
    setState(() {
      _loading = true;
      _error = null;
      _needsSignIn = false;
    });
    try {
      if (!await _restoreService.hasSignedInAccount()) {
        if (!mounted) return;
        setState(() {
          _backups = [];
          _loading = false;
          _needsSignIn = true;
        });
        return;
      }
      final backups = await _restoreService.listAvailableBackupsIfSignedIn();
      if (!mounted) return;
      setState(() {
        _backups = backups;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = _message(e);
        _loading = false;
      });
    }
  }

  Future<void> _signInAndReload() async {
    try {
      await _restoreService.signIn();
      await _loadBackups();
    } catch (e) {
      if (!mounted) return;
      context.showKiiSnackBarError(_message(e));
    }
  }

  Future<bool> _confirmRestore(DriveOrgBackupSummary backup) async {
    final l10n = context.l10n;
    final primary = Theme.of(context).colorScheme.primary;
    final scheme = Theme.of(context).colorScheme;
    final isTablet = DeviceLayout.isTablet(context);

    return await showDialog<bool>(
          context: context,
          barrierColor: Colors.black54,
          builder: (ctx) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(isTablet ? 20 : 20.r),
            ),
            insetPadding: EdgeInsets.symmetric(
              horizontal: isTablet ? 32 : 28.w,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: isTablet ? 480 : 400),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  isTablet ? 24 : 20.w,
                  isTablet ? 24 : 22.h,
                  isTablet ? 24 : 20.w,
                  isTablet ? 24 : 20.h,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: isTablet ? 44 : 44.w,
                          height: isTablet ? 44 : 44.w,
                          decoration: BoxDecoration(
                            color: primary.withValues(alpha: 0.12),
                            borderRadius:
                                BorderRadius.circular(isTablet ? 12 : 12.r),
                          ),
                          child: Icon(
                            Icons.cloud_download_rounded,
                            color: primary,
                            size: isTablet ? 24 : 24.sp,
                          ),
                        ),
                        SizedBox(width: isTablet ? 12 : 12.w),
                        Expanded(
                          child: Text(
                            l10n.restoreFromGoogleDrive,
                            style: AppFonts.interStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: scheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isTablet ? 16 : 16.h),
                    Container(
                      width: double.infinity,
                      padding: _insets(isTablet, 14, 14),
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerLow,
                        borderRadius:
                            BorderRadius.circular(isTablet ? 12 : 12.r),
                        border: Border.all(color: scheme.outlineVariant),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            backup.name,
                            style: AppFonts.interStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: scheme.onSurface,
                            ),
                          ),
                          if (backup.code.isNotEmpty) ...[
                            SizedBox(height: isTablet ? 4 : 4.h),
                            Text(
                              l10n.organizationCodeLabel(backup.code),
                              style: AppFonts.interStyle(
                                fontSize: 13,
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(height: isTablet ? 12 : 12.h),
                    Text(
                      l10n.restoreFromGoogleDriveConfirm(backup.name),
                      style: AppFonts.interStyle(
                        fontSize: 14,
                        height: 1.45,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: isTablet ? 20 : 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButtonWidget.outlined(
                            onPressed: () => Navigator.pop(ctx, false),
                            title: l10n.cancel,
                            width: double.infinity,
                            useFixedSizes: isTablet,
                            height: isTablet ? 48 : 42,
                            borderRadius: isTablet ? 12 : 8,
                          ),
                        ),
                        SizedBox(width: isTablet ? 12 : 12.w),
                        Expanded(
                          child: CustomButtonWidget(
                            onPressed: () => Navigator.pop(ctx, true),
                            title: l10n.restoreAction,
                            width: double.infinity,
                            useFixedSizes: isTablet,
                            height: isTablet ? 48 : 48,
                            borderRadius: isTablet ? 12 : 8,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ) ??
        false;
  }

  Future<void> _restore(DriveOrgBackupSummary backup) async {
    final confirmed = await _confirmRestore(backup);
    if (!confirmed || !mounted) return;

    final l10n = context.l10n;
    HapticFeedback.lightImpact();
    setState(() {
      _restoring = true;
      _progress = 0;
      _progressStep = l10n.restoreFromGoogleDriveStarting;
    });

    try {
      final result = await _restoreService.restoreOrganization(
        orgSlug: backup.slug,
        onProgress: (step, value) {
          if (!mounted) return;
          setState(() {
            _progressStep = _stepLabel(step);
            _progress = value;
          });
        },
      );
      if (!mounted) return;
      HapticFeedback.mediumImpact();
      Navigator.pop(context, result);
    } catch (e) {
      if (!mounted) return;
      context.showKiiSnackBarError(_message(e));
      setState(() {
        _restoring = false;
        _progressStep = null;
        _progress = 0;
      });
    }
  }

  String _stepLabel(String step) {
    final l10n = context.l10n;
    if (step == 'download') return l10n.restoreStepDownload;
    if (step == 'create_database') return l10n.restoreStepCreateDatabase;
    if (step == 'import') return l10n.restoreStepImport;
    if (step == 'finalize') return l10n.restoreStepFinalize;
    return l10n.backupSyncStepUploadTable(step);
  }

  String _message(Object error) {
    if (error is MissingPluginException) {
      return context.l10n.googleDriveBackupPluginError;
    }
    final raw = error.toString();
    if (raw.contains('cancelled') || raw.contains('canceled')) {
      return context.l10n.googleDriveSignInCancelled;
    }
    return context.l10n.restoreFromGoogleDriveFailed(raw);
  }

  String? _formatDate(DateTime? value) {
    if (value == null) return null;
    return DateFormat.yMMMd().add_jm().format(value.toLocal());
  }

  Widget _buildHeader(BuildContext context, bool isTablet, Color primary) {
    final l10n = context.l10n;
    final showSubtitle = !_needsSignIn;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: isTablet ? 40 : 38.w,
          height: isTablet ? 40 : 38.w,
          decoration: BoxDecoration(
            color: primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(isTablet ? 10 : 8.r),
          ),
          child: Icon(
            FontAwesomeIcons.googleDrive,
            color: primary,
            size: isTablet ? 18 : 18.sp,
          ),
        ),
        SizedBox(width: isTablet ? 14 : 14.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.restoreFromGoogleDrive,
                style: context.theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (showSubtitle) ...[
                SizedBox(height: isTablet ? 4 : 4.h),
                Text(
                  l10n.restoreFromGoogleDriveHint,
                  style: context.theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: context.theme.colorScheme.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, bool isTablet, Color primary) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;

    if (_restoring) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: isTablet ? 16 : 18.h),
          Container(
            padding: _insets(isTablet, 16, 16),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(isTablet ? 14 : 14.r),
              border: Border.all(color: scheme.outlineVariant),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: isTablet ? 20 : 20.w,
                      height: isTablet ? 20 : 20.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: primary,
                      ),
                    ),
                    SizedBox(width: isTablet ? 10 : 10.w),
                    Expanded(
                      child: Text(
                        l10n.backupSyncInProgress,
                        style: AppFonts.interStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: scheme.onSurface,
                        ),
                      ),
                    ),
                    Text(
                      l10n.backupSyncProgressPercent(
                        (_progress * 100).clamp(0, 100).round(),
                      ),
                      style: AppFonts.interStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: isTablet ? 12 : 12.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(isTablet ? 6 : 6.r),
                  child: LinearProgressIndicator(
                    minHeight: isTablet ? 6 : 6.h,
                    value: _progress > 0 ? _progress : null,
                    backgroundColor: primary.withValues(alpha: 0.12),
                    color: primary,
                  ),
                ),
                if (_progressStep != null) ...[
                  SizedBox(height: isTablet ? 10 : 10.h),
                  Text(
                    _progressStep!,
                    style: AppFonts.interStyle(
                      fontSize: 12,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      );
    }

    if (_loading) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: isTablet ? 28 : 32.h),
        child: Center(
          child: SizedBox(
            width: isTablet ? 28 : 28.w,
            height: isTablet ? 28 : 28.w,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: primary,
            ),
          ),
        ),
      );
    }

    if (_needsSignIn) {
      return _EmptyStateCard(
        isTablet: isTablet,
        icon: Icons.cloud_off_outlined,
        message: l10n.restoreFromGoogleDriveHint,
        primary: primary,
        compact: true,
        action: CustomButtonWidget(
          onPressed: _restoring ? null : _signInAndReload,
          title: l10n.googleDriveSignIn,
          width: double.infinity,
          useFixedSizes: isTablet,
          height: isTablet ? 52 : 48,
          borderRadius: isTablet ? 12 : 8,
        ),
      );
    }

    if (_error != null) {
      return _EmptyStateCard(
        isTablet: isTablet,
        icon: Icons.error_outline_rounded,
        message: _error!,
        primary: primary,
        action: CustomButtonWidget(
          onPressed: _restoring ? null : _signInAndReload,
          title: l10n.googleDriveSignIn,
          width: double.infinity,
          useFixedSizes: isTablet,
          height: isTablet ? 52 : 48,
          borderRadius: isTablet ? 12 : 8,
        ),
      );
    }

    if (_backups.isEmpty) {
      return _EmptyStateCard(
        isTablet: isTablet,
        icon: Icons.folder_off_outlined,
        message: l10n.restoreFromGoogleDriveEmpty,
        primary: primary,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ..._backups.map(
          (backup) => Padding(
            padding: EdgeInsets.only(bottom: isTablet ? 10 : 10.h),
            child: _BackupSelectTile(
              backup: backup,
              primary: primary,
              enabled: !_restoring,
              isTablet: isTablet,
              dateLabel: _formatDate(backup.exportedAt),
              onTap: () => _restore(backup),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSheetContent(BuildContext context, bool isTablet) {
    final l10n = context.l10n;
    final primary = Theme.of(context).colorScheme.primary;
    final horizontal = isTablet ? 24.0 : 20.w;
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;

    final scrollContent = SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        horizontal,
        isTablet ? 24 : 18.h,
        horizontal,
        isTablet ? 8 : 16.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(context, isTablet, primary),
          SizedBox(height: isTablet ? 16 : 18.h),
          _buildBody(context, isTablet, primary),
        ],
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!isTablet) ...[
          SizedBox(height: 10.h),
          AppBottomSheetTheme.dragHandle(context),
        ],
        if (isTablet)
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 380),
            child: scrollContent,
          )
        else
          Flexible(child: scrollContent),
        Padding(
          padding: EdgeInsets.fromLTRB(
            horizontal,
            isTablet ? 8 : 0,
            horizontal,
            isTablet ? 20 + bottomInset : 16.h,
          ),
          child: CustomButtonWidget.outlined(
            onPressed: _restoring ? null : () => Navigator.pop(context),
            title: l10n.cancel,
            width: double.infinity,
            useFixedSizes: isTablet,
            height: isTablet ? 52 : 48,
            borderRadius: isTablet ? 12 : 8,
          ),
        ),
        if (!isTablet) SizedBox(height: 8.h),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = DeviceLayout.isTablet(context);
    final scheme = Theme.of(context).colorScheme;
    final maxHeight = MediaQuery.sizeOf(context).height * (isTablet ? 0.88 : 0.82);

    if (isTablet) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 520,
              maxHeight: maxHeight,
            ),
            child: Material(
              color: scheme.surface,
              elevation: 12,
              shadowColor: scheme.shadow.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
              clipBehavior: Clip.antiAlias,
              child: _buildSheetContent(context, true),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        constraints: BoxConstraints(maxHeight: maxHeight),
        decoration: AppBottomSheetTheme.topSheetDecoration(context).copyWith(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          boxShadow: [
            BoxShadow(
              color: scheme.shadow.withValues(alpha: 0.18),
              blurRadius: 24,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: _buildSheetContent(context, false),
      ),
    );
  }
}

class _BackupSelectTile extends StatelessWidget {
  const _BackupSelectTile({
    required this.backup,
    required this.primary,
    required this.enabled,
    required this.onTap,
    required this.isTablet,
    this.dateLabel,
  });

  final DriveOrgBackupSummary backup;
  final Color primary;
  final bool enabled;
  final VoidCallback onTap;
  final bool isTablet;
  final String? dateLabel;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final radius = isTablet ? 12.0 : 12.r;

    return Material(
      color: scheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(radius),
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 14 : 14.w,
            vertical: isTablet ? 12 : 12.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Row(
            children: [
              Container(
                width: isTablet ? 40 : 40.w,
                height: isTablet ? 40 : 40.w,
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(isTablet ? 10 : 10.r),
                ),
                child: Icon(
                  Icons.business,
                  color: primary,
                  size: isTablet ? 22 : 22.sp,
                ),
              ),
              SizedBox(width: isTablet ? 12 : 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      backup.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppFonts.interStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurface,
                      ),
                    ),
                    if (backup.code.isNotEmpty) ...[
                      SizedBox(height: isTablet ? 2 : 2.h),
                      Text(
                        l10n.organizationCodeLabel(backup.code),
                        style: AppFonts.interStyle(
                          fontSize: 12,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    if (dateLabel != null) ...[
                      SizedBox(height: isTablet ? 2 : 2.h),
                      Text(
                        dateLabel!,
                        style: AppFonts.interStyle(
                          fontSize: 12,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(width: isTablet ? 8 : 8.w),
              Icon(
                Icons.restore_rounded,
                color: enabled
                    ? primary.withValues(alpha: 0.75)
                    : scheme.onSurfaceVariant,
                size: isTablet ? 22 : 22.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyStateCard extends StatelessWidget {
  const _EmptyStateCard({
    required this.icon,
    required this.message,
    required this.primary,
    required this.isTablet,
    this.action,
    this.compact = false,
  });

  final IconData icon;
  final String message;
  final Color primary;
  final bool isTablet;
  final Widget? action;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final padding = isTablet ? (compact ? 16.0 : 20.0) : 20.w;

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(isTablet ? 14 : 14.r),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: isTablet ? (compact ? 36 : 40) : 40.sp,
            color: primary.withValues(alpha: 0.7),
          ),
          SizedBox(height: isTablet ? (compact ? 10 : 12) : 12.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppFonts.interStyle(
              fontSize: 14,
              height: 1.45,
              color: scheme.onSurfaceVariant,
            ),
          ),
          if (action != null) ...[
            SizedBox(height: isTablet ? 16 : 16.h),
            action!,
          ],
        ],
      ),
    );
  }
}
