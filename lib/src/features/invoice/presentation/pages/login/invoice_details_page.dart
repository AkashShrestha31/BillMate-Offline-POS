import 'dart:io';
import 'dart:ui' show Rect;
import 'package:hotel/constants.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/services/display_precision/app_money_format.dart';
import 'package:hotel/src/core/helpers/freemium_navigation.dart';
import 'package:hotel/src/core/helpers/gallery_save_helper.dart';
import 'package:hotel/src/core/helpers/invoice_edit_access.dart';
import 'package:hotel/src/core/helpers/invoice_receipt_pdf_service.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/widget/action_bottom_sheet.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/estimate_invoice_sheet.dart';
import 'package:hotel/src/core/services/app_loading_overlay.dart';
import 'package:hotel/src/features/action/presentation/pages/payment_edit_page.dart';
import 'package:hotel/src/features/invoice/data/models/request/delete_invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_sales_response_model.dart';
import 'package:hotel/src/features/invoice/presentation/cubits/delete_invoice/delete_invoice_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/widgets/delete_invoice_confirm_sheet.dart';
import 'package:hotel/src/features/settlement/data/models/response/partial_settlement_response_model.dart';
import 'package:hotel/src/features/settlement/presentation/pages/partial_payment_settlement_page.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

/// [Share.shareXFiles] on iOS requires a non-zero anchor rect for the popover.
Rect _sharePositionOriginForSheet(BuildContext context) {
  final box = context.findRenderObject() as RenderBox?;
  if (box != null && box.attached && box.hasSize) {
    final rect = box.localToGlobal(Offset.zero) & box.size;
    if (rect.width >= 1 && rect.height >= 1) {
      return rect;
    }
  }
  final size = MediaQuery.sizeOf(context);
  return Rect.fromCenter(
    center: Offset(size.width / 2, size.height / 2),
    width: 2,
    height: 2,
  );
}

@RoutePage()
class InvoiceDetailsPage extends StatefulWidget {
  final Function()? onSubmit;
  final Function()? onDelete;
  final Function()? onCompleted;
  final InvoiceType invoiceType;
  const InvoiceDetailsPage(
      {super.key, required this.invoice, this.onSubmit, this.onDelete, this.onCompleted, required this.invoiceType});

  final InvoiceItem invoice;

  @override
  State<InvoiceDetailsPage> createState() => _InvoiceDetailsPageState();
}

class _InvoiceDetailsPageState extends State<InvoiceDetailsPage> {
  late InvoiceItem _currentInvoice;

  InvoiceItem get _invoice => _currentInvoice;

  InvoiceType get _invoiceType => widget.invoiceType;

