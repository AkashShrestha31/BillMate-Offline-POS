import 'package:shared_preferences/shared_preferences.dart';

/// Local cache for premium entitlement (lifetime persists; subs refreshed via restore).
class SubscriptionEntitlementStorage {
  static const _keyActive = 'billing_premium_active';
  static const _keyLifetime = 'billing_premium_lifetime';
  static const _keyProductId = 'billing_premium_product_id';
  static const _keyPlanLabel = 'billing_premium_plan_label';
  static const _keyExpiresAtMs = 'billing_premium_expires_at_ms';

  Future<bool> get isPremiumActive async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyActive) ?? false;
  }

  Future<bool> get isLifetime async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyLifetime) ?? false;
  }

  Future<String?> get activeProductId async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyProductId);
  }

  Future<String?> get planLabel async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPlanLabel);
  }

  Future<DateTime?> get expiresAt async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getInt(_keyExpiresAtMs);
    if (raw == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(raw);
  }

  Future<void> grant({
    required String productId,
    required bool lifetime,
    required String planLabel,
    DateTime? expiresAt,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyActive, true);
    await prefs.setBool(_keyLifetime, lifetime);
    await prefs.setString(_keyProductId, productId);
    await prefs.setString(_keyPlanLabel, planLabel);
    if (lifetime || expiresAt == null) {
      await prefs.remove(_keyExpiresAtMs);
    } else {
      await prefs.setInt(_keyExpiresAtMs, expiresAt.millisecondsSinceEpoch);
    }
  }

  Future<void> revokeSubscriptionAccess() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_keyLifetime) ?? false) return;
    await prefs.setBool(_keyActive, false);
    await prefs.remove(_keyProductId);
    await prefs.remove(_keyPlanLabel);
    await prefs.remove(_keyExpiresAtMs);
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyActive);
    await prefs.remove(_keyLifetime);
    await prefs.remove(_keyProductId);
    await prefs.remove(_keyPlanLabel);
    await prefs.remove(_keyExpiresAtMs);
  }
}
