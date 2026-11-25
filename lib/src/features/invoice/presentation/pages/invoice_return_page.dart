import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/app_loading_overlay.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_return_check_model.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_sales_response_model.dart';
import 'package:hotel/src/features/invoice/presentation/cubit/invoice_return_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/widgets/cancel_return_confirm_sheet.dart';
import 'package:hotel/src/core/services/display_precision/app_money_format.dart';
import 'package:hotel/src/core/layout/device_layout.dart';
import 'package:hotel/src/features/invoice/presentation/widgets/invoice_tab_tablet_layout.dart';
import 'package:intl/intl.dart';
import 'package:hotel/constants.dart';

/// Return-request section colors derived from the active theme.
extension _ReturnUi on _InvoiceReturnPageState {
  ColorScheme get _scheme => Theme.of(context).colorScheme;
  bool get _isDark => _scheme.brightness == Brightness.dark;

  Color get _uiBg => _scheme.surfaceContainerLow;
  Color get _uiSurface => _scheme.surfaceContainerHigh;
  Color get _uiSurfaceElevated => _scheme.surfaceContainer;
  Color get _uiBorder => _scheme.outlineVariant.withValues(alpha: _isDark ? 0.55 : 1);
  Color get _uiBorderLight => _scheme.outlineVariant.withValues(alpha: _isDark ? 0.35 : 0.75);
  Color get _uiLabel => _scheme.onSurfaceVariant;
  Color get _uiText => _scheme.onSurface;
  Color get _uiSuccess => _isDark ? const Color(0xFF4ADE80) : const Color(0xFF16A34A);
  Color get _uiPendingBg => _isDark ? const Color(0xFF3D2A14) : const Color(0xFFFFF7ED);
  Color get _uiPendingFg => _isDark ? const Color(0xFFFBBF24) : const Color(0xFFD97706);
  Color get _uiChipDefective => _isDark ? const Color(0xFF4C1D1D) : const Color(0xFFFEE2E2);
  Color get _uiChipMind => _isDark ? const Color(0xFF14532D) : const Color(0xFFDCFCE7);
  Color get _uiChipDefectiveFg => _isDark ? const Color(0xFFFCA5A5) : const Color(0xFF991B1B);
  Color get _uiChipMindFg => _isDark ? const Color(0xFF86EFAC) : const Color(0xFF166534);
}

const _returnReasons = ['Defective', 'Wrong item', 'Changed mind', 'Damaged', 'Other'];

class InvoiceReturnPage extends StatefulWidget {
  const InvoiceReturnPage({
    super.key,
    required this.invoice,
    required this.invoiceType,
    this.onCompleted,
  });

  final InvoiceItem invoice;
  final InvoiceType invoiceType;
  final VoidCallback? onCompleted;

  @override
  State<InvoiceReturnPage> createState() => _InvoiceReturnPageState();
}

class _InvoiceReturnPageState extends State<InvoiceReturnPage> {
  final _dateController = TextEditingController();
  final _authorizedController = TextEditingController();
  final _dateDisplay = DateFormat('MMM d, yyyy');
  final Map<String, TextEditingController> _qtyControllers = {};
  final Map<String, String> _lineReasons = {};
  final Map<String, bool> _lineSelected = {};

  List<InvoiceReturnLine> _lines = [];
  String? _loadedDataSignature;
  bool _cancellingReturn = false;
  String _refundMethod = 'cash';
  String _refundPaymentMethod = 'Cash';

  static const _paymentMethods = ['Cash', 'QR', 'Bank', 'Transfer'];

  Color get _primary => Theme.of(context).colorScheme.primary;

  Color get _onPrimary => Theme.of(context).colorScheme.onPrimary;

  Color get _primarySoft => _primary.withValues(alpha: 0.12);

  Color get _primaryContainer => Theme.of(context).colorScheme.primaryContainer;

  Color get _onPrimaryContainer => Theme.of(context).colorScheme.onPrimaryContainer;

  bool get _isTablet => DeviceLayout.isTablet(context);

  static const double _tabletMaxWidth = 640;

  double _tabletContentWidth(BuildContext context) {
    final available = MediaQuery.sizeOf(context).width;
    return available < _tabletMaxWidth ? available : _tabletMaxWidth;
  }

  double _sz(double tablet, double phone) =>
      InvoiceTabTabletLayout.sz(context, tablet, phone);

  double _sp(double tablet, double phone) =>
      InvoiceTabTabletLayout.sp(context, tablet, phone);

  NumberFormat get _currency => AppMoneyFormat.currency(currencySymbol);

  String get _returnDateIso {
    final raw = _dateController.text.trim();
    final parsed = DateTime.tryParse(raw) ?? _dateDisplay.tryParse(raw);
    return DateFormat('yyyy-MM-dd').format(parsed ?? DateTime.now());
  }

  String _formatQty(double q) {
    if (q == q.roundToDouble()) return '${q.round()}';
    return AppMoneyFormat.formatAmount(q);
  }

