import 'package:flutter/material.dart';
import 'package:hotel/src/core/services/currency/currency_picker_option.dart';
import 'package:hotel/src/core/widget/app_search_icon.dart';

/// Searchable list: country name, ISO code, and currency symbol.
class CurrencySearchableBottomSheet extends StatefulWidget {
  const CurrencySearchableBottomSheet({
    super.key,
    required this.title,
    required this.searchHint,
    required this.options,
    required this.currentCode,
  });

  final String title;
  final String searchHint;
  final List<CurrencyPickerOption> options;
  final String? currentCode;

  @override
  State<CurrencySearchableBottomSheet> createState() =>
      _CurrencySearchableBottomSheetState();
}

class _CurrencySearchableBottomSheetState
    extends State<CurrencySearchableBottomSheet> {
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

  List<CurrencyPickerOption> get _filtered {
    final q = _searchController.text;
    final list = widget.options.where((o) => o.matchesQuery(q)).toList();
    list.sort(CurrencyPickerOption.compareByCode);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final filtered = _filtered;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(height: 1),
          const SizedBox(height: 12),
          TextField(
            controller: _searchController,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: widget.searchHint,
              prefixIcon: AppSearchIcon.inputDecoration(
                color: scheme.onSurfaceVariant,
              ),
              suffixIcon: _searchController.text.isEmpty
                  ? null
                  : IconButton(
                      tooltip: 'Clear',
                      icon: Icon(
                        Icons.clear_rounded,
                        color: scheme.onSurfaceVariant,
                      ),
                      onPressed: () => _searchController.clear(),
                    ),
              filled: true,
              fillColor: scheme.surfaceContainerHighest.withValues(alpha: 0.35),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: scheme.outlineVariant),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: scheme.outlineVariant),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: scheme.primary, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Text(
                      'No matches',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.only(top: 4, bottom: 8),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => Divider(
                      height: 1,
                      indent: 16,
                      endIndent: 16,
                      color: scheme.outlineVariant.withValues(alpha: 0.5),
                    ),
                    itemBuilder: (context, index) {
                      final option = filtered[index];
                      final isSelected = option.code == widget.currentCode;
                      return ListTile(
                        onTap: () => Navigator.pop(context, option.code),
                        title: Text(
                          option.code,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight:
                                isSelected ? FontWeight.w700 : FontWeight.w600,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              option.displaySymbol,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: scheme.primary,
                              ),
                            ),
                            if (isSelected) ...[
                              const SizedBox(width: 8),
                              Icon(
                                Icons.check_circle,
                                color: scheme.primary,
                                size: 22,
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

Future<String?> showCurrencyPickerBottomSheet({
  required BuildContext context,
  required String title,
  required String searchHint,
  required List<CurrencyPickerOption> options,
  required String? currentCode,
}) {
  final maxHeight = MediaQuery.sizeOf(context).height * 0.75;
  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (ctx) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(ctx).bottom),
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            constraints: BoxConstraints(maxHeight: maxHeight),
            decoration: BoxDecoration(
              color: Theme.of(ctx).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: CurrencySearchableBottomSheet(
              title: title,
              searchHint: searchHint,
              options: options,
              currentCode: currentCode,
            ),
          ),
        ),
      );
    },
  );
}
