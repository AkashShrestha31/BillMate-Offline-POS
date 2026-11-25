import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/l10n/app_language_list_sorter.dart';
import 'package:hotel/src/core/l10n/app_language_option.dart';
import 'package:hotel/src/core/l10n/app_language_suggestion.dart';
import 'package:hotel/src/core/l10n/app_locale_service.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/services/token_storage.dart';
import 'package:hotel/src/features/onboarding/domain/app_walkthrough_storage.dart';
import 'package:hotel/src/features/onboarding/presentation/layout/onboarding_layout.dart';
import 'package:hotel/src/features/onboarding/presentation/widgets/language_selection_mobile_layout.dart';
import 'package:hotel/src/features/onboarding/presentation/widgets/language_selection_tablet_layout.dart';
import 'package:hotel/src/features/setup/presentation/setup_navigation.dart';

@RoutePage()
class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({super.key});

  @override
  State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  final _localeService = getIt<AppLocaleService>();
  final _searchController = TextEditingController();

  late String _selectedCode;
  late final String _suggestedCode;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _suggestedCode = AppLanguageSuggestion.resolve(
      deviceLocale: AppLanguageSuggestion.deviceLocale(),
      supportedLanguageCodes: _localeService.languages.map((l) => l.code),
    );
    if (!_localeService.hasSavedPreference) {
      _selectedCode = _suggestedCode;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _localeService.previewLanguage(_suggestedCode);
      });
    } else {
      _selectedCode = _localeService.languageCode;
    }
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<AppLanguageOption> get _filteredLanguages {
    final query = _searchController.text;
    final filtered = _localeService.languages
        .where((option) => option.matchesQuery(query))
        .toList();
    return sortLanguageOptionsByTable(
      options: filtered,
      tableOrder: _localeService.languages,
      suggestedCode: _suggestedCode,
    );
  }

  AppLanguageOption? get _selectedOption {
    for (final option in _localeService.languages) {
      if (option.code == _selectedCode) return option;
    }
    return null;
  }

  Future<void> _onContinue() async {
    if (_saving) return;
    setState(() => _saving = true);
    try {
      await _localeService.updateLanguage(_selectedCode);
      if (!mounted) return;
      await _navigateNext();
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _navigateNext() async {
    final needsWalkthrough = await AppWalkthroughStorage.shouldShow();
    final isLoggedIn = await TokenStorage.hasActiveSession();
    if (!mounted) return;

    if (needsWalkthrough && !isLoggedIn) {
      context.router.replace(const AppWalkthroughRoute());
      return;
    }

    await navigateAfterOnboarding(context.router);
  }

  void _selectLanguage(AppLanguageOption option) {
    if (_selectedCode == option.code) return;
    setState(() => _selectedCode = option.code);
    _localeService.previewLanguage(option.code);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final selectedName =
        _selectedOption?.nativeName ?? _selectedOption?.name ?? l10n.language;

    final layoutProps = (
      searchController: _searchController,
      filteredLanguages: _filteredLanguages,
      selectedCode: _selectedCode,
      suggestedCode: _suggestedCode,
      saving: _saving,
      selectedName: selectedName,
      onSelect: _selectLanguage,
      onContinue: _onContinue,
    );

    if (OnboardingLayout.isTablet(context)) {
      return LanguageSelectionTabletLayout(
        searchController: layoutProps.searchController,
        filteredLanguages: layoutProps.filteredLanguages,
        selectedCode: layoutProps.selectedCode,
        suggestedCode: layoutProps.suggestedCode,
        saving: layoutProps.saving,
        selectedName: layoutProps.selectedName,
        onSelect: layoutProps.onSelect,
        onContinue: layoutProps.onContinue,
      );
    }

    return LanguageSelectionMobileLayout(
      searchController: layoutProps.searchController,
      filteredLanguages: layoutProps.filteredLanguages,
      selectedCode: layoutProps.selectedCode,
      suggestedCode: layoutProps.suggestedCode,
      saving: layoutProps.saving,
      selectedName: layoutProps.selectedName,
      onSelect: layoutProps.onSelect,
      onContinue: layoutProps.onContinue,
    );
  }
}
