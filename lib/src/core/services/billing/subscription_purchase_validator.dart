import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:hotel/src/core/config/app_billing_config.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_2_wrappers.dart';

/// Resolved premium access from StoreKit transactions / purchase details.
class StoreEntitlementSnapshot {
  const StoreEntitlementSnapshot({
    required this.isActive,
    this.productId,
    this.lifetime = false,
    this.expiresAt,
  });

  const StoreEntitlementSnapshot.inactive()
      : isActive = false,
        productId = null,
        lifetime = false,
        expiresAt = null;

  final bool isActive;
  final String? productId;
  final bool lifetime;
  final DateTime? expiresAt;
}

abstract final class SubscriptionPurchaseValidator {
  static DateTime? parseExpirationRaw(dynamic raw) {
    if (raw == null) return null;
    if (raw is num) {
      final ms = raw > 1e12 ? raw.toInt() : (raw * 1000).round();
      return DateTime.fromMillisecondsSinceEpoch(ms);
    }
    if (raw is String) {
      final trimmed = raw.trim();
      if (trimmed.isEmpty) return null;
      final asNum = num.tryParse(trimmed);
      if (asNum != null) {
        final ms = asNum > 1e12 ? asNum.toInt() : (asNum * 1000).round();
        return DateTime.fromMillisecondsSinceEpoch(ms);
      }
      return DateTime.tryParse(trimmed);
    }
    return null;
  }

  static DateTime? parseExpirationSeconds(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    final value = double.tryParse(raw);
    if (value == null) return null;
    // SK2Transaction exposes milliseconds since epoch; older payloads may be seconds.
    if (value > 1e12) {
      return DateTime.fromMillisecondsSinceEpoch(value.round());
    }
    return DateTime.fromMillisecondsSinceEpoch((value * 1000).round());
  }

  static DateTime? _expirationFromJsonMap(Map<String, dynamic> decoded) {
    for (final key in const [
      'expiresDate',
      'expirationDate',
      'expires_date_ms',
      'expiresDateMs',
    ]) {
      final parsed = parseExpirationRaw(decoded[key]);
      if (parsed != null) return parsed;
    }
    return null;
  }

