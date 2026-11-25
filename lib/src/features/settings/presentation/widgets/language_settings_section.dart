import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/l10n/app_locale_service.dart';
import 'package:hotel/src/core/widget/language_searchable_bottom_sheet.dart';
import 'package:hotel/src/features/dashboard/presentation/widgets/more_settings_widgets.dart';

/// More page: app UI language (JSON translations + Flutter l10n).
class LanguageSettingsSection extends StatelessWidget {
  const LanguageSettingsSection({super.key, this.embedded = false});

  final bool embedded;

  @override
  Widget build(BuildContext context) {
    final service = getIt<AppLocaleService>();
    return ListenableBuilder(
      listenable: service,
      builder: (context, _) {
        final theme = context.theme;
        final current = service.currentLanguage;
        final subtitle = current?.fieldLabel ?? service.languageCode;

        final tile = ListTile(
          contentPadding: MoreSettingsLayout.tilePadding(context),
          leading: const MoreIconBox(icon: Icons.translate_rounded),
          title: Text(
            context.l10n.selectLanguage,
            style: MoreSettingsLayout.tileTitle(theme),
          ),
          subtitle: Text(
            subtitle,
            style: MoreSettingsLayout.tileSubtitle(theme),
          ),
          trailing: Icon(
            Icons.chevron_right,
            size: MoreSettingsLayout.chevronSize(context),
            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          ),
          onTap: () => _showLanguageSheet(context, service),
        );

        if (embedded) return tile;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4.w),
              child: Text(
                context.l10n.language,
                style: MoreSettingsLayout.sectionLabel(theme),
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8.sp),
              ),
              child: tile,
            ),
          ],
        );
      },
    );
  }

  Future<void> _showLanguageSheet(
    BuildContext context,
    AppLocaleService service,
  ) async {
    final selected = await showLanguagePickerBottomSheet(
      context: context,
      title: context.l10n.selectLanguage,
      searchHint: context.l10n.searchLanguages,
      languages: service.languages,
      currentCode: service.languageCode,
    );

    if (selected == null ||
        selected == service.languageCode ||
        !context.mounted) {
      return;
    }

    try {
      await service.updateLanguage(selected);
      if (!context.mounted) return;
      final name = service.currentLanguage?.name ?? selected;
      context.showKiiSnackBarSuccess(
        context.l10n.languageUpdated(name),
      );
    } catch (e) {
      if (!context.mounted) return;
      context.showKiiSnackBarError(
        context.l10n.languageUpdateFailed(e.toString()),
      );
    }
  }
}
