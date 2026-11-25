import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/constants/margin_constants.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/helpers/payment_method_for_api.dart';
import 'package:hotel/src/core/layout/device_layout.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/features/payment_methods/presentation/cubit/payment_methods_cubit.dart';
import 'package:hotel/constants.dart';

class PartialPaymentPreviewPage extends StatefulWidget {
  const PartialPaymentPreviewPage({
    super.key,
    required this.total,
    required this.accent,
    this.initialAmounts,
    /// When non-null and non-empty, row labels are fixed to this list (tests / special callers).
    /// From checkout, pass **null** so rows come only from [PaymentMethodsCubit] (same instance as summary).
    this.paymentMethodNames,
    /// When true, shows drag handle + close instead of [AppBar] (for [showModalBottomSheet]).
    this.embedInSheet = false,
  });

  final double total;
  final Color accent;
  final Map<String, double>? initialAmounts;
  final List<String>? paymentMethodNames;
  final bool embedInSheet;

  @override
  State<PartialPaymentPreviewPage> createState() => _PartialPaymentPreviewPageState();
}

class _PartialPaymentPreviewPageState extends State<PartialPaymentPreviewPage> {
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, FocusNode> _focusNodes = {};
  List<String> _activeMethods = [];

  String _money(double value) =>
      context.l10n.formatMoneyWithSymbol(currencySymbol, value);

  bool get _tablet => DeviceLayout.isTablet(context);

  double _sz(double tablet, double phone) => _tablet ? tablet : phone;

  double _sp(double tablet, double phone) => _tablet ? tablet : phone.sp;

  /// Same fallbacks as settlement flow when the payment-methods API errors or returns nothing.
  static const List<String> _kFallbackPaymentMethods = ['Cash', 'Bank', 'Transfer', 'Settlement'];

  static String _initialText(double? v) {
    if (v == null || v <= 0) return '';
    if (v == v.roundToDouble()) return '${v.round()}';
    return v.toStringAsFixed(1);
  }

  /// Resolves [initialAmounts] when keys are API-normalized (e.g. `Transfer`) but rows use display names (e.g. `Bank Transfer`).
  double? _initialAmountForMethod(String method) {
    final raw = widget.initialAmounts;
    if (raw == null) return null;
    if (raw.containsKey(method)) return raw[method];
    final api = normalizePaymentMethodForApi(method);
    for (final e in raw.entries) {
      if (normalizePaymentMethodForApi(e.key) == api) return e.value;
    }
    return null;
  }

  /// API names when available; loading/initial stay empty (spinner); error / empty success use fallbacks.
  List<String> _methodsFromCubitState(PaymentMethodsState state) {
    if (state.maybeWhen(error: (_) => true, noInternet: () => true, orElse: () => false)) {
      return List<String>.from(_kFallbackPaymentMethods);
    }
    final fromApi = state.paymentMethodNames();
    if (fromApi.isNotEmpty) return List<String>.from(fromApi);
    if (state.maybeWhen(loading: () => true, initial: () => true, orElse: () => false)) {
      return const [];
    }
    return List<String>.from(_kFallbackPaymentMethods);
  }