  static DateTime? expirationFromJson(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) {
        final direct = _expirationFromJsonMap(decoded);
        if (direct != null) return direct;

        for (final nestedKey in const [
          'signedTransactionInfo',
          'transaction',
          'payload',
        ]) {
          final nested = decoded[nestedKey];
          if (nested is Map<String, dynamic>) {
            final parsed = _expirationFromJsonMap(nested);
            if (parsed != null) return parsed;
          }
          if (nested is String && nested.isNotEmpty) {
            final parsed = expirationFromJson(nested);
            if (parsed != null) return parsed;
          }
        }
      }
    } catch (_) {
      // Not JSON.
    }
    return null;
  }

  static DateTime? expirationFromPurchase(PurchaseDetails purchase) {
    if (AppBillingConfig.isLifetimeProduct(purchase.productID)) return null;

    final local = purchase.verificationData.localVerificationData;
    if (local.isNotEmpty) {
      final parsed = expirationFromJson(local);
      if (parsed != null) return parsed;
    }

    return null;
  }

  static bool isPurchaseEntitlementActive(
    PurchaseDetails purchase, {
    DateTime? now,
  }) {
    if (!AppBillingConfig.isPremiumProduct(purchase.productID)) return false;
    if (AppBillingConfig.isLifetimeProduct(purchase.productID)) return true;

    final expiresAt = expirationFromPurchase(purchase);
    if (expiresAt == null) return false;

    return expiresAt.isAfter(now ?? DateTime.now());
  }

  static bool isCachedEntitlementActive({
    required bool premiumActive,
    required bool lifetime,
    DateTime? expiresAt,
    DateTime? now,
  }) {
    if (!premiumActive) return false;
    if (lifetime) return true;
    if (expiresAt == null) return false;
    return expiresAt.isAfter(now ?? DateTime.now());
  }

  static StoreEntitlementSnapshot snapshotFromPurchases(
    Iterable<PurchaseDetails> purchases, {
    DateTime? now,
  }) {
    final clock = now ?? DateTime.now();
    StoreEntitlementSnapshot? best;

    for (final purchase in purchases) {
      if (purchase.status != PurchaseStatus.purchased &&
          purchase.status != PurchaseStatus.restored) {
        continue;
      }
      if (!AppBillingConfig.isPremiumProduct(purchase.productID)) continue;

      if (AppBillingConfig.isLifetimeProduct(purchase.productID)) {
        return StoreEntitlementSnapshot(
          isActive: true,
          productId: purchase.productID,
          lifetime: true,
        );
      }

      final expiresAt = expirationFromPurchase(purchase);
      if (expiresAt != null && expiresAt.isAfter(clock)) {
        final candidate = StoreEntitlementSnapshot(
          isActive: true,
          productId: purchase.productID,
          expiresAt: expiresAt,
        );
        if (best == null ||
            (best.expiresAt == null ||
                candidate.expiresAt!.isAfter(best.expiresAt!))) {
          best = candidate;
        }
      }
    }

    return best ?? const StoreEntitlementSnapshot.inactive();
  }

  static StoreEntitlementSnapshot snapshotFromTransactions(
    Iterable<SK2Transaction> transactions, {
    DateTime? now,
  }) {
    final clock = now ?? DateTime.now();
    StoreEntitlementSnapshot? best;

    for (final tx in transactions) {
      if (!AppBillingConfig.isPremiumProduct(tx.productId)) continue;

      if (AppBillingConfig.isLifetimeProduct(tx.productId)) {
        return StoreEntitlementSnapshot(
          isActive: true,
          productId: tx.productId,
          lifetime: true,
        );
      }

      final expiresAt = parseExpirationSeconds(tx.expirationDate) ??
          expirationFromJson(tx.jsonRepresentation);
      if (expiresAt != null && expiresAt.isAfter(clock)) {
        final candidate = StoreEntitlementSnapshot(
          isActive: true,
          productId: tx.productId,
          expiresAt: expiresAt,
        );
        if (best == null ||
            (best.expiresAt == null ||
                candidate.expiresAt!.isAfter(best.expiresAt!))) {
          best = candidate;
        }
      }
    }

    return best ?? const StoreEntitlementSnapshot.inactive();
  }

  /// Reads Apple [Transaction.currentEntitlements] via StoreKit restore.
  static Future<StoreEntitlementSnapshot> readIosCurrentEntitlements(
    InAppPurchase iap,
  ) async {
    if (!Platform.isIOS || !InAppPurchaseStoreKitPlatform.isStoreKit2Enabled) {
      return const StoreEntitlementSnapshot.inactive();
    }

    final completer = Completer<StoreEntitlementSnapshot>();
    StreamSubscription<List<PurchaseDetails>>? sub;

    sub = iap.purchaseStream.listen(
      (purchases) {
        if (completer.isCompleted) return;
        completer.complete(snapshotFromPurchases(purchases));
      },
      onError: (_) {
        if (!completer.isCompleted) {
          completer.complete(const StoreEntitlementSnapshot.inactive());
        }
      },
    );

    try {
      await SK2Transaction.restorePurchases();
      return await completer.future.timeout(
        const Duration(seconds: 4),
        onTimeout: () => const StoreEntitlementSnapshot.inactive(),
      );
    } catch (_) {
      return const StoreEntitlementSnapshot.inactive();
    } finally {
      await sub.cancel();
    }
  }

  static Future<void> finishExpiredIosTransactions() async {
    if (!Platform.isIOS || !InAppPurchaseStoreKitPlatform.isStoreKit2Enabled) {
      return;
    }

    final now = DateTime.now();
    final transactions = await SK2Transaction.unfinishedTransactions();
    for (final tx in transactions) {
      if (!AppBillingConfig.isPremiumProduct(tx.productId)) continue;
      if (AppBillingConfig.isLifetimeProduct(tx.productId)) continue;

      final expiresAt = parseExpirationSeconds(tx.expirationDate) ??
          expirationFromJson(tx.jsonRepresentation);
      if (expiresAt != null && !expiresAt.isAfter(now)) {
        final id = int.tryParse(tx.id);
        if (id != null) {
          await SK2Transaction.finish(id);
        }
      }
    }
  }

  static Future<void> completePurchaseDetails(
    InAppPurchase iap,
    PurchaseDetails purchase,
  ) async {
    if (purchase.pendingCompletePurchase) {
      await iap.completePurchase(purchase);
    }

    if (Platform.isIOS &&
        purchase is SK2PurchaseDetails &&
        purchase.purchaseID != null) {
      final id = int.tryParse(purchase.purchaseID!);
      if (id != null) {
        try {
          await SK2Transaction.finish(id);
        } catch (_) {
          // Already finished or unavailable.
        }
      }
    }
  }
}
