import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/themes/app_theme_mode_service.dart';
import 'package:hotel/src/features/dashboard/presentation/widgets/more_settings_widgets.dart';

/// More page: light / dark appearance toggle.
class AppearanceSettingsSection extends StatelessWidget {
  const AppearanceSettingsSection({super.key, this.embedded = false});

  final bool embedded;

  @override
  Widget build(BuildContext context) {
    final service = getIt<AppThemeModeService>();

    return ListenableBuilder(
      listenable: service,
      builder: (context, _) {
        final theme = context.theme;
        final effectiveDark = theme.brightness == Brightness.dark;

        final tile = ListTile(
          contentPadding: MoreSettingsLayout.tilePadding(context),
          leading: MoreIconBox(
            icon: effectiveDark
                ? Icons.dark_mode_rounded
                : Icons.light_mode_outlined,
          ),
          title: Text(
            context.l10n.darkMode,
            style: MoreSettingsLayout.tileTitle(theme),
          ),
          subtitle: Text(
            service.followsSystemTheme
                ? context.l10n.darkModeSystemSubtitle
                : context.l10n.darkModeSubtitle,
            style: MoreSettingsLayout.tileSubtitle(theme),
          ),
          trailing: MoreSettingsSwitch(
            value: effectiveDark,
            onChanged: service.setDarkMode,
          ),
          onTap: () => service.setDarkMode(!effectiveDark),
        );

        if (embedded) return tile;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4.w),
              child: Text(
                context.l10n.appearance,
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
}
