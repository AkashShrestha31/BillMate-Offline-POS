import 'package:flutter/material.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/widget/app_search_icon.dart';
import 'package:hotel/src/features/org/domain/organization_business_type.dart';

class BusinessTypeSearchableBottomSheet extends StatefulWidget {
  const BusinessTypeSearchableBottomSheet({
    super.key,
    required this.title,
    required this.searchHint,
    required this.currentCode,
  });

  final String title;
  final String searchHint;
  final String currentCode;

  @override
  State<BusinessTypeSearchableBottomSheet> createState() =>
      _BusinessTypeSearchableBottomSheetState();
}

class _BusinessTypeSearchableBottomSheetState
    extends State<BusinessTypeSearchableBottomSheet> {
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

  List<String> get _filtered {
    final q = _searchController.text.trim().toLowerCase();
    final l10n = context.l10n;
    if (q.isEmpty) return OrganizationBusinessType.all;
    return OrganizationBusinessType.all.where((code) {
      final label = l10n.businessTypeLabel(code).toLowerCase();
      final subtitle = l10n.businessTypeSubtitle(code).toLowerCase();
      return label.contains(q) ||
          subtitle.contains(q) ||
          code.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final l10n = context.l10n;
    final filtered = _filtered;
    final selectedCode = OrganizationBusinessType.normalize(widget.currentCode);

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
                      final code = filtered[index];
                      final isSelected = selectedCode == code;
                      return ListTile(
                        onTap: () => Navigator.pop(context, code),
                        leading: Icon(
                          OrganizationBusinessType.iconFor(code),
                          color: scheme.primary,
                          size: 24,
                        ),
                        title: Text(
                          l10n.businessTypeLabel(code),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight:
                                isSelected ? FontWeight.w700 : FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          l10n.businessTypeSubtitle(code),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                        trailing: isSelected
                            ? Icon(Icons.check_circle, color: scheme.primary)
                            : null,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

Future<String?> showBusinessTypePickerBottomSheet(
  BuildContext context, {
  required String currentCode,
}) {
  final l10n = context.l10n;
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
            child: BusinessTypeSearchableBottomSheet(
              title: l10n.selectBusinessType,
              searchHint: l10n.search,
              currentCode: currentCode,
            ),
          ),
        ),
      );
    },
  );
}
