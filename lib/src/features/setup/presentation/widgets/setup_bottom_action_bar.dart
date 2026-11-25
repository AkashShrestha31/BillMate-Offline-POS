import 'package:flutter/material.dart';
import 'package:hotel/src/core/layout/device_layout.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';

/// Bottom back + continue bar for the local setup wizard.
class SetupBottomActionBar extends StatelessWidget {
  const SetupBottomActionBar({
    super.key,
    required this.primaryTitle,
    required this.onPrimary,
    this.loading = false,
    this.showBack = false,
    this.backTitle = 'Back',
    this.onBack,
  });

  final String primaryTitle;
  final VoidCallback? onPrimary;
  final bool loading;
  final bool showBack;
  final String backTitle;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isTablet = DeviceLayout.isTablet(context);
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    final horizontal = isTablet ? 32.0 : 16.0;
    final top = isTablet ? 12.0 : 8.0;
    final bottom = (isTablet ? 12.0 : 24.0) + bottomInset;
    final maxWidth = isTablet ? 680.0 : double.infinity;

    final buttons = Row(
      children: [
        if (showBack) ...[
          Expanded(
            child: CustomButtonWidget.outlined(
              title: backTitle,
              onPressed: onBack,
              useFixedSizes: isTablet,
              height: isTablet ? 52 : 42,
              borderRadius: isTablet ? 12 : 8,
            ),
          ),
          SizedBox(width: isTablet ? 12 : 12),
        ],
        Expanded(
          flex: showBack ? 2 : 1,
          child: CustomButtonWidget.primary(
            title: primaryTitle,
            onPressed: onPrimary,
            loading: loading,
            useFixedSizes: isTablet,
            height: isTablet ? 52 : 48,
            borderRadius: isTablet ? 12 : 8,
            elevation: isTablet ? 4 : 6,
            shadowColor: cs.primary.withValues(alpha: isTablet ? 0.3 : 0.35),
          ),
        ),
      ],
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isTablet ? cs.surface : Colors.transparent,
        border: isTablet
            ? Border(
                top: BorderSide(
                  color: cs.outlineVariant.withValues(alpha: 0.45),
                ),
              )
            : null,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(horizontal, top, horizontal, bottom),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: buttons,
          ),
        ),
      ),
    );
  }
}

/// Centers setup header and form content on tablet / iPad.
class SetupTabletContentWidth extends StatelessWidget {
  const SetupTabletContentWidth({
    super.key,
    required this.child,
    this.maxWidth = 680,
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    if (!DeviceLayout.isTablet(context)) return child;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
