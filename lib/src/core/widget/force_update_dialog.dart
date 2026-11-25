import 'package:flutter/material.dart';
import 'package:hotel/src/core/extensions/extensions/localization_extension.dart';
import 'package:hotel/src/core/widget/app_brand_name.dart';
import 'package:hotel/src/core/services/force_update/force_update_result.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hotel/src/core/l10n/platform_app_localizations.dart';

/// Blocks navigation until the user opens the store (force update).
class ForceUpdateDialog extends StatelessWidget {
  const ForceUpdateDialog({
    super.key,
    required this.result,
  });

  final ForceUpdateResult result;

  static Future<void> show(BuildContext context, ForceUpdateResult result) {
    return showDialog<void>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: ForceUpdateDialog(result: result),
      ),
    );
  }

  Future<void> _openStore() async {
    final url = result.storeUrl;
    if (url == null || url.isEmpty) return;
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(result.title ?? 'Update required'),
      content: AppBrandName.replaceInText(
        context,
        text: result.message ??
            context.l10n.forceUpdateMessage(context.l10n.platformAppDisplayName),
        brandName: context.l10n.platformAppDisplayName,
        style: theme.textTheme.bodyMedium,
      ),
      actions: [
        FilledButton(
          onPressed: _openStore,
          style: FilledButton.styleFrom(
            backgroundColor: primary,
            minimumSize: const Size(double.infinity, 44),
          ),
          child: const Text('Update now'),
        ),
      ],
    );
  }
}
