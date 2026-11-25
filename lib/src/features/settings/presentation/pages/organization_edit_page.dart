import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/l10n/app_localizations.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/layout/device_layout.dart';
import 'package:hotel/src/core/helpers/image_picker_helper.dart';
import 'package:hotel/src/core/helpers/item_image_helper.dart';
import 'package:hotel/src/core/services/currency/app_currency_formatter.dart';
import 'package:hotel/src/core/services/currency/app_currency_service.dart';
import 'package:hotel/src/core/services/display_precision/app_display_precision_service.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/country_searchable_bottom_sheet.dart';
import 'package:hotel/src/core/widget/currency_searchable_bottom_sheet.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/core/widget/uploadable_image_avatar.dart';
import 'package:hotel/src/features/org/domain/accounting_settings_service.dart';
import 'package:hotel/src/features/org/domain/organization_business_type.dart';
import 'package:hotel/src/features/org/domain/organization_field_limits.dart';
import 'package:hotel/src/features/org/domain/organization_settings_service.dart';
import 'package:hotel/src/features/invoice/presentation/cubit/accounting_settings_cubit.dart';
import 'package:hotel/src/features/org/domain/system_settings_service.dart';
import 'package:hotel/src/features/org/domain/country_fiscal_year.dart';
import 'package:hotel/src/features/org/domain/country_tax_profile.dart';
import 'package:hotel/src/features/org/domain/country_tax_rate_picker.dart';
import 'package:hotel/src/features/org/domain/tax_id_format_catalog.dart';
import 'package:hotel/src/features/org/domain/invoice_tax_kind.dart';
import 'package:hotel/src/features/org/domain/tax_math.dart';
import 'package:hotel/src/features/org/domain/tax_settings_service.dart';
import 'package:hotel/src/features/loyalty/domain/loyalty_features.dart';
import 'package:hotel/src/features/org/presentation/widgets/tax_id_label_picker_sheet.dart';
import 'package:hotel/src/features/org/presentation/widgets/business_type_picker_field.dart';
import 'package:hotel/src/features/settings/domain/bank_account_service.dart';
import 'package:hotel/src/features/settings/presentation/pages/banks_list_page.dart';
import 'package:hotel/src/features/setup/domain/setup_region_options.dart';

class OrganizationEditPage extends StatefulWidget {
  const OrganizationEditPage({super.key});

  @override
  State<OrganizationEditPage> createState() => _OrganizationEditPageState();
}

