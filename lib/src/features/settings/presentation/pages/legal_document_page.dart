import 'package:flutter/material.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';

/// One section in a legal document (Privacy Policy, Terms of Service, etc.).
class LegalSection {
  const LegalSection({
    required this.title,
    required this.paragraphs,
    this.bullets,
  });

  final String title;
  final List<String> paragraphs;
  final List<String>? bullets;
}

/// Scrollable legal text with section headings.
class LegalDocumentPage extends StatelessWidget {
  const LegalDocumentPage({
    super.key,
    required this.title,
    required this.intro,
    required this.lastUpdated,
    required this.sections,
  });

  final String title;
  final String intro;
  final String lastUpdated;
  final List<LegalSection> sections;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: scheme.surfaceContainerLow,
      appBar: AppBar(
        leading: const AppBarIosBackButton(),
        title: Text(title),
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
          Text(
            lastUpdated,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            intro,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 20),
          for (final section in sections) ...[
            _SectionCard(section: section),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.section});

  final LegalSection section;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final bodyStyle = theme.textTheme.bodyMedium?.copyWith(
      height: 1.5,
      color: scheme.onSurfaceVariant,
    );
    final bulletStyle = theme.textTheme.bodyMedium?.copyWith(
      height: 1.45,
      color: scheme.onSurfaceVariant,
    );

    return Material(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              section.title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 10),
            for (final p in section.paragraphs) ...[
              Text(p, style: bodyStyle),
              const SizedBox(height: 8),
            ],
            if (section.bullets != null)
              for (final b in section.bullets!)
                Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('•  ', style: bulletStyle),
                      Expanded(child: Text(b, style: bulletStyle)),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
