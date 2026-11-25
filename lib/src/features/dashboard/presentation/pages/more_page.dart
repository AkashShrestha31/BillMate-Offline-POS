import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:hotel/src/features/org/domain/organization_business_type.dart';
import 'package:hotel/src/features/org/domain/organization_settings.dart';
import 'package:hotel/src/features/org/domain/organization_settings_service.dart';
import 'package:hotel/src/core/widget/confirmation_dialog.dart';
import 'package:hotel/src/core/widget/employee_profile_avatar.dart';
import 'package:hotel/src/core/widget/progress_step_widget.dart';
import 'package:hotel/src/core/widget/tab_error_view.dart';
import 'package:hotel/src/features/dashboard/data/models/client_to_server_request_params.dart';
import 'package:hotel/src/features/dashboard/presentation/bloc/client_to_server_cubit.dart';
import 'package:hotel/src/features/dashboard/presentation/bloc/server_to_client_cubit.dart';
import 'package:hotel/src/features/employee_management/data/models/response/employee_model.dart';
import 'package:hotel/src/features/employee_management/presentation/bloc/employee_cubit.dart';
import 'package:hotel/src/core/config/app_billing_config.dart';
import 'package:hotel/src/core/config/app_platform_config.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/services/billing/subscription_service.dart';
import 'package:hotel/src/core/services/app_rating/app_rating_service.dart';
import 'package:hotel/src/core/helpers/session_helper.dart';
import 'package:hotel/src/features/dashboard/presentation/pages/employee_management_hub_page.dart';
import 'package:hotel/src/features/dashboard/presentation/pages/operation_management_page.dart';
import 'package:hotel/src/features/dashboard/presentation/pages/reports_hub_page.dart';
import 'package:hotel/src/features/dashboard/presentation/widgets/more_settings_widgets.dart';
import 'package:hotel/src/features/help/presentation/pages/contact_us_page.dart';
import 'package:hotel/src/features/help/presentation/pages/faq_page.dart';
import 'package:hotel/src/features/org/domain/org_switch_coordinator.dart';
import 'package:hotel/src/features/org/presentation/widgets/organization_picker_bottom_sheet.dart';
import 'package:hotel/src/features/dashboard/presentation/widgets/logout_confirm_sheet.dart';
import 'package:hotel/src/features/settings/presentation/pages/privacy_policy_page.dart';
import 'package:hotel/src/features/settings/presentation/widgets/appearance_settings_section.dart';
import 'package:hotel/src/features/settings/presentation/widgets/bluetooth_printer_settings_section.dart';
import 'package:hotel/src/features/settings/presentation/widgets/live_stock_tracking_settings_section.dart';
import 'package:hotel/src/features/settings/presentation/widgets/subscription_settings_section.dart';
import 'package:hotel/src/features/settings/presentation/widgets/language_settings_section.dart';
import 'package:hotel/src/features/backup/presentation/widgets/backup_sync_entry_tile.dart';
import 'package:hotel/src/features/settings/presentation/widgets/notification_settings_section.dart';
import 'package:hotel/src/features/settings/presentation/widgets/organization_settings_section.dart';
import 'package:hotel/src/features/app_lock/presentation/widgets/app_lock_settings_section.dart';
// import 'package:hotel/src/features/setup/presentation/widgets/test_data_settings_tile.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const _MorePageView();
  }
}

/// Shared account settings body used by More and Profile.
class AccountSettingsBody extends StatelessWidget {
  const AccountSettingsBody({
    super.key,
    this.employee,
    this.showAppBar = true,
    this.showBackButton = true,
    this.showOrganizationName = false,
    this.notificationCount = 0,
    this.appBarTitle,
  });

  final EmployeeModel? employee;
  final bool showAppBar;
  final bool showBackButton;
  final bool showOrganizationName;
  final int notificationCount;

  /// App bar title (`More` tab vs standalone `Profile`). Falls back to [AppLocalizations.more].
  final String? appBarTitle;

