import 'dart:async' show unawaited;
import 'dart:io';
import 'dart:ui' show Rect;
import 'package:flutter/material.dart';
import 'package:hotel/constants.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hotel/src/core/widget/above_sheet_snack.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/services/display_precision/app_money_format.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/helpers/freemium_navigation.dart';
import 'package:hotel/src/core/helpers/invoice_receipt_pdf_service.dart';
import 'package:hotel/src/core/helpers/invoice_return_access.dart';
import 'package:hotel/src/core/layout/device_layout.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/services/app_loading_overlay.dart';
import 'package:hotel/src/core/services/receipt_print/receipt_print_coordinator.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/features/invoice/data/datasources/invoice_return_remote_data_source.dart';
import 'package:hotel/src/features/invoice/data/datasources/invoice_remote_data_source.dart';
import 'package:hotel/src/features/invoice/presentation/cubit/accounting_settings_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/cubit/invoice_return_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/pages/invoice_return_page.dart';
import 'package:hotel/src/features/invoice/presentation/widgets/cancel_return_confirm_sheet.dart';
import 'package:hotel/src/features/invoice/presentation/widgets/invoice_tab_tablet_layout.dart';
import 'package:hotel/src/core/widget/estimate_invoice_sheet.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_sales_response_model.dart';
import 'package:hotel/src/features/settlement/presentation/pages/partial_payment_settlement_page.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Rect _shareOrigin(BuildContext context) {
  final box = context.findRenderObject() as RenderBox?;
  if (box != null && box.attached && box.hasSize) {
    final rect = box.localToGlobal(Offset.zero) & box.size;
    if (rect.width >= 1 && rect.height >= 1) return rect;
  }
  final size = MediaQuery.sizeOf(context);
  return Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: 2, height: 2);
}

EstimateInvoiceViewData estimateViewDataFromInvoiceItem({
  required BuildContext context,
  required InvoiceItem invoice,
  required InvoiceType invoiceType,
}) {
  final lines = (invoice.items ?? []).map((e) {
    final q = (e.quantity ?? 0).toDouble();
    final storedAmount = (e.amount ?? 0).toDouble();
    final storedRate = (e.rate ?? 0).toDouble();
    final a = storedAmount > 0
        ? storedAmount
        : (storedRate > 0 ? storedRate * q : 0.0);
    final r = storedRate > 0 ? storedRate : (q > 0 ? a / q : 0.0);
    return EstimateInvoiceLine(
      particular: e.item ?? '—',
      rate: r,
      quantity: q,
      amount: a,
    );
  }).toList();

  final lineSum = invoice.items?.fold<double>(0, (s, e) => s + (e.amount ?? 0)) ?? 0;
  final disc = invoice.discountAmount ?? invoice.totalDiscount ?? 0;
  final subTotal = lineSum > 0 ? lineSum : (invoice.grandTotal ?? 0) + disc;
  final totalAfter = invoice.grandTotal ?? (subTotal - disc).clamp(0, double.infinity);
  final taxInfo = estimateTaxFromInvoiceTotals(
    baseGrandTotal: invoice.baseGrandTotal,
    grandTotal: invoice.grandTotal,
    subTotal: subTotal,
    discountAmount: disc.toDouble(),
    taxAmountLine: context.l10n.taxAmountLine,
    fallbackTaxLabel: context.l10n.checkoutTaxLabel,
  );

  final payments = invoice.payment ?? [];
  final paySum = payments.fold<double>(0, (s, p) => s + (p.amount ?? 0));
  final String paymentSummary;
  if (payments.isEmpty) {
    if ((invoice.outstandingAmount ?? 0) > 0) {
      paymentSummary =
          'Unpaid ($currencySymbol ${(invoice.outstandingAmount ?? 0).toStringAsFixed(1)})';
    } else if (invoice.submitted == 1) {
      paymentSummary = 'Paid';
    } else {
      paymentSummary = '—';
    }
  } else if (payments.length == 1) {
    final p = payments.first;
    paymentSummary = '${p.paymentMethod ?? 'Payment'} ($currencySymbol ${(p.amount ?? 0).toStringAsFixed(1)})';
  } else {
    paymentSummary = 'Multiple ($currencySymbol ${paySum.toStringAsFixed(1)})';
  }

  final party = (invoice.party ?? '').trim();
  final customerLabel = party.isEmpty ? 'Cash Customer' : party;
  final invNo = invoice.invoiceName ?? '—';
  final typeLabel = invoiceType == InvoiceType.sales ? 'Sales' : 'Purchase';
  final headerLine = party.isEmpty ? typeLabel : '$typeLabel · $party';

  final rawBase = invNo.replaceAll(RegExp(r'[^a-zA-Z0-9_-]+'), '_');
  final fileBase = rawBase.isEmpty ? 'invoice' : rawBase;

  final billed = (invoice.modifiedBy ?? '').trim();
  final billedBy = billed.isNotEmpty ? billed : context.loggedInUserFullName;

  final payRows = estimatePaymentRowsForInvoiceItem(invoice);
  final apiPaid = _invoicePaidSum(invoice);
  final rowSum = payRows?.fold<double>(0, (a, r) => a + r.amount) ?? 0.0;
  final effectivePaid = apiPaid > 1e-6 ? apiPaid : rowSum;
  final outAmt = invoice.outstandingAmount;

  final returnedLines = <EstimateInvoiceReturnLine>[];
  for (final e in invoice.items ?? []) {
    final returnedQty = (e.alreadyReturnedQuantity ?? 0).toDouble();
    if (returnedQty <= 1e-6) continue;
    final q = (e.quantity ?? 0).toDouble();
    final storedAmount = (e.amount ?? 0).toDouble();
    final storedRate = (e.rate ?? 0).toDouble();
    final lineAmount = storedAmount > 0
        ? storedAmount
        : (storedRate > 0 ? storedRate * q : 0.0);
    final unitRate = q > 0 ? lineAmount / q : storedRate;
    returnedLines.add(
      EstimateInvoiceReturnLine(
        particular: e.item ?? '—',
        quantity: returnedQty,
        amount: unitRate * returnedQty,
      ),
    );
  }
  final totalReturned = invoice.totalReturnedAgainst ??
      returnedLines.fold<double>(0, (s, r) => s + r.amount);
  final netPayable = invoice.netPayable;

  return EstimateInvoiceViewData(
    titleSuffix: '',
    invoiceNumber: invNo,
    invoiceDateText: formatEstimateInvoiceDateFromRaw(invoice.date),
    headerLine: headerLine,
    customerLabel: customerLabel,
    lines: lines,
    subTotal: subTotal,
    discountAmount: disc,
    totalAfterDiscount: totalAfter,
    taxAmount: taxInfo?.taxAmount,
    taxLabel: taxInfo?.taxLabel,
    paymentSummary: paymentSummary,
    kotLine: null,
    billedBy: billedBy,
    fileBaseName: fileBase,
    paymentRows: payRows,
    paymentPaidTotal: (payRows != null && payRows.isNotEmpty && effectivePaid > 1e-6) ? effectivePaid : null,
    paymentOutstanding: (outAmt != null && outAmt > 1e-6) ? outAmt : null,
    returnedLines: returnedLines,
    totalReturnedAgainst: totalReturned > 0.005 ? totalReturned : null,
    netPayable: netPayable,
  );
}

