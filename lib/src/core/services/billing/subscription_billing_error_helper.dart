/// Maps StoreKit / billing failures to UI-safe signals (no raw platform text).
abstract final class SubscriptionBillingErrorHelper {
  static bool isTechnicalError(String? message) {
    if (message == null || message.isEmpty) return false;
    final lower = message.toLowerCase();
    return lower.contains('platformexception') ||
        lower.contains('storekit') ||
        lower.contains('failed_to_fetch') ||
        lower.contains('socketexception') ||
        lower.contains('network') ||
        lower.contains('internet') ||
        lower.contains('offline') ||
        lower.contains('connection') ||
        lower.contains('purchase failed');
  }

  static bool isTechnicalException(Object? error) =>
      isTechnicalError(error?.toString());
}
