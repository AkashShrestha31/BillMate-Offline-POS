import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/layout/device_layout.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:hotel/constants.dart';

class EditDiscountSheet extends StatefulWidget {
  const EditDiscountSheet({
    super.key,
    required this.subTotal,
    required this.initialDiscountAmount,
  });

  final double subTotal;
  final double initialDiscountAmount;

  static Future<double?> show(
    BuildContext context, {
    required double subTotal,
    required double initialDiscountAmount,
  }) {
    final sheet = EditDiscountSheet(
      subTotal: subTotal,
      initialDiscountAmount: initialDiscountAmount,
    );

    if (DeviceLayout.isTablet(context)) {
      return showDialog<double>(
        context: context,
        barrierDismissible: true,
        builder: (_) => sheet,
      );
    }

    return showModalBottomSheet<double>(
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
  State<EditDiscountSheet> createState() => _EditDiscountSheetState();
}

class _EditDiscountSheetState extends State<EditDiscountSheet> {
  late final TextEditingController _percent;
  late final TextEditingController _amount;

  bool get _tablet => DeviceLayout.isTablet(context);

  double _sz(double tablet, double phone) => _tablet ? tablet : phone;

  @override
  void initState() {
    super.initState();
    _percent = TextEditingController();
    _amount = TextEditingController();
    if (widget.initialDiscountAmount > 0 && widget.subTotal > 0) {
      _amount.text = trimMoneyAmount(widget.initialDiscountAmount, maxDecimals: 2);
      final pct = (widget.initialDiscountAmount / widget.subTotal) * 100;
      _percent.text =
          (pct - pct.round()).abs() < 0.05 ? '${pct.round()}' : pct.toStringAsFixed(2);
    }
  }

  double get _discount {
    final pRaw = _percent.text.trim();
    final aRaw = _amount.text.trim();
    final p = double.tryParse(pRaw);
    final a = double.tryParse(aRaw);
    final hasAmount = aRaw.isNotEmpty && a != null;
    final hasPercent = pRaw.isNotEmpty && p != null;
    if (hasAmount && !hasPercent) return a.clamp(0, double.infinity);
    if (hasPercent && !hasAmount) return (widget.subTotal * p / 100).clamp(0, double.infinity);
    if (hasAmount && hasPercent) return a.clamp(0, double.infinity);
    return 0;
  }

  String _money(double value) =>
      context.l10n.formatMoneyWithSymbol(currencySymbol, value);

  void _onPercentChanged(String _) {
    if (_percent.text.trim().isNotEmpty) {
      _amount.clear();
    }
    setState(() {});
  }

  void _onAmountChanged(String _) {
    if (_amount.text.trim().isNotEmpty) {
      _percent.clear();
    }
    setState(() {});
  }

  @override
  void dispose() {
    _percent.dispose();
    _amount.dispose();
    super.dispose();
  }

  Widget _buildBody() {
    final l10n = context.l10n;
    final fieldHeight = _sz(48, 45.h);
    final buttonHeight = _sz(48, 45.h);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        _sz(20, 14.w),
        _sz(16, 8.h),
        _sz(20, 14.w),
        _sz(16, 12.h),
      ),
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
                  l10n.checkoutEditDiscount,
                  style: context.theme.textTheme.titleMedium?.copyWith(
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
          SizedBox(height: _sz(12, 6.h)),
          Row(
            children: [
              Text(
                l10n.subtotal,
                style: context.theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: _tablet ? 15 : null,
                ),
              ),
              const Spacer(),
              Text(
                _money(widget.subTotal),
                style: context.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: _tablet ? 16 : null,
                ),
              ),
            ],
          ),
          SizedBox(height: _sz(16, 12.h)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomTextFormField(
                  height: fieldHeight,
                  useFixedSizes: _tablet,
                  controller: _percent,
                  onChanged: _onPercentChanged,
                  labelText: l10n.checkoutPercentage,
                  hint: '00.00',
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: _sz(8, 4.w)),
                    child: Icon(
                      Icons.percent,
                      size: _sz(18, 16),
                      color: context.theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              SizedBox(width: _sz(12, 10.w)),
              Expanded(
                child: CustomTextFormField(
                  height: fieldHeight,
                  useFixedSizes: _tablet,
                  controller: _amount,
                  onChanged: _onAmountChanged,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  labelText: l10n.amount,
                  hint: '00.00',
                ),
              ),
            ],
          ),
          SizedBox(height: _sz(16, 12.h)),
          Row(
            children: [
              Text(
                l10n.discount,
                style: context.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: _tablet ? 16 : null,
                ),
              ),
              const Spacer(),
              Text(
                _money(_discount),
                style: context.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: _tablet ? 16 : null,
                ),
              ),
            ],
          ),
          SizedBox(height: _sz(24, 20.h)),
          Row(
            children: [
              Expanded(
                child: CustomButtonWidget.outlined(
                  height: buttonHeight,
                  borderRadius: _sz(8, 6.r),
                  onPressed: () => Navigator.pop(context, 0.0),
                  title: l10n.checkoutDiscard,
                ),
              ),
              SizedBox(width: _sz(12, 10.w)),
              Expanded(
                child: CustomButtonWidget(
                  onPressed: () => Navigator.pop(context, _discount),
                  height: buttonHeight,
                  borderRadius: _sz(8, 6.r),
                  title: l10n.saveChanges,
                ),
              ),
            ],
          ),
        ],
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
