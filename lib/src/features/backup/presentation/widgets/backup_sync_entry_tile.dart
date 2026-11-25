import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/helpers/freemium_navigation.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/features/backup/domain/google_drive_backup_service.dart';
import 'package:hotel/src/features/backup/presentation/pages/backup_sync_page.dart';
import 'package:hotel/src/features/dashboard/presentation/widgets/more_settings_widgets.dart';
import 'package:intl/intl.dart';

/// More page entry: opens the dedicated backup & sync screen.
class BackupSyncEntryTile extends StatefulWidget {
  const BackupSyncEntryTile({super.key, this.embedded = false});

  final bool embedded;

  @override
  State<BackupSyncEntryTile> createState() => _BackupSyncEntryTileState();
}

class _BackupSyncEntryTileState extends State<BackupSyncEntryTile> {
  final _backupService = getIt<GoogleDriveBackupService>();
  String? _subtitle;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSubtitle();
  }

  Future<void> _loadSubtitle() async {
    final info = await _backupService.loadSyncInfo();
    if (!mounted) return;
    final l10n = context.l10n;

    String subtitle;
    if (info.hasSynced && info.syncedAt != null) {
      final when = DateFormat.yMMMd().add_jm().format(info.syncedAt!.toLocal());
      subtitle = l10n.moreBackupSyncTileLastSync(when);
    } else if (info.isSignedIn) {
      subtitle = l10n.moreBackupSyncTileSignedInNoSync;
    } else {
      subtitle = l10n.moreBackupSyncTileNeverSynced;
    }

    setState(() {
      _subtitle = subtitle;
      _loading = false;
    });
  }

  Future<void> _openPage() async {
    if (!await gateFreemiumFeature(context, FreemiumFeature.backupSync)) {
      return;
    }
    if (!mounted) return;
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(builder: (_) => const BackupSyncPage()),
    );
    await _loadSubtitle();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final tile = ListTile(
      contentPadding: MoreSettingsLayout.tilePadding(context),
      leading: const MoreIconBox(icon: Icons.cloud_upload_outlined),
      title: Text(
        context.l10n.backupSyncPageTitle,
        style: MoreSettingsLayout.tileTitle(theme),
      ),
      subtitle: _loading
          ? Text(
              context.l10n.loading,
              style: MoreSettingsLayout.tileSubtitle(theme),
            )
          : Text(
              _subtitle ?? context.l10n.moreBackupSyncTileNeverSynced,
              style: MoreSettingsLayout.tileSubtitle(theme),
            ),
      trailing: Icon(
        Icons.chevron_right,
        size: MoreSettingsLayout.chevronSize(context),
        color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
      ),
      onTap: _loading ? null : _openPage,
    );

    if (widget.embedded) return tile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w),
          child: Text(
            context.l10n.googleDriveBackupSectionTitle,
            style: MoreSettingsLayout.sectionLabel(theme),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(8.sp),
          ),
          child: tile,
        ),
      ],
    );
  }
}
