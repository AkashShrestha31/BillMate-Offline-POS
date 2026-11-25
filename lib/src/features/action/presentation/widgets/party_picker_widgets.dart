import 'package:flutter/material.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/layout/device_layout.dart';
import 'package:hotel/src/core/services/currency/app_currency_formatter.dart';
import 'package:hotel/src/core/widget/app_search_icon.dart';

abstract final class PartyPickerLayout {
  static const double tabletSheetMaxWidth = 520;

  static bool isTablet(BuildContext context) => DeviceLayout.isTablet(context);

  static double sz(BuildContext context, double tablet, double phone) {
    if (isTablet(context)) return tablet;
    return phone;
  }

  static double sp(BuildContext context, double tablet, double phone) {
    if (isTablet(context)) return tablet;
    return phone;
  }

  static double cardRadiusFor(BuildContext context) => sz(context, 14, 14);

  static double sheetRadiusFor(BuildContext context) => sz(context, 20, 20);

  /// Shared horizontal inset for header, search, chips, list, footer.
  static double pageHorizontal(BuildContext context) => sz(context, 20, 20);

  static double sectionGap(BuildContext context) => sz(context, 12, 12);

  static double listItemGap(BuildContext context) => sz(context, 8, 8);

  static double chipRowHeight(BuildContext context) => sz(context, 40, 40);

  static Color pageBackground(ColorScheme scheme) => scheme.surfaceContainerLow;

  static Color chipUnselectedColor(ColorScheme scheme) =>
      scheme.surfaceContainerHighest;

  static Color searchFillColor(ColorScheme scheme) =>
      scheme.surfaceContainerHighest;

  static Color selectedCardBgColor(ColorScheme scheme) =>
      scheme.primaryContainer.withValues(alpha: 0.35);

  static Color tileBorderColor(ColorScheme scheme, {required bool selected}) =>
      selected ? brandGreen : scheme.outlineVariant.withValues(alpha: 0.65);

  /// Legacy light-only constants — prefer theme methods above in new code.
  static const sheetBackground = Color(0xFFF5F5F5);
  static const chipUnselected = Color(0xFFF1F5F9);
  static const searchFill = Color(0xFFF3F4F6);
  static const settledBg = Color(0xFFDCFCE7);
  static const settledFg = Color(0xFF15803D);
  static const balanceBg = Color(0xFFFFEDD5);
  static const balanceFg = Color(0xFF9A3412);
  static const selectedCardBg = Color(0xFFF0FDF4);
  static const brandGreen = Color(0xFF16A34A);
}

