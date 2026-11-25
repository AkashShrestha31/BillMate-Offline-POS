import 'package:flutter/material.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/widget/app_delete_icon.dart';

/// Reusable row tile for PDF export / action options in bottom sheets.
/// Used in party_details_page (Export as PDF, Share PDF) and invoice_card (Edit, Payment, Submit, Delete).
class PdfExportOptionTile extends StatelessWidget {
  const PdfExportOptionTile({
    super.key,
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

  static bool isDeleteIcon(IconData icon) {
    return icon == Icons.delete ||
        icon == Icons.delete_outline ||
        icon == Icons.delete_outline_rounded ||
        icon == Icons.delete_forever_outlined ||
        icon == Icons.delete_rounded ||
        icon == Icons.delete_forever;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = color ?? theme.colorScheme.onSurface;
    final leading = iconWidget ??
        (isDeleteIcon(icon)
            ? AppDeleteIcon(size: 24, color: iconColor)
            : Icon(icon, size: 24, color: iconColor));

    return InkWell(
      onTap: onTap,
      canRequestFocus: false,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        children: [
          leading,
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: AppFonts.interStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