  @override
  void initState() {
    super.initState();
    _dateController.text = _dateDisplay.format(DateTime.now());
    final auth = context.employeeData?.email?.trim();
    _authorizedController.text = (auth != null && auth.isNotEmpty) ? auth : context.loggedInUserFullName;
    context.read<InvoiceReturnCubit>().load(
          invoiceType: widget.invoiceType,
          invoiceName: widget.invoice.invoiceName ?? '',
        );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _authorizedController.dispose();
    for (final c in _qtyControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _syncLinesFromReady(InvoiceReturnCheckData data) {
    for (final c in _qtyControllers.values) {
      c.dispose();
    }
    _qtyControllers.clear();
    _lineReasons.clear();
    _lineSelected.clear();
    _lines = data.items.map((e) {
      final line = InvoiceReturnLine(
        lineId: e.lineId,
        displayName: e.displayName,
        quantity: e.quantity,
        alreadyReturnedQty: e.alreadyReturnedQty,
        maxReturnQty: e.maxReturnQty,
        rate: e.rate,
        amount: e.amount,
        unit: e.unit,
        canReturn: e.canReturn,
        returnQty: 0,
      );
      _qtyControllers[line.lineId] = TextEditingController();
      _lineReasons[line.lineId] = 'Defective';
      _lineSelected[line.lineId] = false;
      return line;
    }).toList();
    _loadedDataSignature = _dataSignature(data);
  }

  String _dataSignature(InvoiceReturnCheckData data) {
  final history = data.returnInvoices
      .map((e) => '${e.name}:${e.status}:${e.returnAmount}')
      .join('|');
  final items = data.items
      .map((e) => '${e.lineId}:${e.alreadyReturnedQty}:${e.maxReturnQty}')
      .join('|');
  return '$history#$items';
  }

  void _applyReadyData(InvoiceReturnCheckData data) {
    final signature = _dataSignature(data);
    if (_loadedDataSignature == signature) return;
    _syncLinesFromReady(data);
  }

  bool get _hasReturnableLines =>
      _lines.any((line) => line.canReturn && line.maxReturnQty > 0.005);

  String _qtyText(double q) {
    if (q <= 0.005) return '';
    if (q == q.roundToDouble()) return '${q.round()}';
    return q.toStringAsFixed(1);
  }

  void _setLineQty(InvoiceReturnLine line, double qty) {
    if (!line.canReturn || !(_lineSelected[line.lineId] ?? false)) return;
    final clamped = qty.clamp(0, line.maxReturnQty).toDouble();
    setState(() {
      line.returnQty = clamped;
      _qtyControllers[line.lineId]?.text = _qtyText(clamped);
    });
  }

  void _toggleLine(InvoiceReturnLine line, bool? selected) {
    setState(() {
      _lineSelected[line.lineId] = selected ?? false;
      if (!(_lineSelected[line.lineId] ?? false)) {
        line.returnQty = 0;
        _qtyControllers[line.lineId]?.text = '';
      } else if (line.returnQty < 0.005 && line.maxReturnQty > 0.005) {
        _setLineQty(line, 1);
      }
    });
  }

  void _applyFullReturn() {
    setState(() {
      for (final line in _lines) {
        if (line.canReturn && line.maxReturnQty > 0.005) {
          _lineSelected[line.lineId] = true;
          line.returnQty = line.maxReturnQty;
          _qtyControllers[line.lineId]?.text = _qtyText(line.returnQty);
        }
      }
    });
  }

  void _clearAllReturns() {
    setState(() {
      for (final line in _lines) {
        _lineSelected[line.lineId] = false;
        line.returnQty = 0;
        _qtyControllers[line.lineId]?.text = '';
      }
    });
  }

  int get _selectedItemCount => _lines.where((l) => l.returnQty > 0.005 && (_lineSelected[l.lineId] ?? false)).length;

  double get _returnUnits =>
      _lines.fold<double>(0, (s, l) => s + ((_lineSelected[l.lineId] ?? false) ? l.returnQty : 0));

  double get _returnTotal => _lines.fold<double>(
        0,
        (sum, l) => sum + ((_lineSelected[l.lineId] ?? false) ? l.returnQty * l.rate : 0),
      );

  bool get _invoiceUnpaid {
    final s = context.read<InvoiceReturnCubit>().state;
    if (s is InvoiceReturnReady) return s.data.invoice?.invoiceUnpaid ?? false;
    if (s is InvoiceReturnSubmitting) return s.data.invoice?.invoiceUnpaid ?? false;
    return false;
  }

  String _buildReasonPayload() {
    final parts = <String>[];
    for (final line in _lines) {
      if (line.returnQty <= 0.005 || !(_lineSelected[line.lineId] ?? false)) continue;
      final r = _lineReasons[line.lineId] ?? 'Defective';
      parts.add('${line.displayName}: $r');
    }
    if (parts.isEmpty) return '—';
    return parts.join('; ');
  }

  Future<void> _pickDate() async {
    final parsed = DateTime.tryParse(_dateController.text.trim());
    final picked = await showDatePicker(
      context: context,
      initialDate: parsed ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _dateController.text = _dateDisplay.format(picked));
    }
  }

  Future<void> _confirmCancelReturn(InvoiceReturnHistoryEntry entry) async {
    if (_returnHistoryIsCancelled(entry)) return;

    final confirmed = await showCancelReturnConfirmSheet(
      context: context,
      returnName: entry.name,
    );
    if (confirmed != true || !mounted) return;

    final email = _authorizedController.text.trim();
    final createdBy = email.isNotEmpty ? email : context.loggedInUserFullName;
    setState(() => _cancellingReturn = true);
    try {
      AppLoadingOverlay.of(context).show();
      final msg = await context.read<InvoiceReturnCubit>().cancelReturn(
            returnInvoiceName: entry.name,
            cancelledBy: createdBy.isEmpty ? 'mobile' : createdBy,
          );
      if (!mounted) return;
      AppLoadingOverlay.of(context).hide();
      setState(() => _cancellingReturn = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg ?? 'Return cancelled')),
      );
      widget.onCompleted?.call();
    } catch (e) {
      if (!mounted) return;
      AppLoadingOverlay.of(context).hide();
      setState(() => _cancellingReturn = false);
      final text = e is AppException ? e.message : e.toString();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    }
  }

  void _submit() {
    final refund = _invoiceUnpaid ? 'none' : _refundMethod;
    final payMethod = refund == 'cash' ? _refundPaymentMethod : null;
    final email = _authorizedController.text.trim();
    final createdBy = email.isNotEmpty ? email : context.loggedInUserFullName;
    context.read<InvoiceReturnCubit>().submit(
          returnDate: _returnDateIso,
          reason: _buildReasonPayload(),
          createdBy: createdBy.isEmpty ? 'mobile' : createdBy,
          refundMethod: refund,
          refundPaymentMethod: payMethod,
          lines: _lines,
        );
  }

  String _invoiceDateLabel(InvoiceReturnSummary? inv) {
    final raw = inv?.date ?? widget.invoice.date;
    if (raw == null || raw.trim().isEmpty) return '—';
    final d = DateTime.tryParse(raw.trim());
    if (d == null) return raw;
    return _dateDisplay.format(d);
  }

  @override
  Widget build(BuildContext context) {
    final isSales = widget.invoiceType == InvoiceType.sales;

    return Scaffold(
      backgroundColor: _uiBg,
      appBar: AppBar(
        backgroundColor: _uiSurface,
        foregroundColor: _uiText,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: AppBarIosBackButton(color: _uiText),
        title: Text(
          isSales ? 'Sales Return' : 'Purchase Return',
          style: AppFonts.interStyle(
            color: _uiText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocConsumer<InvoiceReturnCubit, InvoiceReturnState>(
        listener: (context, state) {
          if (state is InvoiceReturnReady) {
            _applyReadyData(state.data);
            final flash = state.flashMessage;
            if (flash != null && flash.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(flash)),
              );
              widget.onCompleted?.call();
            }
            setState(() {});
          }
          if (state is InvoiceReturnFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is InvoiceReturnLoading) {
            return Center(
              child: CircularProgressIndicator(color: _primary),
            );
          }
          if (state is InvoiceReturnFailure && _lines.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(_sz(12, 12.w)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.message, textAlign: TextAlign.center, style: AppFonts.interStyle(color: _uiText)),
                    SizedBox(height: _sz(16, 16.h)),
                    TextButton(
                      onPressed: () => context.read<InvoiceReturnCubit>().load(
                            invoiceType: widget.invoiceType,
                            invoiceName: widget.invoice.invoiceName ?? '',
                          ),
                      child: Text('Try again'),
                    ),
                  ],
                ),
              ),
            );
          }

          final data = switch (state) {
            InvoiceReturnReady(:final data) => data,
            InvoiceReturnSubmitting(:final data) => data,
            _ => null,
          };
          if (data == null) return const SizedBox.shrink();
          _applyReadyData(data);

          final inv = data.invoice;
          final unpaid = inv?.invoiceUnpaid ?? false;
          final submitting = state is InvoiceReturnSubmitting || _cancellingReturn;
          final canSubmit = !submitting && _hasReturnableLines && _returnTotal > 0.005;
          final invoiceNo = inv?.name ?? widget.invoice.invoiceName ?? '—';
          final party = (inv?.party ?? widget.invoice.party ?? '').trim();

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.fromLTRB(
                    _sz(24, _sz(12, 12.w)),
                    _sz(4, 4.h),
                    _sz(24, _sz(12, 12.w)),
                    _sz(16, 16.h),
                  ),
                  children: [
                    if (_isTablet)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: _tabletContentWidth(context),
                            child: _buildPageSections(
                              party: party,
                              invoiceNo: invoiceNo,
                              invoiceDate: _invoiceDateLabel(inv),
                              inv: inv,
                              unpaid: unpaid,
                              isSales: isSales,
                              submitting: submitting,
                              data: data,
                            ),
                          ),
                        ],
                      )
                    else
                      _buildPageSections(
                        party: party,
                        invoiceNo: invoiceNo,
                        invoiceDate: _invoiceDateLabel(inv),
                        inv: inv,
                        unpaid: unpaid,
                        isSales: isSales,
                        submitting: submitting,
                        data: data,
                      ),
                  ],
                ),
              ),
              _footer(submitting: submitting, canSubmit: canSubmit, showActions: _hasReturnableLines),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPageSections({
    required String party,
    required String invoiceNo,
    required String invoiceDate,
    required InvoiceReturnSummary? inv,
    required bool unpaid,
    required bool isSales,
    required bool submitting,
    required InvoiceReturnCheckData data,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        verticalMarginMedium,
        _customerSection(
          party: party.isEmpty ? 'Cash Customer' : party,
          invoiceNo: invoiceNo,
          invoiceDate: invoiceDate,
        ),
        _alreadyReturnedSection(),
        SizedBox(height: _sz(20, 20.h)),
        _returnItemsSection(submitting),
        SizedBox(height: _sz(20, 20.h)),
        _returnSettingsSection(
          unpaid: unpaid,
          isSales: isSales,
          submitting: submitting,
        ),
        _returnHistorySection(data.returnInvoices, submitting),
        SizedBox(height: _sz(20, 20.h)),
        _refundSummarySection(inv),
      ],
    );
  }

  Widget _progressDot({
    required String label,
    required IconData icon,
    required bool done,
    required bool active,
  }) {
    final color = done
        ? _uiSuccess
        : active
            ? _primary
            : _uiBorderLight;
    final bg = done
        ? _uiSuccess.withValues(alpha: 0.15)
        : active
            ? _primarySoft
            : _uiSurfaceElevated;

    return Column(
      children: [
        Container(
          width: _sz(36, 36.w),
          height: _sz(36, 36.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bg,
            border: Border.all(color: color, width: 1.5),
          ),
          child: Icon(icon, size: _sp(18, 18.sp), color: color),
        ),
        SizedBox(height: _sz(8, 8.h)),
        SizedBox(
          width: _sz(64, 64.w),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppFonts.interStyle(fontSize: _sp(10, 10.sp), color: _uiLabel, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _customerSection({
    required String party,
    required String invoiceNo,
    required String invoiceDate,
  }) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('CUSTOMER INFO', Icons.person_outline_rounded),
          SizedBox(height: _sz(16, 16.h)),
          _returnField(
            labelText: 'Customer name',
            initialValue: party,
            readOnly: true,
          ),
          SizedBox(height: _sz(12, 12.h)),
          _returnField(
            labelText: 'Invoice #',
            initialValue: invoiceNo,
            readOnly: true,
          ),
          SizedBox(height: _sz(12, 12.h)),
          Row(
            children: [
              Expanded(
                child: _returnField(
                  labelText: 'Invoice date',
                  initialValue: invoiceDate,
                  readOnly: true,
                ),
              ),
              SizedBox(width: _sz(10, 10.w)),
              Expanded(
                child: _returnField(
                  labelText: 'Return date',
                  controller: _dateController,
                  readOnly: true,
                  onTap: _pickDate,
                  suffixIcon: Icon(
                    Icons.calendar_today_outlined,
                    size: _sp(18, 18.sp),
                    color: _uiLabel,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _alreadyReturnedSection() {
    final returned = _lines.where((l) => l.alreadyReturnedQty > 0.005).toList();
    if (returned.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(height: _sz(20, 20.h)),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle('RETURNED ITEMS', Icons.assignment_return_outlined),
              SizedBox(height: _sz(12, 12.h)),
              ...returned.map(_alreadyReturnedRow),
            ],
          ),
        ),
      ],
    );
  }

  Widget _alreadyReturnedRow(InvoiceReturnLine line) {
    final returnedAmount = line.alreadyReturnedQty * line.rate;
    final progress = line.quantity > 0.005 ? (line.alreadyReturnedQty / line.quantity).clamp(0.0, 1.0) : 0.0;

    return Container(
      margin: EdgeInsets.only(bottom: _sz(10, 10.h)),
      padding: EdgeInsets.all(_sz(12, 12.w)),
      decoration: BoxDecoration(
        color: _uiPendingBg.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(_sz(10, 10.r)),
        border: Border.all(color: _uiPendingFg.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  line.displayName,
                  style: AppFonts.interStyle(
                    fontSize: _sp(14, 14.sp),
                    fontWeight: FontWeight.w600,
                    color: _uiText,
                  ),
                ),
              ),
              Text(
                _currency.format(returnedAmount),
                style: AppFonts.interStyle(
                  fontSize: _sp(13, 13.sp),
                  fontWeight: FontWeight.w700,
                  color: _uiPendingFg,
                ),
              ),
            ],
          ),
          SizedBox(height: _sz(6, 6.h)),
          Text(
            'Returned ${_formatQty(line.alreadyReturnedQty)} of ${_formatQty(line.quantity)} ${line.unit}',
            style: AppFonts.interStyle(fontSize: _sp(12, 12.sp), color: _uiLabel),
          ),
          SizedBox(height: _sz(8, 8.h)),
          ClipRRect(
            borderRadius: BorderRadius.circular(_sz(4, 4.r)),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: _sz(6, 6.h),
              backgroundColor: _uiBorderLight,
              valueColor: AlwaysStoppedAnimation<Color>(_uiPendingFg),
            ),
          ),
        ],
      ),
    );
  }

  Widget _returnItemsSection(bool submitting) {
    final returnable = _lines.where((l) => l.maxReturnQty > 0.005).toList();
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: _sectionTitle('RETURN ITEMS', Icons.list_alt_rounded)),
              Text(
                '$_selectedItemCount items',
                style: AppFonts.interStyle(fontSize: _sp(12, 12.sp), color: _uiLabel),
              ),
            ],
          ),
          SizedBox(height: _sz(12, 12.h)),
          Row(
            children: [
              _textAction('Return all', submitting ? null : _applyFullReturn),
              SizedBox(width: _sz(12, 12.w)),
              _textAction('Clear', submitting ? null : _clearAllReturns),
            ],
          ),
          SizedBox(height: _sz(14, 14.h)),
          if (returnable.isEmpty)
            Text(
              _lines.any((l) => l.alreadyReturnedQty > 0.005)
                  ? 'All items on this invoice have been returned.'
                  : 'No line items on this invoice.',
              style: AppFonts.interStyle(fontSize: _sp(13, 13.sp), color: _uiLabel),
            )
          else
            ...returnable.map((l) => _returnItemCard(l, submitting)),
        ],
      ),
    );
  }

  Widget _returnItemCard(InvoiceReturnLine line, bool disabled) {
    final selected = _lineSelected[line.lineId] ?? false;
    final canEdit = line.canReturn && line.maxReturnQty > 0.005 && !disabled && selected;
    final lineTotal = line.returnQty * line.rate;
    final reason = _lineReasons[line.lineId] ?? 'Defective';

    return Container(
      margin: EdgeInsets.only(bottom: _sz(12, 12.h)),
      padding: EdgeInsets.all(_sz(14, 14.w)),
      decoration: BoxDecoration(
        color: _uiSurfaceElevated,
        borderRadius: BorderRadius.circular(_sz(12, 12.r)),
        border: Border.all(
          color: selected ? _primary.withValues(alpha: 0.45) : _uiBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      line.displayName,
                      style: AppFonts.interStyle(
                        fontSize: _sp(15, 15.sp),
                        fontWeight: FontWeight.w600,
                        color: _uiText,
                      ),
                    ),
                    SizedBox(height: _sz(2, 2.h)),
                    Text(
                      'Sold ${_formatQty(line.quantity)} · Returned ${_formatQty(line.alreadyReturnedQty)} · Left ${_formatQty(line.maxReturnQty)}',
                      style: AppFonts.interStyle(fontSize: _sp(12, 12.sp), color: _uiLabel),
                    ),
                  ],
                ),
              ),
              if (line.quantity > 0.005) ...[
                TextButton(
                  onPressed: disabled || !line.canReturn || !selected
                      ? null
                      : () => _setLineQty(line, line.maxReturnQty),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: _sz(8, 8.w), vertical: _sz(4, 4.h)),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text('Max', style: AppFonts.interStyle(fontSize: _sp(12, 12.sp), color: _primary)),
                ),
                SizedBox(width: _sz(4, 4.w)),
              ],
              Checkbox(
                value: selected,
                onChanged: disabled || !line.canReturn ? null : (v) => _toggleLine(line, v),
                activeColor: _primary,
                checkColor: _onPrimary,
                side: BorderSide(color: _uiBorderLight, width: 1.5),
              ),
            ],
          ),
          if (line.quantity > 0.005) ...[
            SizedBox(height: _sz(10, 10.h)),
            ClipRRect(
              borderRadius: BorderRadius.circular(_sz(4, 4.r)),
              child: LinearProgressIndicator(
                value: (line.alreadyReturnedQty / line.quantity).clamp(0.0, 1.0),
                minHeight: _sz(5, 5.h),
                backgroundColor: _uiBorderLight,
                valueColor: AlwaysStoppedAnimation<Color>(
                  line.alreadyReturnedQty > 0.005 ? _uiPendingFg : _primary,
                ),
              ),
            ),
          ],
          SizedBox(height: _sz(12, 12.h)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _returnField(
                  labelText: 'Sold qty',
                  initialValue: _formatQty(line.quantity),
                  readOnly: true,
                ),
              ),
              SizedBox(width: _sz(8, 8.w)),
              Expanded(
                child: _returnField(
                  labelText: 'Returned',
                  initialValue: _formatQty(line.alreadyReturnedQty),
                  readOnly: true,
                ),
              ),
              SizedBox(width: _sz(8, 8.w)),
              Expanded(
                child: _returnField(
                  labelText: 'Max return',
                  initialValue: _formatQty(line.maxReturnQty),
                  readOnly: true,
                ),
              ),
            ],
          ),
          SizedBox(height: _sz(12, 12.h)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: _returnField(
                  labelText: 'Return qty',
                  controller: _qtyControllers[line.lineId],
                  enabled: canEdit,
                  hint: '0',
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  onChanged: (v) {
                    final q = double.tryParse(v.trim()) ?? 0;
                    line.returnQty = q.clamp(0, line.maxReturnQty).toDouble();
                    if ((line.returnQty - q).abs() > 0.001) {
                      _qtyControllers[line.lineId]?.text = _qtyText(line.returnQty);
                    }
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: _sz(10, 10.w)),
              Expanded(
                flex: 2,
                child: _returnField(
                  labelText: 'Unit price',
                  initialValue: _formatQty(line.rate),
                  readOnly: true,
                ),
              ),
            ],
          ),
          SizedBox(height: _sz(10, 10.h)),
          _returnDropdownField<String>(
            fieldKey: ValueKey('reason-${line.lineId}-$reason'),
            labelText: 'Return reason',
            value: reason,
            items: _returnReasons,
            onChanged: disabled || !selected
                ? null
                : (v) {
                    if (v != null) setState(() => _lineReasons[line.lineId] = v);
                  },
          ),
          SizedBox(height: _sz(10, 10.h)),
          Row(
            children: [
              _reasonChip(reason),
              const Spacer(),
              if (lineTotal > 0.005)
                Text(
                  _currency.format(lineTotal),
                  style: AppFonts.interStyle(
                    fontSize: _sp(14, 14.sp),
                    fontWeight: FontWeight.w700,
                    color: _uiText,
                  ),
                ),
            ],
          ),
          if (!line.canReturn || line.maxReturnQty <= 0.005)
            Padding(
              padding: EdgeInsets.only(top: _sz(8, 8.h)),
              child: Text(
                'Not returnable',
                style: AppFonts.interStyle(fontSize: _sp(11, 11.sp), color: _uiPendingFg),
              ),
            ),
        ],
      ),
    );
  }

  Widget _refundSummarySection(InvoiceReturnSummary? inv) {
    final alreadyReturned = inv?.alreadyReturnedAmount ?? 0;
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('REFUND SUMMARY', Icons.receipt_long_outlined),
          SizedBox(height: _sz(16, 16.h)),
          Row(
            children: [
              Expanded(child: _summaryTile('Items', '$_selectedItemCount')),
              SizedBox(width: _sz(10, 10.w)),
              Expanded(child: _summaryTile('Units', _returnUnits.toStringAsFixed(0))),
              SizedBox(width: _sz(10, 10.w)),
              Expanded(
                child: _summaryTile(
                  'Refund',
                  _currency.format(_returnTotal),
                  highlight: true,
                ),
              ),
            ],
          ),
          SizedBox(height: _sz(16, 16.h)),
          if (alreadyReturned > 0.005) ...[
            _summaryRow('Already returned', _currency.format(alreadyReturned)),
            SizedBox(height: _sz(8, 8.h)),
          ],
          _summaryRow('Subtotal', _currency.format(_returnTotal)),
          SizedBox(height: _sz(8, 8.h)),
          _summaryRow('Restocking fee', _currency.format(0)),
          SizedBox(height: _sz(8, 8.h)),
          _summaryRow('Tax adjustment', _currency.format(0)),
          Padding(
            padding: EdgeInsets.only(top: _sz(14, 14.h)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Net refund',
                  style: AppFonts.interStyle(fontSize: _sp(15, 15.sp), fontWeight: FontWeight.w600, color: _uiText),
                ),
                Text(
                  _currency.format(_returnTotal),
                  style: AppFonts.interStyle(
                    fontSize: _sp(22, 22.sp),
                    fontWeight: FontWeight.w700,
                    color: _primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _returnSettingsSection({
    required bool unpaid,
    required bool isSales,
    required bool submitting,
  }) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('RETURN SETTINGS', Icons.settings_outlined),
          SizedBox(height: _sz(16, 16.h)),
          if (isSales) ...[
            if (unpaid)
              Padding(
                padding: EdgeInsets.only(bottom: _sz(12, 12.h)),
                child: Text(
                  'Unpaid invoice — stock return only (no refund).',
                  style: AppFonts.interStyle(fontSize: _sp(12, 12.sp), color: _uiPendingFg),
                ),
              )
            else ...[
              _returnDropdownField<String>(
                fieldKey: ValueKey('refund-$_refundMethod'),
                labelText: 'Refund method',
                value: _refundMethod == 'cash'
                    ? 'Original payment method'
                    : _refundMethod == 'credit'
                        ? 'Store credit'
                        : 'Stock only',
                items: const ['Original payment method', 'Store credit', 'Stock only'],
                onChanged: submitting
                    ? null
                    : (v) {
                        if (v == null) return;
                        setState(() {
                          if (v == 'Store credit') {
                            _refundMethod = 'credit';
                          } else if (v == 'Stock only') {
                            _refundMethod = 'none';
                          } else {
                            _refundMethod = 'cash';
                          }
                        });
                      },
              ),
              if (_refundMethod == 'cash') ...[
                SizedBox(height: _sz(12, 12.h)),
                Text('Payment channel', style: AppFonts.interStyle(fontSize: _sp(11, 11.sp), color: _uiLabel)),
                SizedBox(height: _sz(6, 6.h)),
                Wrap(
                  spacing: _sz(8, 8.w),
                  runSpacing: _sz(8, 8.h),
                  children: _paymentMethods.map((m) {
                    final sel = _refundPaymentMethod == m;
                    return FilterChip(
                      label: Text(m),
                      selected: sel,
                      onSelected: submitting ? null : (_) => setState(() => _refundPaymentMethod = m),
                      backgroundColor: _uiSurfaceElevated,
                      selectedColor: _primarySoft,
                      labelStyle: AppFonts.interStyle(color: sel ? _primary : _uiText, fontSize: _sp(12, 12.sp)),
                      side: BorderSide(color: sel ? _primary : _uiBorder),
                      checkmarkColor: _primary,
                    );
                  }).toList(),
                ),
              ],
            ],
          ],
          SizedBox(height: _sz(14, 14.h)),
          _returnField(
            labelText: 'Authorized by',
            controller: _authorizedController,
          ),
        ],
      ),
    );
  }

  Widget _returnHistorySection(List<InvoiceReturnHistoryEntry> history, bool submitting) {
    if (history.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(height: _sz(20, 20.h)),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle('PREVIOUS RETURNS', Icons.history_rounded),
              SizedBox(height: _sz(12, 12.h)),
              ...history.map((entry) => _previousReturnRow(entry, submitting)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _previousReturnRow(InvoiceReturnHistoryEntry entry, bool submitting) {
    final cancelled = _returnHistoryIsCancelled(entry);
    final statusLabel = _returnHistoryStatusLabel(entry);
    final refundLabel = _returnHistoryRefundLabel(entry);
    final dateText = _formatReturnHistoryDate(entry.date);

    return Padding(
      padding: EdgeInsets.only(bottom: _sz(10, 10.h)),
      child: Container(
        padding: EdgeInsets.all(_sz(12, 12.w)),
        decoration: BoxDecoration(
          color: cancelled ? _uiSurfaceElevated : _uiSurface,
          borderRadius: BorderRadius.circular(_sz(10, 10.r)),
          border: Border.all(
            color: cancelled ? _uiBorder : _uiBorderLight,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.name,
                    style: AppFonts.interStyle(
                      fontSize: _sp(14, 14.sp),
                      fontWeight: FontWeight.w600,
                      color: cancelled ? _uiLabel : _uiText,
                      decoration: cancelled ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  if (dateText.isNotEmpty) ...[
                    SizedBox(height: _sz(4, 4.h)),
                    Text(
                      dateText,
                      style: AppFonts.interStyle(fontSize: _sp(12, 12.sp), color: _uiLabel),
                    ),
                  ],
                  SizedBox(height: _sz(8, 8.h)),
                  Wrap(
                    spacing: _sz(6, 6.w),
                    runSpacing: _sz(6, 6.h),
                    children: [
                      _returnStatusPill(statusLabel),
                      if (refundLabel != null)
                        _returnStatusPill(refundLabel, muted: true),
                    ],
                  ),
                  if (entry.items.isNotEmpty) ...[
                    SizedBox(height: _sz(10, 10.h)),
                    ...entry.items.map(_previousReturnItemRow),
                  ],
                ],
              ),
            ),
            SizedBox(width: _sz(8, 8.w)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _currency.format(entry.returnAmount),
                  style: AppFonts.interStyle(
                    fontSize: _sp(14, 14.sp),
                    fontWeight: FontWeight.w700,
                    color: cancelled ? _uiLabel : _uiText,
                    decoration: cancelled ? TextDecoration.lineThrough : null,
                  ),
                ),
                if (!cancelled) ...[
                  SizedBox(height: _sz(6, 6.h)),
                  TextButton(
                    onPressed: submitting ? null : () => _confirmCancelReturn(entry),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: _sz(8, 8.w), vertical: _sz(4, 4.h)),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Cancel',
                      style: AppFonts.interStyle(fontSize: _sp(12, 12.sp), color: _uiPendingFg),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _previousReturnItemRow(InvoiceReturnHistoryLine line) {
    return Padding(
      padding: EdgeInsets.only(bottom: _sz(4, 4.h)),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${line.item} · ${_formatQty(line.quantity)} ${line.unit}',
              style: AppFonts.interStyle(fontSize: _sp(12, 12.sp), color: _uiLabel),
            ),
          ),
          Text(
            _currency.format(line.amount),
            style: AppFonts.interStyle(
              fontSize: _sp(12, 12.sp),
              fontWeight: FontWeight.w600,
              color: _uiText,
            ),
          ),
        ],
      ),
    );
  }

  bool _returnHistoryIsCancelled(InvoiceReturnHistoryEntry entry) {
    final s = (entry.status ?? '').toLowerCase().trim();
    return s == 'cancelled' || s == 'canceled';
  }

  String _returnHistoryStatusLabel(InvoiceReturnHistoryEntry entry) {
    final s = (entry.status ?? '').toLowerCase().trim();
    if (s == 'cancelled' || s == 'canceled') return 'Cancelled';
    if (s == 'returned') return 'Returned';
    if (s == 'active') return 'Active';
    if (s.isNotEmpty) {
      return s[0].toUpperCase() + s.substring(1);
    }
    return 'Returned';
  }

  String? _returnHistoryRefundLabel(InvoiceReturnHistoryEntry entry) {
    final rs = (entry.refundStatus ?? entry.refund?.status ?? '').toLowerCase().trim();
    if (rs == 'no_refund') return 'No refund';
    if (rs == 'refunded') return 'Refunded';
    if (rs.isNotEmpty) {
      return rs[0].toUpperCase() + rs.substring(1);
    }
    return null;
  }

  String _formatReturnHistoryDate(String? raw) {
    if (raw == null || raw.trim().isEmpty) return '';
    final d = DateTime.tryParse(raw.trim());
    if (d == null) return raw.trim();
    return DateFormat('MMM d, yyyy').format(d);
  }

  Widget _returnStatusPill(String label, {bool muted = false}) {
    final lower = label.toLowerCase();
    Color bg;
    Color fg;
    if (lower == 'cancelled') {
      bg = _uiChipDefective;
      fg = _uiChipDefectiveFg;
    } else if (lower == 'returned' || lower == 'active') {
      bg = _uiChipMind;
      fg = _uiChipMindFg;
    } else if (muted) {
      bg = _uiSurfaceElevated;
      fg = _uiLabel;
    } else {
      bg = _primaryContainer;
      fg = _onPrimaryContainer;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _sz(8, 8.w), vertical: _sz(3, 3.h)),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(_sz(6, 6.r)),
      ),
      child: Text(
        label,
        style: AppFonts.interStyle(
          fontSize: _sp(11, 11.sp),
          fontWeight: FontWeight.w600,
          color: fg,
        ),
      ),
    );
  }

  Widget _footer({
    required bool submitting,
    required bool canSubmit,
    required bool showActions,
  }) {
    if (!showActions) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.fromLTRB(
        _sz(24, _sz(16, 16.w)),
        _sz(12, 12.h),
        _sz(24, _sz(16, 16.w)),
        _sz(16, 16.h),
      ),
      decoration: BoxDecoration(
        color: _uiSurface,
        border: Border(top: BorderSide(color: _uiBorder)),
      ),
      child: SafeArea(
        top: false,
        child: _isTablet
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: _tabletContentWidth(context),
                    child: CustomButtonWidget(
                      width: double.infinity,
                      onPressed: canSubmit ? _submit : null,
                      icon: submitting
                          ? SizedBox(
                              width: _sz(18, 18.w),
                              height: _sz(18, 18.w),
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Icon(Icons.north_east_rounded, size: _sp(18, 18.sp)),
                      title: 'Approve & process',
                    ),
                  ),
                ],
              )
            : CustomButtonWidget(
                onPressed: canSubmit ? _submit : null,
                icon: submitting
                    ? SizedBox(
                        width: _sz(18, 18.w),
                        height: _sz(18, 18.w),
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Icon(Icons.north_east_rounded, size: _sp(18, 18.sp)),
                title: 'Approve & process',
              ),
      ),
    );
  }

  // --- Shared widgets ---

  Widget _card({
    required Widget child,
    EdgeInsetsGeometry? padding,
  }) {
    return Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.all(_sz(16, 16.w)),
      decoration: BoxDecoration(
        color: _uiSurface,
        borderRadius: BorderRadius.circular(_sz(14, 14.r)),
        border: Border.all(color: _uiBorder),
      ),
      child: child,
    );
  }

  Widget _sectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: _sp(16, 16.sp), color: _uiLabel),
        SizedBox(width: _sz(8, 8.w)),
        Text(
          title,
          style: AppFonts.interStyle(
            fontSize: _sp(11, 11.sp),
            fontWeight: FontWeight.w700,
            color: _uiLabel,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }

  Widget _returnField({
    required String labelText,
    TextEditingController? controller,
    String? initialValue,
    bool readOnly = false,
    bool enabled = true,
    VoidCallback? onTap,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatter,
    ValueChanged<String>? onChanged,
    String? hint,
    double? height,
  }) {
    return CustomTextFormField(
      labelText: labelText,
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      readOnly: readOnly || onTap != null,
      enabled: enabled,
      onTap: onTap,
      suffixIcon: suffixIcon,
      height: height != null ? _sz(height, height.h) : null,
      keyboardType: keyboardType,
      inputFormatter: inputFormatter,
      onChanged: onChanged,
      hint: hint,
      borderRadius: _sz(10, 10.r),
      borderColor: _uiBorder,
      fillColor: _uiSurfaceElevated,
      padding: EdgeInsets.zero,
      useFixedSizes: _isTablet,
      style: AppFonts.interStyle(
        fontSize: _sp(14, 14.sp),
        fontWeight: FontWeight.w500,
        color: _uiText,
      ),
    );
  }

  Widget _returnDropdownField<T>({
    Key? fieldKey,
    required String labelText,
    required T value,
    required List<T> items,
    required ValueChanged<T?>? onChanged,
  }) {
    return CustomTextFormField(
      key: fieldKey,
      labelText: labelText,
      initialValue: value.toString(),
      readOnly: true,
      enabled: onChanged != null,
      borderRadius: _sz(10, 10.r),
      borderColor: _uiBorder,
      fillColor: _uiSurfaceElevated,
      contentPadding: EdgeInsets.symmetric(
        horizontal: _sz(12, 12.w),
        vertical: _sz(10, 10.h),
      ),
      padding: EdgeInsets.zero,
      useFixedSizes: _isTablet,
      style: AppFonts.interStyle(
        fontSize: _sp(14, 14.sp),
        fontWeight: FontWeight.w500,
        color: _uiText,
      ),
      suffixIcon: Icon(
        Icons.keyboard_arrow_down_rounded,
        size: _sp(22, 22.sp),
        color: _uiLabel,
      ),
      onTap: onChanged == null
          ? null
          : () async {
              final picked = await _showOptionPicker<T>(
                context: context,
                options: items,
                current: value,
              );
              if (picked != null) onChanged(picked);
            },
    );
  }

  Future<T?> _showOptionPicker<T>({
    required BuildContext context,
    required List<T> options,
    required T current,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: _uiSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(_sz(16, 16.r))),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: _sz(8, 8.h)),
            Container(
              width: _sz(40, 40.w),
              height: _sz(4, 4.h),
              decoration: BoxDecoration(
                color: _uiBorder,
                borderRadius: BorderRadius.circular(_sz(2, 2.r)),
              ),
            ),
            SizedBox(height: _sz(12, 12.h)),
            ...options.map(
              (o) => ListTile(
                title: Text(
                  o.toString(),
                  style: AppFonts.interStyle(
                    fontSize: _sp(15, 15.sp),
                    fontWeight: o == current ? FontWeight.w700 : FontWeight.w400,
                    color: _uiText,
                  ),
                ),
                trailing: o == current ? Icon(Icons.check_rounded, color: _primary, size: _sp(22, 22.sp)) : null,
                onTap: () => Navigator.pop(ctx, o),
              ),
            ),
            SizedBox(height: _sz(8, 8.h)),
          ],
        ),
      ),
    );
  }

  Widget _summaryTile(String label, String value, {bool highlight = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _sz(10, 10.w), vertical: _sz(12, 12.h)),
      decoration: BoxDecoration(
        color: highlight ? _primarySoft : _uiSurfaceElevated,
        borderRadius: BorderRadius.circular(_sz(10, 10.r)),
        border: Border.all(color: highlight ? _primary.withValues(alpha: 0.35) : _uiBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppFonts.interStyle(
              fontSize: _sp(11, 11.sp),
              color: highlight ? _primary : _uiLabel,
            ),
          ),
          SizedBox(height: _sz(4, 4.h)),
          Text(
            value,
            style: AppFonts.interStyle(
              fontSize: highlight ? _sp(16, 16.sp) : _sp(14, 14.sp),
              fontWeight: FontWeight.w700,
              color: highlight ? _primary : _uiText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppFonts.interStyle(fontSize: _sp(13, 13.sp), color: _uiLabel)),
        Text(value, style: AppFonts.interStyle(fontSize: _sp(13, 13.sp), color: _uiText)),
      ],
    );
  }

  Widget _reasonChip(String reason) {
    Color bg;
    Color fg;
    switch (reason) {
      case 'Wrong item':
        bg = _primarySoft;
        fg = _primary;
        break;
      case 'Changed mind':
        bg = _uiChipMind;
        fg = _uiChipMindFg;
        break;
      default:
        bg = _uiChipDefective;
        fg = _uiChipDefectiveFg;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _sz(10, 10.w), vertical: _sz(4, 4.h)),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(_sz(6, 6.r)),
      ),
      child: Text(
        reason,
        style: AppFonts.interStyle(fontSize: _sp(11, 11.sp), color: fg, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _textAction(String label, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: AppFonts.interStyle(
          fontSize: _sp(13, 13.sp),
          color: onTap == null ? _uiBorderLight : _primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
