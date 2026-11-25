import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';

/// Centered empty list state with an SVG illustration, title, and optional subtitle.
class ListEmptyState extends StatelessWidget {
  const ListEmptyState({
    super.key,
    required this.illustrationPath,
    required this.title,
    this.subtitle,
    this.padding,
    this.action,
  });

  final String illustrationPath;
  final String title;
  final String? subtitle;
  final EdgeInsetsGeometry? padding;

  /// Optional call to action rendered below the text (e.g. an "Add item" button).
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;
    final scheme = theme.colorScheme;

    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: 48.h, horizontal: 24.w),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              illustrationPath,
              width: 200.w,
              height: 167.h,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            if (subtitle != null && subtitle!.isNotEmpty) ...[
              SizedBox(height: 6.h),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                  height: 1.35,
                ),
              ),
            ],
            if (action != null) ...[
              SizedBox(height: 20.h),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
