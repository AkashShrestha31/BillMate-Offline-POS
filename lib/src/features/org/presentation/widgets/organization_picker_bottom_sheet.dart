import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hotel/src/core/widget/app_delete_icon.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/helpers/freemium_navigation.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/helpers/session_helper.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/services/app_loading_overlay.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:hotel/src/core/services/org/saved_organization.dart';
import 'package:hotel/src/features/org/domain/organization_business_type.dart';
import 'package:hotel/src/features/org/domain/organization_deletion_service.dart';
import 'package:hotel/src/features/org/presentation/org_code_page_intent.dart';
import 'package:hotel/src/features/org/domain/organization_database_service.dart';
import 'package:hotel/src/features/org/domain/org_switch_coordinator.dart';
import 'package:hotel/src/features/setup/domain/test_data_login_service.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/features/org/presentation/widgets/delete_organization_confirm_sheet.dart';

/// Where the organization picker was opened from.
enum OrganizationPickerSource {
  /// More / settings: signing out may be required before switching org.
  settings,

  /// Login workspace **Change**: no session; navigates to org code with prefill.
  login,
}

/// Shows saved organizations plus **Add more +** to connect another org.
///
/// Returns `true` when the active workspace changed (or the user was routed
/// away to finish connecting another org).
Future<bool> showOrganizationPickerBottomSheet(
  BuildContext context, {
  OrganizationPickerSource source = OrganizationPickerSource.settings,
}) async {
  final changed = await showModalBottomSheet<bool>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (ctx) => _OrganizationPickerSheet(
      parentContext: context,
      source: source,
    ),
  );
  return changed ?? false;
}

class _OrganizationPickerSheet extends StatefulWidget {
  const _OrganizationPickerSheet({
    required this.parentContext,
    required this.source,
  });

  final BuildContext parentContext;
  final OrganizationPickerSource source;

  @override
  State<_OrganizationPickerSheet> createState() =>
      _OrganizationPickerSheetState();
}

