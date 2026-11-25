import 'package:flutter/material.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/features/settings/domain/live_stock_tracking_service.dart';
import 'package:hotel/src/features/settings/presentation/live_stock_issue_guard.dart';

Future<bool> showLiveStockOnHandSheet(
  BuildContext context, {
  required String itemName,
  String? itemType,
}) async {
  final tracking = liveStockOrNull();
  if (tracking == null || !tracking.enabled) return false;
  if ((itemType ?? '').trim().toLowerCase() == 'service') return false;

  final saved = await showModalBottomSheet<bool>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => _LiveStockOnHandSheet(itemName: itemName),
  );
  return saved == true;
}

class _LiveStockOnHandSheet extends StatefulWidget {
  const _LiveStockOnHandSheet({required this.itemName});

  final String itemName;

  @override
  State<_LiveStockOnHandSheet> createState() => _LiveStockOnHandSheetState();
}

class _LiveStockOnHandSheetState extends State<_LiveStockOnHandSheet> {
  late final TextEditingController _controller;
  bool _saving = false;
  List<String> _locations = const [LiveStockTrackingService.defaultLocation];
  String _location = LiveStockTrackingService.defaultLocation;

  bool get _pickLocation => _locations.length > 1;

  @override
  void initState() {
    super.initState();
    final current = liveStockOrNull()?.onHand(widget.itemName) ?? 0;
    _controller = TextEditingController(
      text: LiveStockTrackingService.formatQty(current),
    );
    _loadLocations();
  }

  Future<void> _loadLocations() async {
    final tracking = liveStockOrNull();
    if (tracking == null) return;
    final locs = await tracking.listLocations();
    if (!mounted) return;
    setState(() {
      _locations = locs.isEmpty
          ? const [LiveStockTrackingService.defaultLocation]
          : locs;
      if (!_locations.contains(_location)) {
        _location = _locations.first;
      }
      final qty = _pickLocation
          ? tracking.onHand(widget.itemName, location: _location)
          : tracking.onHand(widget.itemName);
      _controller.text = LiveStockTrackingService.formatQty(qty);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onLocationChanged(String? value) {
    if (value == null) return;
    final tracking = liveStockOrNull();
    setState(() => _location = value);
    final qty = tracking?.onHand(widget.itemName, location: value) ?? 0;
    _controller.text = LiveStockTrackingService.formatQty(qty);
  }

  Future<void> _save() async {
    final qty = double.tryParse(_controller.text.trim());
    if (qty == null || qty < 0) return;
    final tracking = liveStockOrNull();
    if (tracking == null) return;
    setState(() => _saving = true);
    FocusManager.instance.primaryFocus?.unfocus();
    await tracking.setOnHand(
      itemName: widget.itemName,
      qty: qty,
      location: _pickLocation ? _location : null,
    );
    if (!mounted) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: scheme.outlineVariant.withOpacity(0.55),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text(
                  context.l10n.liveStockSetOnHand,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                verticalMarginSmall,
                Text(
                  widget.itemName,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const Divider(),
                verticalMarginMedium,
                if (_pickLocation) ...[
                  InputDecorator(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _locations.contains(_location)
                            ? _location
                            : _locations.first,
                        isExpanded: true,
                        items: [
                          for (final loc in _locations)
                            DropdownMenuItem(value: loc, child: Text(loc)),
                        ],
                        onChanged: _saving ? null : _onLocationChanged,
                      ),
                    ),
                  ),
                  verticalMarginMedium,
                ],
                CustomTextFormField(
                  controller: _controller,
                  labelText: context.l10n.liveStockOnHandLabel,
                  hint: context.l10n.liveStockOnHandHint,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _saving ? null : _save(),
                ),
                const SizedBox(height: 20),
                CustomButtonWidget(
                  title: context.l10n.liveStockSaveOnHand,
                  loading: _saving,
                  onPressed: _saving ? null : _save,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
