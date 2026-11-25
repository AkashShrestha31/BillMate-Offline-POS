import 'package:flutter/material.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/features/dashboard/presentation/widgets/more_settings_widgets.dart';

class MoreHubPage extends StatelessWidget {
  const MoreHubPage({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final pageBackground = MoreSettingsLayout.background(scheme);

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: pageBackground,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          MoreSettingsLayout.horizontalPadding(context, 16),
          MoreSettingsLayout.sz(context, 16, 16),
          MoreSettingsLayout.horizontalPadding(context, 16),
          MoreSettingsLayout.sz(context, 24, 24),
        ),
        children: [
          Container(
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(
                MoreSettingsLayout.cardRadius(context),
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}

class MoreHubTile extends StatelessWidget {
  const MoreHubTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final scheme = theme.colorScheme;

    return ListTile(
      contentPadding: MoreSettingsLayout.tilePadding(context),
      leading: Icon(
        icon,
        size: MoreSettingsLayout.tileIconSize(context),
        color: scheme.onSurfaceVariant,
      ),
      title: Text(title, style: MoreSettingsLayout.tileTitle(theme)),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: MoreSettingsLayout.tileSubtitle(theme),
            )
          : null,
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: MoreSettingsLayout.sp(context, 14, 14),
        color: scheme.onSurfaceVariant.withValues(alpha: 0.5),
      ),
      onTap: onTap,
    );
  }
}
