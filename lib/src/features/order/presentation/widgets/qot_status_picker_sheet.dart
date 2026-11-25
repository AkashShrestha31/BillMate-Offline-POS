import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';

/// Floating rounded sheet (same pattern as party role): title, divider, radio-style rows.
Future<void> showQotStatusPickerSheet(
  BuildContext context, {
  required List<String> statuses,
  required String selected,
  required ValueChanged<String> onSelected,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (ctx) {
      final theme = Theme.of(ctx);
      final scheme = theme.colorScheme;
      final bottomInset = MediaQuery.of(ctx).padding.bottom;
      return Padding(
        padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 16.h + bottomInset),
        child: DecoratedBox(
          decoration: AppBottomSheetTheme.sheetDecoration(ctx).copyWith(
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: scheme.shadow.withValues(alpha: 0.18),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 12.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Select ticket status',
                    style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: scheme.onSurface,
                        ),
                  ),
                  SizedBox(height: 12.h),
                  Divider(height: 1, thickness: 1, color: scheme.outlineVariant.withValues(alpha: 0.45)),
                  SizedBox(height: 4.h),
                  ...statuses.map((s) {
                    final isOn = s == selected;
                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(ctx).pop();
                          if (s != selected) onSelected(s);
                        },
                        borderRadius: BorderRadius.circular(8.r),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
                          child: Row(
                            children: [
                              _RadioDot(selected: isOn),
                              SizedBox(width: 14.w),
                              Expanded(
                                child: Text(
                                  s,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: scheme.onSurface,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

class _RadioDot extends StatelessWidget {
  const _RadioDot({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (selected) {
      return Container(
        width: 22.r,
        height: 22.r,
        decoration: BoxDecoration(
          color: scheme.primary,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(Icons.check, size: 14.sp, color: scheme.onPrimary),
      );
    }
    return Container(
      width: 22.r,
      height: 22.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: scheme.outlineVariant, width: 1.6),
      ),
    );
  }
}
