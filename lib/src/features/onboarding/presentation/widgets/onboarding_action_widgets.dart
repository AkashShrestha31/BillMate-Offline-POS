import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/widget/app_brand_name.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/layout/device_layout.dart';

/// Primary CTA used across onboarding (language, walkthrough, etc.).
class OnboardingPrimaryButton extends StatelessWidget {
  const OnboardingPrimaryButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.loading = false,
    this.width,
  });

  final String title;
  final VoidCallback? onPressed;
  final bool loading;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final isTablet = DeviceLayout.isTablet(context);
    final cs = Theme.of(context).colorScheme;

    return CustomButtonWidget.primary(
      title: title,
      onPressed: onPressed,
      loading: loading,
      width: width ?? double.infinity,
      useFixedSizes: isTablet,
      height: isTablet ? 52 : 48,
      borderRadius: isTablet ? 12 : 8,
      elevation: isTablet ? 4 : 6,
      shadowColor: cs.primary.withValues(alpha: isTablet ? 0.3 : 0.35),
    );
  }
}

/// Pinned bottom action area with safe inset handling for onboarding screens.
class OnboardingBottomActionBar extends StatelessWidget {
  const OnboardingBottomActionBar({
    super.key,
    required this.title,
    required this.onPressed,
    this.loading = false,
    this.header,
    this.backgroundColor,
  });

  final String title;
  final VoidCallback? onPressed;
  final bool loading;
  final Widget? header;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isTablet = DeviceLayout.isTablet(context);
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    final horizontal = isTablet ? 28.0 : 12.w;
    final top = isTablet ? 12.0 : 16.h;
    final bottom = (isTablet ? 12.0 : 16.h) + bottomInset;
    final gap = isTablet ? 16.0 : 18.h;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor ?? (isTablet ? cs.surface : Colors.transparent),
        border: isTablet
            ? Border(
                top: BorderSide(
                  color: cs.outlineVariant.withValues(alpha: 0.45),
                ),
              )
            : null,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(horizontal, top, horizontal, bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (header != null) ...[
              header!,
              SizedBox(height: gap),
            ],
            OnboardingPrimaryButton(
              title: title,
              onPressed: onPressed,
              loading: loading,
            ),
          ],
        ),
      ),
    );
  }
}

/// Dot indicators for multi-step onboarding flows.
class OnboardingPageIndicators extends StatelessWidget {
  const OnboardingPageIndicators({
    super.key,
    required this.count,
    required this.activeIndex,
  });

  final int count;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isTablet = DeviceLayout.isTablet(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final active = index == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          margin: EdgeInsets.symmetric(horizontal: isTablet ? 4 : 4.w),
          width: active ? (isTablet ? 22 : 22.w) : (isTablet ? 8 : 8.w),
          height: isTablet ? 8 : 8.h,
          decoration: BoxDecoration(
            color: active
                ? cs.primary
                : cs.outlineVariant.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(999),
          ),
        );
      }),
    );
  }
}

/// Top app bar row used on walkthrough (skip, brand, language switch).
class OnboardingTopBar extends StatelessWidget {
  const OnboardingTopBar({
    super.key,
    required this.leading,
    required this.trailing,
  });

  final Widget leading;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTablet = DeviceLayout.isTablet(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        isTablet ? 16 : 8.w,
        isTablet ? 12 : 8.h,
        isTablet ? 24 : 16.w,
        0,
      ),
      child: Row(
        children: [
          leading,
          const Spacer(),
          AppBrandName(
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
              fontSize: isTablet ? 18 : null,
            ),
          ),
          const Spacer(),
          trailing,
        ],
      ),
    );
  }
}
