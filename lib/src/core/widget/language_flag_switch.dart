import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/l10n/app_language_flag.dart';
import 'package:hotel/src/core/l10n/app_locale_service.dart';
import 'package:hotel/src/core/widget/language_searchable_bottom_sheet.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/layout/device_layout.dart';

/// Compact language picker chip with flag emoji — for onboarding headers.
class LanguageFlagSwitch extends StatelessWidget {
  const LanguageFlagSwitch({super.key});

  Future<void> _openPicker(BuildContext context, AppLocaleService service) async {
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
    } catch (_) {
      service.previewLanguage(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    final service = getIt<AppLocaleService>();
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return ListenableBuilder(
      listenable: service,
      builder: (context, _) {
        final code = service.languageCode.toUpperCase();
        final flag = AppLanguageFlag.emoji(service.languageCode);
        final isTablet = DeviceLayout.isTablet(context);

        return InkWell(
          onTap: () => _openPicker(context, service),
          child: Padding(
            padding: isTablet
                ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8)
                : EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  flag,
                  style: AppFonts.interStyle(fontSize: isTablet ? 18 : 16.sp),
                ),
                SizedBox(width: isTablet ? 8 : 6.w),
                Text(
                  code,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                    fontSize: isTablet ? 14 : null,
                  ),
                ),
                SizedBox(width: isTablet ? 4 : 2.w),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: isTablet ? 20 : 18.sp,
                  color: cs.onSurfaceVariant,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