  @override
  void initState() {
    super.initState();
    _currentInvoice = widget.invoice;
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat currencyFormat = AppMoneyFormat.currency(currencySymbol);

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(widget.invoice.invoiceName.toString()),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const AppBarIosBackButton(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () => _showActionBottomSheet(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12.w),
        child: Column(
          children: [
            _buildInvoiceHeader(context, currencyFormat),
            SizedBox(height: 12.h),
            _buildFinancialSummary(context, currencyFormat),
            SizedBox(height: 12.h),
            if (_invoice.items?.isNotEmpty == true) ...[
              _buildItemsList(context, currencyFormat),
              SizedBox(height: 12.h),
            ],
            if (_invoice.payment?.isNotEmpty == true) ...[
              _buildPaymentDetails(context, currencyFormat),
              SizedBox(height: 12.h),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceHeader(BuildContext context, NumberFormat currencyFormat) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Color(0xFFE9ECEF), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Invoice Number',
                      style: AppFonts.interStyle(
                        fontSize: 10.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      _invoice.invoiceName ?? 'N/A',
                      style: AppFonts.interStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(_invoice.status),
            ],
          ),
          SizedBox(height: 10.h),
          _buildInfoRow(Icons.person, 'Party', _invoice.party ?? 'N/A'),
          SizedBox(height: 8.h),
          _buildInfoRow(Icons.calendar_today, 'Date', _formatDate(_invoice.date)),
          // Conditionally show Previous Outstanding only if not null and greater than 0
          if (_invoice.previousOutstanding != null &&
              ((_invoice.previousOutstanding ?? 0.0) - (_invoice.outstandingAmount ?? 0.0).toInt()) > 0) ...[
            SizedBox(height: 8.h),
            _buildPreviousOutstandingRow(Icons.warning_amber, context.l10n.previousUnpaid,
                '$currencySymbol ${((_invoice.previousOutstanding ?? 0.0) - (_invoice.outstandingAmount ?? 0.0)).toInt()}'),
          ],
          SizedBox(height: 16.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: [
                Text(
                  'Grand Total',
                  style: AppFonts.interStyle(
                    fontSize: 12.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  currencyFormat.format(_invoice.grandTotal ?? 0),
                  style: AppFonts.interStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String? status) {
    final color = _getStatusColor(status);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Text(
        status?.toUpperCase() ?? 'UNKNOWN',
        style: AppFonts.interStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16.r, color: Colors.grey[500]),
        SizedBox(width: 8.w),
        Text(
          '$label: ',
          style: AppFonts.interStyle(
            fontSize: 13.sp,
            color: Colors.grey[600],
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppFonts.interStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  // New method for Previous Outstanding in red
  Widget _buildPreviousOutstandingRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16.r, color: Colors.red[600]),
        SizedBox(width: 8.w),
        Text(
          '$label: ',
          style: AppFonts.interStyle(
            fontSize: 13.sp,
            color: Colors.red[600],
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppFonts.interStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: Colors.red[600],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFinancialSummary(BuildContext context, NumberFormat currencyFormat) {
    final disc = _invoice.totalDiscount ?? _invoice.discountAmount ?? 0;
    final lineSum =
        _invoice.items?.fold<double>(0, (s, e) => s + (e.amount ?? 0)) ?? 0;
    final taxInfo = estimateTaxFromInvoiceTotals(
      baseGrandTotal: _invoice.baseGrandTotal,
      grandTotal: _invoice.grandTotal,
      subTotal: lineSum,
      discountAmount: disc.toDouble(),
      taxAmountLine: context.l10n.taxAmountLine,
      fallbackTaxLabel: context.l10n.checkoutTaxLabel,
    );

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Color(0xFFE9ECEF), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Financial Summary',
            style: AppFonts.interStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 12.h),
          _buildFinancialRow(
            context.l10n.unpaid,
            currencyFormat.format(_invoice.outstandingAmount ?? 0),
            Colors.red[400]!,
            Icons.warning,
          ),
          SizedBox(height: 8.h),
          _buildFinancialRow(
            'Total Discount',
            currencyFormat.format(_invoice.totalDiscount ?? 0),
            Colors.green[400]!,
            Icons.discount,
          ),
          if (taxInfo != null) ...[
            SizedBox(height: 8.h),
            _buildFinancialRow(
              taxInfo.taxLabel,
              currencyFormat.format(taxInfo.taxAmount),
              Colors.teal[400]!,
              Icons.receipt_long,
            ),
          ],
          SizedBox(height: 8.h),
          _buildFinancialRow(
            'Paid Amount',
            currencyFormat.format(_paidAmount(_invoice)),
            Colors.blue[400]!,
            Icons.check_circle,
          ),
        ],
      ),
    );
  }

  /// Paid amount = sum of actual payments. When [_invoice.payment] is empty, returns 0.
  double _paidAmount(InvoiceItem item) =>
      item.payment?.fold<double>(0.0, (sum, p) => sum + (p.amount ?? 0)) ?? 0;

  Widget _buildFinancialRow(String label, String amount, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Icon(icon, color: Colors.white, size: 14.r),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              label,
              style: AppFonts.interStyle(
                fontSize: 13.sp,
                color: Colors.grey[700],
              ),
            ),
          ),
          Text(
            amount,
            style: AppFonts.interStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsList(BuildContext context, NumberFormat currencyFormat) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Color(0xFFE9ECEF), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Items',
                style: AppFonts.interStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  '${_invoice.items?.length ?? 0}',
                  style: AppFonts.interStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue[600],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ..._invoice.items!.map((item) => _buildItemCard(item, currencyFormat)).toList(),
        ],
      ),
    );
  }

  Widget _buildItemCard(ItemDetails item, NumberFormat currencyFormat) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Icon(
              Icons.shopping_bag,
              color: Colors.white,
              size: 14.r,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.item ?? 'Unknown Item',
                  style: AppFonts.interStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Qty: ${item.quantity?.toString() ?? '0'}',
                  style: AppFonts.interStyle(
                    fontSize: 11.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            currencyFormat.format(item.amount ?? 0),
            style: AppFonts.interStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentDetails(BuildContext context, NumberFormat currencyFormat) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Color(0xFFE9ECEF), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Payments',
                style: AppFonts.interStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  '${_invoice.payment?.length ?? 0}',
                  style: AppFonts.interStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.green[600],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ..._invoice.payment!
              .map((payment) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (newContext) => PaymentEditPage(
                                  initialPayment: payment,
                                  onSave: () {},
                                )));
                  },
                  child: _buildPaymentCard(payment, currencyFormat)))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildPaymentCard(PaymentDetails payment, NumberFormat currencyFormat) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: Colors.green[400],
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Icon(
              _getPaymentIcon(payment.paymentMethod),
              color: Colors.white,
              size: 14.r,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  payment.paymentMethod ?? 'Unknown',
                  style: AppFonts.interStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                if (payment.paymentId?.isNotEmpty == true)
                  Text(
                    'ID: ${payment.paymentId}',
                    style: AppFonts.interStyle(
                      fontSize: 11.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                if (payment.date != null)
                  Text(
                    DateFormat('yyyy-MM-dd').format(payment.date!),
                    style: AppFonts.interStyle(fontSize: 11.sp, color: Colors.grey[600], fontWeight: FontWeight.w600),
                  ),
              ],
            ),
          ),
          Text(
            currencyFormat.format(payment.amount ?? 0),
            style: AppFonts.interStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Colors.green[600],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'paid':
        return Colors.green;
      case 'unpaid':
        return Colors.red;
      case 'partially paid':
        return Colors.orange;
      case 'overdue':
        return Colors.red[800]!;
      default:
        return Colors.grey;
    }
  }

