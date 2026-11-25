import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel/src/core/constants/app_empty_state_assets.dart';
import 'package:hotel/src/core/layout/device_layout.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

/// A card used for empty/search states with optional icon, title and subtitle.
class EmptyStateCard extends StatelessWidget {
  const EmptyStateCard({
    super.key,
    required this.title,
    this.subtitle,
    this.iconPath = AppEmptyStateAssets.sales,
    this.icon,
    this.framed = true,
  });

  /// Main title text.
  final String title;

  /// Optional subtitle (e.g. date range or hint).
  final String? subtitle;

  /// Path to SVG asset. Ignored if [icon] is non-null.
  final String? iconPath;

  /// Optional custom icon widget. If set, [iconPath] is ignored.
  final Widget? icon;

  /// When false, skips the bordered surface card chrome (illustration + text only).
  final bool framed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isTablet = DeviceLayout.isTablet(context);
    final padding = isTablet ? 32.0 : 40.r;
    final illustrationSize = isTablet ? 140.0 : 200.w;

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null)
          icon!
        else if (iconPath != null && iconPath!.isNotEmpty)
          _EmptyStateIllustration(
            path: iconPath!,
            size: illustrationSize,
          ),
        SizedBox(height: isTablet ? 16 : 12.h),
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppFonts.interStyle(
            fontSize: isTablet ? 18 : 16.sp,
            color: scheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (subtitle != null && subtitle!.isNotEmpty) ...[
          SizedBox(height: isTablet ? 8 : 4.h),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: AppFonts.interStyle(
              fontSize: isTablet ? 15 : 12.sp,
              color: scheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ],
      ],
    );

    if (!framed) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 24 : 16.w,
          vertical: isTablet ? 24 : 20.h,
        ),
        child: content,
      );
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(isTablet ? 16 : 16.r),
        border: Border.all(
          color: scheme.outlineVariant.withValues(alpha: 0.6),
          width: 1,
        ),
      ),
      child: content,
    );
  }
}

class _EmptyStateIllustration extends StatelessWidget {
  const _EmptyStateIllustration({
    required this.path,
    required this.size,
  });

  final String path;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: size,
      height: size * 0.84,
      fit: BoxFit.contain,
    );
  }
}
