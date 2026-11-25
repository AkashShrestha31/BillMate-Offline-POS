import 'package:flutter/material.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';

const _deleteColor = Color(0xFFEF4444);

Future<bool> showDeleteOrganizationConfirmSheet({
  required BuildContext context,
  required String organizationName,
}) {
  final l10n = context.l10n;
  return showAppBottomSheet<bool>(
    context: context,
    title: l10n.deleteOrganizationTitle,
    shrinkWrap: true,
    child: Builder(
      builder: (sheetContext) {
        final sheetTheme = Theme.of(sheetContext);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.deleteOrganizationMessage(organizationName),
              style: AppFonts.interStyle(
                fontSize: 14,
                height: 1.45,
                color: sheetTheme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: sheetTheme.colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: sheetTheme.colorScheme.error.withValues(alpha: 0.35),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    color: sheetTheme.colorScheme.error,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l10n.deleteOrganizationWarning,
                      style: AppFonts.interStyle(
                        fontSize: 13,
                        height: 1.4,
                        color: sheetTheme.colorScheme.onErrorContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CustomButtonWidget.outlined(
                    onPressed: () => Navigator.pop(sheetContext, false),
                    title: l10n.cancel,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButtonWidget(
                    onPressed: () => Navigator.pop(sheetContext, true),
                    title: l10n.delete,
                    width: double.infinity,
                    backgroundColor: _deleteColor,
                    titleColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ),
  ).then((value) => value == true);
}
