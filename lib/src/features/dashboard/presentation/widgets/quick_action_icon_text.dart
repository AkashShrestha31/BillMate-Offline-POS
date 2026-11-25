import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/layout/device_layout.dart';

/// Reusable icon + label widget for business quick action tiles.
class QuickActionIconText extends StatelessWidget {
  const QuickActionIconText({
    super.key,
    required this.icon,
    required this.label,
    this.iconSize,
    this.containerSize,
    this.labelStyle,
  });

  final IconData icon;
  final String label;
  final double? iconSize;
  final double? containerSize;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final scheme = theme.colorScheme;
    final isTablet = DeviceLayout.isTablet(context);
    final size = containerSize ?? (isTablet ? 52.0 : 52.h);
    final iSize = iconSize ?? (isTablet ? 22.0 : 22.sp);
    final isLight = scheme.brightness == Brightness.light;
    final radius = isTablet ? 14.0 : 14.r;
    final gap = isTablet ? 8.0 : 10.h;
    final style = labelStyle ??
        theme.textTheme.bodySmall?.copyWith(
          color: scheme.onSurfaceVariant,
          fontWeight: FontWeight.w500,
          fontSize: isTablet ? 12 : null,
          height: 1.2,
        );
    final fontSize = style?.fontSize ?? (isTablet ? 12.0 : 12.sp);
    final lineHeight = fontSize * (style?.height ?? 1.2);
    final labelHeight = lineHeight * 2;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: isLight ? 0.10 : 0.16),
            borderRadius: BorderRadius.circular(radius),
            boxShadow: isLight
                ? [
                    BoxShadow(
                      color: scheme.primary.withValues(alpha: 0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Icon(
            icon,
            size: iSize,
            color: isLight ? scheme.primary : Colors.white,
          ),
        ),
        SizedBox(height: gap),
        // Fixed 2-line slot so icons stay aligned across the row.
        SizedBox(
          height: labelHeight,
          width: double.infinity,
          child: Text(
            label,
            style: style,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
