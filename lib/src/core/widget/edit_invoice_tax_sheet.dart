import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/l10n/app_localizations.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/layout/device_layout.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/features/org/domain/country_tax_profile.dart';
import 'package:hotel/src/features/org/domain/country_tax_rate_picker.dart';
import 'package:hotel/src/features/org/domain/invoice_tax_kind.dart';
import 'package:hotel/src/features/org/domain/tax_settings_service.dart';

class InvoiceTaxEditResult {
  const InvoiceTaxEditResult({
    required this.applyTax,
    required this.kind,
    required this.ratePercent,
  });

  final bool applyTax;
  final InvoiceTaxKind kind;
  final double ratePercent;
}

class EditInvoiceTaxSheet extends StatefulWidget {
  const EditInvoiceTaxSheet({
    super.key,
    required this.country,
    required this.initialApplyTax,
    required this.initialKind,
    required this.initialRatePercent,
  });

  final String country;
  final bool initialApplyTax;
  final InvoiceTaxKind initialKind;
  final double initialRatePercent;

  static Future<InvoiceTaxEditResult?> show(
    BuildContext context, {
    required String country,
    required bool initialApplyTax,
    required InvoiceTaxKind initialKind,
    required double initialRatePercent,
  }) {
    final sheet = EditInvoiceTaxSheet(
      country: country,
      initialApplyTax: initialApplyTax,
      initialKind: initialKind,
      initialRatePercent: initialRatePercent,
    );

    if (DeviceLayout.isTablet(context)) {
      return showDialog<InvoiceTaxEditResult>(
        context: context,
        barrierDismissible: true,
        builder: (_) => sheet,
      );
    }

    return showModalBottomSheet<InvoiceTaxEditResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: false,
      builder: (_) => Align(
        alignment: Alignment.bottomCenter,
        child: sheet,
      ),
    );
  }

  @override
  State<EditInvoiceTaxSheet> createState() => _EditInvoiceTaxSheetState();
}

class _EditInvoiceTaxSheetState extends State<EditInvoiceTaxSheet> {
  late bool _applyTax;
  late InvoiceTaxKind _kind;
  late final TextEditingController _rateController;

  CountryTaxProfile get _profile => CountryTaxProfiles.of(widget.country);

  bool get _tablet => DeviceLayout.isTablet(context);

  double _sz(double tablet, double phone) => _tablet ? tablet : phone;

  @override
  void initState() {
    super.initState();
    _applyTax = widget.initialApplyTax;
    _kind = widget.initialKind;
    _rateController = TextEditingController(
      text: _formatRateInput(widget.initialRatePercent),
    );
    _rateController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _rateController.dispose();
    super.dispose();
  }

  String _formatRateInput(double rate) {
    if (rate <= 0) return '';
    if (rate == rate.roundToDouble()) return rate.toStringAsFixed(0);
    return rate.toStringAsFixed(2).replaceFirst(RegExp(r'\.?0+$'), '');
  }

  double get _ratePercent {
    final parsed = double.tryParse(_rateController.text.trim());
    if (parsed != null) {
      return parsed.clamp(
        TaxSettingsService.minTaxRate,
        TaxSettingsService.maxTaxRate,
      );
    }
    return 0;
  }

  void _selectKind(InvoiceTaxKind kind) {
    setState(() {
      _kind = kind;
      final preset = _profile.primaryRateFor(kind);
      _rateController.text = _formatRateInput(preset);
      if (!_applyTax && preset > 0) {
        _applyTax = true;
      }
    });
  }

  void _selectPreset(double rate) {
    setState(() {
      _rateController.text = _formatRateInput(rate);
      _applyTax = rate > 0;
    });
  }

  void _popResult({required bool applyTax, required double ratePercent}) {
    Navigator.pop(
      context,
      InvoiceTaxEditResult(
        applyTax: applyTax && ratePercent > 0,
        kind: _kind,
        ratePercent: ratePercent,
      ),
    );
  }

  String _kindLabel(InvoiceTaxKind kind, AppLocalizations l10n) {
    switch (kind) {
      case InvoiceTaxKind.vat:
        return _profile.labelForKind(InvoiceTaxKind.vat);
      case InvoiceTaxKind.corporate:
        return l10n.checkoutTaxCorporate;
      case InvoiceTaxKind.personal:
        return l10n.checkoutTaxPersonal;
    }
  }

