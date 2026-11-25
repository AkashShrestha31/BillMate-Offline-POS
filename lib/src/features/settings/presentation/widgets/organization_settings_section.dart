import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/features/org/domain/org_switch_coordinator.dart';
import 'package:hotel/src/features/org/domain/organization_business_type.dart';
import 'package:hotel/src/features/org/domain/organization_settings_service.dart';
import 'package:hotel/src/features/dashboard/presentation/widgets/more_settings_widgets.dart';
import 'package:hotel/src/features/settings/presentation/pages/organization_edit_page.dart';

/// More page: view and edit organization name, company name, and business type.
class OrganizationSettingsSection extends StatelessWidget {
  const OrganizationSettingsSection({super.key, this.embedded = false});

  final bool embedded;

  Future<void> _openEdit(BuildContext context) async {
    final updated = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => const OrganizationEditPage(),
      ),
    );
    if (updated == true) {
      OrgSwitchCoordinator.notifier.value++;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return ListenableBuilder(
      listenable: OrgSwitchCoordinator.notifier,
      builder: (context, _) {
        return FutureBuilder(
          future: OrganizationSettingsService().load(),
          builder: (context, snapshot) {
            final settings = snapshot.data;
            final businessTypeLabel = settings == null
                ? null
                : context.l10n.businessTypeLabel(settings.businessType);
            final subtitle = settings == null
                ? null
                : [
                    if (businessTypeLabel != null && businessTypeLabel.isNotEmpty)
                      businessTypeLabel,
                    if (settings.organizationName.isNotEmpty)
                      settings.organizationName,
                  ].join(' · ');

            final tile = ListTile(
              contentPadding: MoreSettingsLayout.tilePadding(context),
              leading: MoreIconBox(
                icon: OrganizationBusinessType.iconFor(settings?.businessType),
                logo: settings?.logo,
              ),
              title: Text(
                context.l10n.editOrganizationInfo,
                style: MoreSettingsLayout.tileTitle(theme),
              ),
              subtitle: snapshot.connectionState == ConnectionState.waiting
                  ? Text(
                      context.l10n.loading,
                      style: MoreSettingsLayout.tileSubtitle(theme),
                    )
                  : (subtitle != null && subtitle.isNotEmpty)
                      ? Text(
                          subtitle,
                          style: MoreSettingsLayout.tileSubtitle(theme),
                        )
                      : null,
              trailing: Icon(
                Icons.chevron_right,
                size: MoreSettingsLayout.chevronSize(context),
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
              ),
              onTap: snapshot.connectionState == ConnectionState.waiting
                  ? null
                  : () => _openEdit(context),
            );

            if (embedded) return tile;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 4.w),
                  child: Text(
                    context.l10n.organizationSettings,
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
          },
        );
      },
    );
  }
}