  bool _sameMethodsOrdered(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  void _syncMethodRows(List<String> next) {
    if (_sameMethodsOrdered(_activeMethods, next)) return;

    for (final removed in _activeMethods.where((m) => !next.contains(m)).toList()) {
      _controllers[removed]?.removeListener(_onFieldChanged);
      _focusNodes[removed]?.removeListener(_onFocusChanged);
      _controllers[removed]?.dispose();
      _focusNodes[removed]?.dispose();
      _controllers.remove(removed);
      _focusNodes.remove(removed);
    }

    for (final m in next) {
      if (_controllers.containsKey(m)) continue;
      final c = TextEditingController(text: _initialText(_initialAmountForMethod(m)));
      final n = FocusNode();
      c.addListener(_onFieldChanged);
      n.addListener(_onFocusChanged);
      _controllers[m] = c;
      _focusNodes[m] = n;
    }

    _activeMethods = List<String>.from(next);
  }

  void _onFieldChanged() => setState(() {});

  void _onFocusChanged() => setState(() {});

  @override
  void initState() {
    super.initState();
    final fixed = widget.paymentMethodNames;
    if (fixed != null && fixed.isNotEmpty) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      try {
        final c = context.read<PaymentMethodsCubit>();
        c.state.maybeWhen(
          initial: () => c.load(),
          orElse: () {},
        );
      } catch (_) {}
    });
  }

  @override
  void dispose() {
    final ctrls = _controllers.values.toList(growable: false);
    final nodes = _focusNodes.values.toList(growable: false);
    for (final c in ctrls) {
      c.removeListener(_onFieldChanged);
    }
    for (final n in nodes) {
      n.removeListener(_onFocusChanged);
    }
    super.dispose();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        for (final c in ctrls) {
          c.dispose();
        }
        for (final n in nodes) {
          n.dispose();
        }
      });
    });
  }

  double get _sumEntered {
    var s = 0.0;
    for (final c in _controllers.values) {
      s += double.tryParse(c.text.trim()) ?? 0;
    }
    return s;
  }

  static const double _kAmountTol = 1e-6;

  bool get _sumExceedsGrandTotal => _sumEntered > widget.total + _kAmountTol;

  double get _remaining => widget.total - _sumEntered;

  bool get _hasAnyPaymentAmount => _sumEntered > _kAmountTol;

  bool get _canConfirm => _hasAnyPaymentAmount && !_sumExceedsGrandTotal;

  void _fillRemainingForMethod(String method) {
    var sumOthers = 0.0;
    for (final e in _controllers.entries) {
      if (e.key == method) continue;
      sumOthers += double.tryParse(e.value.text.trim()) ?? 0;
    }
    final fill = (widget.total - sumOthers).clamp(0.0, double.infinity);
    _controllers[method]!.text = fill <= 0 ? '' : _initialText(fill);
  }

  Map<String, double> _nonZeroAmounts() {
    final out = <String, double>{};
    for (final e in _controllers.entries) {
      final v = double.tryParse(e.value.text.trim()) ?? 0;
      if (v <= 0) continue;
      final apiKey = normalizePaymentMethodForApi(e.key);
      out[apiKey] = (out[apiKey] ?? 0) + v;
    }
    return out;
  }

  void _confirm() {
    if (_sumEntered <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.checkoutEnterAtLeastOnePayment)),
      );
      return;
    }
    if (_sumExceedsGrandTotal) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.checkoutPaymentsExceedTotal)),
      );
      return;
    }
    Navigator.pop(context, _nonZeroAmounts());
  }

  Widget _embedSheetChrome(Widget child) {
    if (!widget.embedInSheet) return child;
    final scheme = Theme.of(context).colorScheme;
    final chrome = Column(
      children: [
        if (!_tablet) ...[
          SizedBox(height: 8.h),
          Center(
            child: Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: scheme.outlineVariant,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
        ],
        Padding(
          padding: EdgeInsets.fromLTRB(
            _sz(16, 8.w),
            _sz(16, 4.h),
            _sz(8, 4.w),
            _sz(8, 0),
          ),
          child: Row(
            children: [
              if (!_tablet) SizedBox(width: 48.w),
              Expanded(
                child: Text(
                  context.l10n.checkoutPartialPayment,
                  textAlign: _tablet ? TextAlign.start : TextAlign.center,
                  style: context.theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: _sp(20, 16),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.close_rounded,
                  size: _sz(24, 24),
                  color: scheme.onSurfaceVariant,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: scheme.outlineVariant.withValues(alpha: 0.5),
        ),
        Expanded(child: child),
      ],
    );
    return chrome;
  }

  Widget _wrapEmbedPresentation(Widget body) {
    final scheme = Theme.of(context).colorScheme;
    final sheet = Material(
      color: scheme.surface,
      child: _embedSheetChrome(body),
    );
    if (!_tablet) return sheet;

    final maxHeight = MediaQuery.sizeOf(context).height * 0.88;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 520,
            maxHeight: maxHeight,
          ),
          child: Material(
            color: scheme.surface,
            elevation: 12,
            shadowColor: scheme.shadow.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              height: maxHeight,
              child: sheet,
            ),
          ),
        ),
      ),
    );
  }

  Widget _scaffoldBody() {
    final scheme = Theme.of(context).colorScheme;
    if (_activeMethods.isEmpty) {
      return Center(
        child: SizedBox(
          width: 28,
          height: 28,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: widget.accent,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(
        _sz(20, 18.w),
        _sz(12, 8.h),
        _sz(20, 18.w),
        _sz(16, 18.h),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: _sz(12, 10.w),
              vertical: _sz(10, 8.h),
            ),
            decoration: BoxDecoration(
              color: scheme.primaryContainer.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(_sz(10, 8.r)),
            ),
            child: Text(
              context.l10n.checkoutPartialPaymentBanner,
              style: context.theme.textTheme.bodySmall?.copyWith(
                color: scheme.onPrimaryContainer,
                fontSize: _sp(13, 12),
                height: 1.35,
              ),
            ),
          ),
          SizedBox(height: _sz(14, 14.h)),
          Text(
            '${context.l10n.grandTotal}: ${_money(widget.total)}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: widget.accent,
              fontSize: _sp(17, 16),
            ),
          ),
          verticalMarginXSmall,
          Text(
            context.l10n.checkoutPleaseEnterAmounts,
            style: context.theme.textTheme.titleSmall?.copyWith(
              fontSize: _sp(14, 14),
            ),
          ),
          SizedBox(height: _sz(10, 10.h)),
          Expanded(
            child: ListView.separated(
              itemCount: _activeMethods.length,
              separatorBuilder: (_, __) => SizedBox(height: _sz(10, 10.h)),
              itemBuilder: (context, i) {
                final method = _activeMethods[i];
                final controller = _controllers[method]!;
                final focusNode = _focusNodes[method]!;
                final focused = focusNode.hasFocus;
                final letter = method.isNotEmpty ? method.substring(0, 1) : '?';
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: _sz(12, 12.w),
                    vertical: _sz(10, 8.h),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_sz(10, 10.r)),
                    border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.6)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: _sz(20, 18.r),
                        backgroundColor: scheme.surfaceContainerHighest,
                        child: Text(
                          letter,
                          style: context.theme.textTheme.labelMedium?.copyWith(
                            fontSize: _sp(14, 12),
                          ),
                        ),
                      ),
                      SizedBox(width: _sz(12, 10.w)),
                      Expanded(
                        child: Text(
                          method,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.theme.textTheme.labelLarge?.copyWith(
                            fontSize: _sp(15, 14),
                          ),
                        ),
                      ),
                      if (focused)
                        IconButton(
                          tooltip: context.l10n.checkoutFillRemainingBalance,
                          icon: Icon(
                            Icons.calculate,
                            size: _sz(22, 22),
                            color: widget.accent,
                          ),
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(
                            minWidth: _sz(36, 36.w),
                            minHeight: _sz(36, 36.h),
                          ),
                          onPressed: () => _fillRemainingForMethod(method),
                        ),
                      SizedBox(
                        width: _sz(124, 104.w),
                        child: CustomTextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          borderColor: Colors.transparent,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          prefixText: '$currencySymbol ',
                          hint: '00.00',
                          height: _sz(44, 50.h),
                          useFixedSizes: _tablet,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: _sz(8, 8.h)),
          Text(
            context.l10n.checkoutPartialPaymentEqualHint,
            style: context.theme.textTheme.labelMedium?.copyWith(
              color: widget.accent,
              fontSize: _sp(13, 12),
              height: 1.35,
            ),
          ),
          SizedBox(height: _sz(8, 8.h)),
          if (_sumExceedsGrandTotal)
            Text(
              context.l10n.checkoutOverGrandTotalBy(_money(_sumEntered - widget.total)),
              style: context.theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: context.theme.colorScheme.error,
                fontSize: _sp(14, 14),
              ),
            )
          else
            Text(
              context.l10n.checkoutRemainingUnpaid(_money(_remaining.clamp(0, double.infinity))),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: _sp(14, 14),
              ),
            ),
          SizedBox(height: _sz(12, 12.h)),
          Row(
            children: [
              Expanded(
                child: CustomButtonWidget.outlined(
                  height: _sz(48, 45.h),
                  onPressed: () => Navigator.pop(context),
                  title: context.l10n.back,
                ),
              ),
              SizedBox(width: _sz(10, 10.w)),
              Expanded(
                child: CustomButtonWidget(
                  onPressed: _canConfirm ? _confirm : null,
                  height: _sz(48, 45.h),
                  borderRadius: _sz(8, 6.r),
                  title: context.l10n.checkoutConfirmPayment,
                ),
              ),
            ],
          ),
          if (!_tablet) verticalMarginLarge,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fixed = widget.paymentMethodNames;
    if (fixed != null && fixed.isNotEmpty) {
      if (!_sameMethodsOrdered(_activeMethods, fixed)) {
        _syncMethodRows(List<String>.from(fixed));
      }
      final body = ColoredBox(color: scheme.surface, child: _scaffoldBody());
      if (widget.embedInSheet) {
        return _wrapEmbedPresentation(body);
      }
      return Scaffold(
        backgroundColor: scheme.surface,
        appBar: AppBar(
          leading: const AppBarIosBackButton(),
          title: Text(context.l10n.checkoutPartialPayment),
          centerTitle: false,
        ),
        body: body,
      );
    }

    PaymentMethodsCubit? cubit;
    try {
      cubit = context.read<PaymentMethodsCubit>();
    } catch (_) {
      final err = ColoredBox(
        color: scheme.surface,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              'Payment methods are unavailable here. Open partial payment from invoice or order checkout.',
              textAlign: TextAlign.center,
              style: context.theme.textTheme.bodyLarge,
            ),
          ),
        ),
      );
      if (widget.embedInSheet) {
        return _wrapEmbedPresentation(err);
      }
      return Scaffold(
        backgroundColor: scheme.surface,
        appBar: AppBar(
          leading: const AppBarIosBackButton(),
          title: Text(context.l10n.checkoutPartialPayment),
          centerTitle: false,
        ),
        body: err,
      );
    }

    final body = ColoredBox(
      color: scheme.surface,
      child: BlocBuilder<PaymentMethodsCubit, PaymentMethodsState>(
        bloc: cubit,
        builder: (context, state) {
          final methods = _methodsFromCubitState(state);
          if (!_sameMethodsOrdered(_activeMethods, methods)) {
            _syncMethodRows(methods);
          }
          return _scaffoldBody();
        },
      ),
    );
    if (widget.embedInSheet) {
      return _wrapEmbedPresentation(body);
    }
    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        leading: const AppBarIosBackButton(),
        title: Text(context.l10n.checkoutPartialPayment),
        centerTitle: false,
      ),
      body: body,
    );
  }
}
