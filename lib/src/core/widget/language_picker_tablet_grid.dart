import 'package:flutter/material.dart';
import 'package:hotel/src/core/l10n/app_language_flag.dart';
import 'package:hotel/src/core/l10n/app_language_option.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

/// Grid of language tiles for tablet / iPad pickers and selection screens.
class LanguagePickerTabletGrid extends StatelessWidget {
  const LanguagePickerTabletGrid({
    super.key,
    required this.languages,
    required this.selectedCode,
    required this.onSelect,
    this.suggestedCode = 'en',
    this.suggestedBadgeLabel = 'SUGGESTED',
    this.emptyLabel = 'No matches',
    this.searchQuery,
    this.noMatchesForQueryLabel,
  });

  final List<AppLanguageOption> languages;
  final String selectedCode;
  final ValueChanged<AppLanguageOption> onSelect;
  final String suggestedCode;
  final String suggestedBadgeLabel;
  final String emptyLabel;
  final String? searchQuery;
  final String Function(String query)? noMatchesForQueryLabel;

  static int columnCount(double width) {
    if (width >= 1100) return 4;
    if (width >= 760) return 3;
    return 2;
  }

  static double aspectRatio(int columns) {
    return switch (columns) {
      4 => 4.2,
      3 => 3.8,
      _ => 3.2,
    };
  }

  @override
  Widget build(BuildContext context) {
    if (languages.isEmpty) {
      final query = searchQuery?.trim() ?? '';
      final message = query.isNotEmpty && noMatchesForQueryLabel != null
          ? noMatchesForQueryLabel!(query)
          : emptyLabel;

      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = columnCount(constraints.maxWidth);

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: aspectRatio(columns),
          ),
          itemCount: languages.length,
          itemBuilder: (context, index) {
            final option = languages[index];
            return LanguagePickerTabletGridTile(
              option: option,
              selected: option.code == selectedCode,
              showSuggestedBadge: option.code == suggestedCode,
              suggestedBadgeLabel: suggestedBadgeLabel,
              onTap: () => onSelect(option),
            );
          },
        );
      },
    );
  }
}

class LanguagePickerTabletGridTile extends StatelessWidget {
  const LanguagePickerTabletGridTile({
    super.key,
    required this.option,
    required this.selected,
    required this.onTap,
    this.showSuggestedBadge = false,
    this.suggestedBadgeLabel = 'SUGGESTED',
  });

  final AppLanguageOption option;
  final bool selected;
  final VoidCallback onTap;
  final bool showSuggestedBadge;
  final String suggestedBadgeLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Material(
      color: selected ? cs.primary.withValues(alpha: 0.08) : cs.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected
                  ? cs.primary.withValues(alpha: 0.45)
                  : cs.outlineVariant.withValues(alpha: 0.5),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: selected
                      ? cs.primary.withValues(alpha: 0.14)
                      : cs.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  AppLanguageFlag.emoji(option.code),
                  style: AppFonts.interStyle(fontSize: 20),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            option.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (showSuggestedBadge) ...[
                          const SizedBox(width: 4),
                          LanguagePickerSuggestedBadge(label: suggestedBadgeLabel),
                        ],
                      ],
                    ),
                    Text(
                      option.nativeName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                selected ? Icons.check_circle_rounded : Icons.circle_outlined,
                size: 20,
                color: selected ? cs.primary : cs.outlineVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguagePickerSuggestedBadge extends StatelessWidget {
  const LanguagePickerSuggestedBadge({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: cs.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: cs.primary,
              fontSize: 9,
              letterSpacing: 0.3,
            ),
      ),
    );
  }
}
