import 'package:flutter/material.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/widget/pdf_export_option_tile.dart';
import 'package:hotel/src/core/widget/app_search_icon.dart';

class SearchableSelectBottomSheet extends StatefulWidget {
  const SearchableSelectBottomSheet({
    super.key,
    required this.title,
    required this.searchHint,
    required this.options,
    required this.currentValue,
  });

  final String title;
  final String searchHint;

  /// `key` is the returned value. `value` is the displayed label.
  final List<MapEntry<String, String>> options;
  final String? currentValue;

  @override
  State<SearchableSelectBottomSheet> createState() =>
      _SearchableSelectBottomSheetState();
}

class _SearchableSelectBottomSheetState
    extends State<SearchableSelectBottomSheet> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  List<MapEntry<String, String>> get _filtered {
    final q = _searchController.text.trim().toLowerCase();
    if (q.isEmpty) return widget.options;
    return widget.options
        .where(
          (e) =>
              e.key.toLowerCase().contains(q) ||
              e.value.toLowerCase().contains(q),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final filtered = _filtered;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.title,
            style: theme.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          verticalMarginSmall,
          const Divider(),
          verticalMarginMedium,
          TextField(
            controller: _searchController,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: widget.searchHint,
              prefixIcon: AppSearchIcon.inputDecoration( color: scheme.onSurfaceVariant),
              suffixIcon: _searchController.text.isEmpty
                  ? null
                  : IconButton(
                      tooltip: 'Clear',
                      icon: Icon(Icons.clear_rounded,
                          color: scheme.onSurfaceVariant),
                      onPressed: () => _searchController.clear(),
                    ),
              filled: true,
              fillColor: scheme.surfaceContainerHighest.withOpacity(0.35),
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
          verticalMarginMedium,
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
                    padding: const EdgeInsets.only(bottom: 8),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 4),
                    itemBuilder: (context, index) {
                      final e = filtered[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: PdfExportOptionTile(
                          icon: widget.currentValue == e.key
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          title: e.value,
                          color: widget.currentValue == e.key
                              ? Colors.green
                              : null,
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            Navigator.pop(context, e.key);
                          },
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
