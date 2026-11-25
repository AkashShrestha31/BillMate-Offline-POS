/// Earn / redeem helpers for loyalty points.
///
/// [conversionFactor] = points awarded per 1.0 currency unit of eligible spend
/// (Frappe Books / ERPNext convention). Redeem value = points / factor.
abstract final class LoyaltyMath {
  static int pointsFromAmount(double amount, double conversionFactor) {
    if (amount <= 0 || conversionFactor <= 0) return 0;
    return (amount * conversionFactor).floor().clamp(0, 1 << 30);
  }

  static double amountFromPoints(int points, double conversionFactor) {
    if (points <= 0 || conversionFactor <= 0) return 0;
    return points / conversionFactor;
  }

  /// Max points a customer can redeem against [eligibleAmount] given balance.
  static int maxRedeemablePoints({
    required int balancePoints,
    required double eligibleAmount,
    required double conversionFactor,
  }) {
    if (balancePoints <= 0 || eligibleAmount <= 0 || conversionFactor <= 0) {
      return 0;
    }
    final maxByAmount = (eligibleAmount * conversionFactor).floor();
    return balancePoints < maxByAmount ? balancePoints : maxByAmount;
  }
}
