/// Shared length limits for organization identity fields.
class OrganizationFieldLimits {
  OrganizationFieldLimits._();

  static const int maxNameLength = 70;

  static void assertNameLength(String value, {required String fieldLabel}) {
    if (value.trim().length > maxNameLength) {
      throw ArgumentError(
        '$fieldLabel must be at most $maxNameLength characters',
      );
    }
  }
}
