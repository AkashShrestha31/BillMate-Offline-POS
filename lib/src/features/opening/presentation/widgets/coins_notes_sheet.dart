import 'package:flutter/material.dart';
import 'package:hotel/constants.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';

/// NPR denominations: notes 200, 100, 50, 20, 10, 5, 2; coins 1, 0.50, 0.25, 0.20, 0.10, 0.05
const List<double> kDenominationValues = [
  1000, 500, 100, 50, 20, 10, 5
  // , 2, 1, 0.50, 0.25, 0.20, 0.10, 0.05,
];

class CoinsNotesSheet extends StatefulWidget {
  const CoinsNotesSheet({
    super.key,
    required this.initialQuantities,
    required this.onConfirm,
  });

  final Map<double, int> initialQuantities;
  final void Function(double total, Map<double, int> quantities) onConfirm;

  static Future<void> show({
    required BuildContext context,
    required Map<double, int> initialQuantities,
    required void Function(double total, Map<double, int> quantities) onConfirm,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => SafeArea(
        child: CoinsNotesSheet(
          initialQuantities: Map.from(initialQuantities),
          onConfirm: (total, qty) {
            Navigator.pop(ctx);
            onConfirm(total, qty);
          },
        ),
      ),
    );
  }

  @override
  State<CoinsNotesSheet> createState() => _CoinsNotesSheetState();
}

class _CoinsNotesSheetState extends State<CoinsNotesSheet> {
  late final ValueNotifier<Map<double, int>> _quantitiesNotifier;

  @override
  void initState() {
    super.initState();
    final initial = Map<double, int>.from(widget.initialQuantities);
    for (final d in kDenominationValues) {
      initial.putIfAbsent(d, () => 0);
    }
    _quantitiesNotifier = ValueNotifier<Map<double, int>>(initial);
  }

  double _totalFor(Map<double, int> quantities) {
    return quantities.entries.fold(
      0.0,
      (sum, e) => sum + (e.key * e.value),
    );
  }

  void _updateQuantity(double denom, int delta) {
    final next = Map<double, int>.from(_quantitiesNotifier.value);
    final current = next[denom] ?? 0;
    next[denom] = (current + delta).clamp(0, 9999);
    _quantitiesNotifier.value = next;
  }

  @override
  void dispose() {
    _quantitiesNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ValueListenableBuilder<Map<double, int>>(
        valueListenable: _quantitiesNotifier,
        builder: (context, quantities, _) {
          final total = _totalFor(quantities);
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Coins/Notes',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              verticalMarginSmall,
              const Divider(height: 1),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: kDenominationValues
                              .take(4)
                              .map((d) => _DenomRow(
                                    denomination: d,
                                    quantity: quantities[d] ?? 0,
                                    onIncrement: () => _updateQuantity(d, 1),
                                    onDecrement: () => _updateQuantity(d, -1),
                                  ))
                              .toList(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          children: kDenominationValues
                              .skip(4)
                              .map((d) => _DenomRow(
                                    denomination: d,
                                    quantity: quantities[d] ?? 0,
                                    onIncrement: () => _updateQuantity(d, 1),
                                    onDecrement: () => _updateQuantity(d, -1),
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                child: Row(
                  children: [
                    FilledButton(
                      onPressed: () =>
                          widget.onConfirm(total, _quantitiesNotifier.value),
                      child: const Text('Confirm'),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Total $currencySymbol ${total.toStringAsFixed(2)}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DenomRow extends StatelessWidget {
  const _DenomRow({
    required this.denomination,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  final double denomination;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: IconButton.filled(
              style: IconButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(32, 32),
                maximumSize: const Size(32, 32),
              ),
              onPressed: onDecrement,
              icon: const Icon(Icons.remove, size: 16),
            ),
          ),
          horizontalMarginSmall,
          SizedBox(
            width: 34,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                quantity.toString(),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: context.theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
          ),
          horizontalMarginSmall,
          SizedBox(
            width: 24,
            height: 24,
            child: IconButton.filled(
              style: IconButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(32, 32),
                maximumSize: const Size(32, 32),
              ),
              onPressed: onIncrement,
              icon: const Icon(Icons.add, size: 16),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              quantity > 0
                  ? '$currencySymbol ${denomination.toStringAsFixed(denomination >= 1 ? 0 : 2)} = $currencySymbol ${(denomination * quantity).toStringAsFixed(2)}'
                  : '$currencySymbol ${denomination.toStringAsFixed(denomination >= 1 ? 0 : 2)}',
              overflow: TextOverflow.ellipsis,
              style:context.theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700
              ),
            ),
          ),
        ],
      ),
    );
  }
}
