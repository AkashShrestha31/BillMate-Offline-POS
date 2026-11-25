import 'package:flutter/material.dart';
import 'package:hotel/l10n/app_localizations.dart';
import 'package:hotel/src/core/widget/app_search_icon.dart';
import 'package:hotel/src/features/org/domain/country_tax_profile.dart';
import 'package:hotel/src/features/org/domain/country_tax_rate_picker.dart';
import 'package:hotel/src/features/org/domain/invoice_tax_kind.dart';

class TaxIdLabelOption {
  const TaxIdLabelOption({required this.country, required this.label});

  final String country;
  final String label;

  String get subtitle => label;
}

abstract final class TaxIdLabelCatalog {
  static List<TaxIdLabelOption> all({InvoiceTaxKind kind = InvoiceTaxKind.vat}) {
    final options = <TaxIdLabelOption>[];
    for (final profile in CountryTaxProfiles.allProfiles) {
      for (final label in profile.tinLabelsFor(kind)) {
        options.add(TaxIdLabelOption(country: profile.country, label: label));
      }
    }
    options.sort((a, b) {
      final c = a.country.compareTo(b.country);
      if (c != 0) return c;
      return a.label.compareTo(b.label);
    });
    return options;
  }

  static List<TaxIdLabelOption> forCountry(
    String country, {
    InvoiceTaxKind kind = InvoiceTaxKind.vat,
  }) {
    final profile = CountryTaxProfiles.of(country);
    final labels = profile.tinLabelsFor(kind);
    return labels
        .map((label) => TaxIdLabelOption(country: country, label: label))
        .toList(growable: false);
  }
}

Future<String?> showTaxIdLabelPickerBottomSheet(
  BuildContext context, {
  required String currentLabel,
  String? country,
  InvoiceTaxKind taxKind = InvoiceTaxKind.vat,
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) {
      final maxHeight = MediaQuery.sizeOf(ctx).height * 0.85;
      final bottomInset = MediaQuery.viewInsetsOf(ctx).bottom;
      return Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: SafeArea(
            top: false,
            child: TaxIdLabelPickerSheet(
              currentLabel: currentLabel,
              country: country,
              taxKind: taxKind,
            ),
          ),
        ),
      );
    },
  );
}

class TaxIdLabelPickerSheet extends StatefulWidget {
  const TaxIdLabelPickerSheet({
    super.key,
    required this.currentLabel,
    this.country,
    this.taxKind = InvoiceTaxKind.vat,
  });

  final String currentLabel;
  final String? country;
  final InvoiceTaxKind taxKind;

  @override
  State<TaxIdLabelPickerSheet> createState() => _TaxIdLabelPickerSheetState();
}

class _TaxIdLabelPickerSheetState extends State<TaxIdLabelPickerSheet> {
  late final TextEditingController _searchController;
  late final List<TaxIdLabelOption> _options;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(() => setState(() {}));
    final country = widget.country?.trim();
    _options = (country != null && country.isNotEmpty)
        ? TaxIdLabelCatalog.forCountry(country, kind: widget.taxKind)
        : TaxIdLabelCatalog.all(kind: widget.taxKind);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<TaxIdLabelOption> get _filtered {
    final q = _searchController.text.trim().toLowerCase();
    if (q.isEmpty) return _options;
    return _options
        .where(
          (o) =>
              o.country.toLowerCase().contains(q) ||
              o.label.toLowerCase().contains(q),
        )
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final filtered = _filtered;
    final screenHeight = MediaQuery.sizeOf(context).height;
    // Cap list height so short lists wrap; long lists scroll.
    final maxListHeight = screenHeight * 0.55;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        Center(
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: scheme.outlineVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 12, 4),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  l10n.taxIdLabel,
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
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
          child: Text(
            l10n.taxIdLabelPickerSubtitle,
            style: theme.textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: l10n.searchCountryOrLabel,
              prefixIcon: AppSearchIcon.inputDecoration(
                color: scheme.onSurfaceVariant,
              ),
              filled: true,
              fillColor: scheme.surfaceContainerHighest,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        if (filtered.isEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
            child: Center(
              child: Text(
                l10n.noSearchResults,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
          )
        else
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxListHeight),
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 12),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => Divider(
                height: 1,
                color: scheme.outlineVariant.withValues(alpha: 0.5),
              ),
              itemBuilder: (context, index) {
                final option = filtered[index];
                final selected = option.label == widget.currentLabel;
                return ListTile(
                  title: Text(
                    option.country,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight:
                          selected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(option.subtitle),
                  trailing: selected
                      ? Icon(Icons.check, color: scheme.primary)
                      : null,
                  onTap: () => Navigator.pop(context, option.label),
                );
              },
            ),
          ),
      ],
    );
  }
}
