import 'dart:io';
import 'dart:ui' show Rect;
import 'package:hotel/src/core/themes/app_fonts.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/features/invoice/presentation/cubit/accounting_settings_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/helpers/freemium_navigation.dart';
import 'package:hotel/src/core/helpers/gallery_save_helper.dart';
import 'package:hotel/src/core/helpers/invoice_edit_access.dart';
import 'package:hotel/src/core/helpers/invoice_return_access.dart';
import 'package:hotel/src/core/helpers/invoice_receipt_pdf_service.dart';
import 'package:hotel/src/core/layout/device_layout.dart';
import 'package:hotel/src/features/invoice/data/datasources/invoice_return_remote_data_source.dart';
import 'package:hotel/src/features/invoice/presentation/cubit/invoice_return_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/pages/invoice_return_page.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/features/invoice/presentation/widgets/transaction_details_bottom_sheet.dart';
import 'package:hotel/src/core/services/app_loading_overlay.dart';
import 'package:hotel/src/core/widget/action_bottom_sheet.dart';
import 'package:hotel/src/features/invoice/presentation/widgets/delete_invoice_confirm_sheet.dart';
import 'package:hotel/src/features/invoice/presentation/widgets/cancel_return_confirm_sheet.dart';
import 'package:hotel/src/features/invoice/presentation/widgets/invoice_tab_tablet_layout.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_sales_response_model.dart';
import 'package:hotel/src/features/settlement/presentation/pages/partial_payment_settlement_page.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

