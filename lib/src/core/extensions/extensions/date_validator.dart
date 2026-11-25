class DateFieldsValidator {
  /// Validates the day input field
  static String? validateDay(String? dayInput) {
    if (dayInput == null || dayInput.trim().isEmpty) {
      return "Enter expiry day";
    }
    int? day = int.tryParse(dayInput);
    if (day == null || day < 1 || day > 31) {
      return "Invalid day";
    }
    return null; // ✅ Valid day
  }

  /// Validates the month input field
  static String? validateMonth(String? monthInput) {
    if (monthInput == null || monthInput.trim().isEmpty) {
      return "Enter expiry month";
    }
    int? month = int.tryParse(monthInput);
    if (month == null || month < 1 || month > 12) {
      return "Invalid month";
    }
    return null; // ✅ Valid month
  }

  /// Validates the year input field
  static String? validateYear(String? yearInput) {
    if (yearInput == null || yearInput.trim().isEmpty) {
      return "Enter expiry year";
    }
    int? year = int.tryParse(yearInput);
    int currentYear = DateTime.now().year;
    if (year == null || year < currentYear) {
      return "Document expired";
    }
    return null; // ✅ Valid year
  }
}
