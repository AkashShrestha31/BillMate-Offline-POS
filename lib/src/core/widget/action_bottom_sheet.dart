import 'package:flutter/material.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/widget/pdf_export_option_tile.dart';

/// One action row in [ActionBottomSheet].
class ActionSheetItem {
  const ActionSheetItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.color,
    this.iconWidget,
  });

  final IconData icon;
  final Widget? iconWidget;
  final String title;
  final VoidCallback onTap;
  final Color? color;
}

/// Reusable bottom sheet with title and a list of action tiles (same style as
/// party_details_page / invoice_card: margin 16 L/R/B, rounded 20, transparent background).
class ActionBottomSheet {
  ActionBottomSheet._();

  static const _sheetMargin = EdgeInsets.only(left: 16, right: 16, bottom: 16);
  static const _padding = EdgeInsets.fromLTRB(24, 20, 24, 24);

  /// Shows a modal bottom sheet with [title] and [items].
  /// Each item is rendered as [PdfExportOptionTile]. On tap, the sheet is
  /// closed then the item's [ActionSheetItem.onTap] is called.
  static void show(
    BuildContext context, {
    required String title,
    required List<ActionSheetItem> items,
    Widget Function(BuildContext sheetContext)? titleTrailingBuilder,
  }) {
    final theme = Theme.of(context);
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => SafeArea(
        child: Container(
          margin: _sheetMargin,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: _padding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (titleTrailingBuilder != null) titleTrailingBuilder!(sheetContext),
                  ],
                ),
                verticalMarginSmall,
                const Divider(),
                verticalMarginMedium,
                ...items.expand((item) => [
                      PdfExportOptionTile(
                        icon: item.icon,
                        iconWidget: item.iconWidget,
                        title: item.title,
                        color: item.color,
                        onTap: () {
                          Navigator.pop(sheetContext);
                          item.onTap();
                        },
                      ),
                      verticalMarginLarge,
                    ]).toList()
                  ..removeLast(), // trailing spacing after last item
              ],
            ),
          ),
        ),
      ),
    );
  }
}
