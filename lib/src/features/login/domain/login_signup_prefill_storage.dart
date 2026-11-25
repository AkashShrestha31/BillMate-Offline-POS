import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// One-time login prefill after manual organization setup.
///
/// Stores email + password per org until the user completes their first
/// successful sign-in, then only email is prefilled on future visits.
class LoginSignupPrefillStorage {
  LoginSignupPrefillStorage._();

  static const _emailPrefix = 'login_signup_prefill_email_v1_';
  static const _passwordPrefix = 'login_signup_prefill_password_v1_';

  static Future<void> saveForActiveOrg({
    required String email,
    required String password,
  }) async {
    final orgSlug = (await OrgStorage.getOrgSlug())?.trim().toLowerCase();
    final normalizedEmail = email.trim().toLowerCase();
    final trimmedPassword = password;
    if (orgSlug == null ||
        orgSlug.isEmpty ||
        normalizedEmail.isEmpty ||
        trimmedPassword.isEmpty) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('$_emailPrefix$orgSlug', normalizedEmail);
    await prefs.setString('$_passwordPrefix$orgSlug', trimmedPassword);
  }

  static Future<({String email, String password})?> loadForActiveOrg() async {
    final orgSlug = (await OrgStorage.getOrgSlug())?.trim().toLowerCase();
    if (orgSlug == null || orgSlug.isEmpty) return null;

    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('$_emailPrefix$orgSlug')?.trim().toLowerCase();
    final password = prefs.getString('$_passwordPrefix$orgSlug');
    if (email == null ||
        email.isEmpty ||
        password == null ||
        password.isEmpty) {
      return null;
    }
    return (email: email, password: password);
  }

  static Future<void> clearForActiveOrg() async {
    final orgSlug = (await OrgStorage.getOrgSlug())?.trim().toLowerCase();
    if (orgSlug == null || orgSlug.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_emailPrefix$orgSlug');
    await prefs.remove('$_passwordPrefix$orgSlug');
  }
}
