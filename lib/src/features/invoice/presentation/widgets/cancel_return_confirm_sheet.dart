import 'package:flutter/material.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';

Future<bool> showCancelReturnConfirmSheet({
  required BuildContext context,
  required String returnName,
  String? message,
}) {
  final l10n = context.l10n;
  final body = message ??
      'Cancel return "$returnName"? This restores quantities on the original invoice.';

  return showAppBottomSheet<bool>(
    context: context,
    title: 'Cancel return',
    shrinkWrap: true,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            body,
            style: AppFonts.interStyle(
              fontSize: 14,
              height: 1.45,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: CustomButtonWidget.outlined(
                onPressed: () => Navigator.pop(context, false),
                title: l10n.no,
                width: double.infinity,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomButtonWidget(
                onPressed: () => Navigator.pop(context, true),
                title: 'Cancel return',
                width: double.infinity,
              ),
            ),
          ],
        ),
      ],
    ),
  ).then((value) => value == true);
}
