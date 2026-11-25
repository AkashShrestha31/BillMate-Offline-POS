import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

class DetailInfoRow extends StatelessWidget {
  const DetailInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.bold = false,
    this.fontSize,
    this.valueColor,
  });

  final String label;
  final String value;
  final bool bold;
  final double? fontSize;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: AppFonts.interStyle(
                fontSize: fontSize ?? 14.sp,
                fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: AppFonts.interStyle(
                fontSize: fontSize ?? 14.sp,
                fontWeight: bold ? FontWeight.bold : FontWeight.w600,
                color: valueColor ?? scheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
