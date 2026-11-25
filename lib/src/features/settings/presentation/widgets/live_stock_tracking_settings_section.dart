import 'package:flutter/material.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/helpers/freemium_navigation.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/features/dashboard/presentation/widgets/more_settings_widgets.dart';
import 'package:hotel/src/features/settings/domain/live_stock_tracking_service.dart';

/// More page: toggle live on-hand stock updates from invoices.
class LiveStockTrackingSettingsSection extends StatefulWidget {
  const LiveStockTrackingSettingsSection({super.key, this.embedded = false});

  final bool embedded;

  @override
  State<LiveStockTrackingSettingsSection> createState() =>
      _LiveStockTrackingSettingsSectionState();
}

class _LiveStockTrackingSettingsSectionState
    extends State<LiveStockTrackingSettingsSection> {
  bool _saving = false;

  Future<void> _persist(bool enabled) async {
    if (enabled) {
      final allowed = await gateFreemiumFeature(
        context,
        FreemiumFeature.stock,
      );
      if (!allowed) return;
    }
    if (!mounted) return;
    setState(() => _saving = true);
    await getIt<LiveStockTrackingService>().setEnabled(enabled);
    if (!mounted) return;
    setState(() => _saving = false);
    context.showKiiSnackBarSuccess(context.l10n.liveStockTrackingSaved);
  }

  @override
  Widget build(BuildContext context) {
    final service = getIt<LiveStockTrackingService>();
    final theme = context.theme;

    return ListenableBuilder(
      listenable: service,
      builder: (context, _) {
        final tile = ListTile(
          contentPadding: MoreSettingsLayout.tilePadding(context),
          leading: const MoreIconBox(icon: Icons.inventory_2_outlined),
          title: Text(
            context.l10n.liveStockTracking,
            style: MoreSettingsLayout.tileTitle(theme),
          ),
          subtitle: Text(
            context.l10n.liveStockTrackingSubtitle,
            style: MoreSettingsLayout.tileSubtitle(theme),
          ),
          trailing: MoreSettingsSwitch(
            value: service.enabled,
            onChanged: _saving ? null : _persist,
          ),
          onTap: _saving ? null : () => _persist(!service.enabled),
        );

        if (widget.embedded) return tile;

        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: tile,
        );
      },
    );
  }
}