  void _showSyncBottomSheet(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: scheme.outlineVariant.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.moreDataSynchronization,
              style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: scheme.primaryContainer.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.upload, color: scheme.primary),
              ),
              title: Text(
                l10n.moreSendDataToClient,
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                l10n.moreSendDataToClientSubtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: scheme.onSurfaceVariant.withValues(alpha: 0.5),
              ),
              onTap: () {
                Navigator.pop(bottomSheetContext);
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (dialogContext) => ConfirmationDialog(
                    title: l10n.moreSendDataToClient,
                    warningMessage: l10n.moreSendDataToClientWarning,
                    subtitle: l10n.moreSendDataToClientConfirm,
                    onConfirm: () => context.read<ServerToClientCubit>().serverToClient(),
                  ),
                );
              },
            ),
            const Divider(height: 1, indent: 16, endIndent: 16),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: scheme.secondaryContainer.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.refresh, color: scheme.secondary),
              ),
              title: Text(
                l10n.moreFetchDataFromClient,
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                l10n.moreFetchDataFromClientSubtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: scheme.onSurfaceVariant.withValues(alpha: 0.5),
              ),
              onTap: () {
                Navigator.pop(bottomSheetContext);
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (dialogContext) => ConfirmationDialog(
                    title: l10n.moreFetchDataFromClient,
                    warningMessage: l10n.moreFetchDataFromClientWarning,
                    subtitle: l10n.moreFetchDataFromClientConfirm,
                    onConfirm: () => context.read<ClientToServerCubit>().clientToServer(
                          params: ClientToServerRequestParams(
                            requestedFile: "HotelRoyalRestroLodge.books.db",
                            priority: "normal",
                          ),
                        ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final router = context.router;
    final confirmed = await showLogoutConfirmSheet(context);
    if (!confirmed) return;

    await WidgetsBinding.instance.endOfFrame;
    FocusManager.instance.primaryFocus?.unfocus();
    if (!context.mounted) return;
    await _performLogout(router);
  }

  Future<void> _performLogout(StackRouter router) async {
    await SessionHelper.clearSessionData();
    await WidgetsBinding.instance.endOfFrame;
    FocusManager.instance.primaryFocus?.unfocus();
    router.replaceAll([const LoginRoute()]);
  }

  void _showComingSoon(BuildContext context) {
    context.showKiiSnackBarInfo(context.l10n.comingSoon);
  }

  Future<void> _openRateUs(BuildContext context) async {
    final opened = await getIt<AppRatingService>().openRateUsListing();
    if (!context.mounted) return;
    if (!opened) {
      context.showKiiSnackBarWarning(context.l10n.rateUsUnavailable);
    }
  }

  Future<void> _openExternalOrInApp(
    BuildContext context, {
    required String? externalUrl,
    required Widget Function() inAppPage,
  }) async {
    if (externalUrl == null) {
      await Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (_) => inAppPage()),
      );
      return;
    }

    final launched = await launchUrl(
      Uri.parse(externalUrl),
      mode: LaunchMode.externalApplication,
    );
    if (!context.mounted) return;
    if (!launched) {
      context.showKiiSnackBarError(context.l10n.tryAgain);
    }
  }

  Future<void> _openPrivacyPolicy(BuildContext context) => _openExternalOrInApp(
        context,
        externalUrl: AppPlatformConfig.externalPrivacyPolicyUrl,
        inAppPage: () => const PrivacyPolicyPage(),
      );

  Future<void> _openFaq(BuildContext context) => _openExternalOrInApp(
        context,
        externalUrl: AppPlatformConfig.externalFaqUrl,
        inAppPage: () => const FaqPage(),
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final pageBackground = MoreSettingsLayout.background(scheme);

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: showAppBar
          ? AppBar(
              backgroundColor: pageBackground,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,
              centerTitle: false,
              title: Text(
                appBarTitle ?? context.l10n.more,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              leading: showBackButton
                  ? IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => context.router.maybePop(),
                    )
                  : null,
              actions: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications_outlined),
                      onPressed: () => _showComingSoon(context),
                    ),
                    if (notificationCount > 0)
                      Positioned(
                        right: 8.w,
                        top: 8.h,
                        child: Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.error,
                            shape: BoxShape.circle,
                          ),
                          constraints: BoxConstraints(minWidth: 18.w, minHeight: 18.w),
                          child: Text(
                            notificationCount > 9 ? '9+' : '$notificationCount',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onError,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            )
          : null,
      body: MultiBlocListener(
        listeners: [
          BlocListener<ClientToServerCubit, ClientToServerState>(
            listener: (context, state) {
              state.maybeWhen(
                success: (response) => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UnifiedProgressPage(
                      requestId: response.requestId,
                      operationType: OperationType.upload,
                    ),
                  ),
                ),
                error: (message) => ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.red)),
                orElse: () {},
              );
            },
          ),
          BlocListener<ServerToClientCubit, ServerToClientState>(
            listener: (context, state) {
              state.maybeWhen(
                success: (response) => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UnifiedProgressPage(operationType: OperationType.download),
                  ),
                ),
                error: (message) => ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.red)),
                orElse: () {},
              );
            },
          ),
          BlocListener<EmployeeCubit, EmployeeState>(
            listener: (context, state) {
              state.maybeWhen(
                submitSuccess: (_) async {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(context.l10n.loggedOut),
                      backgroundColor: Colors.green,
                    ),
                  );
                  await SessionHelper.clearSessionData();
                  if (context.mounted) context.router.replaceAll([LoginRoute()]);
                },
                orElse: () {},
              );
            },
          ),
        ],
        child: BlocBuilder<EmployeeCubit, EmployeeState>(
          builder: (context, state) {
            final EmployeeModel? data = state.maybeWhen<EmployeeModel?>(
              employeeDetail: (e) => e,
              orElse: () => employee,
            );
            final display = data ?? employee;
            final name = display?.displayName ?? context.l10n.statisticsDefaultUser;
            final phone = display?.phone ?? '';
            final email = display?.email ?? 'email@example.com';
            final firstLetter = name.isNotEmpty ? name[0].toUpperCase() : 'U';
            final profileImage = display?.profileImage;
            final userPosition = display?.position.trim();
            return SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  MoreSettingsLayout.horizontalPadding(context, 12.w),
                  MoreSettingsLayout.sz(context, 8, 8.h),
                  MoreSettingsLayout.horizontalPadding(context, 12.w),
                  MoreSettingsLayout.sz(context, 24, 24.h),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _ProfileSummaryCard(
                      theme: theme,
                      showOrganizationName: showOrganizationName,
                      userName: name,
                      userContact: email.isNotEmpty ? email : phone,
                      profileImage: profileImage,
                      userInitial: firstLetter,
                      roleLabel: (userPosition != null && userPosition.isNotEmpty)
                          ? userPosition
                          : null,
                    ),
                    SizedBox(height: MoreSettingsLayout.sz(context, 24, 24.h)),
                    MoreSectionLabel(context.l10n.operations),
                    MoreSettingsCard(
                      children: [
                        MoreNavTile(
                          icon: Icons.inventory_2_outlined,
                          title: context.l10n.operationManagement,
                          subtitle: context.l10n.operationManagementSubtitle,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => const OperationManagementPage(),
                            ),
                          ),
                        ),
                        MoreNavTile(
                          icon: Icons.groups_2_outlined,
                          title: context.l10n.employeeManagement,
                          subtitle: context.l10n.employeeManagementSubtitle,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => const EmployeeManagementHubPage(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MoreSettingsLayout.sz(context, 24, 24.h)),
                    MoreSectionLabel(context.l10n.report),
                    MoreSettingsCard(
                      children: [
                        MoreNavTile(
                          icon: Icons.bar_chart_rounded,
                          title: context.l10n.report,
                          subtitle: context.l10n.reportSubtitle,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => const ReportsHubPage(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MoreSettingsLayout.sz(context, 24, 24.h)),
                    MoreSectionLabel(context.l10n.preferences),
                    const MoreSettingsCard(
                      children: [
                        SubscriptionSettingsSection(embedded: true),
                        OrganizationSettingsSection(embedded: true),
                        BluetoothPrinterSettingsSection(embedded: true),
                        LanguageSettingsSection(embedded: true),
                        LiveStockTrackingSettingsSection(embedded: true),
                      ],
                    ),
                    SizedBox(height: MoreSettingsLayout.sz(context, 24, 24.h)),
                    MoreSectionLabel(context.l10n.security),
                    const MoreSettingsCard(
                      children: [
                        AppLockSettingsSection(embedded: true),
                      ],
                    ),
                    SizedBox(height: MoreSettingsLayout.sz(context, 24, 24.h)),
                    MoreSectionLabel(context.l10n.appearance),
                    const MoreSettingsCard(
                      children: [
                        AppearanceSettingsSection(embedded: true),
                      ],
                    ),
                    SizedBox(height: MoreSettingsLayout.sz(context, 24, 24.h)),
                    MoreSectionLabel(context.l10n.notifications),
                    const MoreSettingsCard(
                      children: [
                        NotificationSettingsSection(embedded: true),
                      ],
                    ),
                    SizedBox(height: MoreSettingsLayout.sz(context, 24, 24.h)),
                    MoreSectionLabel(context.l10n.dataAndBackup),
                    MoreSettingsCard(
                      children: [
                        const BackupSyncEntryTile(embedded: true),
                        // Demo / test data tools hidden from More → Data & Backup.
                        // if (AppPlatformConfig.isIOS)
                        //   const TestDataSettingsTile(),
                      ],
                    ),
                    SizedBox(height: MoreSettingsLayout.sz(context, 24, 24.h)),
                    MoreSectionLabel(context.l10n.helpAndSupport),
                    MoreSettingsCard(
                      children: [
                        MoreNavTile(
                          icon: Icons.help_outline_rounded,
                          title: context.l10n.faq,
                          onTap: () => _openFaq(context),
                        ),
                        MoreNavTile(
                          icon: Icons.star_outline_rounded,
                          title: context.l10n.rateUs,
                          onTap: () => _openRateUs(context),
                        ),
                        MoreNavTile(
                          icon: Icons.mail_outline_rounded,
                          title: context.l10n.contactUs,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => const ContactUsPage(),
                            ),
                          ),
                        ),
                        MoreNavTile(
                          icon: Icons.verified_user_outlined,
                          title: context.l10n.privacyAndPolicies,
                          onTap: () => _openPrivacyPolicy(context),
                        ),
                      ],
                    ),
                    SizedBox(height: MoreSettingsLayout.sz(context, 24, 24.h)),
                    _LogoutButton(onPressed: () => _showLogoutDialog(context)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final logoutColor = theme.colorScheme.error;
    return Material(
      color: logoutColor.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(MoreSettingsLayout.cardRadius(context)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: MoreSettingsLayout.sz(context, 16, 16.h),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout_rounded,
                color: logoutColor,
                size: MoreSettingsLayout.sp(context, 22, 22),
              ),
              SizedBox(width: MoreSettingsLayout.sz(context, 8, 8.w)),
              Text(
                context.l10n.logout,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: logoutColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileSummaryCard extends StatelessWidget {
  const _ProfileSummaryCard({
    required this.theme,
    required this.showOrganizationName,
    required this.userName,
    required this.userContact,
    required this.profileImage,
    required this.userInitial,
    this.roleLabel,
  });

  final ThemeData theme;
  final bool showOrganizationName;
  final String userName;
  final String userContact;
  final String? profileImage;
  final String userInitial;
  final String? roleLabel;

  @override
  Widget build(BuildContext context) {
    if (!showOrganizationName) {
      return MoreSettingsCard(
        children: [
          _UserProfileRow(
            theme: theme,
            userName: userName,
            userContact: userContact,
            profileImage: profileImage,
            userInitial: userInitial,
            roleLabel: roleLabel,
          ),
        ],
      );
    }

    return MoreSettingsCard(
      children: [
        ListenableBuilder(
            listenable: OrgSwitchCoordinator.notifier,
            builder: (context, _) {
              return FutureBuilder<(OrganizationSettings?, String?)>(
                future: () async {
                  final settings = await OrganizationSettingsService().load();
                  final code = await OrgStorage.getOrgCode();
                  return (settings, code);
                }(),
                builder: (context, snapshot) {
                  final settings = snapshot.data?.$1;
                  final orgCode = snapshot.data?.$2?.trim();
                  final organizationName = settings == null
                      ? null
                      : (settings.organizationName.isNotEmpty
                          ? settings.organizationName
                          : (settings.organizationSlug.isNotEmpty
                              ? settings.organizationSlug
                              : null));
                  final businessType = settings?.businessType;
                  final organizationLogo = settings?.logo;
                  final hasOrganization =
                      organizationName != null && organizationName.isNotEmpty;
                  if (!hasOrganization) return const SizedBox.shrink();

                  final businessLabel = (businessType != null && businessType.isNotEmpty)
                      ? context.l10n.businessTypeLabel(businessType)
                      : null;

                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => showOrganizationPickerBottomSheet(context),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          MoreSettingsLayout.sz(context, 16, 16.w),
                          MoreSettingsLayout.sz(context, 16, 16.h),
                          MoreSettingsLayout.sz(context, 12, 12.w),
                          MoreSettingsLayout.sz(context, 16, 16.h),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MoreIconBox(
                              icon: OrganizationBusinessType.iconFor(businessType),
                              filled: true,
                              logo: organizationLogo,
                            ),
                            SizedBox(width: MoreSettingsLayout.sz(context, 12, 12.w)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    context.l10n.organizationSettings.toUpperCase(),
                                    style: MoreSettingsLayout.sectionLabel(theme),
                                  ),
                                  SizedBox(height: MoreSettingsLayout.sz(context, 4, 4.h)),
                                  Text(
                                    organizationName,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  if (businessLabel != null || (orgCode != null && orgCode.isNotEmpty)) ...[
                                    SizedBox(height: MoreSettingsLayout.sz(context, 8, 8.h)),
                                    Wrap(
                                      spacing: MoreSettingsLayout.sz(context, 8, 8.w),
                                      runSpacing: MoreSettingsLayout.sz(context, 6, 6.h),
                                      children: [
                                        if (businessLabel != null)
                                          MoreBadge(label: businessLabel, tinted: true),
                                        if (orgCode != null && orgCode.isNotEmpty)
                                          MoreBadge(label: orgCode),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        // const MoreSettingsDivider(),
        _UserProfileRow(
          theme: theme,
          userName: userName,
          userContact: userContact,
          profileImage: profileImage,
          userInitial: userInitial,
          roleLabel: roleLabel,
        ),
      ],
    );
  }
}

class _UserProfileRow extends StatelessWidget {
  const _UserProfileRow({
    required this.theme,
    required this.userName,
    required this.userContact,
    required this.profileImage,
    required this.userInitial,
    this.roleLabel,
  });

  final ThemeData theme;
  final String userName;
  final String userContact;
  final String? profileImage;
  final String userInitial;
  final String? roleLabel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: getIt<SubscriptionService>(),
      builder: (context, _) {
        return _buildContent(context);
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    final billing = getIt<SubscriptionService>();
    final planLabel = AppBillingConfig.showBillingUi && billing.hasPremiumAccess
        ? billing.activePlanDisplayLabel
        : null;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        MoreSettingsLayout.sz(context, 16, 16.w),
        MoreSettingsLayout.sz(context, 12, 12.h),
        MoreSettingsLayout.sz(context, 16, 16.w),
        MoreSettingsLayout.sz(context, 16, 16.h),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          EmployeeProfileAvatar(
            profileImage: profileImage,
            initial: userInitial,
            radius: MoreSettingsLayout.sz(context, 24, 24.r),
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            initialStyle: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.primary,
            ),
          ),
          SizedBox(width: MoreSettingsLayout.sz(context, 12, 12.w)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (userContact.isNotEmpty) ...[
                  SizedBox(height: MoreSettingsLayout.sz(context, 2, 2.h)),
                  Text(
                    userContact,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: MoreSettingsLayout.tileSubtitle(theme),
                  ),
                ],
                if (planLabel != null) ...[
                  SizedBox(height: MoreSettingsLayout.sz(context, 6, 6.h)),
                  Row(
                    children: [
                      Icon(
                        Icons.verified_rounded,
                        size: MoreSettingsLayout.sp(context, 14, 14),
                        color: theme.colorScheme.primary,
                      ),
                      SizedBox(width: MoreSettingsLayout.sz(context, 4, 4.w)),
                      Flexible(
                        child: Text(
                          planLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          if (roleLabel != null) MoreBadge(label: roleLabel!, tinted: true),
        ],
      ),
    );
  }
}

class _MorePageView extends StatelessWidget {
  const _MorePageView();

  Future<void> _retryEmployeeProfile(BuildContext context) async {
    final userId = await SessionHelper.getUserId();
    if (userId == null || userId.trim().isEmpty) return;
    if (!context.mounted) return;
    context.read<EmployeeCubit>().getEmployeeById(userId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeCubit, EmployeeState>(
      builder: (context, state) {
        return state.when(
          initial: () => const AccountSettingsBody(
            showAppBar: true,
            showBackButton: false,
            showOrganizationName: true,
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          submitting: () => const Center(child: CircularProgressIndicator()),
          noInternet: () => TabErrorView(
            title: context.l10n.noInternetConnection.replaceAll('.', ''),
            message: context.l10n.statisticsCheckConnection,
            isNoInternet: true,
            onRetry: () => _retryEmployeeProfile(context),
          ),
          error: (message) => TabErrorView(
            title: context.l10n.statisticsCouldNotLoadProfile,
            message: message,
            onRetry: () => _retryEmployeeProfile(context),
          ),
          employeeDetail: (data) => AccountSettingsBody(
            employee: data,
            showAppBar: true,
            showBackButton: false,
            showOrganizationName: true,
          ),
          loaded: (_) => const AccountSettingsBody(
            showAppBar: true,
            showBackButton: false,
            showOrganizationName: true,
          ),
          submitSuccess: (_) => const AccountSettingsBody(
            showAppBar: true,
            showBackButton: false,
            showOrganizationName: true,
          ),
        );
      },
    );
  }
}
