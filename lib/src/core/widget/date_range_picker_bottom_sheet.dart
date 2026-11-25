import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

Future<DateTimeRange?> showDateRangePickerBottomSheet({
  required BuildContext context,
  required DateTime minDate,
  required DateTime maxDate,
  required DateTime initialStart,
  required DateTime initialEnd,
  String title = 'Select date range',
}) {
  return showModalBottomSheet<DateTimeRange?>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.5),
    builder: (ctx) {
      return _DateRangePickerBottomSheet(
        title: title,
        minDate: minDate,
        maxDate: maxDate,
        initialStart: initialStart,
        initialEnd: initialEnd,
      );
    },
  );
}

class _DateRangePickerBottomSheet extends StatefulWidget {
  const _DateRangePickerBottomSheet({
    required this.title,
    required this.minDate,
    required this.maxDate,
    required this.initialStart,
    required this.initialEnd,
  });

  final String title;
  final DateTime minDate;
  final DateTime maxDate;
  final DateTime initialStart;
  final DateTime initialEnd;

  @override
  State<_DateRangePickerBottomSheet> createState() =>
      _DateRangePickerBottomSheetState();
}

class _DateRangePickerBottomSheetState
    extends State<_DateRangePickerBottomSheet> {
  late final DateRangePickerController _pickerController;
  late PickerDateRange _pickerRange;

  @override
  void initState() {
    super.initState();
    _pickerController = DateRangePickerController();
    _pickerController.displayDate = widget.initialEnd;
    _pickerController.selectedRange =
        PickerDateRange(widget.initialStart, widget.initialEnd);
    _pickerRange = _pickerController.selectedRange!;
  }

  @override
  void dispose() {
    _pickerController.dispose();
    super.dispose();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    final value = args.value;
    if (value is PickerDateRange) {
      setState(() => _pickerRange = value);
      return;
    }
    if (value is DateTime) {
      setState(() => _pickerRange = PickerDateRange(value, null));
    }
  }

  DateTime _localDateOnly(DateTime date) {
    final local = date.toLocal();
    return DateTime(local.year, local.month, local.day);
  }

  String _formatRangeLabel(PickerDateRange range) {
    final start = range.startDate;
    final end = range.endDate ?? range.startDate;
    if (start == null) return 'Select start and end dates';
    if (end == null) {
      return DateFormat('MMM d, yyyy').format(_localDateOnly(start));
    }
    final s = _localDateOnly(start);
    final e = _localDateOnly(end);
    if (s.year == e.year && s.month == e.month && s.day == e.day) {
      return DateFormat('MMM d, yyyy').format(s);
    }
    if (s.year == e.year) {
      return '${DateFormat('MMM d').format(s)} – ${DateFormat('MMM d, yyyy').format(e)}';
    }
    return '${DateFormat('MMM d, yyyy').format(s)} – ${DateFormat('MMM d, yyyy').format(e)}';
  }

  void _apply() {
    final fromController = _pickerController.selectedRange;
    final range = fromController ?? _pickerRange;
    final start = range.startDate;
    final end = range.endDate ?? range.startDate;
    if (start == null || end == null) {
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(content: Text('Select a start and end date')),
      );
      return;
    }

    var s = _localDateOnly(start);
    var e = _localDateOnly(end);
    if (e.isBefore(s)) {
      final temp = s;
      s = e;
      e = temp;
    }
    if (s.isBefore(widget.minDate)) s = widget.minDate;
    if (e.isAfter(widget.maxDate)) e = widget.maxDate;

    Navigator.pop(context, DateTimeRange(start: s, end: e));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final sheetColor = scheme.surfaceContainerHigh;
    final primary = scheme.primary;
    final rangeFill = scheme.primaryContainer;
    final onSurface = scheme.onSurface;
    final onSurfaceVariant = scheme.onSurfaceVariant;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        decoration: AppBottomSheetTheme.topSheetDecoration(context).copyWith(
          color: sheetColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(26.r)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10.h),
              Center(child: AppBottomSheetTheme.dragHandle(context)),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 14.h, 8.w, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: primary.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Text(
                                _formatRangeLabel(_pickerRange),
                                style: AppFonts.interStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop<DateTimeRange?>(context),
                      icon: Icon(
                        Icons.close_rounded,
                        color: onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              Divider(
                height: 1,
                color: scheme.outlineVariant.withValues(alpha: 0.45),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8.w, 4.h, 8.w, 0),
                child: SizedBox(
                  height: 360.h,
                  child: SfDateRangePicker(
                    view: DateRangePickerView.month,
                    monthFormat: 'MMMM',
                    controller: _pickerController,
                    selectionMode: DateRangePickerSelectionMode.range,
                    minDate: widget.minDate,
                    maxDate: widget.maxDate,
                    showTodayButton: false,
                    showNavigationArrow: true,
                    navigationDirection:
                        DateRangePickerNavigationDirection.horizontal,
                    navigationMode: DateRangePickerNavigationMode.snap,
                    backgroundColor: sheetColor,
                    todayHighlightColor: Colors.transparent,
                    selectionShape: DateRangePickerSelectionShape.circle,
                    startRangeSelectionColor: primary,
                    endRangeSelectionColor: primary,
                    rangeSelectionColor: rangeFill,
                    selectionTextStyle: AppFonts.interStyle(
                      color: scheme.onPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                    rangeTextStyle: AppFonts.interStyle(
                      color: onSurface,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    headerHeight: 52,
                    headerStyle: DateRangePickerHeaderStyle(
                      backgroundColor: sheetColor,
                      textAlign: TextAlign.center,
                      textStyle: AppFonts.interStyle(
                        color: onSurface,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        letterSpacing: -0.3,
                      ),
                    ),
                    monthViewSettings: DateRangePickerMonthViewSettings(
                      firstDayOfWeek: 1,
                      viewHeaderHeight: 40,
                      dayFormat: 'EEE',
                      weekendDays: const [DateTime.saturday, DateTime.sunday],
                      enableSwipeSelection: true,
                      viewHeaderStyle: DateRangePickerViewHeaderStyle(
                        backgroundColor: sheetColor,
                        textStyle: AppFonts.interStyle(
                          color: onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    monthCellStyle: DateRangePickerMonthCellStyle(
                      textStyle: AppFonts.interStyle(
                        color: onSurface,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      weekendTextStyle: AppFonts.interStyle(
                        color: onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      leadingDatesTextStyle: AppFonts.interStyle(
                        color: onSurfaceVariant.withValues(alpha: 0.55),
                        fontSize: 13,
                      ),
                      trailingDatesTextStyle: AppFonts.interStyle(
                        color: onSurfaceVariant.withValues(alpha: 0.55),
                        fontSize: 13,
                      ),
                      todayTextStyle: AppFonts.interStyle(
                        color: primary,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                      todayCellDecoration: BoxDecoration(
                        border: Border.all(color: primary, width: 1.5),
                        shape: BoxShape.circle,
                      ),
                      disabledDatesTextStyle: AppFonts.interStyle(
                        color: onSurface.withValues(alpha: 0.22),
                        fontSize: 13,
                      ),
                    ),
                    onSelectionChanged: _onSelectionChanged,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButtonWidget.outlined(
                        height: 48.h,
                        borderRadius: 8.r,
                        onPressed: () =>
                            Navigator.pop<DateTimeRange?>(context),
                        title: 'Cancel',
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: CustomButtonWidget(
                        height: 48.h,
                        borderRadius: 8.r,
                        onPressed: _apply,
                        title: 'Apply',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
