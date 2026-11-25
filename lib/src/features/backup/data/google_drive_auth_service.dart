import 'dart:io' show Platform;

import 'package:google_sign_in/google_sign_in.dart';
import 'package:hotel/src/features/backup/domain/drive_backup_state_storage.dart';
import 'package:injectable/injectable.dart';

/// iOS OAuth client for bundle `ai.billmate` (Google Sign-In / Drive).
const _iosGoogleClientId =
    '952990325742-49a78l949879vr5cmdjhqds7ebbrve7p.apps.googleusercontent.com';

@lazySingleton
class GoogleDriveAuthService {
  GoogleDriveAuthService()
      : _googleSignIn = GoogleSignIn(
          scopes: const [
            'https://www.googleapis.com/auth/drive.file',
          ],
          clientId: Platform.isIOS ? _iosGoogleClientId : null,
        );

  final GoogleSignIn _googleSignIn;

  GoogleSignIn get googleSignIn => _googleSignIn;

  Future<GoogleSignInAccount?> get currentUser async =>
      _googleSignIn.currentUser ?? await _googleSignIn.signInSilently();

  Future<bool> isSignedIn() async => (await currentUser) != null;

  Future<GoogleSignInAccount> signIn() async {
    final account = await _googleSignIn.signIn();
    if (account == null) {
      throw StateError('Google sign-in was cancelled.');
    }
    await DriveBackupStateStorage.saveAccountEmail(account.email);
    return account;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await DriveBackupStateStorage.clear();
  }

  Future<GoogleSignInAccount> ensureSignedIn() async {
    final existing = await currentUser;
    if (existing != null) return existing;
    return signIn();
  }
}
