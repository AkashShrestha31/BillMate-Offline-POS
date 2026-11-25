import 'package:flutter/material.dart';

/// Stable id for local show/hide preference (per organization).
abstract final class ExploreFeatureIds {
  static const reconciliation = 'reconciliation';
  static const opening = 'opening';
  static const closing = 'closing';
  static const calculator = 'calculator';
  static const inventory = 'inventory';
  static const addEmployee = 'add_employee';
  static const addParty = 'add_party';
}

/// Metadata for customize sheet (no dependency on [BusinessMenuItem]).
class ExploreFeatureToggleItem {
  const ExploreFeatureToggleItem({
    required this.id,
    required this.label,
    required this.icon,
    this.permissionFeatureName,
  });

  final String id;
  final String label;
  final IconData icon;

  /// API `featureName` for org access; `null` = always available to customize.
  final String? permissionFeatureName;
}
