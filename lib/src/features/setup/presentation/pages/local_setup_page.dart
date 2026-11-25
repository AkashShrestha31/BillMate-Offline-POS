import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hotel/l10n/app_localizations.dart';
import 'package:hotel/src/core/helpers/keyboard_dismiss_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/constants/app_constants.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/services/token_storage.dart';
import 'package:hotel/src/core/widget/app_brand_name.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/core/widget/uploadable_image_avatar.dart';
import 'package:hotel/src/core/helpers/image_picker_helper.dart';
import 'package:hotel/src/core/helpers/item_image_helper.dart';
import 'package:hotel/src/features/login/domain/login_signup_prefill_storage.dart';
import 'package:hotel/src/features/app_lock/domain/last_login_email_storage.dart';
import 'package:hotel/src/features/backup/presentation/widgets/restore_from_drive_sheet.dart';
import 'package:hotel/src/features/org/domain/country_fiscal_year.dart';
import 'package:hotel/src/features/org/domain/country_tax_profile.dart';
import 'package:hotel/src/features/org/domain/country_tax_rate_picker.dart';
import 'package:hotel/src/features/org/domain/tax_id_format_catalog.dart';
import 'package:hotel/src/features/org/domain/invoice_tax_kind.dart';
import 'package:hotel/src/features/org/domain/organization_business_type.dart';
import 'package:hotel/src/features/org/domain/tax_math.dart';
import 'package:hotel/src/features/org/domain/tax_settings_service.dart';
import 'package:hotel/src/features/org/presentation/widgets/tax_id_label_picker_sheet.dart';
import 'package:hotel/src/features/org/domain/organization_code_generator.dart';
import 'package:hotel/src/features/org/domain/organization_field_limits.dart';
import 'package:hotel/src/features/org/presentation/widgets/business_type_picker_field.dart';
import 'package:hotel/src/features/org/presentation/org_navigation.dart';
import 'package:hotel/src/features/setup/data/models/setup_complete_request.dart';
import 'package:hotel/src/core/services/currency/currency_picker_option.dart';
import 'package:hotel/src/core/layout/device_layout.dart';
import 'package:hotel/src/core/widget/country_searchable_bottom_sheet.dart';
import 'package:hotel/src/core/widget/currency_searchable_bottom_sheet.dart';
import 'package:hotel/src/features/setup/domain/currency_seed_data.dart';
import 'package:hotel/src/features/setup/domain/setup_field_limits.dart';
import 'package:hotel/src/features/setup/domain/local_setup_service.dart';
import 'package:hotel/src/features/setup/domain/setup_region_options.dart';
import 'package:hotel/src/features/setup/domain/setup_credentials_pdf_service.dart';
import 'package:hotel/src/features/setup/presentation/widgets/setup_bottom_action_bar.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/l10n/platform_app_localizations.dart';

enum _SetupFinishChoice {
  cancelled,
  continueWithoutPdf,
  downloadPdf,
}

@RoutePage()
class LocalSetupPage extends StatefulWidget {
  const LocalSetupPage({super.key});

  @override
  State<LocalSetupPage> createState() => _LocalSetupPageState();
}

class _LocalSetupPageState extends State<LocalSetupPage> {
  static final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static const _minPasswordLength = 6;
  final _pageController = PageController();
  final _formKeys = List.generate(4, (_) => GlobalKey<FormState>());

  final _orgNameController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _logoPathNotifier = ValueNotifier<String?>(null);
  final _logoRemovedNotifier = ValueNotifier<bool>(false);
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _taxRateController = TextEditingController();
  final _taxIdNumberController = TextEditingController();

  String _country = '';
  String _taxIdLabel = 'TIN';
  TaxMode _taxMode = TaxMode.exclusive;
  InvoiceTaxKind _taxKind = InvoiceTaxKind.vat;
  String _currency = '';
  String _businessType = OrganizationBusinessType.defaultCode;
  List<CurrencyPickerOption> _currencyOptions = [];
  List<SetupCountryOption> _countryOptions = [];
  DateTime _fiscalStart = CountryFiscalYears.datesFor('').$1;
  DateTime _fiscalEnd = CountryFiscalYears.datesFor('').$2;