class PartyPickerFilterChip extends StatelessWidget {
  const PartyPickerFilterChip({
    super.key,
    required this.label,
    required this.count,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final int count;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final scheme = theme.colorScheme;
    return Padding(
      padding: EdgeInsets.only(right: PartyPickerLayout.sz(context, 10, 10)),
      child: Material(
        color: selected ? scheme.primary : PartyPickerLayout.chipUnselectedColor(scheme),
        elevation: 0,
        borderRadius: BorderRadius.circular(PartyPickerLayout.sz(context, 999, 999)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(PartyPickerLayout.sz(context, 999, 999)),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              PartyPickerLayout.sz(context, 14, 14),
              PartyPickerLayout.sz(context, 8, 8),
              PartyPickerLayout.sz(context, 10, 10),
              PartyPickerLayout.sz(context, 8, 8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: PartyPickerLayout.sp(context, 14, 14),
                    color: selected ? scheme.onPrimary : scheme.onSurface,
                  ),
                ),
                SizedBox(width: PartyPickerLayout.sz(context, 6, 6)),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: PartyPickerLayout.sz(context, 6, 6),
                    vertical: PartyPickerLayout.sz(context, 1, 1),
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? scheme.onPrimary.withValues(alpha: 0.22)
                        : scheme.outlineVariant.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(PartyPickerLayout.sz(context, 999, 999)),
                  ),
                  child: Text(
                    '$count',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: PartyPickerLayout.sp(context, 11, 11),
                      color: selected ? scheme.onPrimary : scheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PartyPickerAddNewCard extends StatelessWidget {
  const PartyPickerAddNewCard({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    const green = PartyPickerLayout.brandGreen;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        PartyPickerLayout.pageHorizontal(context),
        PartyPickerLayout.sz(context, 10, 10),
        PartyPickerLayout.pageHorizontal(context),
        PartyPickerLayout.sz(context, 10, 10),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(PartyPickerLayout.cardRadiusFor(context)),
        clipBehavior: Clip.antiAlias,
        child: CustomPaint(
          painter: _DashedBorderPainter(
            color: green.withValues(alpha: 0.45),
            radius: PartyPickerLayout.cardRadiusFor(context),
            strokeWidth: 1,
            dashWidth: 5,
            dashGap: 3,
          ),
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: PartyPickerLayout.sz(context, 14, 14),
                vertical: PartyPickerLayout.sz(context, 12, 12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.add_rounded,
                    color: green,
                    size: PartyPickerLayout.sp(context, 20, 20),
                  ),
                  SizedBox(width: PartyPickerLayout.sz(context, 10, 10)),
                  Expanded(
                    child: Text(
                      label,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: green,
                        fontWeight: FontWeight.w600,
                        fontSize: PartyPickerLayout.sp(context, 15, 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PartyPickerPartyTile extends StatelessWidget {
  const PartyPickerPartyTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.initials,
    required this.avatarBackground,
    required this.avatarForeground,
    required this.balanceLabel,
    required this.balanceSettled,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String? subtitle;
  final String initials;
  final Color avatarBackground;
  final Color avatarForeground;
  final String balanceLabel;
  final bool balanceSettled;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final scheme = theme.colorScheme;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        PartyPickerLayout.pageHorizontal(context),
        0,
        PartyPickerLayout.pageHorizontal(context),
        PartyPickerLayout.listItemGap(context),
      ),
      child: Material(
        color: selected
            ? PartyPickerLayout.selectedCardBgColor(scheme)
            : scheme.surface,
        elevation: 0,
        borderRadius: BorderRadius.circular(PartyPickerLayout.cardRadiusFor(context)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(PartyPickerLayout.cardRadiusFor(context)),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: PartyPickerLayout.sz(context, 14, 14),
              vertical: PartyPickerLayout.sz(context, 12, 12),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(PartyPickerLayout.cardRadiusFor(context)),
              border: Border.all(
                color: PartyPickerLayout.tileBorderColor(scheme, selected: selected),
                width: selected ? 1.5 : 0.8,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: PartyPickerLayout.sz(context, 18, 18),
                  backgroundColor: avatarBackground,
                  child: Text(
                    initials,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: PartyPickerLayout.sp(context, 12, 12),
                      color: avatarForeground,
                    ),
                  ),
                ),
                SizedBox(width: PartyPickerLayout.sz(context, 12, 12)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: PartyPickerLayout.sp(context, 15, 15),
                          height: 1.25,
                          color: scheme.onSurface,
                        ),
                      ),
                      if (subtitle != null && subtitle!.isNotEmpty) ...[
                        const SizedBox(height: 3),
                        Text(
                          subtitle!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: PartyPickerLayout.sp(context, 12, 12),
                            height: 1.2,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(width: PartyPickerLayout.sz(context, 10, 10)),
                _BalanceBadge(label: balanceLabel, settled: balanceSettled),
                SizedBox(width: PartyPickerLayout.sz(context, 10, 10)),
                _SelectionIndicator(selected: selected),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BalanceBadge extends StatelessWidget {
  const _BalanceBadge({
    required this.label,
    required this.settled,
  });

  final String label;
  final bool settled;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final scheme = theme.colorScheme;
    final bg = settled
        ? scheme.primaryContainer.withValues(alpha: 0.45)
        : scheme.tertiaryContainer.withValues(alpha: 0.45);
    final fg = settled ? scheme.onPrimaryContainer : scheme.onTertiaryContainer;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: PartyPickerLayout.sz(context, 10, 10),
        vertical: PartyPickerLayout.sz(context, 4, 4),
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(PartyPickerLayout.sz(context, 999, 999)),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: PartyPickerLayout.sp(context, 10, 10),
          color: fg,
        ),
      ),
    );
  }
}

class _SelectionIndicator extends StatelessWidget {
  const _SelectionIndicator({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final size = PartyPickerLayout.sz(context, 20, 20);
    if (selected) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: scheme.primary, shape: BoxShape.circle),
        child: Icon(
          Icons.check_rounded,
          color: scheme.onPrimary,
          size: PartyPickerLayout.sp(context, 13, 13),
        ),
      );
    }
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: scheme.outlineVariant, width: 1.25),
      ),
    );
  }
}

class PartyPickerFooter extends StatelessWidget {
  const PartyPickerFooter({
    super.key,
    required this.selectedName,
    required this.confirmLabel,
    required this.onConfirm,
    this.enabled = true,
  });

  final String? selectedName;
  final String confirmLabel;
  final VoidCallback onConfirm;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final scheme = theme.colorScheme;
    return Container(
      padding: EdgeInsets.fromLTRB(
        PartyPickerLayout.pageHorizontal(context),
        PartyPickerLayout.sz(context, 14, 14),
        PartyPickerLayout.pageHorizontal(context),
        PartyPickerLayout.sz(context, 14, 14),
      ),
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(
          top: BorderSide(
            color: scheme.outlineVariant.withValues(alpha: 0.45),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.l10n.partyPickerSelectedLabel,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: PartyPickerLayout.sp(context, 11, 11),
                    letterSpacing: 0.6,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: PartyPickerLayout.sz(context, 4, 4)),
                Text(
                  selectedName?.trim().isNotEmpty == true ? selectedName!.trim() : '—',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: PartyPickerLayout.sp(context, 15, 15),
                    color: scheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: PartyPickerLayout.sz(context, 12, 12)),
          SizedBox(
            height: PartyPickerLayout.sz(context, 44, 44),
            child: FilledButton(
              onPressed: enabled ? onConfirm : null,
              style: FilledButton.styleFrom(
                backgroundColor: scheme.primary,
                disabledBackgroundColor: scheme.surfaceContainerHighest,
                foregroundColor: scheme.onPrimary,
                padding: EdgeInsets.symmetric(
                  horizontal: PartyPickerLayout.sz(context, 24, 24),
                ),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    PartyPickerLayout.sz(context, 10, 10),
                  ),
                ),
              ),
              child: Text(
                confirmLabel,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: PartyPickerLayout.sp(context, 14, 14),
                  color: enabled ? scheme.onPrimary : scheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PartyPickerSearchField extends StatelessWidget {
  const PartyPickerSearchField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hintText,
    required this.onChanged,
    required this.onClear,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final scheme = theme.colorScheme;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        PartyPickerLayout.pageHorizontal(context),
        PartyPickerLayout.sz(context, 12, 12),
        PartyPickerLayout.pageHorizontal(context),
        PartyPickerLayout.sz(context, 10, 10),
      ),
      child: ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          final fieldHeight = PartyPickerLayout.sz(context, 44, 44);
          return SizedBox(
            height: fieldHeight,
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: PartyPickerLayout.sp(context, 14, 14),
                color: scheme.onSurface,
              ),
              decoration: InputDecoration(
                isDense: true,
                hintText: hintText,
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: PartyPickerLayout.sp(context, 14, 14),
                  color: scheme.onSurfaceVariant,
                ),
                filled: true,
                fillColor: PartyPickerLayout.searchFillColor(scheme),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: PartyPickerLayout.sz(context, 4, 4),
                  vertical: PartyPickerLayout.sz(context, 8, 8),
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(
                    left: PartyPickerLayout.sz(context, 10, 10),
                    right: PartyPickerLayout.sz(context, 4, 4),
                  ),
                  child: AppSearchIcon(
                    size: PartyPickerLayout.sp(context, 20, 20),
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                prefixIconConstraints: BoxConstraints(
                  minWidth: PartyPickerLayout.sz(context, 36, 36),
                  minHeight: PartyPickerLayout.sz(context, 20, 20),
                ),
                suffixIcon: controller.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.close_rounded,
                          size: PartyPickerLayout.sp(context, 16, 16),
                          color: scheme.onSurfaceVariant,
                        ),
                        onPressed: onClear,
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    PartyPickerLayout.sz(context, 10, 10),
                  ),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    PartyPickerLayout.sz(context, 10, 10),
                  ),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    PartyPickerLayout.sz(context, 10, 10),
                  ),
                  borderSide: BorderSide(color: scheme.primary, width: 1.25),
                ),
              ),
              onChanged: onChanged,
            ),
          );
        },
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({
    required this.color,
    required this.radius,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashGap,
  });

