import 'package:flutter/material.dart';
import 'package:hotel/src/core/extensions/extensions/localization_extension.dart';
import 'package:hotel/src/features/settings/presentation/data/legal_content.dart';
import 'package:hotel/src/features/settings/presentation/pages/legal_document_page.dart';
import 'package:hotel/src/core/l10n/platform_app_localizations.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appName = context.l10n.platformAppDisplayName;
    return LegalDocumentPage(
      title: context.l10n.termsAndConditions,
      lastUpdated: LegalContent.lastUpdatedLabel,
      intro: LegalContent.termsIntro(appName),
      sections: LegalContent.termsOfService(appName),
    );
  }
}
