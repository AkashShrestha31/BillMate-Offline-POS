import 'package:flutter/material.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';

Future<bool> showDisableAppPinConfirmSheet(BuildContext context) {
  final l10n = context.l10n;

  return showAppBottomSheet<bool>(
    context: context,
    title: l10n.disableAppPinTitle,
    shrinkWrap: true,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            l10n.disableAppPinMessage,
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
                title: l10n.cancel,
                width: double.infinity,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomButtonWidget(
                onPressed: () => Navigator.pop(context, true),
                title: l10n.confirm,
                width: double.infinity,
              ),
            ),
          ],
        ),
      ],
    ),
  ).then((value) => value == true);
}
