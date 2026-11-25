import 'package:hotel/src/core/helpers/session_helper.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/role/domain/protected_party_roles.dart';
import 'package:sqflite/sqflite.dart';

/// Ensures [Role] exists and default party roles are present (existing DBs).
class RoleTableBootstrap {
  RoleTableBootstrap(this._db);

  final LocalDb _db;

  static const defaultRoles = [
    (name: 'Customer', description: 'Parties who buy from you', sortOrder: 1, isSystem: true),
    (name: 'Supplier', description: 'Parties you purchase from', sortOrder: 2, isSystem: true),
    (name: 'Both', description: 'Shows under Customer and Supplier tabs', sortOrder: 3, isSystem: true),
    (name: 'Employee', description: 'Staff linked as a party', sortOrder: 4, isSystem: true),
  ];

  static const createTableSql = '''
CREATE TABLE IF NOT EXISTS "Role" (
  "name" TEXT NOT NULL PRIMARY KEY,
  "description" TEXT,
  "sort_order" INTEGER NOT NULL DEFAULT 0,
  "is_system" INTEGER NOT NULL DEFAULT 0,
  "created_by" TEXT NOT NULL,
  "modified_by" TEXT NOT NULL,
  "created" DATETIME NOT NULL,
  "modified" DATETIME NOT NULL
)
''';

  Future<void> ensureReady() async {
    final db = await _db.database;
    await db.execute(createTableSql);

    final now = DateTime.now().toIso8601String();
    final actor =
        await SessionHelper.getUserIdentifierForPermissionsApi() ?? 'system';

    final existingCount = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM Role'),
        ) ??
        0;

    await db.transaction((txn) async {
      for (final role in defaultRoles) {
        // On an existing DB, only re-ensure built-in roles. Custom roles that
        // the user deleted must not be re-inserted on refresh.
        if (existingCount > 0 && !role.isSystem) continue;

        await txn.insert(
          'Role',
          {
            'name': role.name,
            'description': role.description,
            'sort_order': role.sortOrder,
            'is_system': role.isSystem ? 1 : 0,
            'created_by': actor,
            'modified_by': actor,
            'created': now,
            'modified': now,
          },
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }
      await _syncProtectedFlags(txn);
    });
  }

  static Future<void> _syncProtectedFlags(Transaction txn) async {
    for (final role in defaultRoles) {
      final protected = ProtectedPartyRoles.isProtected(role.name);
      final flag = protected ? 1 : 0;
      await txn.update(
        'Role',
        {'is_system': flag},
        where: 'LOWER(name) = ? AND is_system != ?',
        whereArgs: [role.name.toLowerCase(), flag],
      );
    }
  }
}
