import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/helpers/freemium_navigation.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/layout/device_layout.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/services/app_loading_overlay.dart';
import 'package:hotel/src/core/themes/app_colors.dart';
import 'package:hotel/src/core/widget/app_logo.dart';
import 'package:hotel/src/features/backup/presentation/widgets/restore_from_drive_sheet.dart';
import 'package:hotel/src/core/services/org/saved_organization.dart';
import 'package:hotel/src/features/org/domain/organization_business_type.dart';
import 'package:hotel/src/features/org/domain/organization_database_service.dart';
import 'package:hotel/src/features/org/domain/org_switch_coordinator.dart';
import 'package:hotel/src/features/org/presentation/cubit/org_lookup_cubit.dart';
import 'package:hotel/src/features/org/presentation/org_code_page_intent.dart';
import 'package:hotel/src/features/setup/domain/test_data_login_service.dart';
import 'package:hotel/src/features/setup/presentation/widgets/setup_bottom_action_bar.dart';

@RoutePage()
class OrganizationCodePage extends StatefulWidget {
  const OrganizationCodePage({super.key});

  @override
  State<OrganizationCodePage> createState() => _OrganizationCodePageState();
}

class _OrganizationCodePageState extends State<OrganizationCodePage> {
  List<SavedOrganization> _organizations = [];
  bool _loadingOrganizations = true;
  String? _prefillCode;
  String? _selectedCode;
  bool _testDataBusy = false;

  @override
  void initState() {
    super.initState();
    final prefill = OrgCodePageIntent.consumePrefill();
    _prefillCode = prefill.code;
    _loadOrganizations();
  }

