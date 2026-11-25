import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Theme-aware colors and decorations for modal bottom sheets.
abstract final class AppBottomSheetTheme {
  AppBottomSheetTheme._();

  static ColorScheme scheme(BuildContext context) =>
      Theme.of(context).colorScheme;

  static Color surface(BuildContext context) => scheme(context).surface;

  static Color onSurface(BuildContext context) => scheme(context).onSurface;

  static Color onSurfaceVariant(BuildContext context) =>
      scheme(context).onSurfaceVariant;

  static Color outlineVariant(BuildContext context) =>
      scheme(context).outlineVariant;

  static Color inputFill(BuildContext context) =>
      scheme(context).surfaceContainerHighest;

  static BoxDecoration floatingCardDecoration(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BoxDecoration(
      color: colorScheme.surfaceContainerHigh,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: colorScheme.outlineVariant.withValues(alpha: 0.45),
      ),
      boxShadow: [
        BoxShadow(
          color: colorScheme.shadow.withValues(alpha: 0.35),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  static BoxDecoration sheetDecoration(
    BuildContext context, {
    BorderRadiusGeometry? borderRadius,
    double radius = 20,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return BoxDecoration(
      color: colorScheme.surfaceContainerHigh,
      borderRadius: borderRadius ?? BorderRadius.circular(radius),
      border: Border.all(
        color: colorScheme.outlineVariant.withValues(alpha: 0.4),
      ),
    );
  }

  static BoxDecoration topSheetDecoration(BuildContext context) =>
      sheetDecoration(
        context,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      );

  static Widget dragHandle(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: 48,
      height: 5,
      decoration: BoxDecoration(
        color: scheme.onSurfaceVariant.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

/// Shared shell for modal bottom sheets (title, close, divider, rounded card).
class AppBottomSheetShell extends StatelessWidget {
  const AppBottomSheetShell({
    super.key,
    required this.title,
    required this.child,
    this.showDivider = true,
    this.expandBody = false,
    this.showCloseButton = true,
    this.compactHeader = false,
  });

  final String title;
  final Widget child;
  final bool showDivider;
  final bool expandBody;
  final bool showCloseButton;
  final bool compactHeader;

  static const _shellPadding = EdgeInsets.fromLTRB(20, 10, 20, 20);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: _shellPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: expandBody ? MainAxisSize.max : MainAxisSize.min,
        children: [
          Center(child: AppBottomSheetTheme.dragHandle(context)),
          SizedBox(height: compactHeader ? 10 : 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    height: compactHeader ? 1.0 : 1.2,
                  ),
                ),
              ),
              if (showCloseButton) const AppBottomSheetCloseButton(),
            ],
          ),
          if (showDivider) ...[
            SizedBox(height: compactHeader ? 10 : 16.h),
            const Divider(height: 1),
            SizedBox(height: compactHeader ? 12 : 16.h),
          ],
          if (expandBody) Expanded(child: child) else child,
        ],
      ),
    );
  }
}

/// Circular close control used on app bottom sheets.
class AppBottomSheetCloseButton extends StatelessWidget {
  const AppBottomSheetCloseButton({
    super.key,
    this.onPressed,
    this.enabled = true,
  });

  final VoidCallback? onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Material(
        color: theme.colorScheme.surfaceContainerHighest,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: !enabled
              ? null
              : onPressed ??
                  () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (!context.mounted) return;
                      Navigator.of(context, rootNavigator: true).pop();
                    });
                  },
          child: SizedBox(
            width: 32,
            height: 32,
            child: Icon(
              Icons.close_rounded,
              size: 18,
              color: theme.colorScheme.onSurfaceVariant.withValues(
                alpha: enabled ? 1 : 0.4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<T?> showAppBottomSheet<T>({
  required BuildContext context,
  required String title,
  Widget? child,
  Widget Function(BuildContext sheetContext)? bodyBuilder,
  bool showDivider = true,
  double maxHeightFactor = 0.75,
  bool scrollableBody = false,
  bool isDismissible = true,
  bool enableDrag = true,
  bool showCloseButton = true,
  bool shrinkWrap = false,
  bool compactHeader = false,
}) {
  assert(child != null || bodyBuilder != null);

  FocusManager.instance.primaryFocus?.unfocus();
  final maxHeight = MediaQuery.sizeOf(context).height * maxHeightFactor;

  return showModalBottomSheet<T>(
    context: context,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    builder: (ctx) {
      final body = bodyBuilder != null ? bodyBuilder(ctx) : child!;
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(ctx).bottom),
        child: SafeArea(
          top: false,
          child: Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            height: scrollableBody ? maxHeight : null,
            constraints: shrinkWrap || scrollableBody
                ? null
                : BoxConstraints(maxHeight: maxHeight),
            decoration: AppBottomSheetTheme.sheetDecoration(ctx),
            child: AppBottomSheetShell(
              title: title,
              showDivider: showDivider,
              expandBody: scrollableBody,
              showCloseButton: showCloseButton,
              compactHeader: compactHeader,
              child: body,
            ),
          ),
        ),
      );
    },
  ).whenComplete(() {
    FocusManager.instance.primaryFocus?.unfocus();
  });
}

/// List row styled like the currency picker sheet.
class AppBottomSheetListTile extends StatelessWidget {
  const AppBottomSheetListTile({
    super.key,
    required this.title,
    required this.onTap,
    this.trailing,
    this.trailingText,
  });

  final String title;
  final VoidCallback onTap;
  final Widget? trailing;
  final String? trailingText;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: trailing ??
          (trailingText == null
              ? Icon(Icons.chevron_right_rounded,
                  color: scheme.onSurfaceVariant)
              : Text(
                  trailingText!,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: scheme.primary,
                  ),
                )),
    );
  }
}
