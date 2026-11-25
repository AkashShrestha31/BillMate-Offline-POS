import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hotel/src/core/config/app_freemium_config.dart';
import 'package:hotel/src/core/constants/test_data_constants.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/services/billing/freemium_gate_service.dart';
import 'package:hotel/src/core/services/billing/subscription_service.dart';

/// Exposes which record ids remain accessible on the free tier for a list screen.
class FreemiumAccessScope extends InheritedWidget {
  const FreemiumAccessScope({
    super.key,
    required this.feature,
    required this.accessibleKeys,
    required super.child,
    this.partyRole,
  });

  final FreemiumFeature feature;
  final String? partyRole;

  /// `null` means premium / limits off — every record is accessible.
  final Set<String>? accessibleKeys;

  static FreemiumAccessScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FreemiumAccessScope>();
  }

  bool isLocked(String recordKey) {
    if (TestDataConstants.isDemoInvoiceName(recordKey)) return false;
    if (AppFreemiumConfig.isFreePaymentMethod(recordKey)) return false;
    final keys = accessibleKeys;
    if (keys == null) return false;
    final normalized = recordKey.trim();
    if (normalized.isEmpty) return false;
    return !keys.contains(normalized);
  }

  @override
  bool updateShouldNotify(FreemiumAccessScope oldWidget) {
    return oldWidget.feature != feature ||
        oldWidget.partyRole != partyRole ||
        oldWidget.accessibleKeys != accessibleKeys;
  }
}

/// Loads accessible record ids and rebuilds when subscription status changes.
class FreemiumAccessHost extends StatefulWidget {
  const FreemiumAccessHost({
    super.key,
    required this.feature,
    required this.child,
    this.partyRole,
  });

  final FreemiumFeature feature;
  final String? partyRole;
  final Widget child;

  @override
  State<FreemiumAccessHost> createState() => _FreemiumAccessHostState();
}

class _FreemiumAccessHostState extends State<FreemiumAccessHost> {
  static final Map<String, Set<String>?> _keysCache = {};

  final _gate = getIt<FreemiumGateService>();
  final _billing = getIt<SubscriptionService>();

  Set<String>? _accessibleKeys;
  bool _resolved = false;

  String get _cacheKey => '${widget.feature.name}|${widget.partyRole ?? ''}';

  @override
  void initState() {
    super.initState();
    _billing.addListener(_reload);
    unawaited(_reload());
  }

  @override
  void didUpdateWidget(covariant FreemiumAccessHost oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.feature != widget.feature ||
        oldWidget.partyRole != widget.partyRole) {
      unawaited(_reload());
    }
  }

  @override
  void dispose() {
    _billing.removeListener(_reload);
    super.dispose();
  }

  Future<void> _reload() async {
    await _billing.initializeIfNeeded();

    if (!_gate.limitsApply) {
      _keysCache.remove(_cacheKey);
      if (!mounted) return;
      setState(() {
        _accessibleKeys = null;
        _resolved = true;
      });
      return;
    }

    final cached = _keysCache[_cacheKey];
    if (!mounted) return;
    setState(() {
      _accessibleKeys = cached ?? const {};
      _resolved = cached != null;
    });

    final keys = await _gate.accessibleRecordKeys(
      widget.feature,
      partyRole: widget.partyRole,
    );
    if (!mounted) return;
    _keysCache[_cacheKey] = keys;
    setState(() {
      _accessibleKeys = keys;
      _resolved = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_gate.limitsApply) {
      return FreemiumAccessScope(
        feature: widget.feature,
        partyRole: widget.partyRole,
        accessibleKeys: null,
        child: widget.child,
      );
    }

    return FreemiumAccessScope(
      feature: widget.feature,
      partyRole: widget.partyRole,
      accessibleKeys: _resolved ? _accessibleKeys : const {},
      child: widget.child,
    );
  }
}
