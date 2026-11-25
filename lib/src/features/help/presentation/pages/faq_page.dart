import 'package:flutter/material.dart';
import 'package:hotel/l10n/app_localizations.dart';
import 'package:hotel/src/core/extensions/extensions/localization_extension.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/app_brand_name.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/l10n/platform_app_localizations.dart';

class _FaqEntry {
  const _FaqEntry({
    required this.question,
    required this.answer,
    this.brandInQuestion = false,
    this.brandInAnswer = false,
  });

  final String question;
  final String answer;
  final bool brandInQuestion;
  final bool brandInAnswer;
}

class _FaqSection {
  const _FaqSection({required this.title, required this.entries});

  final String title;
  final List<_FaqEntry> entries;
}

/// In-app FAQ — content mirrors `docs/FAQ.md`.
class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  List<_FaqSection> _sections(AppLocalizations l) {
    return [
      _FaqSection(
        title: l.faqSectionGettingStarted,
        entries: [
          _FaqEntry(
            question: l.whatIsApp(l.platformAppDisplayName),
            answer: l.appDescriptionFaq(l.platformAppDisplayName),
            brandInQuestion: true,
            brandInAnswer: true,
          ),
          _FaqEntry(
            question: l.faqNeedInternetQuestion,
            answer: l.faqNeedInternetAnswer,
          ),
          _FaqEntry(
            question: l.faqFirstInstallQuestion,
            answer: l.faqFirstInstallAnswer,
          ),
        ],
      ),
      _FaqSection(
        title: l.faqSectionLogin,
        entries: [
          _FaqEntry(
            question: l.faqSignInCredentialsQuestion,
            answer: l.faqSignInCredentialsAnswer,
          ),
          _FaqEntry(
            question: l.faqLoggedOutQuestion,
            answer: l.faqLoggedOutAnswer,
          ),
        ],
      ),
      _FaqSection(
        title: l.faqSectionNavigation,
        entries: [
          _FaqEntry(
            question: l.faqBottomTabsQuestion,
            answer: l.faqBottomTabsAnswer,
          ),
        ],
      ),
      _FaqSection(
        title: l.faqSectionInvoices,
        entries: [
          _FaqEntry(
            question: l.faqCreateInvoiceQuestion,
            answer: l.faqCreateInvoiceAnswer,
          ),
          _FaqEntry(
            question: l.faqInvoiceDetailsQuestion,
            answer: l.faqInvoiceDetailsAnswer,
          ),
          _FaqEntry(
            question: l.faqZeroRateQuestion,
            answer: l.faqZeroRateAnswer,
          ),
        ],
      ),
      _FaqSection(
        title: l.faqSectionPayments,
        entries: [
          _FaqEntry(
            question: l.faqPartialPaymentQuestion,
            answer: l.faqPartialPaymentAnswer,
          ),
          _FaqEntry(
            question: l.faqMultiplePaymentQuestion,
            answer: l.faqMultiplePaymentAnswer,
          ),
          _FaqEntry(
            question: l.faqSplitPaymentSavedQuestion,
            answer: l.faqSplitPaymentSavedAnswer,
          ),
        ],
      ),
      _FaqSection(
        title: l.faqSectionItemsStock,
        entries: [
          _FaqEntry(
            question: l.faqAddItemQuestion,
            answer: l.faqAddItemAnswer,
          ),
          _FaqEntry(
            question: l.faqCustomUnitQuestion,
            answer: l.faqCustomUnitAnswer,
          ),
          _FaqEntry(
            question: l.faqStockQuantitiesQuestion,
            answer: l.faqStockQuantitiesAnswer,
          ),
        ],
      ),
      _FaqSection(
        title: l.faqSectionProfileEmployees,
        entries: [
          _FaqEntry(
            question: l.faqProfileNameQuestion,
            answer: l.faqProfileNameAnswer,
          ),
        ],
      ),
      _FaqSection(
        title: l.faqSectionDashboardReports,
        entries: [
          _FaqEntry(
            question: l.faqRevenueDetailsQuestion,
            answer: l.faqRevenueDetailsAnswer,
          ),
          _FaqEntry(
            question: l.faqOtherReportsQuestion,
            answer: l.faqOtherReportsAnswer,
          ),
        ],
      ),
      _FaqSection(
        title: l.faqSectionPremium,
        entries: [
          _FaqEntry(
            question: l.faqPremiumWhatsIncludedQuestion,
            answer: l.faqPremiumWhatsIncludedAnswer,
          ),
          _FaqEntry(
            question: l.faqPremiumFreeTierQuestion,
            answer: l.faqPremiumFreeTierAnswer,
          ),
          _FaqEntry(
            question: l.faqPremiumRestoreQuestion,
            answer: l.faqPremiumRestoreAnswer,
          ),
          _FaqEntry(
            question: l.faqPremiumCancelQuestion,
            answer: l.faqPremiumCancelAnswer,
          ),
          _FaqEntry(
            question: l.faqDarkModeQuestion,
            answer: l.faqDarkModeAnswer,
          ),
          _FaqEntry(
            question: l.faqOpeningClosingReminderQuestion,
            answer: l.faqOpeningClosingReminderAnswer(l.platformAppDisplayName),
            brandInAnswer: true,
          ),
          _FaqEntry(
            question: l.faqPartyRolesQuestion,
            answer: l.faqPartyRolesAnswer,
          ),
          _FaqEntry(
            question: l.faqRateAppQuestion(l.platformAppDisplayName),
            answer: l.faqRateAppAnswer,
            brandInQuestion: true,
          ),
        ],
      ),
      _FaqSection(
        title: l.faqSectionSyncTroubleshooting,
        entries: [
          _FaqEntry(
            question: l.faqWhenSyncQuestion,
            answer: l.faqWhenSyncAnswer,
          ),
          _FaqEntry(
            question: l.faqFabPositionQuestion,
            answer: l.faqFabPositionAnswer,
          ),
          _FaqEntry(
            question: l.faqHowLogoutQuestion,
            answer: l.faqHowLogoutAnswer,
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final sections = _sections(l);
    return Scaffold(
      backgroundColor: scheme.surfaceContainerLow,
      appBar: AppBar(
        leading: const AppBarIosBackButton(),
        title: Text(l.faq),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: scheme.surface,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
        children: [
          AppBrandName.replaceInText(
            context,
            text: '${l.faqIntro(l.platformAppDisplayName)} ${l.faqTapToExpand}',
            brandName: l.platformAppDisplayName,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          for (final section in sections) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 4),
              child: Text(
                section.title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            ...section.entries.map((e) => _FaqTile(entry: e)),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _FaqTile extends StatelessWidget {
  const _FaqTile({required this.entry});

  final _FaqEntry entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final titleStyle = AppFonts.interStyle(
      fontWeight: FontWeight.w600,
      fontSize: 15,
      color: scheme.onSurface,
    );
    final answerStyle = AppFonts.interStyle(
      fontSize: 14,
      height: 1.45,
      color: scheme.onSurfaceVariant,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: Theme(
          data: theme.copyWith(
            dividerColor: Colors.transparent,
            splashColor: scheme.primary.withValues(alpha: 0.08),
            highlightColor: scheme.primary.withValues(alpha: 0.05),
          ),
          child: ExpansionTile(
            iconColor: scheme.onSurfaceVariant,
            collapsedIconColor: scheme.onSurfaceVariant,
            tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            title: entry.brandInQuestion
                ? AppBrandName.replaceInText(
                    context,
                    text: entry.question,
                    brandName: context.l10n.platformAppDisplayName,
                    style: titleStyle,
                  )
                : Text(entry.question, style: titleStyle),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: entry.brandInAnswer
                    ? AppBrandName.replaceInText(
                        context,
                        text: entry.answer,
                        brandName: context.l10n.platformAppDisplayName,
                        style: answerStyle,
                      )
                    : Text(entry.answer, style: answerStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
