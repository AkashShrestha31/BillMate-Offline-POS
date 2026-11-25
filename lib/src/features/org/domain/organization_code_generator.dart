import 'dart:math';

/// Generates a short organization code for local / offline tenants.
class OrganizationCodeGenerator {
  OrganizationCodeGenerator._();

  static const _alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

  /// Uppercase alphanumeric code (default length 6).
  static String generate({int length = 6}) {
    assert(length >= 4 && length <= 12);
    final random = Random.secure();
    return List.generate(
      length,
      (_) => _alphabet[random.nextInt(_alphabet.length)],
    ).join();
  }
}