  Future<void> _loadOrganizations({bool autoSelectPrefill = true}) async {
    setState(() => _loadingOrganizations = true);
    final orgs =
        await OrganizationDatabaseService.listOrganizationsForConnectPage();
    if (!mounted) return;
    setState(() {
      _organizations = orgs;
      _loadingOrganizations = false;
    });

    if (!autoSelectPrefill || _prefillCode == null || _prefillCode!.isEmpty) {
      return;
    }
    final code = _prefillCode!.trim().toUpperCase();
    _prefillCode = null;
    final match = orgs.where((o) => o.code.toUpperCase() == code).toList();
    if (match.isEmpty || !mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _onSelectOrganization(match.first);
    });
  }

  Future<void> _onSelectOrganization(SavedOrganization org) async {
    if (_testDataBusy || _selectedCode != null) return;

    final isTestOrg = await TestDataLoginService.isDemoOrganization(
      orgCode: org.code,
      orgSlug: org.slug,
    );
    if (!mounted) return;

    setState(() => _selectedCode = org.code.trim().toUpperCase());

    if (isTestOrg) {
      await _signInToTestOrganization(org);
      return;
    }

    final hasLocalData =
        await OrganizationDatabaseService.hasDatabaseForOrganization(org);
    if (hasLocalData) {
      if (!mounted) return;
      final overlay = AppLoadingOverlay.of(context);
      overlay.show();
      try {
        await OrganizationDatabaseService.switchTo(org);
        if (!mounted) return;
        overlay.hide();
        context.router.replace(const LoginRoute());
      } catch (e) {
        if (!mounted) return;
        overlay.hide();
        setState(() => _selectedCode = null);
        final message = e.toString().trim().replaceFirst(
              RegExp(r'^Exception:\s*'),
              '',
            );
        context.showKiiSnackBarError(
          message.length <= 120 ? message : context.l10n.tryAgain,
        );
      }
      return;
    }

    if (!mounted) return;
    context.read<OrgLookupCubit>().resolveOrganization(org.code);
  }

  Future<void> _signInToTestOrganization(SavedOrganization org) async {
    final overlay = AppLoadingOverlay.of(context);
    overlay.show();
    try {
      final email = await TestDataLoginService().signInToSavedOrganization(org);
      if (!mounted) return;
      await OrgSwitchCoordinator.finishSwitch(context, email: email);
      if (!mounted) return;
      overlay.hide();
      context.router.replace(const MainRoute());
    } catch (e) {
      if (!mounted) return;
      overlay.hide();
      setState(() => _selectedCode = null);
      final message = e.toString().trim().replaceFirst(
            RegExp(r'^Exception:\s*'),
            '',
          );
      context.showKiiSnackBarError(
        context.l10n.testDataLoginFailed(
          message.length <= 120 ? message : context.l10n.tryAgain,
        ),
      );
    }
  }

  Future<void> _onLoginWithTestData() async {
    if (_testDataBusy || _selectedCode != null) return;

    setState(() => _testDataBusy = true);

    final overlay = AppLoadingOverlay.of(context);
    overlay.show();
    try {
      final email = await TestDataLoginService().loginWithTestData();
      if (!mounted) return;
      await OrgSwitchCoordinator.finishSwitch(context, email: email);
      if (!mounted) return;
      overlay.hide();
      context.router.replace(const MainRoute());
    } catch (e) {
      if (!mounted) return;
      overlay.hide();
      setState(() => _testDataBusy = false);
      final message = e.toString().trim().replaceFirst(
            RegExp(r'^Exception:\s*'),
            '',
          );
      context.showKiiSnackBarError(
        context.l10n.testDataLoginFailed(
          message.length <= 120 ? message : context.l10n.tryAgain,
        ),
      );
    }
  }

  Future<void> _openCreateOrganization() async {
    if (_testDataBusy) return;
    if (!await showFreemiumLimitMessage(
      context,
      FreemiumFeature.organization,
    )) {
      return;
    }
    if (!mounted) return;
    await context.router.push(const LocalSetupRoute());
    if (mounted) await _loadOrganizations(autoSelectPrefill: false);
  }

  Future<void> _openRestoreFromDrive() async {
    if (_testDataBusy || _selectedCode != null) return;

    final restored = await RestoreFromDriveSheet.show(context);
    if (!mounted || restored == null) return;

    await _loadOrganizations(autoSelectPrefill: false);
    if (!mounted) return;

    SavedOrganization? match;
    for (final org in _organizations) {
      if (org.slug == restored.orgSlug || org.code == restored.orgCode) {
        match = org;
        break;
      }
    }

    if (match == null && _organizations.isEmpty) {
      context.showKiiSnackBarError(
        context.l10n.restoreFromGoogleDriveFailed(
          'Organization database is not ready on this device. Try restoring again.',
        ),
      );
      return;
    }

    final org = match ?? _organizations.first;
    context.showKiiSnackBarSuccess(
      context.l10n.restoreFromGoogleDriveSuccess(org.name),
    );

    if (match != null || _organizations.length == 1) {
      await _onSelectOrganization(org);
    }
  }

  bool get _hasSingleOrganization => !_loadingOrganizations && _organizations.length == 1;

  Widget _buildOrganizationList({
    required BuildContext context,
    required ThemeData theme,
    required Color primary,
    required bool hasOrganizations,
    required bool shrinkWrap,
  }) {
    if (_loadingOrganizations) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: Center(
          child: SizedBox(
            width: 28.w,
            height: 28.w,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: primary,
            ),
          ),
        ),
      );
    }

    if (!hasOrganizations) {
      return Text(
        context.l10n.noSavedOrganizationsYet,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          height: 1.4,
        ),
      );
    }

    if (_organizations.length == 1) {
      final org = _organizations.first;
      return _OrganizationSelectTile(
        org: org,
        primary: primary,
        busy: _testDataBusy || _selectedCode != null,
        loading: _selectedCode == org.code.trim().toUpperCase(),
        onTap: () => _onSelectOrganization(org),
      );
    }

    final list = ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
      itemCount: _organizations.length,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        final org = _organizations[index];
        return _OrganizationSelectTile(
          org: org,
          primary: primary,
          busy: _testDataBusy || _selectedCode != null,
          loading: _selectedCode == org.code.trim().toUpperCase(),
          onTap: () => _onSelectOrganization(org),
        );
      },
    );

    return list;
  }

  Widget _buildOrganizationsCard({
    required BuildContext context,
    required ThemeData theme,
    required Color primary,
    required bool hasOrganizations,
    required bool expandList,
    required bool isTablet,
  }) {
    final scheme = theme.colorScheme;
    final cardBorder = scheme.outlineVariant.withValues(alpha: 0.6);
    final radius = isTablet ? 16.0 : 16.r;
    return Container(
      padding: EdgeInsets.all(isTablet ? 20 : 20.w),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: cardBorder),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.08),
            blurRadius: isTablet ? 24 : 24.r,
            offset: Offset(0, isTablet ? 8 : 8.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: expandList ? MainAxisSize.max : MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: isTablet ? 44 : 44.w,
                height: isTablet ? 44 : 44.w,
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(isTablet ? 12 : 12.r),
                ),
                child: Icon(
                  Icons.business,
                  color: primary,
                  size: isTablet ? 24 : 24.sp,
                ),
              ),
              SizedBox(width: isTablet ? 14 : 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.selectOrganization,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,

                      ),
                    ),
                    SizedBox(height: isTablet ? 2 : 2.h),
                    Text(
                      context.l10n.selectOrganizationHint,
                      style: theme.textTheme.bodySmall?.copyWith(
                          color: context.theme.colorScheme.textSecondary
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: isTablet ? 16 : 16.h),
          if (expandList)
            Expanded(
              child: _buildOrganizationList(
                context: context,
                theme: theme,
                primary: primary,
                hasOrganizations: hasOrganizations,
                shrinkWrap: false,
              ),
            )
          else
            _buildOrganizationList(
              context: context,
              theme: theme,
              primary: primary,
              hasOrganizations: hasOrganizations,
              shrinkWrap: true,
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final scheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    final hasOrganizations = _organizations.isNotEmpty;
    final isTablet = DeviceLayout.isTablet(context);
    final horizontal = isTablet ? 32.0 : 12.sp;
    final listMaxHeight = isTablet ? 280.0 : 240.h;

    return BlocListener<OrgLookupCubit, OrgLookupState>(
      listener: (context, state) {
        if (state is OrgLookupSuccess) {
          context.router.replace(const LoginRoute());
        } else if (state is OrgLookupError) {
          if (mounted) setState(() => _selectedCode = null);
          context.showKiiSnackBarError(state.message);
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                scheme.surface,
                scheme.surfaceContainerLow,
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(horizontal, 8, horizontal, 0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _testDataBusy ? null : _openCreateOrganization,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.add),
                          SizedBox(width: isTablet ? 6 : 4),
                          Text(
                            context.l10n.createAction,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.8,
                              color: primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(
                        horizontal,
                        isTablet ? 12 : 0,
                        horizontal,
                        isTablet ? 24 : 12.sp,
                      ),
                      child: SetupTabletContentWidth(
                        maxWidth: isTablet ? 640 : double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: AppLogo(
                                height: isTablet ? 72 : 72.h,
                                width: isTablet ? 72 : 72.w,
                                errorIconSize: isTablet ? 56 : 64.sp,
                              ),
                            ),
                            SizedBox(height: isTablet ? 20 : 16.h),
                            Text(
                              context.l10n.connectOrganizationTitle,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: isTablet ? 6 : 4.h),
                            Text(
                              context.l10n.connectOrganizationSubtitle,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: context.theme.colorScheme.textSecondary,
                              ),
                            ),
                            SizedBox(height: isTablet ? 24 : 20.h),
                            if (_hasSingleOrganization || !hasOrganizations)
                              _buildOrganizationsCard(
                                context: context,
                                theme: theme,
                                primary: primary,
                                hasOrganizations: hasOrganizations,
                                expandList: false,
                                isTablet: isTablet,
                              )
                            else
                              ConstrainedBox(
                                constraints:
                                    BoxConstraints(maxHeight: listMaxHeight),
                                child: _buildOrganizationsCard(
                                  context: context,
                                  theme: theme,
                                  primary: primary,
                                  hasOrganizations: hasOrganizations,
                                  expandList: true,
                                  isTablet: isTablet,
                                ),
                              ),
                            SizedBox(height: isTablet ? 16 : 14.h),
                            _LoginWithTestDataEntry(
                              primary: primary,
                              enabled: !_testDataBusy && _selectedCode == null,
                              busy: _testDataBusy,
                              onTap: _onLoginWithTestData,
                              isTablet: isTablet,
                            ),
                            SizedBox(height: isTablet ? 16 : 14.h),
                            _RestoreFromDriveEntry(
                              primary: primary,
                              enabled: !_testDataBusy && _selectedCode == null,
                              onTap: _openRestoreFromDrive,
                              isTablet: isTablet,
                            ),
                            SizedBox(height: isTablet ? 16 : 14.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: isTablet ? 16 : 14.w,
                                vertical: isTablet ? 14 : 12.h,
                              ),
                              decoration: BoxDecoration(
                                color: scheme.primaryContainer
                                    .withValues(alpha: 0.35),
                                borderRadius: BorderRadius.circular(
                                  isTablet ? 12 : 12.r,
                                ),
                                border: Border.all(
                                  color: scheme.outlineVariant
                                      .withValues(alpha: 0.6),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.info_outline_rounded,
                                    size: isTablet ? 20 : 20.sp,
                                    color: scheme.onSurfaceVariant,
                                  ),
                                  SizedBox(width: isTablet ? 12 : 10.w),
                                  Expanded(
                                    child: Text(
                                      context.l10n.orgConnectOnceInfo,
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: scheme.onSurface,
                                        height: 1.35,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginWithTestDataEntry extends StatelessWidget {
  const _LoginWithTestDataEntry({
    required this.primary,
    required this.enabled,
    required this.busy,
    required this.onTap,
    this.isTablet = false,
  });

  final Color primary;
  final bool enabled;
  final bool busy;
  final VoidCallback onTap;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final tileBorder = scheme.outlineVariant.withValues(alpha: 0.6);

    return Material(
      color: scheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(isTablet ? 12 : 12.r),
      child: InkWell(
        onTap: enabled && !busy ? onTap : null,
        borderRadius: BorderRadius.circular(isTablet ? 12 : 12.r),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 16 : 14.w,
            vertical: isTablet ? 14 : 12.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isTablet ? 12 : 12.r),
            border: Border.all(color: tileBorder),
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
                child: busy
                    ? Padding(
                        padding: EdgeInsets.all(isTablet ? 10 : 10.w),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: primary,
                        ),
                      )
                    : Icon(
                        Icons.science_outlined,
                        color: primary,
                        size: isTablet ? 18 : 18.sp,
                      ),
              ),
              SizedBox(width: isTablet ? 12 : 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.loginWithTestData,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      busy
                          ? context.l10n.preparingTestData
                          : context.l10n.loginWithTestDataSubtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              if (!busy) ...[
                SizedBox(width: 8.w),
                Icon(
                  Icons.chevron_right_rounded,
                  color: enabled
                      ? primary.withValues(alpha: 0.7)
                      : scheme.onSurfaceVariant.withValues(alpha: 0.5),
                  size: 24.sp,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _RestoreFromDriveEntry extends StatelessWidget {
  const _RestoreFromDriveEntry({
    required this.primary,
    required this.enabled,
    required this.onTap,
    this.isTablet = false,
  });

  final Color primary;
  final bool enabled;
  final VoidCallback onTap;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final tileBorder = scheme.outlineVariant.withValues(alpha: 0.6);

    return Material(
      color: scheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(isTablet ? 12 : 12.r),
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(isTablet ? 12 : 12.r),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 16 : 14.w,
            vertical: isTablet ? 14 : 12.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isTablet ? 12 : 12.r),
            border: Border.all(color: tileBorder),
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
                  FontAwesomeIcons.googleDrive,
                  color: primary,
                  size: isTablet ? 18 : 18.sp,
                ),
              ),
              SizedBox(width: isTablet ? 12 : 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.restoreFromGoogleDrive,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      context.l10n.restoreFromGoogleDriveHint,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.chevron_right_rounded,
                color: enabled ? primary.withValues(alpha: 0.7) : scheme.onSurfaceVariant.withValues(alpha: 0.5),
                size: 24.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrganizationSelectTile extends StatelessWidget {
  const _OrganizationSelectTile({
    required this.org,
    required this.primary,
    required this.busy,
    required this.loading,
    required this.onTap,
  });

  final SavedOrganization org;
  final Color primary;
  final bool busy;
  final bool loading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final tileBorder = scheme.outlineVariant.withValues(alpha: 0.6);
    final name = org.name.isNotEmpty ? org.name : org.slug;

    return Material(
      color: scheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: busy ? null : onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: tileBorder),
          ),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.business,
                  color: primary,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurface,
                      ),
                    ),
                    if (org.businessType != null && org.businessType!.isNotEmpty) ...[
                      SizedBox(height: 2.h),
                      Text(
                        context.l10n.organizationBusinessTypeLabel(
                          context.l10n.businessTypeLabel(org.businessType),
                        ),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    SizedBox(height: 2.h),
                    Text(
                      context.l10n.organizationCodeLabel(org.code),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              if (loading)
                SizedBox(
                  width: 22.w,
                  height: 22.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: primary,
                  ),
                )
              else
                Icon(
                  Icons.chevron_right_rounded,
                  color: primary.withValues(alpha: 0.7),
                  size: 24.sp,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
