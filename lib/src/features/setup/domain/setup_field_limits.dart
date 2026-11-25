/// Shared length limits for local setup admin fields.
class SetupFieldLimits {
  SetupFieldLimits._();

  static const int maxFullNameLength = 30;
  static const int maxEmailLength = 30;
  static const int maxBankNameLength = 40;

  static void assertFullNameLength(String value) {
    if (value.trim().length > maxFullNameLength) {
      throw ArgumentError(
        'Full name must be at most $maxFullNameLength characters',
      );
    }
  }

  static void assertEmailLength(String value) {
    if (value.trim().length > maxEmailLength) {
      throw ArgumentError(
        'Email must be at most $maxEmailLength characters',
      );
    }
  }

  static void assertBankNameLength(String value) {
    if (value.trim().length > maxBankNameLength) {
      throw ArgumentError(
        'Bank name must be at most $maxBankNameLength characters',
      );
    }
  }
}