class _OrganizationEditPageState extends State<OrganizationEditPage>
    with SingleTickerProviderStateMixin {
  final _orgNameController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _displayPrecisionController = TextEditingController();
  final _taxRateController = TextEditingController();
  final _taxIdNumberController = TextEditingController();
  final _generalFormKey = GlobalKey<FormState>();
  final _accountingFormKey = GlobalKey<FormState>();

  late final TabController _tabController;
  late final AppCurrencyService _currencyService;
  late final AccountingSettingsService _accountingService;
  late final SystemSettingsService _systemSettingsService;
  late final TaxSettingsService _taxSettingsService;

  String _businessType = OrganizationBusinessType.defaultCode;
  String _organizationCode = '';
  DateTime _fiscalStart = DateTime(2025, 4, 1);
  DateTime _fiscalEnd = DateTime(2026, 3, 31);
  bool _enableInvoiceReturns = true;
  bool _enableLoyaltyProgram = false;
  String? _selectedBankName;
  String _taxIdLabel = 'TIN';
  TaxMode _taxMode = TaxMode.exclusive;
  InvoiceTaxKind _taxKind = InvoiceTaxKind.vat;

  bool _loading = true;
  bool _saving = false;
  String? _storedLogo;
  final _logoPathNotifier = ValueNotifier<String?>(null);
  final _logoRemovedNotifier = ValueNotifier<bool>(false);
  bool _logoDirty = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _currencyService = getIt<AppCurrencyService>();
    _accountingService = getIt<AccountingSettingsService>();
    _systemSettingsService = getIt<SystemSettingsService>();
    _taxSettingsService = getIt<TaxSettingsService>();
    _load();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _orgNameController.dispose();
    _companyNameController.dispose();
    _displayPrecisionController.dispose();
    _taxRateController.dispose();
    _taxIdNumberController.dispose();
    _logoPathNotifier.dispose();
    _logoRemovedNotifier.dispose();
    super.dispose();
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
    _logoDirty = true;
    setState(() {});
  }

  Future<String?> _resolveLogoForSave() async {
    if (!_logoDirty) return null;
    if (_logoRemovedNotifier.value) return '';
    final localPath = _logoPathNotifier.value;
    if (localPath != null && localPath.isNotEmpty) {
      final encoded = await ItemImageHelper.encodeFileForStorage(localPath);
      if (encoded == null && mounted) {
        context.showKiiSnackBarError(context.l10n.itemImageSizeError);
      }
      return encoded;
    }
    return null;
  }

  Future<void> _load() async {
    try {
      final settings = await OrganizationSettingsService().load();
      final fiscal = await _accountingService.loadFiscalYear();
      final enableReturns = await _accountingService.loadEnableInvoiceReturns();
      final enableLoyalty = await _accountingService.loadEnableLoyaltyProgram();
      final displayPrecision =
          await _systemSettingsService.loadDisplayPrecision();
      final taxSettings = await _taxSettingsService.load();
      final selectedBank = getIt.isRegistered<BankAccountService>()
          ? await getIt<BankAccountService>().loadDefaultBankName()
          : null;
      if (!mounted) return;
      setState(() {
        _orgNameController.text = settings.organizationName;
        _companyNameController.text = settings.companyName;
        _businessType = settings.businessType;
        _organizationCode = settings.organizationCode;
        _storedLogo = settings.logo;
        _fiscalStart = _parseDate(fiscal.fiscalYearStart) ?? _fiscalStart;
        _fiscalEnd = _parseDate(fiscal.fiscalYearEnd) ?? _fiscalEnd;
        _enableInvoiceReturns = enableReturns;
        _enableLoyaltyProgram = enableLoyalty;
        _displayPrecisionController.text = displayPrecision.toString();
        _taxRateController.text = taxSettings.defaultTaxRate.toStringAsFixed(
          taxSettings.defaultTaxRate ==
                  taxSettings.defaultTaxRate.roundToDouble()
              ? 0
              : 2,
        );
        _taxIdLabel = taxSettings.taxIdLabel ?? 'TIN';
        _taxIdNumberController.text = taxSettings.taxIdNumber ?? '';
        _taxMode = taxSettings.taxMode;
        _taxKind = taxSettings.taxKind;
        _selectedBankName = selectedBank;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _loading = false);
      context.showKiiSnackBarError(context.l10n.organizationInfoLoadFailed);
    }
  }

  DateTime? _parseDate(String raw) {
    final parts = raw.split('-');
    if (parts.length != 3) return null;
    final y = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);
    final d = int.tryParse(parts[2]);
    if (y == null || m == null || d == null) return null;
    return DateTime(y, m, d);
  }

  String _formatDate(DateTime d) {
    return '${d.year.toString().padLeft(4, '0')}-'
        '${d.month.toString().padLeft(2, '0')}-'
        '${d.day.toString().padLeft(2, '0')}';
  }

  Future<void> _pickDate({required bool isStart}) async {
    final initial = isStart ? _fiscalStart : _fiscalEnd;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked == null || !mounted) return;

    setState(() {
      if (isStart) {
        _fiscalStart = picked;
        if (!_fiscalEnd.isAfter(_fiscalStart)) {
          _fiscalEnd = _fiscalStart.add(const Duration(days: 365));
        }
      } else {
        _fiscalEnd = picked;
      }
    });
  }

  Future<void> _save() async {
    if (_tabController.index == 0 &&
        !_generalFormKey.currentState!.validate()) {
      return;
    }
    if (!(_accountingFormKey.currentState?.validate() ?? true)) {
      return;
    }

    final displayPrecision = int.parse(_displayPrecisionController.text.trim());

    setState(() => _saving = true);
    try {
      final logoValue = await _resolveLogoForSave();
      if (_logoDirty && _logoPathNotifier.value != null && logoValue == null) {
        return;
      }

      await OrganizationSettingsService().save(
        organizationName: _orgNameController.text.trim(),
        companyName: _companyNameController.text.trim(),
        businessType: _businessType,
      );
      if (logoValue != null) {
        await OrganizationSettingsService().saveLogo(logoValue);
        _storedLogo = logoValue.isEmpty ? null : logoValue;
        _logoPathNotifier.value = null;
        _logoRemovedNotifier.value = logoValue.isEmpty;
        _logoDirty = false;
      }
      await _accountingService.updateFiscalYear(
        fiscalYearStart: _formatDate(_fiscalStart),
        fiscalYearEnd: _formatDate(_fiscalEnd),
      );
      await _accountingService
          .updateEnableInvoiceReturns(_enableInvoiceReturns);
      if (LoyaltyFeatures.enabled) {
        await _accountingService
            .updateEnableLoyaltyProgram(_enableLoyaltyProgram);
      }
      await _systemSettingsService.updateDisplayPrecision(displayPrecision);
      await _taxSettingsService.save(
        defaultTaxRate: double.parse(_taxRateController.text.trim()),
        taxMode: _taxMode,
        taxKind: _taxKind,
        taxIdLabel: _taxIdLabel,
        taxIdNumber: _taxIdNumberController.text.trim(),
      );
      await getIt<AppDisplayPrecisionService>().load();
      await getIt<AccountingSettingsCubit>().reload();
      if (!mounted) return;
      context.showKiiSnackBarSuccess(context.l10n.organizationInfoUpdated);
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      context.showKiiSnackBarError(
        context.l10n.organizationInfoSaveFailed(e.toString()),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _showCountrySheet() async {
    final selected = await showCountryPickerBottomSheet(
      context: context,
      title: context.l10n.selectCountry,
      searchHint: context.l10n.search,
      countries: SetupRegionOptions.countries(),
      currentCountry: _currencyService.country,
    );

    if (selected == null || selected == _currencyService.country || !mounted) {
      return;
    }

    try {
      await _currencyService.updateCountry(selected);
      if (!mounted) return;
      // Tax ID / rate defaults for the new country (Accounting tab).
      final taxDefaults = TaxSettingsService.defaultsForCountry(
        selected,
        taxKind: _taxKind,
        existingNumber: _taxIdNumberController.text.trim().isEmpty
            ? null
            : _taxIdNumberController.text.trim(),
      );
      final (fyStart, fyEnd) = CountryFiscalYears.datesFor(selected);
      setState(() {
        _taxIdLabel = taxDefaults.taxIdLabel ?? _taxIdLabel;
        if (taxDefaults.defaultTaxRate > 0) {
          final rate = taxDefaults.defaultTaxRate;
          _taxRateController.text = rate == rate.roundToDouble()
              ? rate.toStringAsFixed(0)
              : rate.toStringAsFixed(2);
        }
        _fiscalStart = fyStart;
        _fiscalEnd = fyEnd;
      });
      context.showKiiSnackBarSuccess(
        'Country set to $selected · ${_currencyService.reportingLabel}',
      );
    } catch (e) {
      if (!mounted) return;
      context.showKiiSnackBarError('Could not update country: $e');
    }
  }

  Future<void> _showCurrencySheet() async {
    final options = await _currencyService.listCurrenciesForPicker();
    if (!mounted) return;
    final current = _currencyService.code;

    final selected = await showCurrencyPickerBottomSheet(
      context: context,
      title: context.l10n.selectCurrency,
      searchHint: '${context.l10n.search} code or symbol',
      options: options,
      currentCode: current,
    );

    if (selected == null || selected == current || !mounted) return;

    try {
      await _currencyService.updateCurrency(selected);
      if (!mounted) return;
      context.showKiiSnackBarSuccess(
        context.l10n.currencyUpdated(selected, AppCurrencyFormatter.symbol),
      );
      setState(() {});
    } catch (e) {
      if (!mounted) return;
      context.showKiiSnackBarError(
        context.l10n.currencyUpdateFailed(e.toString()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: const AppBarIosBackButton(),
        title: Text(l10n.editOrganizationInfo),
        bottom: _loading
            ? null
            : TabBar(
                controller: _tabController,
                labelColor: scheme.primary,
                unselectedLabelColor: scheme.onSurfaceVariant,
                indicatorColor: scheme.primary,
                tabs: [
                  Tab(text: l10n.organizationTabGeneral),
                  Tab(text: l10n.organizationTabRegional),
                  Tab(text: l10n.organizationTabAccounting),
                ],
              ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildGeneralTab(theme, l10n),
                _buildRegionalTab(theme, l10n),
                _buildAccountingTab(theme, l10n),
              ],
            ),
    );
  }

  Widget _buildSaveButton(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.only(top: 28, bottom: 8),
      child: CustomButtonWidget(
        onPressed: _saving ? null : _save,
        loading: _saving,
        title: l10n.saveChanges,
        width: double.infinity,
      ),
    );
  }

  bool get _isTablet => DeviceLayout.isTablet(context);

  double _sz(double tablet, double phone) => _isTablet ? tablet : phone;

  Widget _buildTaxKindSelector(ThemeData theme, AppLocalizations l10n) {
    final country = _currencyService.country;
    final profile = CountryTaxProfiles.of(country);
    final kinds = InvoiceTaxKind.values;

    return _buildSegmentedControl<InvoiceTaxKind>(
      theme: theme,
      values: kinds,
      selected: _taxKind,
      minHeight: _sz(40, 40.h),
      maxLines: 1,
      labelOf: (kind) => kind == InvoiceTaxKind.vat
          ? profile.labelForKind(InvoiceTaxKind.vat)
          : kind == InvoiceTaxKind.corporate
              ? l10n.checkoutTaxCorporate
              : l10n.checkoutTaxPersonal,
      onChanged: _selectTaxKind,
    );
  }

  void _selectTaxKind(InvoiceTaxKind kind) {
    if (_taxKind == kind) return;
    final profile = CountryTaxProfiles.of(_currencyService.country);
    final rate = profile.primaryRateFor(kind);
    final label = profile.primaryTinLabelFor(kind);
    setState(() {
      _taxKind = kind;
      _taxIdLabel = label;
      _taxRateController.text = profile.formatRate(rate);
    });
  }

  Widget _buildKindRatePresets(ThemeData theme, AppLocalizations l10n) {
    final country = _currencyService.country;
    if (country.trim().isEmpty) return const SizedBox.shrink();
    final profile = CountryTaxProfiles.of(country);
    final rates = profile.ratesFor(_taxKind);
    if (rates.length < 2) return const SizedBox.shrink();
    final current = double.tryParse(_taxRateController.text.trim()) ?? 0;
    final scheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: _sz(10, 8.h)),
        Text(
          l10n.checkoutTaxPresetsForCountry(country),
          style: theme.textTheme.labelMedium?.copyWith(
            color: scheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: _sz(8, 8.h)),
        Wrap(
          spacing: _sz(8, 8.w),
          runSpacing: _sz(8, 8.h),
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
                  fontSize: _sz(13, 12.sp),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildTaxModeSelector(ThemeData theme, AppLocalizations l10n) {
    return _buildSegmentedControl<TaxMode>(
      theme: theme,
      values: TaxMode.values,
      selected: _taxMode,
      minHeight: _sz(40, 40.h),
      maxLines: 1,
      labelOf: (mode) => mode == TaxMode.exclusive
          ? l10n.taxModeExclusive
          : l10n.taxModeInclusive,
      onChanged: (mode) => setState(() => _taxMode = mode),
    );
  }

  Widget _buildSegmentedControl<T>({
    required ThemeData theme,
    required List<T> values,
    required T selected,
    required double minHeight,
    required int maxLines,
    required String Function(T value) labelOf,
    required ValueChanged<T> onChanged,
  }) {
    final scheme = theme.colorScheme;
    const radius = 8.0;
    final borderColor = scheme.outlineVariant.withValues(alpha: 0.75);

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
                          horizontal: _sz(16, 14.w),
                          vertical: _sz(10, 8.h),
                        ),
                        color: selected == values[i]
                            ? scheme.primaryContainer
                            : Colors.transparent,
                        child: Text(
                          labelOf(values[i]),
                          maxLines: maxLines,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: selected == values[i]
                                ? FontWeight.w700
                                : FontWeight.w500,
                            fontSize: _sz(12, 11.sp),
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
      country: _currencyService.country,
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

  Widget _buildGeneralTab(ThemeData theme, AppLocalizations l10n) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Form(
        key: _generalFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.editOrganizationInfoSubtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: UploadableImageAvatar(
                localPathNotifier: _logoPathNotifier,
                userRemovedNotifier: _logoRemovedNotifier,
                storedImage: _storedLogo,
                onPick: _pickOrganizationLogo,
                onChanged: () => _logoDirty = true,
                size: 96,
                circular: true,
                placeholderIcon: Icons.business_outlined,
                placeholderLabel: l10n.organizationLogoHint,
              ),
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              controller: _orgNameController,
              labelText: l10n.setupOrganizationName,
              maxLength: OrganizationFieldLimits.maxNameLength,
              validating: (v) =>
                  _validateOrgNameField(v, l10n.setupOrganizationName),
            ),
            const SizedBox(height: 14),
            CustomTextFormField(
              controller: _companyNameController,
              labelText: l10n.setupCompanyName,
              maxLength: OrganizationFieldLimits.maxNameLength,
              validating: (v) =>
                  _validateOrgNameField(v, l10n.setupCompanyName),
            ),
            const SizedBox(height: 14),
            BusinessTypePickerField(
              value: _businessType,
              enabled: false,
              onChanged: (v) => setState(() => _businessType = v),
            ),
            if (_organizationCode.isNotEmpty) ...[
              const SizedBox(height: 14),
              InputDecorator(
                decoration: InputDecoration(
                  labelText: l10n.organizationCode,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  helperText: l10n.organizationCodeReadOnly,
                ),
                child: Text(
                  _organizationCode,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
            _buildSaveButton(l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildRegionalTab(ThemeData theme, AppLocalizations l10n) {
    return ListenableBuilder(
      listenable: _currencyService,
      builder: (context, _) {
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.organizationRegionalSubtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              _PickerField(
                label: l10n.country,
                value: _currencyService.country,
                icon: Icons.public_outlined,
                onTap: _showCountrySheet,
              ),
              const SizedBox(height: 14),
              _PickerField(
                label: l10n.reportingCurrency,
                value: _currencyService.reportingLabel,
                icon: Icons.payments_outlined,
                onTap: _showCurrencySheet,
              ),
              const SizedBox(height: 14),
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
              const SizedBox(height: 14),
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
              _buildSaveButton(l10n),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAccountingTab(ThemeData theme, AppLocalizations l10n) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Form(
        key: _accountingFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.organizationAccountingSubtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              key: ValueKey('org_banks_${_selectedBankName ?? ''}'),
              initialValue: _selectedBankName ?? l10n.banksSettingsSubtitle,
              labelText: l10n.banksSettingsTitle,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              readOnly: true,
              height: null,
              onTap: _openBanks,
              suffixIcon: Icon(
                Icons.chevron_right_rounded,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 14),
            CustomTextFormField(
              controller: _displayPrecisionController,
              labelText: l10n.displayPrecision,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              height: null,
              inputFormatter: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(1),
              ],
              validating: _validateDisplayPrecision,
            ),
            const SizedBox(height: 14),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: Text(
                l10n.enableInvoiceReturns,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                l10n.enableInvoiceReturnsSubtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              value: _enableInvoiceReturns,
              onChanged: (v) => setState(() => _enableInvoiceReturns = v),
            ),
            const SizedBox(height: 8),
            // Loyalty temporarily disabled — restore with LoyaltyFeatures.enabled.
            if (LoyaltyFeatures.enabled)
              SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Enable loyalty program',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'Earn and redeem loyalty points on sales invoices for enrolled customers.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                value: _enableLoyaltyProgram,
                onChanged: (v) => setState(() => _enableLoyaltyProgram = v),
              ),
            if (LoyaltyFeatures.enabled) const SizedBox(height: 14),
            SizedBox(height: _sz(20, 18.h)),
            _buildTaxSectionLabel(theme, l10n.checkoutTaxType),
            SizedBox(height: _sz(10, 8.h)),
            _buildTaxKindSelector(theme, l10n),
            SizedBox(height: _sz(10, 8.h)),
            Text(
              l10n.checkoutTaxTypeHint(
                CountryTaxProfiles.of(_currencyService.country)
                    .labelForKind(_taxKind),
              ),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: _sz(13, 12.sp),
                height: 1.35,
              ),
            ),
            SizedBox(height: _sz(16, 14.h)),
            CustomTextFormField(
              controller: _taxRateController,
              labelText: l10n.defaultTaxRate,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              suffixText: '%',
              height: null,
              validating: _validateTaxRate,
              onChanged: (_) => setState(() {}),
            ),
            _buildKindRatePresets(theme, l10n),
            SizedBox(height: _sz(16, 14.h)),
            CustomTextFormField(
              key: ValueKey('org_tax_id_label_${_taxKind.name}_$_taxIdLabel'),
              initialValue: _taxIdLabel,
              labelText: l10n.taxIdLabel,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              readOnly: true,
              height: null,
              onTap: _showTaxIdLabelPicker,
              suffixIcon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: _sz(16, 14.h)),
            CustomTextFormField(
              controller: _taxIdNumberController,
              labelText: l10n.taxIdNumberOptional(_taxIdLabel),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hint: _taxIdNumberHint(l10n),
              height: null,
            ),
            SizedBox(height: _sz(20, 18.h)),
            _buildTaxSectionLabel(theme, l10n.taxMode),
            SizedBox(height: _sz(10, 8.h)),
            _buildTaxModeSelector(theme, l10n),
            _buildSaveButton(l10n),
          ],
        ),
      ),
    );
  }

  String? _validateTaxRate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.l10n.fieldRequired(context.l10n.defaultTaxRate);
    }
    final parsed = double.tryParse(value.trim());
    if (parsed == null ||
        parsed < TaxSettingsService.minTaxRate ||
        parsed > TaxSettingsService.maxTaxRate) {
      return context.l10n.taxRateRange;
    }
    return null;
  }

  Future<void> _openBanks() async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(builder: (_) => const BanksListPage()),
    );
    if (!mounted || !getIt.isRegistered<BankAccountService>()) return;
    final selected = await getIt<BankAccountService>().loadDefaultBankName();
    if (!mounted) return;
    setState(() => _selectedBankName = selected);
  }

  Future<void> _showTaxIdLabelPicker() async {
    final selected = await showTaxIdLabelPickerBottomSheet(
      context,
      currentLabel: _taxIdLabel,
      country: _currencyService.country,
      taxKind: _taxKind,
    );
    if (selected != null && mounted) {
      setState(() => _taxIdLabel = selected);
    }
  }

  String? _validateDisplayPrecision(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.l10n.fieldRequired(context.l10n.displayPrecision);
    }
    final parsed = int.tryParse(value.trim());
    if (parsed == null ||
        parsed < SystemSettingsService.minDisplayPrecision ||
        parsed > SystemSettingsService.maxDisplayPrecision) {
      return context.l10n.displayPrecisionRange;
    }
    return null;
  }

  String? _required(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return context.l10n.fieldRequired(label);
    }
    return null;
  }

  String? _validateOrgNameField(String? value, String label) {
    final required = _required(value, label);
    if (required != null) return required;
    if (value!.trim().length > OrganizationFieldLimits.maxNameLength) {
      return context.l10n.fieldMaxLength(
        label,
        OrganizationFieldLimits.maxNameLength,
      );
    }
    return null;
  }
}

class _PickerField extends StatelessWidget {
  const _PickerField({
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final String value;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomTextFormField(
      key: ValueKey('picker_${label}_$value'),
      initialValue: value,
      labelText: label,
      readOnly: true,
      onTap: onTap,
      prefixIcon: Icon(icon, color: theme.colorScheme.onSurfaceVariant),
      suffixIcon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
