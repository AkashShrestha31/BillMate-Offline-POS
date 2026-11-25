class LoyaltyProgram {
  const LoyaltyProgram({
    required this.name,
    required this.fromDate,
    required this.toDate,
    required this.isEnabled,
    required this.conversionFactor,
    required this.expiryDuration,
    required this.expenseAccount,
  });

  final String name;
  final String fromDate;
  final String toDate;
  final bool isEnabled;
  final double conversionFactor;
  final int expiryDuration;
  final String expenseAccount;

  bool isActiveOn(DateTime date) {
    if (!isEnabled) return false;
    final day = DateTime(date.year, date.month, date.day);
    final from = DateTime.tryParse(fromDate);
    final to = DateTime.tryParse(toDate);
    if (from == null || to == null) return isEnabled;
    final fromDay = DateTime(from.year, from.month, from.day);
    final toDay = DateTime(to.year, to.month, to.day);
    return !day.isBefore(fromDay) && !day.isAfter(toDay);
  }
}

class PartyLoyaltySnapshot {
  const PartyLoyaltySnapshot({
    required this.partyName,
    required this.points,
    this.program,
  });

  final String partyName;
  final int points;
  final LoyaltyProgram? program;

  bool get canRedeem =>
      program != null &&
      program!.isActiveOn(DateTime.now()) &&
      points > 0 &&
      program!.conversionFactor > 0;
}
