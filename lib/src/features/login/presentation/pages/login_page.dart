import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hotel/src/core/helpers/keyboard_dismiss_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/constants/margin_constants.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/themes/app_colors.dart';
import 'package:hotel/src/core/config/app_platform_config.dart';
import 'package:hotel/src/core/helpers/post_auth_navigation.dart';
import 'package:hotel/src/core/widget/app_brand_name.dart';
import 'package:hotel/src/core/widget/app_logo.dart';
import 'package:hotel/src/core/widget/app_splash_image.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/core/widget/language_flag_switch.dart';
import 'package:hotel/src/core/services/token_storage.dart';
import 'package:hotel/src/features/login/data/models/login_request_params.dart';
import 'package:hotel/src/features/login/domain/login_signup_prefill_storage.dart';
import 'package:hotel/src/features/login/presentation/bloc/login_cubit.dart';
import 'package:hotel/src/features/setup/domain/setup_field_limits.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:hotel/src/features/org/presentation/widgets/organization_badge.dart';
import 'package:hotel/src/features/permission/presentation/cubit/user_permissions_cubit.dart';
import 'package:hotel/src/features/setup/domain/test_data_login_service.dart';
import 'package:hotel/src/features/app_lock/domain/app_lock_coordinator.dart';
import 'package:hotel/src/features/app_lock/domain/app_lock_service.dart';
import 'package:hotel/src/features/app_lock/domain/last_login_email_storage.dart';
import 'package:hotel/src/features/app_lock/presentation/pages/app_lock_setup_flow_page.dart';
import 'package:hotel/src/features/app_lock/presentation/widgets/login_quick_unlock_section.dart';
import 'package:hotel/src/features/login/presentation/widgets/login_page_layout.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  String? _allowedEmailDomain;
  bool _credentialsLocked = false;
  String _lockedLoginEmail = '';
  String _lockedLoginPassword = '';
  final _appLockService = AppLockService();
  bool _completingLogin = false;

  /// In-route loader (avoids root [Overlay] + route replace racing [_Theater] GlobalKeys).
  final ValueNotifier<bool> _loginLoadingOverlay = ValueNotifier<bool>(false);

  ColorScheme get _scheme => Theme.of(context).colorScheme;

  Color get _fieldBorderColor => _scheme.outlineVariant.withValues(alpha: 0.65);

  Color get _lockedFieldFillColor => _scheme.surfaceContainerHighest;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _ensureOrganizationSelected();
      await _refreshLoginFieldsForWorkspace();
    });
  }

  Future<void> _refreshLoginFieldsForWorkspace() async {
    await _loadAllowedEmailDomain();
    await _loadTestDataLoginPrefill();
    if (!_credentialsLocked) {
      final prefilledSignup = await _loadSignupPrefill();
      if (!prefilledSignup) {
        await _loadLastLoginEmail();
      }
    }
  }

  /// Returns true when email and password were prefilled from manual signup.
  Future<bool> _loadSignupPrefill() async {
    final signupCreds = await LoginSignupPrefillStorage.loadForActiveOrg();
    if (signupCreds == null || !mounted || _credentialsLocked) return false;

    final domain = _allowedEmailDomain?.trim();
    setState(() {
      _emailController.text = _emailLocalPart(signupCreds.email, domain);
      _passwordController.text = signupCreds.password;
    });
    return true;
  }

  Future<void> _loadLastLoginEmail() async {
    final lastEmail = await LastLoginEmailStorage.load();
    if (lastEmail == null || !mounted || _credentialsLocked) return;

    final domain = _allowedEmailDomain?.trim();
    setState(() {
      _emailController.text = _emailLocalPart(lastEmail, domain);
    });
  }

  Future<void> _loadTestDataLoginPrefill() async {
    final shouldLock =
        await TestDataLoginService.isActiveOrganizationDemo();
    if (!shouldLock || !mounted) return;

    final creds =
        await TestDataLoginService.resolveCredentialsForActiveOrganization();
    final domain = _allowedEmailDomain?.trim();
    final emailForField = _emailLocalPart(creds.email, domain);

    if (!mounted) return;
    setState(() {
      _credentialsLocked = true;
      _lockedLoginEmail = creds.email;
      _lockedLoginPassword = creds.password;
      _emailController.text = emailForField;
      _passwordController.text = creds.password;
    });
  }

  String _emailLocalPart(String email, String? domain) {
    if (domain == null || domain.isEmpty || !email.contains('@')) {
      return email;
    }
    final parts = email.split('@');
    if (parts.length == 2 && parts.last.toLowerCase() == domain.toLowerCase()) {
      return parts.first;
    }
    return email;
  }

  Future<void> _loadAllowedEmailDomain() async {
    final domain = await OrgStorage.getAllowedEmailDomain();
    if (!mounted) return;
    setState(() => _allowedEmailDomain = domain);
  }

  Future<void> _onWorkspaceChanged() async {
    if (!mounted) return;

    _emailController.clear();
    _passwordController.clear();
    setState(() {
      _credentialsLocked = false;
      _lockedLoginEmail = '';
      _lockedLoginPassword = '';
      _rememberMe = false;
      _allowedEmailDomain = null;
    });

    await _refreshLoginFieldsForWorkspace();
  }

  Future<void> _ensureOrganizationSelected() async {
    if (!await OrgStorage.hasOrgSlug()) {
      if (!mounted) return;
      context.router.replace(const OrganizationCodeRoute());
    }
  }

  void _setLoginLoading(bool visible) {
    _loginLoadingOverlay.value = visible;
  }

  void _deferIfMounted(Future<void> Function() fn) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted || _completingLogin) return;
      await fn();
    });
  }

  @override
  void dispose() {
    _completingLogin = true;
    FocusManager.instance.primaryFocus?.unfocus();
    _loginLoadingOverlay.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _completeSignIn(String email) async {
    final normalized = email.trim().toLowerCase();
    await LoginSignupPrefillStorage.clearForActiveOrg();
    await TokenStorage.saveUserLoginEmail(normalized);
    await LastLoginEmailStorage.save(normalized);
    if (!mounted) return;
    await context
        .read<UserPermissionsCubit>()
        .fetchUserPermissions(userId: normalized);
    if (!mounted) return;
    await dismissKeyboard(settleDelay: const Duration(milliseconds: 120));
    if (!mounted) return;
    await navigateToHomeOrPaywall(context.router);
  }

  String _loginEmail() {
    final raw = _emailController.text.trim();
    final domain = _allowedEmailDomain?.trim();
    if (domain == null || domain.isEmpty) return raw;
    final local = raw.replaceAll('@', '');
    return '$local@$domain';
  }

  void _signInWithPassword() {
    if (!_formKey.currentState!.validate()) return;

    final creds = _credentialsLocked
        ? (email: _lockedLoginEmail, password: _lockedLoginPassword)
        : (
            email: _loginEmail(),
            password: _passwordController.text,
          );

    context.read<LoginCubit>().postLogin(
          params: LoginRequestParams(
            email: creds.email,
            password: creds.password,
          ),
        );
  }

  Future<bool> _offerQuickUnlockSetupIfNeeded() async {
    final shouldOffer = await _appLockService.shouldOfferDevicePinSetup();
    if (!shouldOffer || !mounted) return false;

    FocusManager.instance.primaryFocus?.unfocus();
    await dismissKeyboard(settleDelay: const Duration(milliseconds: 80));
    if (!mounted) return false;

    final wantsSetup = await showAppLockSetupPromptSheet(context);
    if (!mounted || wantsSetup != true) return false;

    final setupDone = await Navigator.of(context, rootNavigator: true).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => AppLockSetupFlowPage(
          appLockService: _appLockService,
          quickUnlockEmail: _loginEmail().trim().toLowerCase(),
        ),
      ),
    );
    if (!mounted) return false;
    return setupDone == true;
  }

  InputDecoration _emailInputDecoration({String? hintText}) {
    final fieldRadius = LoginPageLayout.fieldRadius(context);
    return InputDecoration(
      hintText: hintText,
      hintStyle: context.theme.textTheme.bodyLarge?.copyWith(
        color: _scheme.onSurfaceVariant.withValues(alpha: 0.7),
        fontWeight: FontWeight.w400,
      ),
      prefixIcon: Icon(
        Icons.email_outlined,
        size: LoginPageLayout.fieldIconSize(context),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(fieldRadius),
        borderSide: BorderSide(color: _fieldBorderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(fieldRadius),
        borderSide: BorderSide(color: _fieldBorderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(fieldRadius),
        borderSide: BorderSide(
          color: _scheme.primary,
          width: LoginPageLayout.fieldFocusedBorderWidth(context),
        ),
      ),
      filled: true,
      fillColor: _credentialsLocked ? _lockedFieldFillColor : _scheme.surfaceContainerHighest,
    );
  }

  String? _validateLoginEmail(String? value) {
    final domain = _allowedEmailDomain?.trim();
    final fullEmail = domain == null || domain.isEmpty
        ? value?.trim() ?? ''
        : '${(value?.trim() ?? '').replaceAll('@', '')}@$domain';
    if (fullEmail.isEmpty) {
      return context.l10n.pleaseEnterEmail;
    }
    if (fullEmail.length > SetupFieldLimits.maxEmailLength) {
      return context.l10n.fieldMaxLength(
        context.l10n.email,
        SetupFieldLimits.maxEmailLength,
      );
    }
    return null;
  }

  Widget _buildEmailField() {
    final domain = _allowedEmailDomain?.trim();
    if (domain == null || domain.isEmpty) {
      return CustomTextFormField(
        controller: _emailController,
        prefixIcon: Icon(Icons.email_outlined,color: context.theme.colorScheme.textSecondary.withOpacity(0.7)),
        keyboardType: TextInputType.emailAddress,
        maxLength: SetupFieldLimits.maxEmailLength,
        readOnly: _credentialsLocked,
        enabled: !_credentialsLocked,
        hint: context.l10n.enterEmail,
        validating: (value) {
          final lengthError = _validateLoginEmail(value);
          if (lengthError != null) return lengthError;
          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!.trim())) {
            return context.l10n.pleaseEnterValidEmail;
          }
          return null;
        },
      );
    }

    final localMaxLength =
        SetupFieldLimits.maxEmailLength - domain.length - 1;

    return CustomTextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      maxLength: localMaxLength > 0 ? localMaxLength : 1,
      prefixIcon: Icon(
        Icons.email_outlined,
        color: context.theme.colorScheme.textSecondary.withOpacity(0.7),
      ),
      hint: context.l10n.enterEmail,
      suffixText: '@$domain',
      suffixStyle: context.theme.textTheme.bodyLarge?.copyWith(
        color: _scheme.onSurfaceVariant,
        fontWeight: FontWeight.w600,
      ),
      readOnly: _credentialsLocked,
      enabled: !_credentialsLocked,
      validating: (value) {
        final local = value?.trim() ?? '';
        if (local.isEmpty) {
          return context.l10n.pleaseEnterEmail;
        }
        if (local.contains('@')) {
          return context.l10n.enterEmailLocalPartOnly;
        }
        if (!RegExp(r'^[\w\.\-]+$').hasMatch(local)) {
          return context.l10n.pleaseEnterValidEmail;
        }
        final lengthError = _validateLoginEmail(value);
        if (lengthError != null) return lengthError;
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = _scheme;
    final isTablet = LoginPageLayout.isTablet(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              noInternet: () => context.showKiiSnackBarError(context.l10n.noInternetConnection),
              loading: () => _setLoginLoading(true),
              error: (message) {
                _setLoginLoading(false);
                context.showKiiSnackBarError(message);
              },
              success: (response) {
                _deferIfMounted(() async {
                  if (!context.mounted || _completingLogin) return;
                  _completingLogin = true;

                  _setLoginLoading(false);
                  FocusManager.instance.primaryFocus?.unfocus();
                  final router = context.router;
                final userEmail = _credentialsLocked
                    ? _lockedLoginEmail
                    : _loginEmail().trim().toLowerCase();
                  if (userEmail.isEmpty) {
                    _completingLogin = false;
                    return;
                  }

                  await TokenStorage.saveUserLoginEmail(userEmail);
                  await LastLoginEmailStorage.save(userEmail);
                  await LoginSignupPrefillStorage.clearForActiveOrg();

                  if (context.mounted) {
                    await context
                        .read<UserPermissionsCubit>()
                        .fetchUserPermissions(userId: userEmail);
                  }
                  if (!context.mounted) return;
                  final pinJustSet = await _offerQuickUnlockSetupIfNeeded();
                  if (pinJustSet) {
                    AppLockCoordinator.markSessionUnlocked();
                  }
                  if (!context.mounted) return;
                  context.clearSnackBars();
                  await dismissKeyboard(
                    settleDelay: const Duration(milliseconds: 120),
                  );
                  if (!context.mounted) return;
                  await navigateToHomeOrPaywall(router);
                });
              },
            );
          },
        ),
      ],
      child: ValueListenableBuilder<bool>(
        valueListenable: _loginLoadingOverlay,
        builder: (context, showLoginLoading, _) {
          return Stack(
            children: [
              Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: LoginPageLayout.horizontalPadding(context),
                    right: LoginPageLayout.horizontalPadding(context),
                    top: LoginPageLayout.scrollTopPadding(context),
                    bottom: MediaQuery.viewInsetsOf(context).bottom +
                        LoginPageLayout.scrollBottomExtra(context),
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: LoginPageLayout.maxContentWidth(context),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(
                        LoginPageLayout.contentInnerPadding(context),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              children: [
                                if (AppPlatformConfig.splashAsset != null)
                                  AppSplashImage(
                                    height: LoginPageLayout.splashLogoSize(context),
                                    width: LoginPageLayout.splashLogoSize(context),
                                  )
                                else ...[
                                  AppLogo(
                                    height: LoginPageLayout.appLogoSize(context),
                                    width: LoginPageLayout.appLogoSize(context),
                                    errorIconSize:
                                        LoginPageLayout.appLogoErrorIconSize(context),
                                  ),
                                  SizedBox(
                                    height: LoginPageLayout.spacingAfterLogo(context),
                                  ),
                                  AppBrandName(
                                    style: AppFonts.interStyle(
                                      fontSize: LoginPageLayout.brandFontSize(context),
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                ],
                                Transform.translate(
                                  offset: Offset(
                                    0,
                                    LoginPageLayout.welcomeBackTopOffset(
                                      context,
                                    ),
                                  ),
                                  child: Text(
                                    context.l10n.welcomeBack,
                                    style: AppFonts.interStyle(
                                      fontSize: LoginPageLayout.titleFontSize(
                                        context,
                                      ),
                                      fontWeight: FontWeight.bold,
                                      color: scheme.onSurface,
                                      height: 1.1,
                                    ),
                                  ),
                                ),
                                verticalMarginTiny,
                                Text(
                                  context.l10n.signInToContinue,
                                  style: AppFonts.interStyle(
                                    fontSize: LoginPageLayout.subtitleFontSize(context),
                                    color: scheme.onSurfaceVariant,
                                  ),
                                ),
                                OrganizationBadge(
                                  onOrganizationChanged: _onWorkspaceChanged,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: LoginPageLayout.spacingAfterHeader(context),
                            ),
                            _buildEmailField(),
                            SizedBox(
                              height: LoginPageLayout.spacingBetweenFields(context),
                            ),
                            CustomTextFormField(
                              controller: _passwordController,
                              obscureText: !_isPasswordVisible,
                              readOnly: _credentialsLocked,
                              enabled: !_credentialsLocked,
                              hint: context.l10n.enterPassword,
                              hintStyle: context.theme.textTheme.bodyLarge
                                  ?.copyWith(
                                color: scheme.onSurfaceVariant
                                    .withValues(alpha: 0.7),
                                fontWeight: FontWeight.w400,
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: context
                                    .theme.colorScheme.textSecondary
                                    .withOpacity(0.7),
                              ),
                              suffixIcon: _credentialsLocked
                                  ? null
                                  : IconButton(
                                      icon: Icon(
                                        _isPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: scheme.onSurfaceVariant,
                                        size: LoginPageLayout.passwordVisibilityIconSize(
                                          context,
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isPasswordVisible =
                                              !_isPasswordVisible;
                                        });
                                      },
                                    ),
                              validating: (value) {
                                if (value == null || value.isEmpty) {
                                  return context.l10n.pleaseEnterPassword;
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: LoginPageLayout.spacingBeforeButton(context),
                            ),
                            CustomButtonWidget.primary(
                              onPressed: _signInWithPassword,
                              title: context.l10n.logIn,
                              height: LoginPageLayout.buttonHeight(context),
                              borderRadius: LoginPageLayout.buttonRadius(context),
                              useFixedSizes: isTablet,
                            ),
                            SizedBox(
                              height: LoginPageLayout.spacingAfterButton(context),
                            ),
                            if (!_credentialsLocked)
                              ValueListenableBuilder<TextEditingValue>(
                                valueListenable: _emailController,
                                builder: (context, _, __) {
                                  return LoginQuickUnlockSection(
                                    email: _loginEmail(),
                                    appLockService: _appLockService,
                                    onQuickSignIn: _completeSignIn,
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: LoginPageLayout.languageSwitchPadding(context),
                  child: const LanguageFlagSwitch(),
                ),
              ),
            ),
          ],
        ),
      ),
              if (showLoginLoading)
                Positioned.fill(
                  child: AbsorbPointer(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const ModalBarrier(dismissible: false),
                        Container(
                          decoration: BoxDecoration(
                            color: context.theme.colorScheme.surface,
                            borderRadius: allRadiusLarge,
                          ),
                          padding: symmetricPaddingMedium,
                          child: const CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