  IconData _getPaymentIcon(String? method) {
    switch (method?.toLowerCase()) {
      case 'cash':
        return Icons.money;
      case 'transfer':
        return Icons.account_balance;
      case 'card':
        return Icons.credit_card;
      case 'cheque':
        return Icons.receipt;
      default:
        return Icons.payment;
    }
  }

  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'N/A';
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }

  void _applySettlementResult(PartialSettlementResponseModel response) {
    PartialSettlementInvoice? matchedInvoice;
    for (final invoice in response.settledInvoices) {
      if (invoice.invoice == _invoice.invoiceName) {
        matchedInvoice = invoice;
        break;
      }
    }
    if (matchedInvoice == null) return;

    final nextOutstanding = matchedInvoice.remainingOutstanding;
    final nextStatus = matchedInvoice.fullySettled
        ? 'paid'
        : (nextOutstanding <= 0 ? 'paid' : 'partially paid');

    setState(() {
      _currentInvoice = InvoiceItem(
        parent: _invoice.parent,
        invoiceName: _invoice.invoiceName,
        party: _invoice.party,
        submitted: _invoice.submitted,
        cancelled: _invoice.cancelled,
        grandTotal: _invoice.grandTotal,
        date: _invoice.date,
        status: nextStatus,
        action: _invoice.action,
        modifiedBy: _invoice.modifiedBy,
        outstandingAmount: nextOutstanding,
        previousOutstanding: _invoice.previousOutstanding,
        items: _invoice.items,
        payment: _invoice.payment,
        paymentTotals: _invoice.paymentTotals,
        totalDiscount: _invoice.totalDiscount,
        setDiscountAmount: _invoice.setDiscountAmount,
        discountAmount: _invoice.discountAmount,
        discountPercent: _invoice.discountPercent,
        invoiceType: _invoice.invoiceType ?? _invoiceType,
      );
    });
  }

  bool _shouldShowEditInvoice() => canShowEditInvoice(_invoice);

  Future<void> _showDeleteConfirmation(BuildContext context) async {
    final name = _invoice.invoiceName?.toString() ?? '';
    final confirmed = await showDeleteInvoiceConfirmSheet(
      context: context,
      title: 'Delete Invoice',
      message:
          'Are you sure you want to delete "$name"? This action cannot be undone.',
    );
    if (!confirmed || !context.mounted) return;

    context.read<DeleteInvoiceCubit>().deleteInvoice(
          params: DeleteInvoiceRequestParams(
            confirmDelete: true,
            forceDelete: false,
            deletedBy: context.employeeData?.email,
            invoiceType: _invoiceType,
            invoiceNames: [name],
          ),
        );
  }

  void _showActionBottomSheet(BuildContext context) {
    final rawDate = _invoice.date?.trim();
    final dateOnly = (rawDate == null || rawDate.isEmpty) ? null : rawDate.split('T').first.split(' ').first;
    final invoiceForEdit = InvoiceItem(
      parent: _invoice.parent,
      invoiceName: _invoice.invoiceName,
      party: _invoice.party,
      submitted: _invoice.submitted,
      cancelled: _invoice.cancelled,
      grandTotal: _invoice.grandTotal,
      date: dateOnly,
      status: _invoice.status,
      action: _invoice.action,
      modifiedBy: _invoice.modifiedBy,
      outstandingAmount: _invoice.outstandingAmount,
      previousOutstanding: _invoice.previousOutstanding,
      items: _invoice.items,
      payment: _invoice.payment,
      paymentTotals: _invoice.paymentTotals,
      totalDiscount: _invoice.totalDiscount,
      setDiscountAmount: _invoice.setDiscountAmount,
      discountAmount: _invoice.discountAmount,
      discountPercent: _invoice.discountPercent,
      invoiceType: _invoice.invoiceType ?? _invoiceType,
    );

    final items = <ActionSheetItem>[
      if (_shouldShowEditInvoice())
        ActionSheetItem(
          icon: Icons.edit_outlined,
          title: 'Edit Invoice',
          onTap: () {
            context.router.push(
              CreateInvoiceRoute(
                invoiceToEdit: invoiceForEdit,
                onComplete: () => widget.onCompleted?.call(),
                invoiceType: _invoiceType,
              ),
            );
          },
        ),
      ActionSheetItem(
        icon: Icons.content_copy_outlined,
        title: 'Duplicate Invoice',
        onTap: () {
          context.router.push(
            CreateInvoiceRoute(
              invoiceToDuplicate: invoiceForEdit.snapshotForDuplicate(_invoiceType),
              selectedDate: DateTime.now(),
              onComplete: () => widget.onCompleted?.call(),
              invoiceType: _invoiceType,
            ),
          );
        },
      ),
      if (_invoice.submitted == 1 && _invoice.outstandingAmount != 0.0)
        ActionSheetItem(
          icon: Icons.payment,
          title: 'Make Payment',
          onTap: () async {
            final result = await Navigator.push<PartialSettlementResponseModel>(
              context,
              MaterialPageRoute(
                builder: (context) => PartialPaymentSettlementPage(
                  hideParties: true,
                  item: _invoice,
                  onCompleted: widget.onCompleted,
                  selectedRole: _invoiceType == InvoiceType.sales ? 'customer' : "suppliers",
                ),
              ),
            );
            if (!mounted || result == null) return;
            _applySettlementResult(result);
            widget.onCompleted?.call();
          },
        ),
      if (_invoice.submitted == 1)
        ActionSheetItem(
          icon: Icons.ios_share_outlined,
          title: 'Export Invoice',

          onTap: () => _showExportBottomSheet(context),
        ),
      ActionSheetItem(
        icon: Icons.delete_outline,
        title: 'Delete Invoice',

        onTap: () => _showDeleteConfirmation(context),
      ),
    ];
    final notSubmitted = _invoice.submitted == 0 ||
        _invoice.status?.toLowerCase() == 'not submitted' ||
        _invoice.status?.toLowerCase() == 'not_submitted';

    ActionBottomSheet.show(
      context,
      title: _invoice.invoiceName.toString(),
      items: items,
      titleTrailingBuilder: notSubmitted && widget.onSubmit != null
          ? (sheetContext) => FilledButton(
              onPressed: () {
                Navigator.pop(sheetContext);
                widget.onSubmit?.call();
              },
              style: FilledButton.styleFrom(
                minimumSize: const Size(0, 36),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                visualDensity: VisualDensity.compact,
              ),
              child: Text('Submit'),
            )
          : null,
    );
  }

  void _showExportBottomSheet(BuildContext context) {
    ActionBottomSheet.show(
      context,
      title: 'Export receipt',
      items: [
        ActionSheetItem(
          icon: Icons.picture_as_pdf_outlined,
          title: 'Export as PDF',
          color: const Color(0xFFB91C1C),
          onTap: () => _exportAsPdf(context),
        ),
        ActionSheetItem(
          icon: Icons.image_outlined,
          title: 'Export as image',
          color: const Color(0xFF1D4ED8),
          onTap: () => _exportAsImage(context),
        ),
      ],
    );
  }

  Future<void> _exportAsPdf(BuildContext context) async {
    if (!await gateInvoiceExport(context)) return;
    try {
      AppLoadingOverlay.of(context).show();
      final bytes = await InvoiceReceiptPdfService.buildPdfBytes(
        invoice: _invoice,
        invoiceType: _invoiceType,
        accentColor: Theme.of(context).colorScheme.primary,
      );
      if (!context.mounted) return;
      AppLoadingOverlay.of(context).hide();
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => bytes,
        name: 'Receipt ${_invoice.invoiceName ?? 'invoice'}.pdf',
      );
    } catch (e) {
      if (context.mounted) {
        AppLoadingOverlay.of(context).hide();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not export PDF: $e')),
        );
      }
    }
  }

  Future<void> _showReceiptImagePreview(
    BuildContext context,
    File file,
    String subject,
  ) async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (ctx) => Scaffold(
          appBar: AppBar(
            title: Text('Preview'),
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.pop(ctx),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.download_rounded),
                tooltip: 'Save to gallery',
                onPressed: () => saveImageFileToGallery(ctx, file.path),
              ),
              IconButton(
                icon: Icon(Icons.share),
                tooltip: 'Share',
                onPressed: () async {
                  await Share.shareXFiles(
                    [XFile(file.path)],
                    subject: subject,
                    sharePositionOrigin: _sharePositionOriginForSheet(ctx),
                  );
                },
              ),
            ],
          ),
          body: InteractiveViewer(
            minScale: 0.5,
            maxScale: 4,
            child: Center(
              child: Image.file(file),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _exportAsImage(BuildContext context) async {
    try {
      AppLoadingOverlay.of(context).show();
      final file = await InvoiceReceiptPdfService.exportToPngFile(
        invoice: _invoice,
        invoiceType: _invoiceType,
        accentColor: Theme.of(context).colorScheme.primary,
      );
      if (!context.mounted) return;
      AppLoadingOverlay.of(context).hide();
      await _showReceiptImagePreview(
        context,
        file,
        'Receipt ${_invoice.invoiceName ?? ''}',
      );
    } catch (e) {
      if (context.mounted) {
        AppLoadingOverlay.of(context).hide();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not export image: $e')),
        );
      }
    }
  }
}
