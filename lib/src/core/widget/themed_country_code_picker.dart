import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:hotel/src/core/utils/searchable_country_code_picker_list.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:hotel/src/core/widget/app_search_icon.dart';

/// Opens a themed country-code picker sheet matching other app bottom sheets.
Future<CountryCode?> showThemedCountryCodePickerSheet({
  required BuildContext context,
  CountryCode? selected,
  List<String> favorites = const [
    'NP',
    'IN',
    'US',
    'GB',
    'AE',
    'SA',
    'QA',
    'KW',
    'BH',
    'OM',
    'AU',
    'DE',
    'FR',
    'IT',
    'ES',
  ],
}) {
  return showAppBottomSheet<CountryCode>(
    context: context,
    title: 'Select country code',
    scrollableBody: true,
    maxHeightFactor: 0.75,
    child: _CountryCodePickerSheetBody(
      selected: selected,
      favorites: favorites,
    ),
  );
}

class ThemedCountryCodePickerField extends StatelessWidget {
  const ThemedCountryCodePickerField({
    super.key,
    required this.countryCode,
    required this.onChanged,
    this.favorites = const [
      'NP',
      'IN',
      'US',
      'GB',
      'AE',
      'SA',
      'QA',
      'KW',
      'BH',
      'OM',
      'AU',
      'DE',
      'FR',
      'IT',
      'ES',
    ],
  });

  final CountryCode countryCode;
  final ValueChanged<CountryCode> onChanged;
  final List<String> favorites;

  Future<void> _openSheet(BuildContext context) async {
    final picked = await showThemedCountryCodePickerSheet(
      context: context,
      selected: countryCode,
      favorites: favorites,
    );
    if (picked != null) {
      onChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final dial = countryCode.dialCode ?? '';
    final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: -0.2,
        );

    return InkWell(
      onTap: () => _openSheet(context),
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: Image.asset(
                countryCode.flagUri!,
                package: 'country_code_picker',
                width: 20,
                height: 14,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                dial,
                style: textStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              size: 22,
              color: scheme.outline,
            ),
          ],
        ),
      ),
    );
  }
}

class _CountryCodePickerSheetBody extends StatefulWidget {
  const _CountryCodePickerSheetBody({
    required this.selected,
    required this.favorites,
  });

  final CountryCode? selected;
  final List<String> favorites;

  @override
  State<_CountryCodePickerSheetBody> createState() =>
      _CountryCodePickerSheetBodyState();
}

class _CountryCodePickerSheetBodyState extends State<_CountryCodePickerSheetBody> {
  late List<CountryCode> _allCountries;
  late List<CountryCode> _favoriteCountries;
  late List<CountryCode> _filteredCountries;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _allCountries = searchableCountryCodePickerList()
        .map((json) => CountryCode.fromJson(json))
        .toList();
    _favoriteCountries = _allCountries.where(_isFavoriteCountry).toList();
    _filteredCountries = _allCountries;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _allCountries =
        _allCountries.map((country) => country.localize(context)).toList();
    _favoriteCountries =
        _favoriteCountries.map((country) => country.localize(context)).toList();
    _filterCountries(_searchController.text);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_onSearchChanged)
      ..dispose();
    super.dispose();
  }

  void _onSearchChanged() => _filterCountries(_searchController.text);

  bool _isFavoriteCountry(CountryCode item) {
    for (final criteria in widget.favorites) {
      if (item.code!.toUpperCase() == criteria.toUpperCase() ||
          item.dialCode == criteria ||
          item.name!.toUpperCase() == criteria.toUpperCase()) {
        return true;
      }
    }
    return false;
  }

  void _filterCountries(String query) {
    final normalized = query.trim().toUpperCase();
    setState(() {
      if (normalized.isEmpty) {
        _filteredCountries = _allCountries;
        return;
      }
      _filteredCountries = _allCountries
          .where(
            (country) =>
                country.code!.contains(normalized) ||
                country.dialCode!.contains(normalized) ||
                country.name!.toUpperCase().contains(normalized),
          )
          .toList();
    });
  }

  bool _isSelected(CountryCode country) {
    final selected = widget.selected;
    if (selected == null) return false;
    return selected.code == country.code;
  }

  InputDecoration _searchDecoration(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InputDecoration(
      hintText: 'Search country or dial code',
      isDense: true,
      filled: true,
      fillColor: scheme.surfaceContainerHighest,
      prefixIcon: AppSearchIcon.inputDecoration(size: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: scheme.outlineVariant),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: scheme.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: scheme.primary),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }

  Widget _buildCountryRow(CountryCode country) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final selected = _isSelected(country);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: Image.asset(
          country.flagUri!,
          package: 'country_code_picker',
          width: 28,
          height: 20,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        country.toLongString(),
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: selected
          ? Icon(Icons.check_circle, color: scheme.primary)
          : Icon(Icons.radio_button_unchecked, color: scheme.outlineVariant),
      onTap: () => Navigator.pop(context, country),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final showFavorites =
        _searchController.text.trim().isEmpty && _favoriteCountries.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _searchController,
          style: theme.textTheme.bodyLarge,
          decoration: _searchDecoration(context),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: _filteredCountries.isEmpty
              ? Center(
                  child: Text(
                    'No country found',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                )
              : ListView(
                  children: [
                    if (showFavorites) ...[
                      ..._favoriteCountries.map(_buildCountryRow),
                      const Divider(height: 24),
                    ],
                    ..._filteredCountries.map(_buildCountryRow),
                  ],
                ),
        ),
      ],
    );
  }
}