/// [Share.shareXFiles] on iOS requires a non-zero anchor rect for the popover.
Rect _sharePositionOriginForInvoiceCard(BuildContext context) {
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

Future<void> _exportInvoiceCardAsPdf(
  BuildContext context,
  InvoiceItem invoice,
  InvoiceType invoiceType,
) async {
  if (!await gateInvoiceExport(context)) return;
  try {
    AppLoadingOverlay.of(context).show();
    final bytes = await InvoiceReceiptPdfService.buildPdfBytes(
      invoice: invoice,
      invoiceType: invoiceType,
      accentColor: Theme.of(context).colorScheme.primary,
    );
    if (!context.mounted) return;
    AppLoadingOverlay.of(context).hide();
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => bytes,
      name: 'Receipt ${invoice.invoiceName ?? 'invoice'}.pdf',
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

Future<void> _showInvoiceCardImagePreview(
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
                  sharePositionOrigin: _sharePositionOriginForInvoiceCard(ctx),
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

Future<void> _exportInvoiceCardAsImage(
  BuildContext context,
  InvoiceItem invoice,
  InvoiceType invoiceType,
) async {
  if (!await gateInvoiceExport(context)) return;
  try {
    AppLoadingOverlay.of(context).show();
    final file = await InvoiceReceiptPdfService.exportToPngFile(
      invoice: invoice,
      invoiceType: invoiceType,
      accentColor: Theme.of(context).colorScheme.primary,
    );
    if (!context.mounted) return;
    AppLoadingOverlay.of(context).hide();
    await _showInvoiceCardImagePreview(
      context,
      file,
      'Receipt ${invoice.invoiceName ?? ''}',
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

class InvoiceCard extends StatelessWidget {
  final InvoiceItem invoice;
  final DateFormat dateFormat;
  final NumberFormat currencyFormat;
  final String? highlightQuery;
  final Function()? onSubmit;
  final Function()? onDelete;
  final Function()? onCompleted;
  final InvoiceType? invoiceType;
  final bool isSelectionMode;
  final bool isSelected;

  const InvoiceCard({
    super.key,
    required this.invoice,
    this.onSubmit,
    this.onDelete,
    this.onCompleted,
    required this.dateFormat,
    required this.currencyFormat,
    this.highlightQuery,
    required this.invoiceType,
    this.isSelectionMode = false,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final primary = scheme.primary;
    final tablet = DeviceLayout.isTablet(context);
    final statusLabel = invoiceStatusDisplayLabel(invoice);
    final statusColors = invoiceStatusChipColors(context, invoice);
    final isReturnSlip = invoiceIsReturnSlipRow(invoice);
    final isActiveReturn = invoiceIsReturnDocument(invoice);
    final returnAgainst = (invoice.returnAgainst ?? '').trim();
    final activeReturns = activeReturnInvoiceCount(invoice);
    // Payment chip only when not showing return/cancelled as primary status.
    final showPaymentStatus = !isReturnSlip && statusLabel.toLowerCase() != 'cancelled';
    final cardRadius = InvoiceTabTabletLayout.sz(context, 12, 12.r);

    return GestureDetector(
      onTap: isSelectionMode
          ? null // Tap handled by parent in selection mode
          : () {
              showTransactionDetailsBottomSheet(
                context: context,
                invoice: invoice,
                invoiceType: invoiceType!,
                onSubmit: onSubmit,
                onCompleted: onCompleted,
              );
            },
      // Return slips: tap opens details only; no long-press action menu.
      onLongPress: isReturnSlip
          ? null
          : () async {
              await context.read<AccountingSettingsCubit>().loadIfNeeded();
              if (!context.mounted) return;
              _showActionBottomSheet(context, invoice);
            },
      child: Container(
        margin: EdgeInsets.only(
          bottom: InvoiceTabTabletLayout.sz(context, 0, 4.h),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: InvoiceTabTabletLayout.sz(context, 16, 16.w),
          vertical: InvoiceTabTabletLayout.sz(context, 14, 12.h),
        ),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(cardRadius),
          border: Border.all(
            color: isSelected ? primary : scheme.outlineVariant.withValues(alpha: 0.6),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primary.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Leading Icon (or checkbox in selection mode)
            if (isSelectionMode)
              Container(
                width: InvoiceTabTabletLayout.sz(context, 40, 40.w),
                height: InvoiceTabTabletLayout.sz(context, 40, 40.h),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? primary : scheme.surface,
                  border: Border.all(
                    color: isSelected ? primary : scheme.outlineVariant,
                    width: 2.5,
                  ),
                ),
                child: isSelected
                    ? Icon(
                        Icons.check_rounded,
                        color: scheme.onPrimary,
                        size: InvoiceTabTabletLayout.sz(context, 20, 20.r),
                      )
                    : null,
              ),

            if (isSelectionMode)
              SizedBox(width: InvoiceTabTabletLayout.sz(context, 12, 8.w)),

            // Title and Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.localizeDigits(invoice.invoiceName.toString()),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppFonts.interStyle(
                      fontSize: InvoiceTabTabletLayout.sp(context, 14, 13),
                      fontWeight: FontWeight.w600,
                      color: isSelected ? primary : scheme.onSurface,
                    ),
                  ),
                  SizedBox(height: InvoiceTabTabletLayout.sz(context, 6, 6.h)),
                  Text(
                    invoice.party.toString(),
                    style: AppFonts.interStyle(
                      fontSize: InvoiceTabTabletLayout.sp(context, 13, 12),
                      color: scheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: tablet ? 2 : 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: InvoiceTabTabletLayout.sz(context, 4, 4.h)),
                  Text(
                    _formatDate(context, invoice.date.toString()),
                    style: AppFonts.interStyle(
                      fontSize: InvoiceTabTabletLayout.sp(context, 12, 10),
                      color: scheme.onSurfaceVariant.withValues(alpha: 0.85),
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            SizedBox(width: InvoiceTabTabletLayout.sz(context, 16, 8.w)),

            // Trailing Amount and Status
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.l10n.formatCurrency(
                    currencyFormat.format(
                      double.parse(
                        invoice.outstandingAmount == 0
                            ? invoice.grandTotal.toString()
                            : invoice.outstandingAmount.toString(),
                      ),
                    ),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: AppFonts.interStyle(
                    fontSize: InvoiceTabTabletLayout.sp(context, 15, 14),
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurface,
                  ),
                ),
                SizedBox(height: InvoiceTabTabletLayout.sz(context, 6, 4.h)),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: tablet ? 92 : 0,
                  ),
                  child: Wrap(
                    alignment: WrapAlignment.end,
                    spacing: InvoiceTabTabletLayout.sz(context, 6, 6.w),
                    runSpacing: InvoiceTabTabletLayout.sz(context, 4, 4.h),
                    children: [
                      if (isReturnSlip)
                        _buildStatusChip(
                          context,
                          label: statusLabel,
                          background: statusColors.bg,
                          foreground: statusColors.fg,
                          showDot: true,
                          borderColor: statusColors.fg.withValues(alpha: 0.35),
                        ),
                      if (isActiveReturn && returnAgainst.isNotEmpty)
                        _buildStatusChip(
                          context,
                          label: context.l10n.localizeDigits('Against: $returnAgainst'),
                          background: const Color(0xFFE0F2FE),
                          foreground: const Color(0xFF0369A1),
                          showDot: true,
                          borderColor: const Color(0xFF0284C7).withValues(alpha: 0.25),
                        ),
                      if (!isReturnSlip && activeReturns > 0)
                        _buildStatusChip(
                          context,
                          label: context.l10n.localizeMessage(
                            context.l10n.invoiceReturnCount(activeReturns),
                          ),
                          background: const Color(0xFFE0F2FE),
                          foreground: const Color(0xFF0369A1),
                          showDot: true,
                          borderColor: const Color(0xFF0284C7).withValues(alpha: 0.25),
                        ),
                      if (showPaymentStatus)
                        _buildStatusChip(
                          context,
                          label: statusLabel.toUpperCase(),
                          background: statusColors.bg,
                          foreground: statusColors.fg,
                        ),
                    ],
                  ),
                ),
              ],
            ),

            // Three dot menu (hide in selection mode)
            // if (!isSelectionMode) ...[
            //   SizedBox(width: 8.w),
            //   GestureDetector(
            //     onTap: () => _showActionBottomSheet(context, invoice),
            //     child: Icon(
            //       Icons.more_vert,
            //       color: Colors.grey[600],
            //       size: 18.r,
            //     ),
            //   ),
            // ],
          ],
        ),
      ),
    );
  }

  bool _isNotSubmitted(InvoiceItem invoice) =>
      invoice.submitted == 0 ||
      invoice.status?.toLowerCase() == 'not submitted' ||
      invoice.status?.toLowerCase() == 'not_submitted';

  void _showActionBottomSheet(BuildContext context, InvoiceItem invoice) {
    final type = invoiceType!;
    final enableReturns = _invoiceReturnsEnabled(context);
    final showSubmitInHeader = _isNotSubmitted(invoice) && onSubmit != null;

    final items = <ActionSheetItem>[
      if (canShowEditInvoice(invoice))
        ActionSheetItem(
          icon: Icons.edit_outlined,
          title: 'Edit Invoice',
          onTap: () {
            context.router.push(
              CreateInvoiceRoute(
                invoiceToEdit: invoice,
                onComplete: () => onCompleted?.call(),
                invoiceType: type,
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
              invoiceToDuplicate: invoice.snapshotForDuplicate(type),
              selectedDate: DateTime.now(),
              onComplete: () => onCompleted?.call(),
              invoiceType: type,
            ),
          );
        },
      ),
      if (invoice.submitted == 1 && invoice.outstandingAmount != 0.0)
        ActionSheetItem(
          icon: Icons.payments_outlined,
          title: 'Make Payment',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PartialPaymentSettlementPage(
                hideParties: true,
                item: invoice,
                onCompleted: onCompleted,
                selectedRole: invoiceType == InvoiceType.sales ? 'customer' : 'suppliers',
              ),
            ),
          ),
        ),
      if (enableReturns && canCreateInvoiceReturn(invoice))
        ActionSheetItem(
          icon: Icons.assignment_return_outlined,
          title: 'Create return',
          onTap: () => _openCreateReturn(context, invoice, type),
        ),
      if (enableReturns && canCancelReturnInvoice(invoice))
        ActionSheetItem(
          icon: Icons.cancel_outlined,
          title: 'Cancel return',
          onTap: () => _confirmCancelReturn(context, invoice, type),
        ),
      // if (invoice.submitted == 1)
      //   ActionSheetItem(
      //     icon: Icons.ios_share_outlined,
      //     title: 'Export invoice',
      //     onTap: () => _showInvoiceCardExportBottomSheet(context, invoice, type),
      //   ),
      ActionSheetItem(
        icon: Icons.delete_outline,
        title: 'Delete Invoice',
        onTap: () => _showDeleteConfirmation(context),
      ),
    ];
    ActionBottomSheet.show(
      context,
      title: invoice.invoiceName.toString(),
      items: items,
      titleTrailingBuilder: showSubmitInHeader
          ? (sheetContext) => CustomButtonWidget.outlined(
                shrinkWrap: true,
                expandCrossAxis: false,
                height: 35.h,
                padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
                onPressed: () {
                  Navigator.pop(sheetContext);
                  onSubmit?.call();
                },
                title: 'Submit',
              )
          : null,
    );
  }

  /// From [AccountingSettingsCubit] loaded when sales/purchase/party invoice screens open.
  bool _invoiceReturnsEnabled(BuildContext context) {
    try {
      return context.read<AccountingSettingsCubit>().state == true;
    } catch (_) {
      return false;
    }
  }

  void _openCreateReturn(BuildContext context, InvoiceItem invoice, InvoiceType type) {
    Navigator.push<bool>(
      context,
      MaterialPageRoute<bool>(
        builder: (ctx) => BlocProvider(
          create: (_) => getIt<InvoiceReturnCubit>(),
          child: InvoiceReturnPage(
            invoice: invoice,
            invoiceType: type,
            onCompleted: onCompleted,
          ),
        ),
      ),
    ).then((ok) {
      if (ok == true) onCompleted?.call();
    });
  }

  Future<void> _confirmCancelReturn(
    BuildContext context,
    InvoiceItem invoice,
    InvoiceType type,
  ) async {
    final name = invoice.invoiceName ?? '';
    final confirmed = await showCancelReturnConfirmSheet(
      context: context,
      returnName: name,
      message:
          'Cancel return invoice "$name"? This restores balances on the original invoice.',
    );
    if (confirmed != true || !context.mounted) return;

    final email = context.employeeData?.email?.trim();
    final cancelledBy = (email != null && email.isNotEmpty) ? email : context.loggedInUserFullName;
    try {
      AppLoadingOverlay.of(context).show();
      final msg = await getIt<InvoiceReturnRemoteDataSource>().cancelReturn(
        invoiceType: type,
        returnInvoiceName: name,
        cancelledBy: cancelledBy.isEmpty ? 'mobile' : cancelledBy,
      );
      if (context.mounted) {
        AppLoadingOverlay.of(context).hide();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg ?? 'Return cancelled')),
        );
        onCompleted?.call();
      }
    } catch (e) {
      if (context.mounted) {
        AppLoadingOverlay.of(context).hide();
        final text = e is AppException ? e.message : e.toString();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
      }
    }
  }

  /// Same flow as [PartyDetailsPage] / invoice details: second sheet with PDF + image.
  void _showInvoiceCardExportBottomSheet(
    BuildContext context,
    InvoiceItem invoice,
    InvoiceType invoiceType,
  ) {
    ActionBottomSheet.show(
      context,
      title: 'Export receipt',
      items: [
        ActionSheetItem(
          icon: Icons.picture_as_pdf_outlined,
          title: 'Export as PDF',
          onTap: () => _exportInvoiceCardAsPdf(context, invoice, invoiceType),
        ),
        ActionSheetItem(
          icon: Icons.image_outlined,
          title: 'Export as image',
          onTap: () => _exportInvoiceCardAsImage(context, invoice, invoiceType),
        ),
      ],
    );
  }

  Future<void> _showDeleteConfirmation(BuildContext context) async {
    final name = invoice.invoiceName?.toString() ?? '';
    final confirmed = await showDeleteInvoiceConfirmSheet(
      context: context,
      title: 'Delete Invoice',
      message:
          'Are you sure you want to delete "$name"? This action cannot be undone.',
    );
    if (confirmed) onDelete?.call();
  }

  Widget _buildSummaryItem(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppFonts.interStyle(
              fontSize: 11.sp,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: AppFonts.interStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemRow(ItemDetails item, BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = item.item;
    final query = highlightQuery?.toLowerCase() ?? '';

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Container(
            width: 28.w,
            height: 28.h,
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(color: scheme.outlineVariant, width: 1),
            ),
            child: Center(
              child: Text(
                '${(item.quantity! % 1 == 0) ? item.quantity!.toInt() : item.quantity}',
                style: AppFonts.interStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: query.isEmpty || !text.toString().toLowerCase().contains(query)
                ? Text(
                    text.toString(),
                    style: AppFonts.interStyle(
                      fontSize: 13.sp,
                      color: scheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : _buildHighlightedText(text.toString(), query, scheme),
          ),
          SizedBox(width: 8.w),
          Text(
            context.l10n.formatCurrency(
              currencyFormat.format(double.parse(item.amount.toString())),
            ),
            style: AppFonts.interStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: scheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightedText(String text, String query, ColorScheme scheme) {
    final startIndex = text.toLowerCase().indexOf(query);
    final endIndex = startIndex + query.length;

    return RichText(
      text: TextSpan(
        style: AppFonts.interStyle(
          fontSize: 13.sp,
          color: scheme.onSurface,
          fontWeight: FontWeight.w500,
        ),
        children: [
          TextSpan(text: text.substring(0, startIndex)),
          TextSpan(
            text: text.substring(startIndex, endIndex),
            style: AppFonts.interStyle(
              backgroundColor: scheme.tertiaryContainer,
              fontWeight: FontWeight.w700,
              color: scheme.onTertiaryContainer,
            ),
          ),
          TextSpan(text: text.substring(endIndex)),
        ],
      ),
    );
  }

  static Widget _buildStatusChip(
    BuildContext context, {
    required String label,
    required Color background,
    required Color foreground,
    bool showDot = false,
    Color? borderColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: InvoiceTabTabletLayout.sz(context, 10, 8.w),
        vertical: InvoiceTabTabletLayout.sz(context, 5, 3.h),
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(
          InvoiceTabTabletLayout.sz(context, 6, 4.r),
        ),
        border: borderColor != null ? Border.all(color: borderColor) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: InvoiceTabTabletLayout.sz(context, 6, 6.r),
              height: InvoiceTabTabletLayout.sz(context, 6, 6.r),
              decoration: BoxDecoration(
                color: foreground,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: InvoiceTabTabletLayout.sz(context, 5, 5.w)),
          ],
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppFonts.interStyle(
              fontSize: InvoiceTabTabletLayout.sp(context, 11, 10),
              fontWeight: FontWeight.w600,
              color: foreground,
              letterSpacing: 0.35,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(BuildContext context, String dateString) {
    try {
      final date = DateTime.parse(dateString.replaceFirst(' ', 'T')).toLocal();
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final day = DateTime(date.year, date.month, date.day);
      final difference = today.difference(day).inDays;
      final l10n = context.l10n;

      if (difference == 0) {
        return l10n.localizeMessage(
          l10n.invoiceCommonTodayAt(DateFormat('hh:mm a').format(date)),
        );
      } else if (difference == 1) {
        return l10n.invoiceCommonYesterday;
      } else if (difference < 7) {
        return l10n.localizeMessage(l10n.invoiceCommonDaysAgo(difference));
      } else {
        return l10n.invoiceDayMonthYearLabel(date);
      }
    } catch (e) {
      return dateString;
    }
  }
}
