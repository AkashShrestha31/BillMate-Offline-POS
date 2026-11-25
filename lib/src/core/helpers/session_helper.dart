import 'package:hotel/src/core/helpers/logged_in_profile_store.dart';
import 'package:hotel/src/core/services/token_storage.dart';

/// Current user identity for offline mode (no JWT).
class SessionHelper {
  static Future<String?> getLoggedInEmail() async {
    final email = await TokenStorage.getUserLoginEmail();
    if (email == null || email.trim().isEmpty) return null;
    return email.trim().toLowerCase();
  }

  static Future<String?> getUserId() => getLoggedInEmail();

  static Future<String?> getUserIdentifierForPermissionsApi() =>
      getLoggedInEmail();

  static Future<void> clearSessionData() async {
    loggedInProfileStore.clear();
    await TokenStorage.clearSession();
  }
}
