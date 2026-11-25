import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/features/invoice/presentation/widgets/invoice_list_chrome.dart';
import 'package:hotel/src/features/invoice/presentation/widgets/invoice_tab_tablet_layout.dart';

/// Month/year picker used on Sales and Purchase invoice tabs.
class InvoiceMonthYearPickerDialog extends StatefulWidget {
  const InvoiceMonthYearPickerDialog({
    super.key,
    required this.initialMonth,
    required this.onToday,
    required this.onSelect,
  });

  final DateTime initialMonth;
  final VoidCallback onToday;
  final ValueChanged<DateTime> onSelect;

  static Future<void> show(
    BuildContext context, {
    required DateTime initialMonth,
    required VoidCallback onToday,
    required ValueChanged<DateTime> onSelect,
  }) {
    return showDialog<void>(
      context: context,
      builder: (ctx) => InvoiceMonthYearPickerDialog(
        initialMonth: initialMonth,
        onToday: onToday,
        onSelect: onSelect,
      ),
    );
  }

  @override
  State<InvoiceMonthYearPickerDialog> createState() =>
      _InvoiceMonthYearPickerDialogState();
}

class _InvoiceMonthYearPickerDialogState
    extends State<InvoiceMonthYearPickerDialog> {
  late DateTime _selectedMonth;

  @override
  void initState() {
    super.initState();
    _selectedMonth = widget.initialMonth;
  }

  double _sz(BuildContext context, double tablet, double phone) =>
      InvoiceTabTabletLayout.sz(context, tablet, phone);

  double _sp(BuildContext context, double tablet, double phone) =>
      InvoiceTabTabletLayout.sp(context, tablet, phone);

  @override
  Widget build(BuildContext context) {
    final tablet = InvoiceTabTabletLayout.isTablet(context);
    final radius = _sz(context, 12, 16.r);
    final padding = _sz(context, 16, 20.w);
    final gap = _sz(context, 12, 20.h);
    final monthGap = _sz(context, 8, 8.w);
    final monthRowGap = _sz(context, 8, 8.h);
    final monthAspect = tablet ? 3.8 : 2.5;
    final maxHeight = MediaQuery.sizeOf(context).height * (tablet ? 0.88 : 0.92);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      insetPadding: EdgeInsets.symmetric(
        horizontal: tablet ? 32 : 24.w,
        vertical: tablet ? 24 : 24.h,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: tablet ? 400 : double.infinity,
          maxHeight: maxHeight,
        ),
        child: Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: InvoiceListChrome.surface(context),
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      context.l10n.invoiceCommonSelectMonthAndYear,
                      style: AppFonts.interStyle(
                        fontSize: _sp(context, 16, 16),
                        fontWeight: FontWeight.w600,
                        color: InvoiceListChrome.primaryText(context),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close_rounded,
                      color: InvoiceListChrome.mutedText(context),
                      size: _sz(context, 20, 20.r),
                    ),
                  ),
                ],
              ),
              SizedBox(height: gap),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _YearNavButton(
                    icon: Icons.chevron_left_rounded,
                    onTap: () => setState(() {
                      _selectedMonth = DateTime(
                        _selectedMonth.year - 1,
                        _selectedMonth.month,
                      );
                    }),
                  ),
                  Text(
                    context.l10n.formatCount(_selectedMonth.year),
                    style: AppFonts.interStyle(
                      fontSize: _sp(context, 18, 18),
                      fontWeight: FontWeight.w600,
                      color: InvoiceListChrome.primaryText(context),
                    ),
                  ),
                  _YearNavButton(
                    icon: Icons.chevron_right_rounded,
                    onTap: () => setState(() {
                      _selectedMonth = DateTime(
                        _selectedMonth.year + 1,
                        _selectedMonth.month,
                      );
                    }),
                  ),
                ],
              ),
              SizedBox(height: gap),
              Flexible(
                child: SingleChildScrollView(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: monthAspect,
                      crossAxisSpacing: monthGap,
                      mainAxisSpacing: monthRowGap,
                    ),
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      final monthNames = context.l10n.shortMonthLabels;
                      final isSelected = _selectedMonth.month == index + 1;

                      return GestureDetector(
                        onTap: () => setState(() {
                          _selectedMonth = DateTime(
                            _selectedMonth.year,
                            index + 1,
                          );
                        }),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? context.colorScheme.primary
                                : InvoiceListChrome.subtleFill(context),
                            borderRadius: BorderRadius.circular(
                              _sz(context, 8, 8.r),
                            ),
                            border: Border.all(
                              color: isSelected
                                  ? context.colorScheme.primary
                                  : InvoiceListChrome.border(context),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              monthNames[index],
                              style: AppFonts.interStyle(
                                fontSize: _sp(context, 13, 13),
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? context.colorScheme.onPrimary
                                    : InvoiceListChrome.primaryText(context),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: gap),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.onToday();
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: InvoiceListChrome.border(context),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            _sz(context, 8, 8.r),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: _sz(context, 10, 12.h),
                        ),
                      ),
                      child: Text(
                        context.l10n.invoiceCommonToday,
                        style: AppFonts.interStyle(
                          fontSize: _sp(context, 14, 14),
                          fontWeight: FontWeight.w500,
                          color: InvoiceListChrome.primaryText(context),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: _sz(context, 12, 12.w)),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.onSelect(_selectedMonth);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            _sz(context, 8, 8.r),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: _sz(context, 10, 12.h),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        context.l10n.select,
                        style: AppFonts.interStyle(
                          fontSize: _sp(context, 14, 14),
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _YearNavButton extends StatelessWidget {
  const _YearNavButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(
          InvoiceTabTabletLayout.sz(context, 8, 8.r),
        ),
        decoration: BoxDecoration(
          color: InvoiceListChrome.subtleFill(context),
          borderRadius: BorderRadius.circular(
            InvoiceTabTabletLayout.sz(context, 8, 8.r),
          ),
        ),
        child: Icon(
          icon,
          color: InvoiceListChrome.mutedText(context),
          size: InvoiceTabTabletLayout.sz(context, 20, 20.r),
        ),
      ),
    );
  }
}
