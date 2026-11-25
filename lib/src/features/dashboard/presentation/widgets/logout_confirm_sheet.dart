import 'package:flutter/material.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/features/dashboard/presentation/widgets/logout_confirm_sheet_layout.dart';
import 'package:hotel/l10n/app_localizations.dart';

const _logoutColor = Color(0xFFEF4444);

Future<bool> showLogoutConfirmSheet(BuildContext context) {
  FocusManager.instance.primaryFocus?.unfocus();
  final l10n = context.l10n;
  final isTablet = LogoutConfirmSheetLayout.isTablet(context);

  return showAppBottomSheet<bool>(
    context: context,
    title: l10n.logoutConfirmTitle,
    showDivider: false,
    compactHeader: true,
    shrinkWrap: true,
    isDismissible: false,
    enableDrag: false,
    bodyBuilder: (sheetContext) => _LogoutConfirmBody(
      l10n: l10n,
      isTablet: isTablet,
    ),
  ).then((value) => value == true);
}

class _LogoutConfirmBody extends StatelessWidget {
  const _LogoutConfirmBody({
    required this.l10n,
    required this.isTablet,
  });

  final AppLocalizations l10n;
  final bool isTablet;

  void _pop(BuildContext context, bool result) {
    FocusManager.instance.primaryFocus?.unfocus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;
      Navigator.of(context, rootNavigator: true).pop(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    final onSurfaceVariant = Theme.of(context).colorScheme.onSurfaceVariant;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: LogoutConfirmSheetLayout.messageTopPadding(context),
            bottom: LogoutConfirmSheetLayout.messageBottomPadding(context),
          ),
          child: Text(
            l10n.logoutConfirmMessage,
            style: AppFonts.interStyle(
              fontSize: LogoutConfirmSheetLayout.messageFontSize(context),
              height: 1.35,
              color: onSurfaceVariant,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: CustomButtonWidget.outlined(
                onPressed: () => _pop(context, false),
                title: l10n.cancel,
                width: double.infinity,
                useFixedSizes: isTablet,
                height: LogoutConfirmSheetLayout.buttonHeight(context),
                borderRadius: LogoutConfirmSheetLayout.buttonRadius(context),
              ),
            ),
            SizedBox(
              width: LogoutConfirmSheetLayout.buttonSpacing(context),
            ),
            Expanded(
              child: CustomButtonWidget(
                onPressed: () => _pop(context, true),
                title: l10n.logoutConfirmTitle,
                width: double.infinity,
                backgroundColor: _logoutColor,
                titleColor: Colors.white,
                useFixedSizes: isTablet,
                height: LogoutConfirmSheetLayout.buttonHeight(context),
                borderRadius: LogoutConfirmSheetLayout.buttonRadius(context),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
