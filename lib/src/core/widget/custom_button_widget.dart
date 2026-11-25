import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/layout/device_layout.dart';
import 'package:hotel/src/core/themes/app_colors.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';

enum CustomButtonState { primary, secondary, outlined, disabled }

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    this.onPressed,
    required this.title,
    this.height = 48,
    this.borderRadius = 12,
    this.elevation = 2,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.buttonState = CustomButtonState.primary,
    this.titleColor,
    this.width,
    this.backgroundColor,
    this.loading = false,
    this.shape,
    this.splashColor,
    this.borderColor,
    this.icon,
    this.titleStyle,
    this.shadowColor,
    /// When true, does not force [height] on the outer box so the button can
    /// size to its content (e.g. icon + label in a tight row).
    this.shrinkWrap = false,
    /// When [shrinkWrap] is true: if true, fill the parent cross-axis (e.g. tall
    /// [Row] with stretch). If false, height follows [padding] + content only.
    this.expandCrossAxis = true,
    /// Use logical pixels instead of [ScreenUtil] (tablet / iPad).
    this.useFixedSizes = false,
  });

  final double height;
  final double? width;
  final double borderRadius;
  final double elevation;
  final EdgeInsetsGeometry padding;
  final String title;
  final Color? titleColor;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final bool loading;
  final OutlinedBorder? shape;
  final Color? splashColor;
  final Color? shadowColor;
  final Color? borderColor;
  final Widget? icon;
  final TextStyle? titleStyle;
  final CustomButtonState buttonState;
  final bool shrinkWrap;
  final bool expandCrossAxis;
  final bool useFixedSizes;

  // Primary button (default)
  factory CustomButtonWidget.primary({
    required String title,
    VoidCallback? onPressed,
    double height = 45,
    double borderRadius = 8,
    double elevation = 2,
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    Color? backgroundColor,
    Color? titleColor,
    double? width,
    bool loading = false,
    OutlinedBorder? shape,
    Color? splashColor,
    Color? shadowColor,
    Widget? icon,
    TextStyle? titleStyle,
    bool shrinkWrap = false,
    bool expandCrossAxis = true,
    bool useFixedSizes = false,
  }) {
    return CustomButtonWidget(
      onPressed: onPressed,
      title: title,
      buttonState: CustomButtonState.primary,
      height: height,
      shrinkWrap: shrinkWrap,
      expandCrossAxis: expandCrossAxis,
      useFixedSizes: useFixedSizes,
      borderRadius: borderRadius,
      elevation: elevation,
      padding: padding,
      backgroundColor: backgroundColor,
      titleColor: titleColor,
      width: width,
      loading: loading,
      shape: shape,
      splashColor: splashColor,
      shadowColor: shadowColor,
      icon: icon,
      titleStyle: titleStyle,
    );
  }

  // Secondary button
  factory CustomButtonWidget.secondary({
    required String title,
    VoidCallback? onPressed,
    double height = 42,
    double borderRadius = 8,
    double elevation = 0,
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    Color? backgroundColor,
    Color? titleColor,
    double? width,
    bool loading = false,
    OutlinedBorder? shape,
    Color? splashColor,
    Color? shadowColor,
    Widget? icon,
    TextStyle? titleStyle,
    bool shrinkWrap = false,
    bool expandCrossAxis = true,
  }) {
    return CustomButtonWidget(
      onPressed: onPressed,
      title: title,
      buttonState: CustomButtonState.secondary,
      height: height,
      shrinkWrap: shrinkWrap,
      expandCrossAxis: expandCrossAxis,
      borderRadius: borderRadius,
      elevation: elevation,
      padding: padding,
      backgroundColor: backgroundColor,
      titleColor: titleColor,
      width: width,
      loading: loading,
      shape: shape,
      splashColor: splashColor,
      shadowColor: shadowColor,
      icon: icon,
      titleStyle: titleStyle,
    );
  }

  // Outlined button
  factory CustomButtonWidget.outlined({
    required String title,
    VoidCallback? onPressed,
    double height = 42,
    double borderRadius = 8,
    double elevation = 0,
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    Color? backgroundColor,
    Color? titleColor,
    Color? borderColor,
    double? width,
    bool loading = false,
    OutlinedBorder? shape,
    Color? splashColor,
    Color? shadowColor,
    Widget? icon,
    TextStyle? titleStyle,
    bool shrinkWrap = false,
    bool expandCrossAxis = true,
    bool useFixedSizes = false,
  }) {
    return CustomButtonWidget(
      onPressed: onPressed,
      title: title,
      buttonState: CustomButtonState.outlined,
      height: height,
      shrinkWrap: shrinkWrap,
      expandCrossAxis: expandCrossAxis,
      useFixedSizes: useFixedSizes,
      borderRadius: borderRadius,
      elevation: elevation,
      padding: padding,
      backgroundColor: backgroundColor,
      titleColor: titleColor,
      borderColor: borderColor,
      width: width,
      loading: loading,
      shape: shape,
      splashColor: splashColor,
      shadowColor: shadowColor,
      icon: icon,
      titleStyle: titleStyle,
    );
  }

  // Disabled button
  factory CustomButtonWidget.disabled({
    required String title,
    double height = 42,
    double borderRadius = 8,
    double elevation = 0,
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    Color? backgroundColor,
    Color? titleColor,
    double? width,
    bool loading = false,
    OutlinedBorder? shape,
    Color? splashColor,
    Color? shadowColor,
    Widget? icon,
    TextStyle? titleStyle,
    bool shrinkWrap = false,
    bool expandCrossAxis = true,
  }) {
    return CustomButtonWidget(
      onPressed: null,
      title: title,
      buttonState: CustomButtonState.disabled,
      height: height,
      shrinkWrap: shrinkWrap,
      expandCrossAxis: expandCrossAxis,
      borderRadius: borderRadius,
      elevation: elevation,
      padding: padding,
      backgroundColor: backgroundColor,
      titleColor: titleColor,
      width: width,
      loading: loading,
      shape: shape,
      splashColor: splashColor,
      shadowColor: shadowColor,
      icon: icon,
      titleStyle: titleStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    final fixed = useFixedSizes || DeviceLayout.isTablet(context);

    if (shrinkWrap) {
      return Skeleton.ignore(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final cross = constraints.maxHeight;
            final minCross = expandCrossAxis &&
                    cross.isFinite &&
                    cross > 0
                ? cross
                : null;
            return SizedBox(
              width: width,
              child: ElevatedButton(
                onPressed: _isButtonEnabled ? _handlePressed : null,
                style: _buildButtonStyle(context, minCrossExtent: minCross),
                child: _buildButtonContent(context),
              ),
            );
          },
        ),
      );
    }

    return Skeleton.ignore(
      child: SizedBox(
        width: width ?? double.infinity,
        height: fixed ? height : height.h,
        child: ElevatedButton(
          onPressed: _isButtonEnabled ? _handlePressed : null,
          style: _buildButtonStyle(context),
          child: _buildButtonContent(context),
        ),
      ),
    );
  }

  bool get _isButtonEnabled =>
      buttonState != CustomButtonState.disabled &&
      !loading &&
      onPressed != null;

  void _handlePressed() {
    if (onPressed != null) {
      onPressed!();
    }
  }

  ButtonStyle _buildButtonStyle(
    BuildContext context, {
    double? minCrossExtent,
  }) {
    final minSize = minCrossExtent != null &&
            minCrossExtent.isFinite &&
            minCrossExtent > 0
        ? Size(0, minCrossExtent)
        : Size.zero;

    return ElevatedButton.styleFrom(
      animationDuration: const Duration(milliseconds: 200),
      backgroundColor: _getBackgroundColor(context),
      foregroundColor: _getForegroundColor(context),
      disabledBackgroundColor: _getDisabledBackgroundColor(context),
      disabledForegroundColor: _getDisabledForegroundColor(context),
      elevation: elevation,
      shape: shape ?? _buildShape(),
      padding: padding,
      minimumSize: minSize,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shadowColor: shadowColor ?? Colors.transparent,
      splashFactory: InkRipple.splashFactory,
    );
  }

  OutlinedBorder _buildShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      side: buttonState == CustomButtonState.outlined
          ? BorderSide(
              color: borderColor ?? AppColors.lightColorScheme.primary,
              width: 1,
            )
          : BorderSide.none,
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    if (backgroundColor != null) return backgroundColor!;

    switch (buttonState) {
      case CustomButtonState.primary:
        return context.theme.colorScheme.primary;
      case CustomButtonState.secondary:
        return AppColors.lightColorScheme.secondary;
      case CustomButtonState.outlined:
        return Colors.transparent;
      case CustomButtonState.disabled:
        return context.theme.colorScheme.primary.withOpacity(0.3);
    }
  }

  Color _getForegroundColor(BuildContext context) {
    if (titleColor != null) return titleColor!;

    switch (buttonState) {
      case CustomButtonState.primary:
        return Colors.white;
      case CustomButtonState.secondary:
        return AppColors.lightColorScheme.primary;
      case CustomButtonState.outlined:
        return AppColors.lightColorScheme.primary;
      case CustomButtonState.disabled:
        return Colors.white.withOpacity(0.7);
    }
  }

  Color _getDisabledBackgroundColor(BuildContext context) {
    return context.theme.colorScheme.primary.withOpacity(0.3);
  }

  Color _getDisabledForegroundColor(BuildContext context) {
    return Colors.white.withOpacity(0.7);
  }

  Widget _buildButtonContent(BuildContext context) {
    if (loading) {
      return _buildLoadingIndicator(context);
    }

    return _buildButtonRow(context);
  }

  Widget _buildLoadingIndicator(BuildContext context) {
    final fixed = useFixedSizes || DeviceLayout.isTablet(context);
    return SizedBox(
      width: fixed ? 20 : 20.w,
      height: fixed ? 20 : 20.h,
      child: CircularProgressIndicator(
        color: _getLoadingIndicatorColor(context),
        strokeWidth: 2.5,
      ),
    );
  }

  Color _getLoadingIndicatorColor(BuildContext context) {
    switch (buttonState) {
      case CustomButtonState.primary:
        return Colors.white;
      case CustomButtonState.secondary:
      case CustomButtonState.outlined:
        return context.theme.colorScheme.primary;
      case CustomButtonState.disabled:
        return Colors.white.withOpacity(0.7);
    }
  }

  Widget _buildButtonRow(BuildContext context) {
    final fixed = useFixedSizes || DeviceLayout.isTablet(context);
    if (title.isEmpty && icon == null) {
      return const SizedBox.shrink();
    }

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            icon!,
            if (title.isNotEmpty) SizedBox(width: fixed ? 8 : 8.w),
          ],
          if (title.isNotEmpty)
            Text(
              title,
              style: _getTextStyle(context),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
        ],
      ),
    );
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (titleStyle != null) return titleStyle;
    final fixed = useFixedSizes || DeviceLayout.isTablet(context);

    return AppFonts.interStyle(
      fontSize: fixed ? 15 : 14.sp,
      fontWeight: FontWeight.w600,
      color: titleColor,
    );
  }
}
