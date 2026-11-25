import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_sales_response_model.dart';
import 'package:hotel/constants.dart';
import 'package:hotel/src/core/services/display_precision/app_money_format.dart';

import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';

/// Bill line items picker sheet (Payment Settlement → View Items).
class BillItemsBottomSheet extends StatelessWidget {
  const BillItemsBottomSheet({
    super.key,
    required this.lines,
    this.emptyMessage,
  });

  final List<ItemDetails> lines;
  final String? emptyMessage;

  static const Color _kPaidGreen = Color(0xFF43A047);

  static Future<void> show(
    BuildContext context, {
    required List<ItemDetails>? lines,
    String? emptyMessage,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: false,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final ime = MediaQuery.viewInsetsOf(ctx).bottom;
        return Padding(
          padding: EdgeInsets.only(bottom: ime),
          child: BillItemsBottomSheet(
            lines: lines ?? const [],
            emptyMessage: emptyMessage,
          ),
        );
      },
    );
  }

  static String formatRs(double value) =>
      '$currencySymbol ${AppMoneyFormat.formatAmount(value)}';

  double get _itemsTotal =>
      lines.fold(0.0, (sum, line) => sum + (line.amount ?? 0));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final maxH = MediaQuery.sizeOf(context).height * 0.72;
    final hasLines = lines.isNotEmpty;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        color: scheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
        clipBehavior: Clip.antiAlias,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxH),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.h),
              AppBottomSheetTheme.dragHandle(context),
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 14.h, 8.w, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        color: _kPaidGreen.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.receipt_long_rounded,
                        color: _kPaidGreen,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bill items',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            hasLines
                                ? '${lines.length} item${lines.length == 1 ? '' : 's'}'
                                : 'No line items',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close_rounded),
                      style: IconButton.styleFrom(
                        foregroundColor: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              Divider(height: 1, thickness: 1, color: scheme.outlineVariant.withValues(alpha: 0.45)),
              Flexible(
                child: hasLines
                    ? ListView.separated(
                        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
                        itemCount: lines.length,
                        separatorBuilder: (_, __) => SizedBox(height: 8.h),
                        itemBuilder: (context, index) {
                          return _BillItemTile(
                            index: index + 1,
                            line: lines[index],
                          );
                        },
                      )
                    : _EmptyItemsBody(message: emptyMessage),
              ),
              if (hasLines) ...[
                Divider(height: 1, thickness: 1, color: scheme.outlineVariant.withValues(alpha: 0.45)),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.45)),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Items total',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          formatRs(_itemsTotal),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              SafeArea(
                top: false,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 12.h),
                  child: SizedBox(
                    width: double.infinity,
                    child: CustomButtonWidget(
                      title: hasLines ? 'Done' : 'Close',
                      borderRadius: 12.r,
                      height: 48.h,
                      elevation: 0,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BillItemTile extends StatelessWidget {
  const _BillItemTile({
    required this.index,
    required this.line,
  });

  final int index;
  final ItemDetails line;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final name = (line.item?.trim().isNotEmpty ?? false) ? line.item!.trim() : 'Item';
    final qty = line.quantity;
    final rate = line.rate;
    final amount = line.amount ?? 0;

    String? subtitle;
    if (qty != null && rate != null) {
      subtitle = '${_formatQty(qty)} × ${BillItemsBottomSheet.formatRs(rate)}';
    } else if (qty != null) {
      subtitle = 'Qty ${_formatQty(qty)}';
    } else if (rate != null) {
      subtitle = 'Rate ${BillItemsBottomSheet.formatRs(rate)}';
    }

    final scheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.45)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28.w,
            height: 28.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              '$index',
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1.25,
                  ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            BillItemsBottomSheet.formatRs(amount),
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  static String _formatQty(double qty) {
    if (qty == qty.roundToDouble()) return qty.toInt().toString();
    return qty.toStringAsFixed(2);
  }
}

class _EmptyItemsBody extends StatelessWidget {
  const _EmptyItemsBody({this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = message ??
        'No line items on this invoice. Totals use the invoice summary.';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 36.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
              color: scheme.surfaceContainerLow,
              shape: BoxShape.circle,
              border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.45)),
            ),
            child: Icon(
              Icons.inventory_2_outlined,
              size: 36.sp,
              color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Nothing to show',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            text,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
