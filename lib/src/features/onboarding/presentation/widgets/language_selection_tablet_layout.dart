import 'package:flutter/material.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/l10n/app_language_option.dart';
import 'package:hotel/src/core/widget/app_brand_name.dart';
import 'package:hotel/src/core/widget/app_logo.dart';
import 'package:hotel/src/core/widget/language_picker_tablet_grid.dart';
import 'package:hotel/src/core/widget/language_picker_widgets.dart';
import 'package:hotel/src/features/onboarding/presentation/layout/onboarding_layout.dart';
import 'package:hotel/src/features/onboarding/presentation/widgets/onboarding_action_widgets.dart';
import 'package:hotel/src/core/l10n/platform_app_localizations.dart';

/// Full-width language selection for tablets and iPad (not used on phones).
class LanguageSelectionTabletLayout extends StatelessWidget {
  const LanguageSelectionTabletLayout({
    super.key,
    required this.searchController,
    required this.filteredLanguages,
    required this.selectedCode,
    required this.suggestedCode,
    required this.saving,
    required this.selectedName,
    required this.onSelect,
    required this.onContinue,
  });

  final TextEditingController searchController;
  final List<AppLanguageOption> filteredLanguages;
  final String selectedCode;
  final String suggestedCode;
  final bool saving;
  final String selectedName;
  final ValueChanged<AppLanguageOption> onSelect;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: cs.surface,
      body: SafeArea(
        bottom: false,
        child: SizedBox.expand(
          child: _TabletSplitBody(
            searchController: searchController,
            filteredLanguages: filteredLanguages,
            selectedCode: selectedCode,
            suggestedCode: suggestedCode,
            saving: saving,
            selectedName: selectedName,
            onSelect: onSelect,
            onContinue: onContinue,
          ),
        ),
      ),
    );
  }
}

class _LanguageSelectionHeader extends StatelessWidget {
  const _LanguageSelectionHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AppLogo(
              width: 48,
              height: 48,
              errorIconSize: 44,
            ),
            const SizedBox(width: 12),
            AppBrandName(
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          l10n.selectLanguage,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        AppBrandName.replaceInText(
          context,
          text: l10n.languageSelectionSubtitle(l10n.platformAppDisplayName),
          brandName: l10n.platformAppDisplayName,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: cs.onSurfaceVariant,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}

class _TabletSplitBody extends StatelessWidget {
  const _TabletSplitBody({
    required this.searchController,
    required this.filteredLanguages,
    required this.selectedCode,
    required this.suggestedCode,
    required this.saving,
    required this.selectedName,
    required this.onSelect,
    required this.onContinue,
  });

  final TextEditingController searchController;
  final List<AppLanguageOption> filteredLanguages;
  final String selectedCode;
  final String suggestedCode;
  final bool saving;
  final String selectedName;
  final ValueChanged<AppLanguageOption> onSelect;
  final VoidCallback onContinue;

  double _sidebarWidth(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (OnboardingLayout.isLandscape(context)) {
      return (width * 0.30).clamp(280.0, 420.0);
    }
    return (width * 0.36).clamp(260.0, 340.0);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = context.l10n;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: _sidebarWidth(context),
          child: ColoredBox(
            color: cs.surfaceContainerLow,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: const _LanguageSelectionHeader(),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(28, 24, 28, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      LanguagePickerSearchField(
                        controller: searchController,
                        hint: l10n.searchLanguages,
                        useFixedSizes: true,
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: LanguagePickerListCard(
                          useFixedSizes: true,
                          child: LanguagePickerTabletGrid(
                            languages: filteredLanguages,
                            selectedCode: selectedCode,
                            suggestedCode: suggestedCode,
                            suggestedBadgeLabel: l10n.languageSuggestedBadge,
                            emptyLabel: l10n.noLanguageMatches,
                            searchQuery: searchController.text,
                            noMatchesForQueryLabel:
                                l10n.noLanguageMatchesForQuery,
                            onSelect: onSelect,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              OnboardingBottomActionBar(
                title: l10n.continueInLanguage(selectedName),
                loading: saving,
                onPressed: saving ? null : onContinue,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