String _invoiceTimeLabel(String? rawDate) {
  if (rawDate == null || rawDate.trim().isEmpty) return '';
  final d = DateTime.tryParse(rawDate.trim());
  if (d == null) return '';
  return DateFormat('hh:mm a').format(d);
}

bool _isPaidInvoice(InvoiceItem invoice) {
  final st = invoice.status?.toLowerCase().trim();
  if (st == 'paid') return true;
  if (invoice.submitted == 1 &&
      invoice.outstandingAmount != null &&
      invoice.outstandingAmount == 0.0) {
    return true;
  }
  return false;
}

double _invoicePaidSum(InvoiceItem invoice) =>
    invoice.payment?.fold<double>(0, (s, p) => s + (p.amount ?? 0)) ?? 0;

String _formatReturnDate(String? raw) {
  if (raw == null || raw.trim().isEmpty) return '';
  final d = DateTime.tryParse(raw.trim());
  if (d == null) return raw.trim();
  return DateFormat('yyyy-MM-dd').format(d);
}

String _returnRefStatusLabel(ReturnInvoiceRef ref) {
  final s = (ref.status ?? '').toLowerCase().trim();
  if (s == 'cancelled') return 'Cancelled';
  if (s == 'active') return 'Active';
  if (s.isNotEmpty) {
    return s[0].toUpperCase() + s.substring(1);
  }
  return '—';
}

String? _returnRefRefundLabel(ReturnInvoiceRef ref) {
  final rs = (ref.refundStatus ?? '').toLowerCase().trim();
  if (rs == 'no_refund') return 'No refund';
  if (rs == 'refunded') return 'Refunded';
  if (rs.isNotEmpty) return rs[0].toUpperCase() + rs.substring(1);
  return null;
}

Future<void> showTransactionDetailsBottomSheet({
  required BuildContext context,
  required InvoiceItem invoice,
  required InvoiceType invoiceType,
  VoidCallback? onSubmit,
  VoidCallback? onCompleted,
}) {
  final est = estimateViewDataFromInvoiceItem(
    context: context,
    invoice: invoice,
    invoiceType: invoiceType,
  );
  final currency = AppMoneyFormat.currency(currencySymbol);
  final isTablet = DeviceLayout.isTablet(context);

  Widget buildSheet(BuildContext sheetContext) {
    return _TransactionDetailsSheetBody(
      invoice: invoice,
      invoiceType: invoiceType,
      estimateData: est,
      currencyFormat: currency,
      onSubmit: onSubmit,
      onCompleted: onCompleted,
    );
  }

  if (isTablet) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: buildSheet,
    );
  }

  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    useSafeArea: true,
    builder: buildSheet,
  );
}