  int _step = 0;
  final Set<int> _stepsWithValidationAttempt = {};
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _loadRegionOptions();
  }

  Future<void> _pickOrganizationLogo() async {
    final path = await ImagePickerHelper.pickImagePath(
      context,
      maxWidth: 800,
      maxHeight: 800,
    );
    if (path == null || !mounted) return;
    _logoPathNotifier.value = path;
    _logoRemovedNotifier.value = false;
    setState(() {});
  }

  Future<String?> _encodeSelectedLogo() async {
    if (_logoRemovedNotifier.value) return null;
    final localPath = _logoPathNotifier.value;
    if (localPath == null || localPath.isEmpty) return null;
    final encoded = await ItemImageHelper.encodeFileForStorage(localPath);
    if (encoded == null && mounted) {
      context.showKiiSnackBarError(context.l10n.itemImageSizeError);
    }
    return encoded;
  }

  Future<void> _loadRegionOptions() async {
    _countryOptions = SetupRegionOptions.countries();
    try {
      final options = await CurrencySeedData.pickerOptionsFromAsset();
      if (!mounted) return;
      setState(() {
        _currencyOptions = options;
        _syncCurrencyToCountry();
      });
    } catch (_) {
      if (mounted) setState(() => _syncCurrencyToCountry());
    }
  }

  void _syncCurrencyToCountry() {
    if (_country.trim().isEmpty) return;
    final code = SetupRegionOptions.currencyCodeForCountry(_country);
    if (code != null) {
      _currency = code;
      return;
    }
    if (!_currencyOptions.any((o) => o.code == _currency) &&
        _currencyOptions.isNotEmpty) {
      _currency = _currencyOptions.first.code;
    }
  }

  void _applyCountryTaxDefaults(String country) {
    if (country.trim().isEmpty) return;
    final profile = CountryTaxProfiles.of(country);
    final defaults = TaxSettingsService.defaultsForCountry(
      country,
      taxKind: _taxKind,
    );
    _taxRateController.text = profile.formatRate(defaults.defaultTaxRate);
    _taxIdLabel = defaults.taxIdLabel ?? 'TIN';
    _taxMode = defaults.taxMode;
    final (fyStart, fyEnd) = CountryFiscalYears.datesFor(country);
    _fiscalStart = fyStart;
    _fiscalEnd = fyEnd;
  }

  void _selectTaxKind(InvoiceTaxKind kind) {
    if (_taxKind == kind) return;
    setState(() {
      _taxKind = kind;
      _applyCountryTaxDefaults(_country);
    });
  }

  Widget _buildKindRatePresets({
    required ThemeData theme,
    required AppLocalizations l10n,
    required bool isTablet,
  }) {
    if (_country.trim().isEmpty) return const SizedBox.shrink();
    final profile = CountryTaxProfiles.of(_country);
    final rates = profile.ratesFor(_taxKind);
    if (rates.length < 2) return const SizedBox.shrink();
    final current = double.tryParse(_taxRateController.text.trim()) ?? 0;
    final scheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: isTablet ? 10 : 8),
        Text(
          l10n.checkoutTaxPresetsForCountry(_country),
          style: theme.textTheme.labelMedium?.copyWith(
            color: scheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: isTablet ? 8 : 8),
        Wrap(
          spacing: isTablet ? 8 : 8.w,
          runSpacing: isTablet ? 8 : 8.h,
          children: [
            for (final rate in rates)
              FilterChip(
                selected: (current - rate).abs() < 0.001,
                label: Text('${profile.formatRate(rate)}%'),
                onSelected: (_) => setState(() {
                  _taxRateController.text = profile.formatRate(rate);
                }),
                showCheckmark: false,
                backgroundColor: scheme.surfaceContainerHighest,
                selectedColor: scheme.primaryContainer.withValues(alpha: 0.7),
                side: BorderSide(
                  color: (current - rate).abs() < 0.001
                      ? scheme.primary.withValues(alpha: 0.35)
                      : scheme.outlineVariant.withValues(alpha: 0.8),
                ),
                labelStyle: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: isTablet ? 13 : 12.sp,
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildSetupSegmentedControl<T>({
    required ThemeData theme,
    required bool isTablet,
    required List<T> values,
    required T selected,
    required String Function(T value) labelOf,
    required ValueChanged<T> onChanged,
  }) {
    final scheme = theme.colorScheme;
    const radius = 8.0;
    final borderColor = scheme.outlineVariant.withValues(alpha: 0.75);
    final minHeight = isTablet ? 40.0 : 40.h;
    final hPad = isTablet ? 16.0 : 14.w;
    final vPad = isTablet ? 10.0 : 8.h;
    final fontSize = isTablet ? 12.0 : 11.sp;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < values.length; i++) ...[
                if (i > 0) Container(width: 1, color: borderColor),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => onChanged(values[i]),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 160),
                        constraints: BoxConstraints(minHeight: minHeight),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                          horizontal: hPad,
                          vertical: vPad,
                        ),
                        color: selected == values[i]
                            ? scheme.primaryContainer
                            : Colors.transparent,
                        child: Text(
                          labelOf(values[i]),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: selected == values[i]
                                ? FontWeight.w700
                                : FontWeight.w500,
                            fontSize: fontSize,
                            height: 1.2,
                            color: selected == values[i]
                                ? scheme.onPrimaryContainer
                                : scheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String? _taxIdNumberHint(AppLocalizations l10n) {
    final example = TaxIdFormatCatalog.exampleFor(
      country: _country,
      label: _taxIdLabel,
    );
    return example == null ? null : l10n.taxIdNumberHint(example);
  }

  Widget _buildTaxSectionLabel(ThemeData theme, String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.onSurface,
        ),
      ),
    );
  }

  String? _validateTaxRate(String? value) {
    final l10n = context.l10n;
    if (value == null || value.trim().isEmpty) {
      return l10n.fieldRequired(l10n.defaultTaxRate);
    }
    final parsed = double.tryParse(value.trim());
    if (parsed == null ||
        parsed < TaxSettingsService.minTaxRate ||
        parsed > TaxSettingsService.maxTaxRate) {
      return l10n.taxRateRange;
    }
    return null;
  }

  Future<void> _showTaxIdLabelPicker() async {
    final selected = await showTaxIdLabelPickerBottomSheet(
      context,
      currentLabel: _taxIdLabel,
      country: _country,
      taxKind: _taxKind,
    );
    if (selected != null && mounted) {
      setState(() => _taxIdLabel = selected);
    }
  }

  String get _countryFieldLabel => _country;

  String get _currencyFieldLabel {
    final match = _currencyOptions.where((o) => o.code == _currency);
    if (match.isNotEmpty) return match.first.fieldLabel;
    return _currency;
  }

  Future<void> _showCountryPicker() async {
    if (_countryOptions.isEmpty) {
      _countryOptions = SetupRegionOptions.countries();
    }
    if (_currencyOptions.isEmpty) {
      await _loadRegionOptions();
    }
    if (!mounted) return;

    final l10n = context.l10n;
    final selected = await showCountryPickerBottomSheet(
      context: context,
      title: l10n.selectCountry,
      searchHint: l10n.searchCountry,
      countries: _countryOptions,
      currentCountry: _country,
    );
    if (selected != null && mounted) {
      setState(() {
        _country = selected;
        _syncCurrencyToCountry();
        _applyCountryTaxDefaults(selected);
      });
    }
  }

  Future<void> _showCurrencyPicker() async {
    if (_currencyOptions.isEmpty) {
      await _loadRegionOptions();
    }
    if (!mounted) return;

    final l10n = context.l10n;
    final selected = await showCurrencyPickerBottomSheet(
      context: context,
      title: l10n.selectCurrency,
      searchHint: l10n.searchCodeOrSymbol,
      options: _currencyOptions,
      currentCode: _currency,
    );
    if (selected != null && mounted) {
      setState(() => _currency = selected);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _orgNameController.dispose();
    _companyNameController.dispose();
    _logoPathNotifier.dispose();
    _logoRemovedNotifier.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _bankNameController.dispose();
    _taxRateController.dispose();
    _taxIdNumberController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime d) {
    return '${d.year.toString().padLeft(4, '0')}-'
        '${d.month.toString().padLeft(2, '0')}-'
        '${d.day.toString().padLeft(2, '0')}';
  }

  Future<void> _showOptionSheet({
    required String title,
    required List<String> options,
    required String current,
    required ValueChanged<String> onSelected,
  }) async {
    final theme = Theme.of(context);
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        final maxHeight = MediaQuery.sizeOf(ctx).height * 0.55;
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(ctx).bottom),
          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              constraints: BoxConstraints(maxHeight: maxHeight),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
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
                            title,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => Navigator.pop(ctx),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      itemCount: options.length,
                      separatorBuilder: (_, __) => Divider(
                        height: 1,
                        indent: 16,
                        endIndent: 16,
                        color: theme.colorScheme.outlineVariant
                            .withValues(alpha: 0.5),
                      ),
                      itemBuilder: (context, index) {
                        final option = options[index];
                        final isSelected = option == current;
                        return ListTile(
                          title: Text(
                            option,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                          trailing: isSelected
                              ? Icon(
                                  Icons.check_circle_rounded,
                                  color: theme.colorScheme.primary,
                                )
                              : null,
                          onTap: () => Navigator.pop(ctx, option),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    if (selected != null && mounted) {
      setState(() => onSelected(selected));
    }
  }

  Future<void> _pickDate({required bool isStart}) async {
    final initial = isStart ? _fiscalStart : _fiscalEnd;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked == null) return;
    setState(() {
      if (isStart) {
        _fiscalStart = picked;
        if (!_fiscalEnd.isAfter(_fiscalStart)) {
          _fiscalEnd = DateTime(picked.year + 1, picked.month, picked.day);
        }
      } else {
        _fiscalEnd = picked;
      }
    });
  }

  AutovalidateMode _autoValidateForStep(int step) {
    return _stepsWithValidationAttempt.contains(step)
        ? AutovalidateMode.onUserInteraction
        : AutovalidateMode.disabled;
  }

  bool _validateStep(int step) {
    _stepsWithValidationAttempt.add(step);
    return _formKeys[step].currentState?.validate() ?? false;
  }

  void _resetStepForm(int step) {
    _formKeys[step].currentState?.reset();
    _stepsWithValidationAttempt.remove(step);
  }

  void _next() {
    if (!_validateStep(_step)) {
      setState(() {});
      context.showKiiSnackBarError(context.l10n.setupFixValidationErrors);
      return;
    }
    if (_step >= 3) {
      _submit();
      return;
    }
    final nextStep = _step + 1;
    _resetStepForm(nextStep);
    setState(() => _step = nextStep);
    _pageController.nextPage(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

  void _back() {
    if (_step == 0) return;
    final prevStep = _step - 1;
    _resetStepForm(prevStep);
    setState(() => _step = prevStep);
    _pageController.previousPage(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

  Future<void> _skip() async {
    if (_submitting) return;
    await context.router.replace(const OrganizationCodeRoute());
  }

  Future<void> _openRestoreFromDrive() async {
    if (_submitting) return;
    final restored = await RestoreFromDriveSheet.show(context);
    if (!mounted || restored == null) return;
    await navigateToLoginGate(context.router);
  }

  Future<_SetupFinishChoice?> _promptSaveLoginPdf() {
    final theme = Theme.of(context);
    final isTablet = DeviceLayout.isTablet(context);

    return showModalBottomSheet<_SetupFinishChoice>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(ctx).bottom),
          child: SafeArea(
            top: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isTablet ? 520 : double.infinity,
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Container(
                            width: 40,
                            height: 4,
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.outlineVariant,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                context.l10n.saveLoginDetailsTitle,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Material(
                              color: theme.colorScheme.surfaceContainerHighest,
                              shape: const CircleBorder(),
                              clipBehavior: Clip.antiAlias,
                              child: InkWell(
                                customBorder: const CircleBorder(),
                                onTap: () => Navigator.pop(
                                  ctx,
                                  _SetupFinishChoice.cancelled,
                                ),
                                child: SizedBox(
                                  width: 36,
                                  height: 36,
                                  child: Icon(
                                    Icons.close,
                                    size: 18,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          context.l10n.saveLoginDetailsMessage,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            height: 1.45,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _SetupOrganizationSummaryCard(
                          organizationName: _orgNameController.text.trim(),
                          companyName: _companyNameController.text.trim(),
                          businessType: _businessType,
                        ),
                        const SizedBox(height: 24),
                        CustomButtonWidget.primary(
                          onPressed: () => Navigator.pop(
                            ctx,
                            _SetupFinishChoice.downloadPdf,
                          ),
                          title: context.l10n.downloadPdfAndContinue,
                          useFixedSizes: isTablet,
                          height: isTablet ? 52 : 48,
                          borderRadius: isTablet ? 12 : 8,
                        ),
                        const SizedBox(height: 10),
                        CustomButtonWidget.outlined(
                          onPressed: () => Navigator.pop(
                            ctx,
                            _SetupFinishChoice.continueWithoutPdf,
                          ),
                          title: context.l10n.continueWithoutPdf,
                          useFixedSizes: isTablet,
                          height: isTablet ? 52 : 42,
                          borderRadius: isTablet ? 12 : 8,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String _setupErrorMessage(Object error) {
    final raw = error.toString().trim();
    if (raw.isEmpty) return context.l10n.setupFailed;
    final message = raw.replaceFirst(RegExp(r'^Exception:\s*'), '');
    if (message.length > 120) return context.l10n.setupFailed;
    return context.l10n.setupFailedWithDetails(message);
  }

  Future<void> _submit() async {
    if (!_validateStep(3)) {
      context.showKiiSnackBarError(context.l10n.setupFixValidationErrors);
      return;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      context.showKiiSnackBarError(context.l10n.passwordsDoNotMatch);
      return;
    }

    final finishChoice = await _promptSaveLoginPdf();
    if (!mounted) return;
    if (finishChoice == null || finishChoice == _SetupFinishChoice.cancelled) {
      return;
    }
    final downloadPdf = finishChoice == _SetupFinishChoice.downloadPdf;

    setState(() => _submitting = true);
    try {
      final logo = await _encodeSelectedLogo();
      if (_logoPathNotifier.value != null &&
          _logoPathNotifier.value!.isNotEmpty &&
          !_logoRemovedNotifier.value &&
          logo == null) {
        return;
      }

      final request = SetupCompleteRequest(
        organizationCode: OrganizationCodeGenerator.generate(),
        organizationName: _orgNameController.text.trim(),
        companyName: _companyNameController.text.trim(),
        businessType: _businessType,
        fullName: _fullNameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        country: _country,
        currency: _currency,
        bankName: _bankNameController.text.trim(),
        chartOfAccounts: SetupCompleteRequest.chartOfAccountsOptions.first,
        fiscalYearStart: _formatDate(_fiscalStart),
        fiscalYearEnd: _formatDate(_fiscalEnd),
        defaultTaxRate: double.tryParse(_taxRateController.text.trim()) ?? 0,
        taxMode: _taxMode.storageValue,
        taxKind: _taxKind.storageValue,
        taxIdLabel: _taxIdLabel,
        taxIdNumber: _taxIdNumberController.text.trim(),
        logo: logo,
      );

      await getIt<LocalSetupService>().completeSetup(
        request,
        loadTestData: false,
      );
      // Do not persist a login session here — user must sign in on Login first.
      await TokenStorage.clearSession();
      await LastLoginEmailStorage.save(request.email);
      await LoginSignupPrefillStorage.saveForActiveOrg(
        email: request.email,
        password: request.password,
      );

      if (!mounted) return;

      if (downloadPdf) {
        try {
          await SetupCredentialsPdfService.downloadCredentials(request);
          if (mounted) {
            context.showKiiSnackBarSuccess(
              context.l10n.setupCompleteWithPdfSuccess,
            );
          }
        } catch (e) {
          if (mounted) {
            final details = e.toString().trim().replaceFirst(
                  RegExp(r'^Exception:\s*'),
                  '',
                );
            context.showKiiSnackBarError(
              context.l10n.setupPdfFailed(
                details.length <= 80 ? details : context.l10n.setupFailed,
              ),
            );
          }
        }
      } else {
        context.showKiiSnackBarSuccess(context.l10n.setupCompleteSuccess);
      }

      if (!mounted) return;
      await dismissKeyboard(settleDelay: const Duration(milliseconds: 120));
      if (!mounted) return;
      await navigateToLoginGate(context.router);
    } catch (e) {
      if (mounted) {
        context.showKiiSnackBarError(_setupErrorMessage(e));
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final isTablet = DeviceLayout.isTablet(context);

    String? requiredField(String? value, String fieldLabel) {
      if (value == null || value.trim().isEmpty) {
        return l10n.fieldRequired(fieldLabel);
      }
      return null;
    }

    String? validateOrgField(String? value, String fieldLabel) {
      final required = requiredField(value, fieldLabel);
      if (required != null) return required;
      if (value!.trim().length > OrganizationFieldLimits.maxNameLength) {
        return l10n.fieldMaxLength(
          fieldLabel,
          OrganizationFieldLimits.maxNameLength,
        );
      }
      return null;
    }

    String? validateMaxLengthField(
      String? value,
      String fieldLabel,
      int maxLength,
    ) {
      final required = requiredField(value, fieldLabel);
      if (required != null) return required;
      if (value!.trim().length > maxLength) {
        return l10n.fieldMaxLength(fieldLabel, maxLength);
      }
      return null;
    }

    final header = _buildSetupHeader(context, theme, isTablet);

    final steps = PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _stepCard(
          title: l10n.setupOrganizationStepTitle,
          subtitle: l10n.setupOrganizationStepSubtitle,
          icon: Icons.apartment_rounded,
          isTablet: isTablet,
          child: Form(
            key: _formKeys[0],
            child: Column(
              children: [
                Center(
                  child: UploadableImageAvatar(
                    localPathNotifier: _logoPathNotifier,
                    userRemovedNotifier: _logoRemovedNotifier,
                    storedImage: null,
                    onPick: _pickOrganizationLogo,
                    size: 96,
                    circular: true,
                    placeholderIcon: Icons.business_outlined,
                    placeholderLabel: l10n.organizationLogoHint,
                  ),
                ),
                SizedBox(height: isTablet ? 20 : 16),
                CustomTextFormField(
                  controller: _orgNameController,
                  labelText: l10n.setupOrganizationName,
                  hint: 'e.g. XOrg',
                  maxLength: OrganizationFieldLimits.maxNameLength,
                  autoValidateMode: _autoValidateForStep(0),
                  validating: (v) =>
                      validateOrgField(v, l10n.setupOrganizationName),
                ),
                SizedBox(height: isTablet ? 16 : 14),
                CustomTextFormField(
                  controller: _companyNameController,
                  labelText: l10n.setupCompanyName,
                  hint: l10n.legalDisplayNameHint,
                  maxLength: OrganizationFieldLimits.maxNameLength,
                  autoValidateMode: _autoValidateForStep(0),
                  validating: (v) => validateOrgField(v, l10n.setupCompanyName),
                ),
                SizedBox(height: isTablet ? 16 : 14),
                BusinessTypePickerField(
                  value: _businessType,
                  onChanged: (v) => setState(() => _businessType = v),
                ),
              ],
            ),
          ),
        ),
        _stepCard(
          title: l10n.setupAdminStepTitle,
          subtitle: l10n.setupAdminStepSubtitle,
          icon: Icons.person_outline_rounded,
          isTablet: isTablet,
          child: Form(
            key: _formKeys[1],
            child: Column(
              children: [
                CustomTextFormField(
                  controller: _fullNameController,
                  labelText: l10n.setupFullName,
                  maxLength: SetupFieldLimits.maxFullNameLength,
                  autoValidateMode: _autoValidateForStep(1),
                  validating: (v) => validateMaxLengthField(
                    v,
                    l10n.setupFullName,
                    SetupFieldLimits.maxFullNameLength,
                  ),
                ),
                SizedBox(height: isTablet ? 12 : 8),
                CustomTextFormField(
                  controller: _emailController,
                  labelText: l10n.email,
                  keyboardType: TextInputType.emailAddress,
                  maxLength: SetupFieldLimits.maxEmailLength,
                  autoValidateMode: _autoValidateForStep(1),
                  validating: (v) {
                    final maxLength = validateMaxLengthField(
                      v,
                      l10n.email,
                      SetupFieldLimits.maxEmailLength,
                    );
                    if (maxLength != null) return maxLength;
                    if (!_emailRegex.hasMatch(v!.trim())) {
                      return l10n.invalidEmailAddress;
                    }
                    return null;
                  },
                ),
                SizedBox(height: isTablet ? 12 : 8),
                CustomTextFormField(
                  controller: _passwordController,
                  labelText: l10n.password,
                  obscurable: true,
                  autoValidateMode: _autoValidateForStep(1),
                  validating: (v) {
                    final required = requiredField(v, l10n.password);
                    if (required != null) return required;
                    if (v!.length < _minPasswordLength) {
                      return l10n.passwordMinLength(_minPasswordLength);
                    }
                    return null;
                  },
                ),
                SizedBox(height: isTablet ? 12 : 8),
                CustomTextFormField(
                  controller: _confirmPasswordController,
                  labelText: l10n.setupConfirmPassword,
                  obscurable: true,
                  autoValidateMode: _autoValidateForStep(1),
                  validating: (v) {
                    final required =
                        requiredField(v, l10n.setupConfirmPassword);
                    if (required != null) return required;
                    if (v != _passwordController.text) {
                      return l10n.passwordsDoNotMatch;
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        _stepCard(
          title: l10n.setupRegionStepTitle,
          subtitle: l10n.regionAndCurrencySubtitle,
          icon: Icons.public_rounded,
          isTablet: isTablet,
          child: Form(
            key: _formKeys[2],
            child: Column(
              children: [
                CustomTextFormField(
                  key: ValueKey('country_$_country'),
                  initialValue: _countryFieldLabel,
                  labelText: l10n.country,
                  hint: l10n.selectCountry,
                  readOnly: true,
                  onTap: _showCountryPicker,
                  autoValidateMode: _autoValidateForStep(2),
                  validating: (_) => requiredField(_country, l10n.country),
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: isTablet ? 16 : 14),
                CustomTextFormField(
                  key: ValueKey('currency_$_currency'),
                  initialValue: _currencyFieldLabel,
                  labelText: l10n.currency,
                  hint: l10n.selectCurrency,
                  readOnly: true,
                  onTap: _showCurrencyPicker,
                  autoValidateMode: _autoValidateForStep(2),
                  validating: (_) => requiredField(_currency, l10n.currency),
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
        _stepCard(
          title: l10n.setupAccountingStepTitle,
          subtitle: l10n.setupAccountingStepSubtitle,
          icon: Icons.account_balance_rounded,
          isTablet: isTablet,
          child: Form(
            key: _formKeys[3],
            child: Column(
              children: [
                CustomTextFormField(
                  controller: _bankNameController,
                  labelText: l10n.setupBankName,
                  maxLength: SetupFieldLimits.maxBankNameLength,
                  autoValidateMode: _autoValidateForStep(3),
                  validating: (v) => validateMaxLengthField(
                    v,
                    l10n.setupBankName,
                    SetupFieldLimits.maxBankNameLength,
                  ),
                ),
                SizedBox(height: isTablet ? 16 : 14),
                CustomTextFormField(
                  key: ValueKey('fiscal_start_${_formatDate(_fiscalStart)}'),
                  initialValue: _formatDate(_fiscalStart),
                  labelText: l10n.fiscalYearStart,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  readOnly: true,
                  onTap: () => _pickDate(isStart: true),
                  suffixIcon: Icon(
                    Icons.calendar_today_rounded,
                    size: 20,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: isTablet ? 16 : 14),
                CustomTextFormField(
                  key: ValueKey('fiscal_end_${_formatDate(_fiscalEnd)}'),
                  initialValue: _formatDate(_fiscalEnd),
                  labelText: l10n.fiscalYearEnd,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  readOnly: true,
                  onTap: () => _pickDate(isStart: false),
                  suffixIcon: Icon(
                    Icons.calendar_today_rounded,
                    size: 20,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: isTablet ? 20 : 18),
                _buildTaxSectionLabel(theme, l10n.checkoutTaxType),
                SizedBox(height: isTablet ? 10 : 8),
                _buildSetupSegmentedControl<InvoiceTaxKind>(
                  theme: theme,
                  isTablet: isTablet,
                  values: InvoiceTaxKind.values,
                  selected: _taxKind,
                  labelOf: (kind) => kind == InvoiceTaxKind.vat
                      ? CountryTaxProfiles.of(_country)
                          .labelForKind(InvoiceTaxKind.vat)
                      : kind == InvoiceTaxKind.corporate
                          ? l10n.checkoutTaxCorporate
                          : l10n.checkoutTaxPersonal,
                  onChanged: _selectTaxKind,
                ),
                SizedBox(height: isTablet ? 10 : 8),
                Text(
                  l10n.checkoutTaxTypeHint(
                    CountryTaxProfiles.of(_country).labelForKind(_taxKind),
                  ),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.35,
                  ),
                ),
                SizedBox(height: isTablet ? 16 : 14),
                CustomTextFormField(
                  controller: _taxRateController,
                  labelText: l10n.defaultTaxRate,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  suffixText: '%',
                  autoValidateMode: _autoValidateForStep(3),
                  validating: _validateTaxRate,
                  onChanged: (_) => setState(() {}),
                ),
                _buildKindRatePresets(
                  theme: theme,
                  l10n: l10n,
                  isTablet: isTablet,
                ),
                SizedBox(height: isTablet ? 16 : 14),
                CustomTextFormField(
                  key: ValueKey('tax_id_label_${_taxKind.name}_$_taxIdLabel'),
                  initialValue: _taxIdLabel,
                  labelText: l10n.taxIdLabel,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  readOnly: true,
                  onTap: _showTaxIdLabelPicker,
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: isTablet ? 16 : 14),
                CustomTextFormField(
                  controller: _taxIdNumberController,
                  labelText: l10n.taxIdNumberOptional(_taxIdLabel),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hint: _taxIdNumberHint(l10n),
                ),
                SizedBox(height: isTablet ? 20 : 18),
                _buildTaxSectionLabel(theme, l10n.taxMode),
                SizedBox(height: isTablet ? 10 : 8),
                _buildSetupSegmentedControl<TaxMode>(
                  theme: theme,
                  isTablet: isTablet,
                  values: TaxMode.values,
                  selected: _taxMode,
                  labelOf: (mode) => mode == TaxMode.exclusive
                      ? l10n.taxModeExclusive
                      : l10n.taxModeInclusive,
                  onChanged: (mode) => setState(() => _taxMode = mode),
                ),
              ],
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainerLow,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            header,
            Expanded(
              child: isTablet ? SetupTabletContentWidth(child: steps) : steps,
            ),
            SetupBottomActionBar(
              showBack: _step > 0,
              backTitle: l10n.back,
              onBack: _submitting ? null : _back,
              primaryTitle:
                  _step == 3 ? l10n.setupCompleteSetup : l10n.continueAction,
              onPrimary: _submitting ? null : _next,
              loading: _submitting,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSetupHeader(
    BuildContext context,
    ThemeData theme,
    bool isTablet,
  ) {
    final l10n = context.l10n;
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppBrandName.replaceInText(
                context,
                text: context.l10n
                    .setupAppTitle(context.l10n.platformAppDisplayName),
                brandName: context.l10n.platformAppDisplayName,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            if (_step == 0)
              TextButton(
                onPressed: _submitting ? null : _skip,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  context.l10n.skip,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          l10n.setupSubtitle,
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        if (_step == 0) ...[
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: _submitting ? null : _openRestoreFromDrive,
              icon: const Icon(Icons.cloud_download_outlined, size: 18),
              label: Text(l10n.restoreFromGoogleDrive),
            ),
          ),
        ],
        const SizedBox(height: 20),
        _StepIndicator(current: _step, total: 4),
      ],
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(
        isTablet ? 32 : 16,
        isTablet ? 20 : 16,
        isTablet ? 32 : 16,
        isTablet ? 12 : 8,
      ),
      child: SetupTabletContentWidth(child: content),
    );
  }

  Widget _stepCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget child,
    required bool isTablet,
    Widget? footer,
  }) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(isTablet ? 24 : 16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(isTablet ? 8 : 6.r),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(isTablet ? 8 : 6.r),
                  ),
                  child: Icon(icon, color: theme.colorScheme.primary),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            child,
            if (footer != null) ...[
              const SizedBox(height: 20),
              footer,
            ],
          ],
        ),
      ),
    );
  }
}

class _SetupOrganizationSummaryCard extends StatelessWidget {
  const _SetupOrganizationSummaryCard({
    required this.organizationName,
    required this.companyName,
    required this.businessType,
  });

  final String organizationName;
  final String companyName;
  final String businessType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.setupOrganizationStepTitle,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          if (organizationName.isNotEmpty)
            _summaryLine(theme, l10n.setupOrganizationName, organizationName),
          if (companyName.isNotEmpty) ...[
            const SizedBox(height: 4),
            _summaryLine(theme, l10n.setupCompanyName, companyName),
          ],
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                OrganizationBusinessType.iconFor(businessType),
                size: 16,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  '${l10n.setupBusinessType}: ${l10n.businessTypeLabel(businessType)}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryLine(ThemeData theme, String label, String value) {
    return RichText(
      text: TextSpan(
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
        children: [
          TextSpan(
            text: '$label: ',
            style: AppFonts.interStyle(fontWeight: FontWeight.w500),
          ),
          TextSpan(
            text: value,
            style: AppFonts.interStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.current, required this.total});

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final primary = scheme.primary;
    return Row(
      children: List.generate(total, (i) {
        final active = i <= current;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: i < total - 1 ? 6 : 0),
            height: 4,
            decoration: BoxDecoration(
              color: active
                  ? primary
                  : scheme.outlineVariant.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}
