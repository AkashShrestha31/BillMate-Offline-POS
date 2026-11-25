import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/helpers/item_image_helper.dart';
import 'package:hotel/src/core/layout/device_layout.dart';

/// Shared layout pieces for the More / settings hub.
abstract final class MoreSettingsLayout {
  static const double tabletHorizontalPadding = 24;
  static const switchScale = 0.72;

  static Color background(ColorScheme scheme) => scheme.surfaceContainerLow;

  static bool isTablet(BuildContext context) =>
      DeviceLayout.isTablet(context);

  static double sz(BuildContext context, double tablet, double phone) {
    if (isTablet(context)) return tablet;
    return phone;
  }

  static double sp(BuildContext context, double tablet, double phone) {
    if (isTablet(context)) return tablet;
    return phone.sp;
  }

  static double horizontalPadding(BuildContext context, double phone) =>
      isTablet(context) ? tabletHorizontalPadding : phone;

  static double cardRadius(BuildContext context) => sz(context, 20, 20.r);

  static double iconBoxSize(BuildContext context) => sz(context, 40, 40.w);

  static double tileIconSize(BuildContext context) => sp(context, 22, 22);

  static double chevronSize(BuildContext context) => sp(context, 20, 20);

  static double dividerIndent(BuildContext context) => sz(context, 68, 68.w);

  static EdgeInsets tilePadding(BuildContext context) => EdgeInsets.symmetric(
        horizontal: sz(context, 16, 16.w),
        vertical: sz(context, 4, 4.h),
      );

  static TextStyle? tileTitle(ThemeData theme) =>
      theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600);

  static TextStyle? tileSubtitle(ThemeData theme) =>
      theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      );

  static TextStyle? sectionLabel(ThemeData theme) =>
      theme.textTheme.labelMedium?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.6,
        color: theme.colorScheme.onSurfaceVariant,
      );
}

class MoreSectionLabel extends StatelessWidget {
  const MoreSectionLabel(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Padding(
      padding: EdgeInsets.only(
        left: MoreSettingsLayout.sz(context, 4, 4.w),
        bottom: MoreSettingsLayout.sz(context, 8, 8.h),
      ),
      child: Text(
        label.toUpperCase(),
        style: MoreSettingsLayout.sectionLabel(theme),
      ),
    );
  }
}

class MoreSettingsCard extends StatelessWidget {
  const MoreSettingsCard({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(MoreSettingsLayout.cardRadius(context)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _intersperseDividers(children),
      ),
    );
  }

  static List<Widget> _intersperseDividers(List<Widget> items) {
    if (items.isEmpty) return items;
    final result = <Widget>[items.first];
    for (var i = 1; i < items.length; i++) {
      result.add(const MoreSettingsDivider());
      result.add(items[i]);
    }
    return result;
  }
}

class MoreSettingsDivider extends StatelessWidget {
  const MoreSettingsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = context.theme.colorScheme;
    return Divider(
      height: MoreSettingsLayout.sz(context, 1, 1.h),
      thickness: 1,
      indent: MoreSettingsLayout.dividerIndent(context),
      endIndent: 0,
      color: scheme.outlineVariant.withValues(alpha: 0.45),
    );
  }
}

class MoreSettingsSwitch extends StatelessWidget {
  const MoreSettingsSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: MoreSettingsLayout.switchScale,
      alignment: Alignment.centerRight,
      child: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}

class MoreNavTile extends StatelessWidget {
  const MoreNavTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return ListTile(
      contentPadding: MoreSettingsLayout.tilePadding(context),
      leading: MoreIconBox(icon: icon),
      title: Text(title, style: MoreSettingsLayout.tileTitle(theme)),
      subtitle: subtitle == null
          ? null
          : Text(subtitle!, style: MoreSettingsLayout.tileSubtitle(theme)),
      trailing: trailing ??
          Icon(
            Icons.chevron_right,
            size: MoreSettingsLayout.chevronSize(context),
            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          ),
      onTap: onTap,
    );
  }
}

class MoreSwitchTile extends StatelessWidget {
  const MoreSwitchTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
    this.busy = false,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final iconBox = MoreSettingsLayout.iconBoxSize(context);
    return ListTile(
      contentPadding: MoreSettingsLayout.tilePadding(context),
      leading: busy
          ? SizedBox(
              width: iconBox,
              height: iconBox,
              child: Center(
                child: SizedBox(
                  width: MoreSettingsLayout.sz(context, 22, 22.w),
                  height: MoreSettingsLayout.sz(context, 22, 22.w),
                  child: const CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            )
          : MoreIconBox(icon: icon),
      title: Text(title, style: MoreSettingsLayout.tileTitle(theme)),
      subtitle: subtitle == null
          ? null
          : Text(subtitle!, style: MoreSettingsLayout.tileSubtitle(theme)),
      trailing: MoreSettingsSwitch(value: value, onChanged: onChanged),
      onTap: onChanged == null ? null : () => onChanged!(!value),
    );
  }
}

class MoreBadge extends StatelessWidget {
  const MoreBadge({
    super.key,
    required this.label,
    this.tinted = false,
  });

  final String label;
  final bool tinted;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final primary = theme.colorScheme.primary;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MoreSettingsLayout.sz(context, 10, 10.w),
        vertical: MoreSettingsLayout.sz(context, 4, 4.h),
      ),
      decoration: BoxDecoration(
        color: tinted
            ? primary.withValues(alpha: 0.12)
            : theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(
          MoreSettingsLayout.sz(context, 999, 999.r),
        ),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: tinted ? primary : theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class MoreIconBox extends StatelessWidget {
  const MoreIconBox({
    super.key,
    required this.icon,
    this.filled = false,
    this.logo,
  });

  final IconData icon;
  final bool filled;

  /// Organization logo from SQLite (data URI, local path, or URL).
  final String? logo;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final primary = theme.colorScheme.primary;
    final size = MoreSettingsLayout.iconBoxSize(context);
    final radius = BorderRadius.circular(
      MoreSettingsLayout.sz(context, 12, 12.r),
    );

    if (ItemImageHelper.hasDisplayableImage(logo)) {
      return ClipRRect(
        borderRadius: radius,
        child: ItemImageHelper.buildImage(
          logo,
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: filled ? primary : primary.withValues(alpha: 0.12),
        borderRadius: radius,
      ),
      child: Icon(
        icon,
        color: filled ? theme.colorScheme.onPrimary : primary,
        size: MoreSettingsLayout.tileIconSize(context),
      ),
    );
  }
}