class _TransactionDetailsSheetBody extends StatefulWidget {
  const _TransactionDetailsSheetBody({
    required this.invoice,
    required this.invoiceType,
    required this.estimateData,
    required this.currencyFormat,
    this.onSubmit,
    this.onCompleted,
  });

  final InvoiceItem invoice;
  final InvoiceType invoiceType;
  final EstimateInvoiceViewData estimateData;
  final NumberFormat currencyFormat;
  final VoidCallback? onSubmit;
  final VoidCallback? onCompleted;

  @override
  State<_TransactionDetailsSheetBody> createState() => _TransactionDetailsSheetBodyState();
}

class _TransactionDetailsSheetBodyState extends State<_TransactionDetailsSheetBody> {
  bool _accountExpanded = false;
  late InvoiceItem _invoice;
  late EstimateInvoiceViewData _estimateData;

  @override
  void initState() {
    super.initState();
    _invoice = widget.invoice;
    _estimateData = widget.estimateData;
    if (!invoiceIsReturnSlipRow(widget.invoice)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        unawaited(_freshEstimateData());
      });
    }
    if (invoiceIsReturnSlipRow(widget.invoice)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        try {
          context.read<AccountingSettingsCubit>().loadIfNeeded();
        } catch (_) {}
      });
    }
  }

  Future<InvoiceItem> _loadFreshInvoice() async {
    final name = _invoice.invoiceName?.trim();
    if (name == null || name.isEmpty) return _invoice;
    final fresh = await getIt<InvoiceRemoteDataSource>().getInvoiceByName(
      invoiceName: name,
      invoiceType: widget.invoiceType,
    );
    return fresh ?? _invoice;
  }

  Future<EstimateInvoiceViewData> _freshEstimateData() async {
    final invoice = await _loadFreshInvoice();
    if (!mounted) return _estimateData;
    final estimate = estimateViewDataFromInvoiceItem(
      context: context,
      invoice: invoice,
      invoiceType: widget.invoiceType,
    );
    setState(() {
      _invoice = invoice;
      _estimateData = estimate;
    });
    return estimate;
  }

  Future<void> _sharePdf() async {
    if (!await gateInvoiceExport(context)) return;
    try {
      AppLoadingOverlay.of(context).show();
      final invoice = await _loadFreshInvoice();
      if (!mounted) return;
      final file = await InvoiceReceiptPdfService.exportToPdf(
        invoice: invoice,
        invoiceType: widget.invoiceType,
        accentColor: Theme.of(context).colorScheme.primary,
      );
      if (!mounted) return;
      AppLoadingOverlay.of(context).hide();
      await Share.shareXFiles(
        [XFile(file.path)],
        subject: 'Receipt ${_invoice.invoiceName ?? ''}',
        sharePositionOrigin: _shareOrigin(context),
      );
    } catch (e) {
      if (mounted) {
        AppLoadingOverlay.of(context).hide();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not share: $e')),
        );
      }
    }
  }

  Future<void> _downloadPdf() async {
    if (!await gateInvoiceExport(context)) return;
    try {
      AppLoadingOverlay.of(context).show();
      final invoice = await _loadFreshInvoice();
      if (!mounted) return;
      final tempFile = await InvoiceReceiptPdfService.exportToPdf(
        invoice: invoice,
        invoiceType: widget.invoiceType,
        accentColor: Theme.of(context).colorScheme.primary,
      );
      if (!mounted) return;
      Directory targetDir;
      if (Platform.isAndroid) {
        final primary = Directory('/storage/emulated/0/Download');
        final secondary = Directory('/storage/emulated/0/Downloads');
        if (await primary.exists()) {
          targetDir = primary;
        } else if (await secondary.exists()) {
          targetDir = secondary;
        } else {
          targetDir = (await getApplicationDocumentsDirectory());
        }
      } else {
        targetDir = await getApplicationDocumentsDirectory();
      }
      if (!await targetDir.exists()) {
        await targetDir.create(recursive: true);
      }
      final fileName = tempFile.path.split('/').last;
      final savePath = '${targetDir.path}/$fileName';
      final targetFile = File(savePath);
      if (await targetFile.exists()) await targetFile.delete();
      final saved = await tempFile.copy(savePath);
      if (!mounted) return;
      AppLoadingOverlay.of(context).hide();
      AboveSheetSnack.showSuccess(
        context,
        Platform.isIOS
            ? 'Receipt saved. Open Files, then On My iPhone, BillMate.'
            : 'Saved: ${saved.path}',
      );
    } catch (e) {
      if (mounted) {
        AppLoadingOverlay.of(context).hide();
        AboveSheetSnack.showError(context, 'Could not save: $e');
      }
    }
  }

  Future<void> _printInvoice() async {
    try {
      AppLoadingOverlay.of(context).show();
      final estimate = await _freshEstimateData();
      if (!mounted) return;
      AppLoadingOverlay.of(context).hide();
      await ReceiptPrintCoordinator.printReceipt(
        context,
        data: estimate,
        heading: 'RECEIPT',
        showEstimateDisclaimer: false,
        closeCurrentRouteFirst: true,
      );
    } catch (e) {
      if (mounted) {
        AppLoadingOverlay.of(context).hide();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not print: $e')),
        );
      }
    }
  }

  /// Same rule as [InvoiceCard] action sheet "Make Payment".
  bool _canMakePayment(InvoiceItem inv) =>
      !invoiceIsReturnSlipRow(inv) && inv.submitted == 1 && inv.outstandingAmount != 0.0;

  bool _invoiceReturnsEnabled(BuildContext context) {
    try {
      return context.read<AccountingSettingsCubit>().state == true;
    } catch (_) {
      return false;
    }
  }

  Future<void> _confirmCancelReturn() async {
    final name = _invoice.invoiceName ?? '';
    await _confirmCancelReturnByName(name);
  }

  Future<void> _confirmCancelReturnByName(String returnName) async {
    final confirmed = await showCancelReturnConfirmSheet(
      context: context,
      returnName: returnName,
      message:
          'Cancel return invoice "$returnName"? This restores balances on the original invoice.',
    );
    if (confirmed != true || !mounted) return;

    final email = context.employeeData?.email?.trim();
    final cancelledBy = (email != null && email.isNotEmpty)
        ? email
        : context.loggedInUserFullName;
    try {
      AppLoadingOverlay.of(context).show();
      final msg = await getIt<InvoiceReturnRemoteDataSource>().cancelReturn(
        invoiceType: widget.invoiceType,
        returnInvoiceName: returnName,
        cancelledBy: cancelledBy.isEmpty ? 'mobile' : cancelledBy,
      );
      if (!mounted) return;
      AppLoadingOverlay.of(context).hide();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg ?? 'Return cancelled')),
      );
      widget.onCompleted?.call();
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      AppLoadingOverlay.of(context).hide();
      final text = e is AppException ? e.message : e.toString();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    }
  }

  void _openAddReturn() {
    final inv = _invoice;
    final rootNav = Navigator.of(context, rootNavigator: true);
    Navigator.pop(context);
    rootNav.push<bool>(
      MaterialPageRoute<bool>(
        builder: (ctx) => BlocProvider(
          create: (_) => getIt<InvoiceReturnCubit>(),
          child: InvoiceReturnPage(
            invoice: inv,
            invoiceType: widget.invoiceType,
            onCompleted: widget.onCompleted,
          ),
        ),
      ),
    ).then((ok) {
      if (ok == true) widget.onCompleted?.call();
    });
  }

  void _duplicate() {
    final router = context.router;
    Navigator.pop(context);
    router.push(
      CreateInvoiceRoute(
        invoiceToDuplicate: widget.invoice.snapshotForDuplicate(widget.invoiceType),
        selectedDate: DateTime.now(),
        onComplete: () => widget.onCompleted?.call(),
        invoiceType: widget.invoiceType,
      ),
    );
  }

  void _makePayment() {
    final rootNav = Navigator.of(context, rootNavigator: true);
    Navigator.pop(context);
    rootNav.push<void>(
      MaterialPageRoute<void>(
        builder: (ctx) => PartialPaymentSettlementPage(
          hideParties: true,
          item: widget.invoice,
          onCompleted: widget.onCompleted,
          selectedRole: widget.invoiceType == InvoiceType.sales ? 'customer' : 'suppliers',
        ),
      ),
    );
  }

  void _submitInvoice() {
    Navigator.pop(context);
    widget.onSubmit?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final inv = _invoice;
    final tablet = DeviceLayout.isTablet(context);
    final sheetHeight = MediaQuery.sizeOf(context).height * (tablet ? 0.88 : 0.92);
    final partyTitle = (inv.party ?? '').trim().isEmpty ? 'Cash Customer' : inv.party!.trim();
    final typeLabel = widget.invoiceType == InvoiceType.sales ? 'Sales' : 'Purchase';
    final paid = _isPaidInvoice(inv);
    final statusLabel = invoiceStatusDisplayLabel(inv);
    final statusColors = invoiceStatusChipColors(context, inv);
    final isReturnSlip = invoiceIsReturnSlipRow(inv);
    final isActiveReturn = invoiceIsReturnDocument(inv);
    final returnAgainst = (inv.returnAgainst ?? '').trim();
    final activeReturns = activeReturnInvoiceCount(inv);
    final returnedAgainst = inv.totalReturnedAgainst ?? 0;
    final netPayable = inv.netPayable;
    final displayAmount = isReturnSlip
        ? (inv.grandTotal ?? 0)
        : (netPayable != null && netPayable > 0
            ? netPayable
            : (inv.outstandingAmount == 0 ? (inv.grandTotal ?? 0) : (inv.outstandingAmount ?? 0)));
    final timeStr = _invoiceTimeLabel(inv.date);

    final returnChip = (
      bg: cs.errorContainer.withValues(alpha: 0.45),
      fg: cs.error,
    );
    final typeChip = (
      bg: cs.primaryContainer.withValues(alpha: 0.45),
      fg: cs.onPrimaryContainer,
    );
    final infoChip = (
      bg: cs.secondaryContainer.withValues(alpha: 0.45),
      fg: cs.onSecondaryContainer,
    );

    final sheetBody = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!tablet) ...[
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppBottomSheetTheme.dragHandle(context),
            ],
          ),
        ],
        Padding(
          padding: EdgeInsets.fromLTRB(
            InvoiceTabTabletLayout.sz(context, 20, 16.w),
            tablet ? 16 : 4.h,
            InvoiceTabTabletLayout.sz(context, 12, 8.w),
            0,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  isReturnSlip ? 'Return Details' : 'Transaction Details',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                    fontSize: InvoiceTabTabletLayout.sp(context, 20, 22),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.close_rounded,
                  color: cs.onSurfaceVariant,
                  size: InvoiceTabTabletLayout.sz(context, 24, 24),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        if (isReturnSlip)
          Padding(
            padding: EdgeInsets.fromLTRB(
              InvoiceTabTabletLayout.sz(context, 20, 16.w),
              InvoiceTabTabletLayout.sz(context, 12, 12.h),
              InvoiceTabTabletLayout.sz(context, 20, 16.w),
              0,
            ),
            child: canCancelReturnInvoice(inv) && _invoiceReturnsEnabled(context)
                ? _headerActionBtn(
                    icon: Icons.cancel_outlined,
                    label: 'Cancel return',
                    onTap: _confirmCancelReturn,
                  )
                : const SizedBox.shrink(),
          )
        else
          Padding(
            padding: EdgeInsets.fromLTRB(
              InvoiceTabTabletLayout.sz(context, 20, 16.w),
              InvoiceTabTabletLayout.sz(context, 12, 12.h),
              InvoiceTabTabletLayout.sz(context, 20, 16.w),
              0,
            ),
            child: Row(
              children: [
                if (_invoiceReturnsEnabled(context) && canCreateInvoiceReturn(inv)) ...[
                  Expanded(
                    child: _headerActionBtn(
                      icon: Icons.assignment_return_outlined,
                      label: 'Add return',
                      onTap: _openAddReturn,
                    ),
                  ),
                  SizedBox(width: InvoiceTabTabletLayout.sz(context, 10, 10.w)),
                ],
                if (paid) ...[
                  Expanded(
                    child: _headerActionBtn(
                      icon: Icons.copy_outlined,
                      label: 'Duplicate order',
                      onTap: _duplicate,
                    ),
                  ),
                  SizedBox(width: InvoiceTabTabletLayout.sz(context, 10, 10.w)),
                ] else if (_canMakePayment(inv)) ...[
                  Expanded(
                    child: _headerActionBtn(
                      icon: Icons.payment_outlined,
                      label: 'Make payment',
                      onTap: _makePayment,
                    ),
                  ),
                  SizedBox(width: InvoiceTabTabletLayout.sz(context, 10, 10.w)),
                ] else if (widget.onSubmit != null && inv.submitted == 0) ...[
                  Expanded(
                    child: _headerActionBtn(
                      icon: Icons.receipt_long_outlined,
                      label: 'Submit invoice',
                      onTap: _submitInvoice,
                    ),
                  ),
                  SizedBox(width: InvoiceTabTabletLayout.sz(context, 10, 10.w)),
                ],
                Expanded(
                  child: _headerActionBtn(
                    icon: Icons.print_outlined,
                    label: 'Print invoice',
                    onTap: _printInvoice,
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: InvoiceTabTabletLayout.sz(context, 16, 16.h)),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: InvoiceTabTabletLayout.sz(context, 20, 16.w),
          ),
          child: Container(
            padding: EdgeInsets.all(InvoiceTabTabletLayout.sz(context, 16, 14.w)),
            decoration: BoxDecoration(
              color: cs.surfaceContainerLow,
              borderRadius: BorderRadius.circular(
                InvoiceTabTabletLayout.sz(context, 12, 12.r),
              ),
              border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.5)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        partyTitle,
                        maxLines: tablet ? 2 : 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: InvoiceTabTabletLayout.sp(context, 16, 14),
                        ),
                      ),
                      SizedBox(height: InvoiceTabTabletLayout.sz(context, 10, 10.h)),
                      Wrap(
                        spacing: InvoiceTabTabletLayout.sz(context, 8, 6.w),
                        runSpacing: InvoiceTabTabletLayout.sz(context, 8, 6.h),
                        children: [
                          if (isReturnSlip)
                            _chip('Return', returnChip.bg, returnChip.fg)
                          else
                            _chip(typeLabel, typeChip.bg, typeChip.fg),
                          _chip(
                            statusLabel.toUpperCase(),
                            statusColors.bg,
                            statusColors.fg,
                          ),
                          if (isReturnSlip && returnAgainst.isNotEmpty)
                            _chip(
                              'Against: $returnAgainst',
                              infoChip.bg,
                              infoChip.fg,
                            )
                          else if (isActiveReturn && returnAgainst.isNotEmpty)
                            _chip(
                              'Against: $returnAgainst',
                              infoChip.bg,
                              infoChip.fg,
                            ),
                          if (!isReturnSlip && activeReturns > 0)
                            _chip(
                              activeReturns == 1 ? '1 return' : '$activeReturns returns',
                              infoChip.bg,
                              infoChip.fg,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: InvoiceTabTabletLayout.sz(context, 14, 12.w)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          isReturnSlip
                              ? Icons.assignment_return_outlined
                              : Icons.trending_up_rounded,
                          size: InvoiceTabTabletLayout.sz(context, 18, 16),
                          color: isReturnSlip ? cs.error : cs.primary,
                        ),
                        SizedBox(width: InvoiceTabTabletLayout.sz(context, 4, 4.w)),
                        Text(
                          widget.currencyFormat.format(displayAmount),
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: InvoiceTabTabletLayout.sp(context, 16, 14),
                            color: isReturnSlip ? cs.error : cs.primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: InvoiceTabTabletLayout.sz(context, 6, 6.h)),
                    Text(
                      inv.invoiceName ?? '—',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: cs.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                        fontSize: InvoiceTabTabletLayout.sp(context, 12, 11),
                      ),
                      textAlign: TextAlign.right,
                    ),
                    if (timeStr.isNotEmpty) ...[
                      SizedBox(height: InvoiceTabTabletLayout.sz(context, 2, 2.h)),
                      Text(
                        timeStr,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: cs.onSurfaceVariant.withValues(alpha: 0.85),
                          fontWeight: FontWeight.w500,
                          fontSize: InvoiceTabTabletLayout.sp(context, 12, 11),
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: InvoiceTabTabletLayout.sz(context, 12, 10.h)),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              InvoiceTabTabletLayout.sz(context, 20, 16.w),
              0,
              InvoiceTabTabletLayout.sz(context, 20, 16.w),
              InvoiceTabTabletLayout.sz(context, 16, 8.h),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isReturnSlip && returnAgainst.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: InvoiceTabTabletLayout.sz(context, 12, 12.h),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(InvoiceTabTabletLayout.sz(context, 12, 12.w)),
                      decoration: BoxDecoration(
                        color: cs.primaryContainer.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(
                          InvoiceTabTabletLayout.sz(context, 10, 10.r),
                        ),
                        border: Border.all(color: cs.primary.withValues(alpha: 0.25)),
                      ),
                      child: Text(
                        'Return against $returnAgainst',
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: cs.onPrimaryContainer,
                          fontSize: InvoiceTabTabletLayout.sp(context, 13, 12),
                        ),
                      ),
                    ),
                  ),
                if (!isReturnSlip && (inv.returnInvoices ?? []).isNotEmpty) ...[
                  _ReturnInvoicesPanel(
                    entries: inv.returnInvoices!,
                    currencyFormat: widget.currencyFormat,
                    returnsEnabled: _invoiceReturnsEnabled(context),
                    onCancelReturn: _confirmCancelReturnByName,
                  ),
                  SizedBox(height: InvoiceTabTabletLayout.sz(context, 12, 12.h)),
                ],
                Container(
                  padding: EdgeInsets.all(InvoiceTabTabletLayout.sz(context, 16, 14.w)),
                  decoration: BoxDecoration(
                    color: cs.surface,
                    borderRadius: BorderRadius.circular(
                      InvoiceTabTabletLayout.sz(context, 12, 12.r),
                    ),
                    border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.6)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      EstimateInvoiceReceiptView(data: _estimateData),
                      if (!isReturnSlip &&
                          (inv.items ?? []).any((l) => (l.alreadyReturnedQuantity ?? 0) > 0.005)) ...[
                        SizedBox(height: InvoiceTabTabletLayout.sz(context, 8, 8.h)),
                        for (final line in inv.items!)
                          if ((line.alreadyReturnedQuantity ?? 0) > 0.005)
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: InvoiceTabTabletLayout.sz(context, 4, 4.h),
                              ),
                              child: Text(
                                '${line.item ?? 'Item'} — returned qty: '
                                '${line.alreadyReturnedQuantity!.toStringAsFixed(1)} · '
                                '${widget.currencyFormat.format((line.rate ?? 0) * (line.alreadyReturnedQuantity ?? 0))}',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: cs.error,
                                  fontWeight: FontWeight.w600,
                                  fontSize: InvoiceTabTabletLayout.sp(context, 12, 11),
                                ),
                              ),
                            ),
                      ],
                      if (!isReturnSlip && returnedAgainst > 0.005) ...[
                        SizedBox(height: InvoiceTabTabletLayout.sz(context, 10, 10.h)),
                        Divider(height: 1, color: cs.outlineVariant),
                        SizedBox(height: InvoiceTabTabletLayout.sz(context, 10, 10.h)),
                        _totalRow(
                          theme,
                          'Returned against',
                          '-${widget.currencyFormat.format(returnedAgainst)}',
                          valueColor: cs.error,
                        ),
                        if (netPayable != null)
                          _totalRow(
                            theme,
                            'Payable amount',
                            widget.currencyFormat.format(netPayable),
                            valueColor: cs.primary,
                            bold: true,
                          ),
                      ],
                    ],
                  ),
                ),
                if (_accountExpanded) ...[
                  SizedBox(height: InvoiceTabTabletLayout.sz(context, 12, 12.h)),
                  Text(
                    'Account Summary',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: InvoiceTabTabletLayout.sp(context, 15, 14),
                    ),
                  ),
                  SizedBox(height: InvoiceTabTabletLayout.sz(context, 8, 8.h)),
                  _AccountSummaryTable(invoice: inv),
                ],
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(
            InvoiceTabTabletLayout.sz(context, 16, 8.w),
            InvoiceTabTabletLayout.sz(context, 10, 8.h),
            InvoiceTabTabletLayout.sz(context, 16, 8.w),
            InvoiceTabTabletLayout.sz(context, 12, 10.h),
          ),
          decoration: BoxDecoration(
            color: cs.surface,
            border: Border(top: BorderSide(color: cs.outlineVariant.withValues(alpha: 0.5))),
          ),
          child: Row(
            children: [
              Expanded(
                child: _footerBtn(
                  icon: Icons.share_outlined,
                  label: 'Share',
                  onTap: _sharePdf,
                ),
              ),
              SizedBox(width: InvoiceTabTabletLayout.sz(context, 8, 6.w)),
              Expanded(
                child: _footerBtn(
                  icon: Icons.download_outlined,
                  label: 'Download',
                  onTap: _downloadPdf,
                ),
              ),
            ],
          ),
        ),
      ],
    );

    if (tablet) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 24,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 560,
              maxHeight: sheetHeight,
            ),
            child: Material(
              color: cs.surface,
              elevation: 12,
              shadowColor: cs.shadow.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                height: sheetHeight,
                child: sheetBody,
              ),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: sheetHeight,
      child: Container(
        decoration: AppBottomSheetTheme.topSheetDecoration(context),
        child: SafeArea(
          top: false,
          child: sheetBody,
        ),
      ),
    );
  }

  Widget _totalRow(
    ThemeData theme,
    String label,
    String value, {
    Color? valueColor,
    bool bold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: bold ? FontWeight.w800 : FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  Widget _chip(String text, Color bg, Color fg) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: InvoiceTabTabletLayout.sz(context, 10, 8.w),
        vertical: InvoiceTabTabletLayout.sz(context, 5, 4.h),
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(
          InvoiceTabTabletLayout.sz(context, 6, 6.r),
        ),
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppFonts.interStyle(
          fontSize: InvoiceTabTabletLayout.sp(context, 11, 10),
          fontWeight: FontWeight.w600,
          color: fg,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  Widget _headerActionBtn({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: InvoiceTabTabletLayout.sz(context, 12, 10.w),
          vertical: InvoiceTabTabletLayout.sz(context, 10, 12.h),
        ),
        minimumSize: Size(
          0,
          InvoiceTabTabletLayout.sz(context, 44, 44.h),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            InvoiceTabTabletLayout.sz(context, 10, 10.r),
          ),
        ),
        side: BorderSide(color: scheme.primary.withValues(alpha: 0.35)),
        foregroundColor: scheme.primary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: InvoiceTabTabletLayout.sz(context, 18, 18),
          ),
          SizedBox(width: InvoiceTabTabletLayout.sz(context, 6, 6.w)),
          Flexible(
            child: Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: InvoiceTabTabletLayout.sp(context, 13, 12),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _footerBtn({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(
        InvoiceTabTabletLayout.sz(context, 10, 10.r),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          InvoiceTabTabletLayout.sz(context, 10, 10.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: InvoiceTabTabletLayout.sz(context, 12, 10.h),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: InvoiceTabTabletLayout.sz(context, 18, 16),
                color: scheme.onSurface,
              ),
              SizedBox(width: InvoiceTabTabletLayout.sz(context, 8, 8.w)),
              Text(
                label,
                style: AppFonts.interStyle(
                  fontSize: InvoiceTabTabletLayout.sp(context, 14, 11),
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReturnInvoicesPanel extends StatelessWidget {
  const _ReturnInvoicesPanel({
    required this.entries,
    required this.currencyFormat,
    this.returnsEnabled = false,
    this.onCancelReturn,
  });

  final List<ReturnInvoiceRef> entries;
  final NumberFormat currencyFormat;
  final bool returnsEnabled;
  final Future<void> Function(String returnName)? onCancelReturn;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Return invoices',
            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 10.h),
          for (final e in entries) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e.name ?? '—',
                        style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      if ((e.date ?? '').isNotEmpty)
                        Text(
                          _formatReturnDate(e.date),
                          style: theme.textTheme.labelSmall?.copyWith(color: scheme.onSurfaceVariant),
                        ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      currencyFormat.format(e.returnAmount ?? 0),
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        decoration: (e.status ?? '').toLowerCase() == 'cancelled'
                            ? TextDecoration.lineThrough
                            : null,
                        color: (e.status ?? '').toLowerCase() == 'cancelled'
                            ? scheme.onSurfaceVariant
                            : null,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Wrap(
                      spacing: 6.w,
                      alignment: WrapAlignment.end,
                      children: [
                        _ReturnStatusPill(label: _returnRefStatusLabel(e)),
                        if (_returnRefRefundLabel(e) != null)
                          _ReturnStatusPill(
                            label: _returnRefRefundLabel(e)!,
                            muted: true,
                          ),
                      ],
                    ),
                    if (returnsEnabled && onCancelReturn != null && canCancelReturnEntry(e)) ...[
                      SizedBox(height: 6.h),
                      TextButton(
                        onPressed: () => onCancelReturn!(e.name ?? ''),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Cancel',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: scheme.error,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
            if (e != entries.last)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Divider(height: 1, color: scheme.outlineVariant.withValues(alpha: 0.5)),
              ),
            if ((e.items ?? []).isNotEmpty) ...[
              SizedBox(height: 8.h),
              for (final line in e.items!)
                Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${line.item ?? 'Item'} · ${(line.quantity ?? 0).toStringAsFixed(1)}',
                          style: theme.textTheme.labelSmall?.copyWith(color: scheme.onSurfaceVariant),
                        ),
                      ),
                      Text(
                        currencyFormat.format(line.amount ?? ((line.rate ?? 0) * (line.quantity ?? 0))),
                        style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
            ],
          ],
        ],
      ),
    );
  }
}

class _ReturnStatusPill extends StatelessWidget {
  const _ReturnStatusPill({required this.label, this.muted = false});

  final String label;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isCancelled = label.toLowerCase() == 'cancelled';
    final isActive = label.toLowerCase() == 'active';
    Color bg;
    Color fg;
    if (isCancelled) {
      bg = scheme.surfaceContainerHighest;
      fg = scheme.onSurfaceVariant;
    } else if (isActive) {
      bg = scheme.primaryContainer.withValues(alpha: 0.45);
      fg = scheme.onPrimaryContainer;
    } else if (muted) {
      bg = scheme.surfaceContainerHighest;
      fg = scheme.onSurfaceVariant;
    } else {
      bg = scheme.secondaryContainer.withValues(alpha: 0.45);
      fg = scheme.onSecondaryContainer;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        label,
        style: AppFonts.interStyle(fontSize: 10.sp, fontWeight: FontWeight.w600, color: fg),
      ),
    );
  }
}

class _AccountSummaryTable extends StatelessWidget {
  const _AccountSummaryTable({required this.invoice});

  final InvoiceItem invoice;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final total = invoice.grandTotal ?? 0;
    final payments = invoice.payment ?? [];
    double debitSum = 0;
    double creditSum = 0;

    final rows = <DataRow>[];
    rows.add(
      DataRow(
        cells: [
          DataCell(Text('Gross Sales', style: AppFonts.interStyle(color: scheme.primary, fontWeight: FontWeight.w600))),
          const DataCell(Text('—')),
          DataCell(Text(total.toStringAsFixed(1))),
        ],
      ),
    );
    creditSum += total;

    for (final p in payments) {
      final a = p.amount ?? 0;
      debitSum += a;
      rows.add(
        DataRow(
          cells: [
            DataCell(Text(p.paymentMethod ?? 'Payment', style: AppFonts.interStyle(color: scheme.primary))),
            DataCell(Text(a.toStringAsFixed(1))),
            const DataCell(Text('—')),
          ],
        ),
      );
    }

    for (final r in estimateReturnPaymentRowsForInvoiceItem(invoice)) {
      if (!r.isNoRefund && r.amount > 1e-6) {
        debitSum += r.amount;
      }
      rows.add(
        DataRow(
          cells: [
            DataCell(Text(r.label, style: AppFonts.interStyle(color: scheme.error))),
            DataCell(
              Text(
                r.isNoRefund ? '—' : r.amount.toStringAsFixed(1),
                style: AppFonts.interStyle(color: scheme.error),
              ),
            ),
            const DataCell(Text('—')),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: scheme.outlineVariant),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(scheme.primaryContainer.withValues(alpha: 0.35)),
          dataRowMinHeight: 36,
          headingRowHeight: 40,
          columns: [
            DataColumn(label: Text('Account Heads', style: AppFonts.interStyle(fontWeight: FontWeight.w700))),
            DataColumn(label: Text('Debit', style: AppFonts.interStyle(fontWeight: FontWeight.w700))),
            DataColumn(label: Text('Credit', style: AppFonts.interStyle(fontWeight: FontWeight.w700))),
          ],
          rows: [
            ...rows,
            DataRow(
              color: WidgetStateProperty.all(scheme.surfaceContainerHighest),
              cells: [
                DataCell(Text('Total', style: AppFonts.interStyle(fontWeight: FontWeight.w800))),
                DataCell(Text(debitSum.toStringAsFixed(1), style: AppFonts.interStyle(fontWeight: FontWeight.w700))),
                DataCell(Text(creditSum.toStringAsFixed(1), style: AppFonts.interStyle(fontWeight: FontWeight.w700))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