  final Color color;
  final double radius;
  final double strokeWidth;
  final double dashWidth;
  final double dashGap;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final rrect = RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius));
    final path = Path()..addRRect(rrect);

    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final end = (distance + dashWidth).clamp(0.0, metric.length);
        canvas.drawPath(metric.extractPath(distance, end), paint);
        distance += dashWidth + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.radius != radius;
}

abstract final class PartyPickerAvatarColors {
  static const _pairs = <(Color, Color)>[
    (Color(0xFFFEE2E2), Color(0xFFB91C1C)),
    (Color(0xFFCCFBF1), Color(0xFF0F766E)),
    (Color(0xFFFCE7F3), Color(0xFFBE185D)),
    (Color(0xFFD1FAE5), Color(0xFF047857)),
    (Color(0xFFDBEAFE), Color(0xFF1D4ED8)),
    (Color(0xFFEDE9FE), Color(0xFF6D28D9)),
  ];

  static (Color background, Color foreground) forName(String name) {
    final index = name.hashCode.abs() % _pairs.length;
    return _pairs[index];
  }
}

String partyPickerFormatBalance(
  BuildContext context,
  double? amount, {
  String? currencyCode,
}) {
  final value = amount ?? 0;
  if (value.abs() < 0.01) {
    return context.l10n.partyPickerSettled;
  }
  return AppCurrencyFormatter.format(value, currencyCode: currencyCode);
}