class _OrganizationPickerSheetState extends State<_OrganizationPickerSheet> {
  List<SavedOrganization> _orgs = [];
  String? _currentSlug;
  bool _loading = true;
  bool _deleting = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final orgs =
        await OrganizationDatabaseService.listOrganizationsForConnectPage();
    final slug = await OrgStorage.getOrgSlug();
    if (!mounted) return;
    setState(() {
      _orgs = orgs;
      _currentSlug = slug;
      _loading = false;
    });
  }

  Future<void> _onDeleteOrganization(SavedOrganization org) async {
    if (_deleting) return;

    final name = org.name.isNotEmpty ? org.name : org.slug;
    final confirmed = await showDeleteOrganizationConfirmSheet(
      context: context,
      organizationName: name,
    );
    if (!confirmed || !mounted) return;

    setState(() => _deleting = true);
    try {
      final loggedOut =
          await OrganizationDeletionService().deleteOrganization(org);
      if (!mounted) return;

      if (loggedOut) {
        Navigator.pop(context);
        if (!widget.parentContext.mounted) return;
        widget.parentContext.router.replaceAll([const OrganizationCodeRoute()]);
        widget.parentContext.showKiiSnackBarSuccess(
          widget.parentContext.l10n.organizationDeleted,
        );
        return;
      }

      await _load();
      if (!mounted) return;
      widget.parentContext.showKiiSnackBarSuccess(
        widget.parentContext.l10n.organizationDeleted,
      );
    } catch (e) {
      if (mounted) {
        widget.parentContext.showKiiSnackBarError(
          widget.parentContext.l10n.testDataLoginFailed(e.toString()),
        );
      }
    } finally {
      if (mounted) setState(() => _deleting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxHeight = MediaQuery.sizeOf(context).height * 0.65;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          constraints: BoxConstraints(maxHeight: maxHeight),
          decoration: AppBottomSheetTheme.sheetDecoration(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 8, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        context.l10n.selectOrganization,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    if (_deleting)
                      const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    AppBottomSheetCloseButton(
                      enabled: !_deleting,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Flexible(
                child: _loading
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32),
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        children: [
                          _AddMoreOrganizationTile(
                            onTap: _deleting
                                ? () {}
                                : () => _onAddMoreOrganization(
                                      widget.parentContext,
                                      context,
                                      widget.source,
                                    ),
                          ),
                          if (_orgs.isEmpty)
                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: Text(
                                context.l10n.noSavedOrganizationsUseAddMore,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            )
                          else
                            ..._orgs.map(
                              (org) => _OrganizationListTile(
                                org: org,
                                isCurrent: org.slug == _currentSlug,
                                onTap: _deleting
                                    ? () {}
                                    : () => _onSelectOrganization(
                                          widget.parentContext,
                                          context,
                                          org,
                                          widget.source,
                                        ),
                                onDelete: _deleting
                                    ? null
                                    : () => _onDeleteOrganization(org),
                              ),
                            ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _onAddMoreOrganization(
  BuildContext parentContext,
  BuildContext sheetContext,
  OrganizationPickerSource source,
) async {
  if (!await showFreemiumLimitMessage(
    parentContext,
    FreemiumFeature.organization,
  )) {
    return;
  }
  if (!parentContext.mounted || !sheetContext.mounted) return;

  final l10n = parentContext.l10n;
  final title = source == OrganizationPickerSource.settings
      ? l10n.registerNewOrganizationTitleSignedIn
      : l10n.registerNewOrganizationTitle;
  final message = source == OrganizationPickerSource.settings
      ? l10n.registerNewOrganizationMessageSignedIn
      : l10n.registerNewOrganizationMessageLogin;

  final confirmed = await showAppBottomSheet<bool>(
    context: sheetContext,
    title: title,
    shrinkWrap: true,
    child: Builder(
      builder: (confirmContext) {
        final theme = Theme.of(confirmContext);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.45,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            CustomButtonWidget(
              onPressed: () => Navigator.pop(confirmContext, true),
              title: l10n.startSetup,
              width: double.infinity,
            ),
          ],
        );
      },
    ),
  );
  if (confirmed != true) return;

  if (!sheetContext.mounted) return;
  Navigator.pop(sheetContext);

  if (source == OrganizationPickerSource.settings) {
    await SessionHelper.clearSessionData();
  }
  await OrganizationDatabaseService.archiveActiveDatabase();
  await OrgStorage.clear();
  OrgCodePageIntent.clearPrefill();

  if (!parentContext.mounted) return;
  parentContext.router.replaceAll([const LocalSetupRoute()]);
}

Future<void> _onSelectOrganization(
  BuildContext parentContext,
  BuildContext sheetContext,
  SavedOrganization org,
  OrganizationPickerSource source,
) async {
  if (!sheetContext.mounted) return;

  final currentSlug = await OrgStorage.getOrgSlug();
  if (currentSlug != null &&
      currentSlug.isNotEmpty &&
      org.slug == currentSlug) {
    Navigator.pop(sheetContext, false);
    return;
  }

  final isTestOrg = await TestDataLoginService.isDemoOrganization(
    orgCode: org.code,
    orgSlug: org.slug,
  );

  if (isTestOrg) {
    Navigator.pop(sheetContext, true);

    if (source == OrganizationPickerSource.settings) {
      await SessionHelper.clearSessionData();
    }

    final overlay = AppLoadingOverlay.of(parentContext);
    overlay.show();
    try {
      final email = await TestDataLoginService().signInToSavedOrganization(org);
      if (!parentContext.mounted) return;
      await OrgSwitchCoordinator.finishSwitch(
        parentContext,
        email: email,
      );
      if (!parentContext.mounted) return;
      overlay.hide();
      parentContext.router.replaceAll([const MainRoute()]);
    } catch (e) {
      if (parentContext.mounted) {
        overlay.hide();
        final message = e.toString().trim().replaceFirst(
              RegExp(r'^Exception:\s*'),
              '',
            );
        parentContext.showKiiSnackBarError(
          parentContext.l10n.testDataLoginFailed(
            message.length <= 120 ? message : parentContext.l10n.tryAgain,
          ),
        );
      }
    }
    return;
  }

  if (source == OrganizationPickerSource.settings) {
    await SessionHelper.clearSessionData();
  }

  final hasDatabase =
      await OrganizationDatabaseService.isOrganizationUsable(org);
  if (hasDatabase) {
    try {
      await OrganizationDatabaseService.switchTo(org);
      if (!parentContext.mounted) return;
      if (source == OrganizationPickerSource.login) {
        Navigator.pop(sheetContext, true);
      } else {
        Navigator.pop(sheetContext);
        parentContext.router.replaceAll([const LoginRoute()]);
      }
      return;
    } catch (_) {
      // Fall through to org code flow.
    }
  }

  Navigator.pop(sheetContext, true);

  await OrgStorage.clear();

  OrgCodePageIntent.setPrefill(
    code: org.code,
    displayName: org.name,
  );

  if (!parentContext.mounted) return;
  parentContext.router.replaceAll([const OrganizationCodeRoute()]);
}

class _AddMoreOrganizationTile extends StatelessWidget {
  const _AddMoreOrganizationTile({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(Icons.add, color: theme.colorScheme.primary),
      ),
      title: Text(
        context.l10n.addMoreOrganization,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
          color: theme.colorScheme.primary,
        ),
      ),
      subtitle: Text(context.l10n.connectAnotherOrganization),
      onTap: onTap,
    );
  }
}

class _OrganizationListTile extends StatelessWidget {
  const _OrganizationListTile({
    required this.org,
    required this.isCurrent,
    required this.onTap,
    this.onDelete,
  });

  final SavedOrganization org;
  final bool isCurrent;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.apartment_rounded,
          color: theme.colorScheme.primary,
          size: 22,
        ),
      ),
      title: Text(
        org.name.isNotEmpty ? org.name : org.slug,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        [
          if (org.businessType != null && org.businessType!.isNotEmpty)
            context.l10n.organizationBusinessTypeLabel(
              context.l10n.businessTypeLabel(org.businessType),
            ),
          context.l10n.organizationCodeLabel(org.code),
        ].join(' · '),
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onDelete != null)
            IconButton(
              icon: AppDeleteIcon(
                color: theme.colorScheme.error.withValues(alpha: 0.85),
                size: 22,
              ),
              tooltip: context.l10n.delete,
              onPressed: onDelete,
            ),
          if (isCurrent)
            Icon(Icons.check_circle, color: theme.colorScheme.primary, size: 22)
          else
            const Icon(Icons.chevron_right),
        ],
      ),
      onTap: onTap,
    );
  }
}