  Widget _buildTaxKindSelector(AppLocalizations l10n, ColorScheme scheme) {
    final kinds = InvoiceTaxKind.values;
    const radius = 8.0;
    final borderColor = scheme.outlineVariant.withValues(alpha: 0.75);
    final theme = context.theme;

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
              for (var i = 0; i < kinds.length; i++) ...[
                if (i > 0) Container(width: 1, color: borderColor),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _selectKind(kinds[i]),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 160),
                        constraints: BoxConstraints(minHeight: _sz(40, 40.h)),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                          horizontal: _sz(6, 4.w),
                          vertical: _sz(10, 8.h),
                        ),
                        color: _kind == kinds[i]
                            ? scheme.primaryContainer
                            : Colors.transparent,
                        child: Text(
                          _kindLabel(kinds[i], l10n),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: _kind == kinds[i]
                                ? FontWeight.w700
                                : FontWeight.w500,
                            fontSize: _tablet ? 13 : 11.sp,
                            height: 1.2,
                            color: _kind == kinds[i]
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

  Widget _buildBody() {
    final l10n = context.l10n;
    final scheme = context.theme.colorScheme;
    final theme = context.theme;
    final presets = _profile.presetRatesFor(_kind);
    final fieldHeight = _sz(48, 45.h);
    final buttonHeight = _sz(48, 45.h);
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        _sz(20, 14.w),
        _sz(16, 8.h),
        _sz(20, 14.w),
        _sz(16, 12.h) + bottomInset,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!_tablet) ...[
              Center(child: AppBottomSheetTheme.dragHandle(context)),
              SizedBox(height: _sz(10, 10.h)),
            ],
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.checkoutEditTax,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: _tablet ? 20 : null,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close_rounded,
                    size: _sz(24, 24),
                  ),
                ),
              ],
            ),
            SizedBox(height: _sz(8, 4.h)),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: Text(
                l10n.applyTaxOnInvoice,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: _tablet ? 16 : null,
                ),
              ),
              subtitle: Text(
                l10n.checkoutTaxApplyHint,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              value: _applyTax,
              onChanged: (v) => setState(() => _applyTax = v),
            ),
            SizedBox(height: _sz(12, 10.h)),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                l10n.checkoutTaxType,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: _tablet ? 15 : null,
                ),
              ),
            ),
            SizedBox(height: _sz(8, 8.h)),
            _buildTaxKindSelector(l10n, scheme),
            SizedBox(height: _sz(8, 6.h)),
            Text(
              l10n.checkoutTaxTypeHint(_kindLabel(_kind, l10n)),
              style: theme.textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
                height: 1.35,
              ),
            ),
            SizedBox(height: _sz(16, 12.h)),
            CustomTextFormField(
              height: fieldHeight,
              useFixedSizes: _tablet,
              controller: _rateController,
              onChanged: (_) {
                if (!_applyTax && _ratePercent > 0) {
                  setState(() => _applyTax = true);
                }
              },
              labelText: l10n.checkoutPercentage,
              hint: '00.00',
              suffixIcon: Padding(
                padding: EdgeInsets.only(right: _sz(8, 4.w)),
                child: Icon(
                  Icons.percent,
                  size: _sz(18, 16),
                  color: scheme.onSurfaceVariant,
                ),
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatter: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
            ),
            if (presets.length > 1) ...[
              SizedBox(height: _sz(14, 12.h)),
              Text(
                l10n.checkoutTaxPresetsForCountry(widget.country),
                style: theme.textTheme.labelMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: _sz(8, 8.h)),
              Wrap(
                spacing: _sz(8, 8.w),
                runSpacing: _sz(8, 8.h),
                children: [
                  for (final rate in presets)
                    FilterChip(
                      selected: (_ratePercent - rate).abs() < 0.001 &&
                          (_applyTax || rate <= 0),
                      label: Text(
                        rate <= 0
                            ? l10n.checkoutTaxNoTax
                            : '${_formatRateInput(rate)}%',
                      ),
                      onSelected: (_) => _selectPreset(rate),
                      showCheckmark: false,
                      backgroundColor: scheme.surfaceContainerHighest,
                      selectedColor:
                          scheme.primaryContainer.withValues(alpha: 0.7),
                      side: BorderSide(
                        color: ((_ratePercent - rate).abs() < 0.001 &&
                                (_applyTax || rate <= 0))
                            ? scheme.primary.withValues(alpha: 0.35)
                            : scheme.outlineVariant.withValues(alpha: 0.8),
                      ),
                      labelStyle: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: _tablet ? 13 : 12.sp,
                      ),
                    ),
                ],
              ),
            ],
            SizedBox(height: _sz(24, 20.h)),
            Row(
              children: [
                Expanded(
                  child: CustomButtonWidget.outlined(
                    height: buttonHeight,
                    borderRadius: _sz(8, 6.r),
                    onPressed: () =>
                        _popResult(applyTax: false, ratePercent: 0),
                    title: l10n.checkoutDiscard,
                  ),
                ),
                SizedBox(width: _sz(12, 10.w)),
                Expanded(
                  child: CustomButtonWidget(
                    height: buttonHeight,
                    borderRadius: _sz(8, 6.r),
                    title: l10n.saveChanges,
                    onPressed: () => _popResult(
                      applyTax: _applyTax,
                      ratePercent: _ratePercent,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.theme.colorScheme;
    final body = _buildBody();

    if (_tablet) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Material(
              color: scheme.surface,
              elevation: 12,
              shadowColor: scheme.shadow.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
              clipBehavior: Clip.antiAlias,
              child: body,
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: AppBottomSheetTheme.topSheetDecoration(context).copyWith(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26.r)),
      ),
      child: SafeArea(
        top: false,
        child: body,
      ),
    );
  }
}
