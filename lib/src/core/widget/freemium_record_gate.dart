import 'package:flutter/material.dart';
import 'package:hotel/src/core/helpers/freemium_navigation.dart';
import 'package:hotel/src/core/widget/freemium_access_scope.dart';

/// Mutes and blocks interaction for records beyond the free-tier allowance.
class FreemiumRecordGate extends StatelessWidget {
  const FreemiumRecordGate({
    super.key,
    required this.recordKey,
    required this.child,
    this.borderRadius = 14,
  });

  final String recordKey;
  final Widget child;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final scope = FreemiumAccessScope.maybeOf(context);
    if (scope == null || !scope.isLocked(recordKey)) {
      return child;
    }

    final scheme = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          IgnorePointer(
            child: Opacity(
              opacity: 0.45,
              child: child,
            ),
          ),
          Positioned.fill(
            child: Material(
              color: scheme.surface.withValues(alpha: 0.12),
              child: InkWell(
                onTap: () => gateFreemiumFeature(
                  context,
                  scope.feature,
                  partyRole: scope.partyRole,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                shape: BoxShape.circle,
                border: Border.all(color: scheme.outlineVariant),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.lock_outline_rounded,
                  size: 18,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
