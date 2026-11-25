import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/l10n/app_language_list_sorter.dart';
import 'package:hotel/src/core/l10n/app_language_option.dart';
import 'package:hotel/src/core/l10n/app_language_suggestion.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:hotel/src/core/widget/language_picker_tablet_grid.dart';
import 'package:hotel/src/core/widget/language_picker_widgets.dart';
import 'package:hotel/src/core/layout/device_layout.dart';

class LanguageSearchableBottomSheet extends StatefulWidget {
  const LanguageSearchableBottomSheet({
    super.key,
    required this.searchHint,
    required this.languages,
    required this.currentCode,
    this.useFixedSizes = false,
  });

  final String searchHint;
  final List<AppLanguageOption> languages;
  final String? currentCode;
  final bool useFixedSizes;

  @override
  State<LanguageSearchableBottomSheet> createState() =>
      _LanguageSearchableBottomSheetState();
}

class _LanguageSearchableBottomSheetState
    extends State<LanguageSearchableBottomSheet> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  late final String _suggestedCode = AppLanguageSuggestion.resolve(
    deviceLocale: AppLanguageSuggestion.deviceLocale(),
    supportedLanguageCodes: widget.languages.map((l) => l.code),
  );

  List<AppLanguageOption> get _filtered {
    final q = _searchController.text;
    final filtered = widget.languages.where((l) => l.matchesQuery(q)).toList();
    return sortLanguageOptionsByTable(
      options: filtered,
      tableOrder: widget.languages,
      suggestedCode: _suggestedCode,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final selectedCode = widget.currentCode ?? '';
    final fixed = widget.useFixedSizes;
    final gap = fixed ? 12.0 : 12.h;

    final list = widget.useFixedSizes
        ? LanguagePickerTabletGrid(
            languages: _filtered,
            selectedCode: selectedCode,
            suggestedCode: _suggestedCode,
            suggestedBadgeLabel: l10n.languageSuggestedBadge,
            emptyLabel: l10n.noLanguageMatches,
            searchQuery: _searchController.text,
            noMatchesForQueryLabel: l10n.noLanguageMatchesForQuery,
            onSelect: (option) => Navigator.pop(context, option.code),
          )
        : LanguagePickerList(
            languages: _filtered,
            selectedCode: selectedCode,
            onSelect: (option) => Navigator.pop(context, option.code),
            suggestedCode: _suggestedCode,
            suggestedBadgeLabel: l10n.languageSuggestedBadge,
            emptyLabel: l10n.noLanguageMatches,
            searchQuery: _searchController.text,
            noMatchesForQueryLabel: l10n.noLanguageMatchesForQuery,
            centerEmptyMessage: true,
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LanguagePickerSearchField(
          controller: _searchController,
          hint: widget.searchHint,
          useFixedSizes: fixed,
        ),
        SizedBox(height: gap),
        Expanded(
          child: LanguagePickerListCard(
            useFixedSizes: fixed,
            child: list,
          ),
        ),
      ],
    );
  }
}

Future<String?> showLanguagePickerBottomSheet({
  required BuildContext context,
  required String title,
  required String searchHint,
  required List<AppLanguageOption> languages,
  required String? currentCode,
}) {
  if (DeviceLayout.isTablet(context)) {
    return _showLanguagePickerTabletOverlay(
      context: context,
      title: title,
      searchHint: searchHint,
      languages: languages,
      currentCode: currentCode,
    );
  }

  return showAppBottomSheet<String>(
    context: context,
    title: title,
    maxHeightFactor: 0.82,
    scrollableBody: true,
    child: LanguageSearchableBottomSheet(
      searchHint: searchHint,
      languages: languages,
      currentCode: currentCode,
    ),
  );
}

Future<String?> _showLanguagePickerTabletOverlay({
  required BuildContext context,
  required String title,
  required String searchHint,
  required List<AppLanguageOption> languages,
  required String? currentCode,
}) {
  return showGeneralDialog<String>(
    context: context,
    barrierDismissible: true,
    barrierLabel: title,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (dialogContext, animation, secondaryAnimation) {
      return const SizedBox.shrink();
    },
    transitionBuilder: (dialogContext, animation, secondaryAnimation, child) {
      final size = MediaQuery.sizeOf(dialogContext);
      final isLandscape = size.width > size.height;
      final horizontalInset = isLandscape ? 32.0 : 28.0;
      final width = size.width - horizontalInset * 2;
      final height = size.height * (isLandscape ? 0.78 : 0.84);
      final theme = Theme.of(dialogContext);

      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.97, end: 1).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          ),
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: width,
                height: height,
                decoration: AppBottomSheetTheme.sheetDecoration(dialogContext),
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          icon: const Icon(Icons.close, size: 22),
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(height: 1),
                    const SizedBox(height: 16),
                    Expanded(
                      child: LanguageSearchableBottomSheet(
                        searchHint: searchHint,
                        languages: languages,
                        currentCode: currentCode,
                        useFixedSizes: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
