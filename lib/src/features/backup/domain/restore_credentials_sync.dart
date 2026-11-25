import 'package:hotel/src/features/backup/domain/models/organization_backup_meta.dart';
import 'package:hotel/src/features/setup/domain/local_setup_storage.dart';
import 'package:sqflite/sqflite.dart';

/// Restores offline login credentials after a Drive backup import.
///
/// Passwords are stored in device preferences, not SQLite, so they must be
/// carried in backup metadata (or reused when still present on this device).
class RestoreCredentialsSync {
  RestoreCredentialsSync._();

  static Future<void> applyAfterRestore({
    required OrganizationBackupMeta meta,
    required Database db,
  }) async {
    var email = meta.adminEmail?.trim().toLowerCase();
    var password = meta.adminPassword;

    email ??= await _readAccountingEmail(db);
    email ??= await _readFirstEmployeeEmail(db);

    if (password == null || password.isEmpty) {
      final storedEmail = await LocalSetupStorage.getSavedAdminEmail();
      final storedPassword = await LocalSetupStorage.getSavedAdminPassword();
      if (email != null &&
          storedEmail != null &&
          storedEmail.toLowerCase() == email &&
          storedPassword != null &&
          storedPassword.isNotEmpty) {
        password = storedPassword;
      }
    }

    if (email != null &&
        email.isNotEmpty &&
        password != null &&
        password.isNotEmpty) {
      await LocalSetupStorage.markCompleted(
        adminEmail: email,
        adminPassword: password,
      );
      return;
    }

    await LocalSetupStorage.markLegacyMigrated();
  }

  static Future<String?> _readAccountingEmail(Database db) async {
    try {
      final rows = await db.query(
        'SingleValue',
        columns: ['value'],
        where: 'parent = ? AND fieldname = ?',
        whereArgs: ['AccountingSettings', 'email'],
        limit: 1,
      );
      if (rows.isEmpty) return null;
      final value = rows.first['value']?.toString().trim().toLowerCase();
      return value != null && value.isNotEmpty ? value : null;
    } catch (_) {
      return null;
    }
  }

  static Future<String?> _readFirstEmployeeEmail(Database db) async {
    try {
      final rows = await db.query(
        'Employee',
        columns: ['email'],
        where: 'email IS NOT NULL AND email != ?',
        whereArgs: [''],
        limit: 1,
      );
      if (rows.isEmpty) return null;
      final value = rows.first['email']?.toString().trim().toLowerCase();
      return value != null && value.isNotEmpty ? value : null;
    } catch (_) {
      return null;
    }
  }
}
