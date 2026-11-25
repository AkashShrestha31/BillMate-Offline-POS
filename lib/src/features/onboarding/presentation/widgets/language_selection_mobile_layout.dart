import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/l10n/app_language_option.dart';
import 'package:hotel/src/core/widget/app_brand_name.dart';
import 'package:hotel/src/core/widget/app_logo.dart';
import 'package:hotel/src/core/widget/language_picker_widgets.dart';
import 'package:hotel/src/features/onboarding/presentation/widgets/onboarding_action_widgets.dart';
import 'package:hotel/src/core/l10n/platform_app_localizations.dart';

class LanguageSelectionMobileLayout extends StatelessWidget {
  const LanguageSelectionMobileLayout({
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
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: cs.surfaceContainerLow,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 20.h, 12.w, 0),
              child: Row(
                children: [
                  AppLogo(
                    width: 36.w,
                    height: 36.w,
                    errorIconSize: 32.sp,
                  ),
                  SizedBox(width: 10.w),
                  AppBrandName(
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 24.h, 12.w, 0),
              child: Text(
                l10n.selectLanguage,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 0),
              child: AppBrandName.replaceInText(
                context,
                text: l10n.languageSelectionSubtitle(l10n.platformAppDisplayName),
                brandName: l10n.platformAppDisplayName,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: cs.onSurfaceVariant,
                  height: 1.45,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 20.h, 12.w, 0),
              child: LanguagePickerSearchField(
                controller: searchController,
                hint: l10n.searchLanguages,
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: LanguagePickerListCard(
                  child: LanguagePickerList(
                    languages: filteredLanguages,
                    selectedCode: selectedCode,
                    onSelect: onSelect,
                    suggestedCode: suggestedCode,
                    suggestedBadgeLabel: l10n.languageSuggestedBadge,
                    emptyLabel: l10n.noLanguageMatches,
                    searchQuery: searchController.text,
                    noMatchesForQueryLabel: l10n.noLanguageMatchesForQuery,
                  ),
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
    );
  }
}
