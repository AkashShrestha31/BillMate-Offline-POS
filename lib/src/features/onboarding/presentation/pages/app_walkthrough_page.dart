import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/localization_extension.dart';
import 'package:hotel/src/core/l10n/app_locale_service.dart';
import 'package:hotel/src/core/widget/language_flag_switch.dart';
import 'package:hotel/src/features/onboarding/domain/app_walkthrough_storage.dart';
import 'package:hotel/src/features/onboarding/presentation/layout/onboarding_layout.dart';
import 'package:hotel/src/features/onboarding/presentation/widgets/app_walkthrough_layouts.dart';
import 'package:hotel/src/features/onboarding/presentation/widgets/onboarding_action_widgets.dart';
import 'package:hotel/src/features/setup/presentation/setup_navigation.dart';

@RoutePage()
class AppWalkthroughPage extends StatefulWidget {
  const AppWalkthroughPage({super.key});

  @override
  State<AppWalkthroughPage> createState() => _AppWalkthroughPageState();
}

class _AppWalkthroughPageState extends State<AppWalkthroughPage> {
  final PageController _pageController = PageController();

  static const _illustrations = [
    'assets/svg/01-dashboard.svg',
    'assets/svg/02-offline-sync.svg',
    'assets/svg/03-billing-pos.svg',
    'assets/svg/04-staff-reports.svg',
    'assets/svg/05-secure-backup.svg',
    'assets/svg/06-get-started.svg',
  ];

  int _pageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<WalkthroughSlideData> _slides(BuildContext context) {
    final l = context.l10n;
    return [
      WalkthroughSlideData(
        title: l.walkthroughDashboardTitle,
        description: l.walkthroughDashboardDescription,
        illustrationAsset: _illustrations[0],
      ),
      WalkthroughSlideData(
        title: l.walkthroughOfflineTitle,
        description: l.walkthroughOfflineDescription,
        illustrationAsset: _illustrations[1],
      ),
      WalkthroughSlideData(
        title: l.walkthroughBillingTitle,
        description: l.walkthroughBillingDescription,
        illustrationAsset: _illustrations[2],
      ),
      WalkthroughSlideData(
        title: l.walkthroughStaffTitle,
        description: l.walkthroughStaffDescription,
        illustrationAsset: _illustrations[3],
      ),
      WalkthroughSlideData(
        title: l.walkthroughBackupTitle,
        description: l.walkthroughBackupDescription,
        illustrationAsset: _illustrations[4],
      ),
      WalkthroughSlideData(
        title: l.walkthroughReadyTitle,
        description: l.walkthroughReadyDescription,
        illustrationAsset: _illustrations[5],
      ),
    ];
  }

  Future<void> _finish() async {
    await AppWalkthroughStorage.markCompleted();
    if (!mounted) return;
    await navigateAfterOnboarding(context.router);
  }

  void _onNext(BuildContext context) {
    final slides = _slides(context);
    if (_pageIndex >= slides.length - 1) {
      _finish();
      return;
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

  Widget _buildTopBar(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return OnboardingTopBar(
      leading: TextButton(
        onPressed: _finish,
        child: Text(
          context.l10n.skip,
          style: theme.textTheme.labelLarge?.copyWith(
            color: cs.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      trailing: const LanguageFlagSwitch(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localeService = getIt<AppLocaleService>();

    return ListenableBuilder(
      listenable: localeService,
      builder: (context, _) {
        final slides = _slides(context);
        final isLast = _pageIndex == slides.length - 1;
        final actionTitle =
            isLast ? context.l10n.getStarted : context.l10n.next;
        final topBar = _buildTopBar(context);
        final pageIndicators = OnboardingPageIndicators(
          count: slides.length,
          activeIndex: _pageIndex,
        );

        final layoutProps = (
          slides: slides,
          pageIndex: _pageIndex,
          pageController: _pageController,
          onPageChanged: (int i) => setState(() => _pageIndex = i),
          topBar: topBar,
          actionTitle: actionTitle,
          onAction: () => _onNext(context),
          pageIndicators: pageIndicators,
        );

        if (OnboardingLayout.isTablet(context)) {
          return AppWalkthroughTabletLayout(
            slides: layoutProps.slides,
            pageIndex: layoutProps.pageIndex,
            pageController: layoutProps.pageController,
            onPageChanged: layoutProps.onPageChanged,
            topBar: layoutProps.topBar,
            actionTitle: layoutProps.actionTitle,
            onAction: layoutProps.onAction,
            pageIndicators: layoutProps.pageIndicators,
          );
        }

        return AppWalkthroughMobileLayout(
          slides: layoutProps.slides,
          pageIndex: layoutProps.pageIndex,
          pageController: layoutProps.pageController,
          onPageChanged: layoutProps.onPageChanged,
          topBar: layoutProps.topBar,
          actionTitle: layoutProps.actionTitle,
          onAction: layoutProps.onAction,
          pageIndicators: layoutProps.pageIndicators,
        );
      },
    );
  }
}
