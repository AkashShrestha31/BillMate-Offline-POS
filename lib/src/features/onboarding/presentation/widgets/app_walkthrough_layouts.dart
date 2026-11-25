import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel/src/features/onboarding/presentation/layout/onboarding_layout.dart';
import 'package:hotel/src/features/onboarding/presentation/widgets/onboarding_action_widgets.dart';

class WalkthroughSlideData {
  const WalkthroughSlideData({
    required this.title,
    required this.description,
    required this.illustrationAsset,
  });

  final String title;
  final String description;
  final String illustrationAsset;
}

class AppWalkthroughMobileLayout extends StatelessWidget {
  const AppWalkthroughMobileLayout({
    super.key,
    required this.slides,
    required this.pageIndex,
    required this.pageController,
    required this.onPageChanged,
    required this.topBar,
    required this.actionTitle,
    required this.onAction,
    required this.pageIndicators,
  });

  final List<WalkthroughSlideData> slides;
  final int pageIndex;
  final PageController pageController;
  final ValueChanged<int> onPageChanged;
  final Widget topBar;
  final String actionTitle;
  final VoidCallback onAction;
  final Widget pageIndicators;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surfaceContainerLow,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            topBar,
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: slides.length,
                onPageChanged: onPageChanged,
                itemBuilder: (context, index) {
                  return _WalkthroughMobileSlideView(slide: slides[index]);
                },
              ),
            ),
            OnboardingBottomActionBar(
              title: actionTitle,
              onPressed: onAction,
              header: pageIndicators,
            ),
          ],
        ),
      ),
    );
  }
}

/// Full-width tablet / iPad walkthrough — split illustration + copy layout.
class AppWalkthroughTabletLayout extends StatelessWidget {
  const AppWalkthroughTabletLayout({
    super.key,
    required this.slides,
    required this.pageIndex,
    required this.pageController,
    required this.onPageChanged,
    required this.topBar,
    required this.actionTitle,
    required this.onAction,
    required this.pageIndicators,
  });

  final List<WalkthroughSlideData> slides;
  final int pageIndex;
  final PageController pageController;
  final ValueChanged<int> onPageChanged;
  final Widget topBar;
  final String actionTitle;
  final VoidCallback onAction;
  final Widget pageIndicators;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isLandscape = OnboardingLayout.isLandscape(context);

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: cs.surface,
                border: Border(
                  bottom: BorderSide(
                    color: cs.outlineVariant.withValues(alpha: 0.35),
                  ),
                ),
              ),
              child: topBar,
            ),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: slides.length,
                onPageChanged: onPageChanged,
                itemBuilder: (context, index) {
                  return _WalkthroughTabletSlideView(
                    slide: slides[index],
                    isLandscape: isLandscape,
                  );
                },
              ),
            ),
            OnboardingBottomActionBar(
              title: actionTitle,
              onPressed: onAction,
              header: pageIndicators,
              backgroundColor: cs.surface,
            ),
          ],
        ),
      ),
    );
  }
}

class _WalkthroughMobileSlideView extends StatelessWidget {
  const _WalkthroughMobileSlideView({required this.slide});

  final WalkthroughSlideData slide;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 260.h,
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(20.r),
            ),
            padding: EdgeInsets.all(16.w),
            child: SvgPicture.asset(
              slide.illustrationAsset,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 32.h),
          Text(
            slide.title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
              height: 1.2,
            ),
          ),
          SizedBox(height: 14.h),
          Text(
            slide.description,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: cs.onSurfaceVariant,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _WalkthroughTabletSlideView extends StatelessWidget {
  const _WalkthroughTabletSlideView({
    required this.slide,
    required this.isLandscape,
  });

  final WalkthroughSlideData slide;
  final bool isLandscape;

  @override
  Widget build(BuildContext context) {
    if (isLandscape) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 11,
            child: _WalkthroughIllustrationPanel(asset: slide.illustrationAsset),
          ),
          Expanded(
            flex: 9,
            child: _WalkthroughCopyPanel(
              title: slide.title,
              description: slide.description,
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 11,
          child: _WalkthroughIllustrationPanel(asset: slide.illustrationAsset),
        ),
        Expanded(
          flex: 9,
          child: _WalkthroughCopyPanel(
            title: slide.title,
            description: slide.description,
            centered: true,
          ),
        ),
      ],
    );
  }
}

class _WalkthroughIllustrationPanel extends StatelessWidget {
  const _WalkthroughIllustrationPanel({required this.asset});

  final String asset;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ColoredBox(
      color: cs.surfaceContainerLow,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxSide = constraints.biggest.shortestSide * 0.82;
          final boxSize = maxSide.clamp(220.0, 460.0);

          return Center(
            child: Container(
              width: boxSize,
              height: boxSize,
              decoration: BoxDecoration(
                color: cs.surfaceContainerHighest.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(28),
              child: SvgPicture.asset(
                asset,
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _WalkthroughCopyPanel extends StatelessWidget {
  const _WalkthroughCopyPanel({
    required this.title,
    required this.description,
    this.centered = false,
  });

  final String title;
  final String description;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final align = centered ? TextAlign.center : TextAlign.start;
    final cross = centered ? CrossAxisAlignment.center : CrossAxisAlignment.start;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: cross,
        children: [
          Text(
            title,
            textAlign: align,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            textAlign: align,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: cs.onSurfaceVariant,
              height: 1.5,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
