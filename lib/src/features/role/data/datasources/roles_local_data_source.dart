import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/helpers/session_helper.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/services/billing/freemium_gate_service.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/role/data/datasources/roles_remote_data_source.dart';
import 'package:hotel/src/features/role/data/models/delete_role_options.dart';
import 'package:hotel/src/features/role/data/models/role_item.dart';
import 'package:hotel/src/features/role/data/models/role_request.dart';
import 'package:hotel/src/features/role/domain/protected_party_roles.dart';
import 'package:hotel/src/features/role/domain/role_table_bootstrap.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@LazySingleton(as: RolesRemoteDataSource)
class RolesLocalDataSource implements RolesRemoteDataSource {
  RolesLocalDataSource(this._db);

  final LocalDb _db;

  Future<void> _ensureReady() => RoleTableBootstrap(_db).ensureReady();

  @override
  Future<List<RoleItem>> getRoles({String? search}) async {
    await _ensureReady();
    try {
      final q = search?.trim().toLowerCase();
      final rows = q != null && q.isNotEmpty
          ? await _db.rawQuery(
              '''
SELECT r.*, (
  SELECT COUNT(*) FROM Party p WHERE LOWER(p.role) = LOWER(r.name)
) AS party_count
FROM Role r
WHERE LOWER(r.name) LIKE ? OR LOWER(COALESCE(r.description, '')) LIKE ?
ORDER BY r.sort_order ASC, r.name ASC
''',
              ['%$q%', '%$q%'],
            )
          : await _db.rawQuery(
              '''
SELECT r.*, (
  SELECT COUNT(*) FROM Party p WHERE LOWER(p.role) = LOWER(r.name)
) AS party_count
FROM Role r
ORDER BY r.sort_order ASC, r.name ASC
''',
            );
      return rows.map(_rowToItem).toList();
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<RoleItem> createRole(RoleRequest request) async {
    await _ensureReady();
    try {
      await getIt<FreemiumGateService>().assertCan(FreemiumFeature.partyRole);
      final name = request.name.trim();
      if (name.isEmpty) {
        throw const AppException(message: 'Role name is required');
      }
      final db = await _db.database;
      final existing = await db.query(
        'Role',
        where: 'LOWER(name) = ?',
        whereArgs: [name.toLowerCase()],
        limit: 1,
      );
      if (existing.isNotEmpty) {
        throw const AppException(message: 'A role with this name already exists');
      }

      final now = DateTime.now().toIso8601String();
      final actor =
          await SessionHelper.getUserIdentifierForPermissionsApi() ?? 'local';
      final maxOrder = Sqflite.firstIntValue(
            await db.rawQuery('SELECT COALESCE(MAX(sort_order), 0) FROM Role'),
          ) ??
          0;

      await db.insert('Role', {
        'name': name,
        'description': request.description?.trim(),
        'sort_order': request.sortOrder ?? (maxOrder + 1),
        'is_system': 0,
        'created_by': actor,
        'modified_by': actor,
        'created': now,
        'modified': now,
      });

      return RoleItem(
        name: name,
        description: request.description?.trim(),
        sortOrder: request.sortOrder ?? (maxOrder + 1),
      );
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<RoleItem> updateRole({
    required String originalName,
    required RoleRequest request,
  }) async {
    await _ensureReady();
    try {
      final db = await _db.database;
      final rows = await db.query(
        'Role',
        where: 'name = ?',
        whereArgs: [originalName],
        limit: 1,
      );
      if (rows.isEmpty) {
        throw const AppException(message: 'Role not found');
      }
      final newName = request.name.trim();
      if (newName.isEmpty) {
        throw const AppException(message: 'Role name is required');
      }

      if (newName.toLowerCase() != originalName.toLowerCase()) {
        final dup = await db.query(
          'Role',
          where: 'LOWER(name) = ?',
          whereArgs: [newName.toLowerCase()],
          limit: 1,
        );
        if (dup.isNotEmpty) {
          throw const AppException(message: 'A role with this name already exists');
        }
      }

      final now = DateTime.now().toIso8601String();
      final actor =
          await SessionHelper.getUserIdentifierForPermissionsApi() ?? 'local';

      await db.transaction((txn) async {
        if (newName.toLowerCase() != originalName.trim().toLowerCase()) {
          await txn.update(
            'Party',
            {'role': newName.toLowerCase()},
            where: 'LOWER(role) = ?',
            whereArgs: [originalName.trim().toLowerCase()],
          );
        }
        await txn.update(
          'Role',
          {
            'name': newName,
            if (request.description != null)
              'description': request.description!.trim(),
            if (request.sortOrder != null) 'sort_order': request.sortOrder,
            'modified_by': actor,
            'modified': now,
          },
          where: 'name = ?',
          whereArgs: [originalName],
        );
      });

      return RoleItem(
        name: newName,
        description: request.description?.trim(),
        sortOrder: request.sortOrder ??
            (rows.first['sort_order'] as int? ?? 0),
        isSystem: false,
      );
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<void> deleteRole(
    String name, {
    DeleteRoleOptions options = const DeleteRoleOptions(),
  }) async {
    await _ensureReady();
    try {
      final db = await _db.database;
      final rows = await db.query(
        'Role',
        where: 'name = ?',
        whereArgs: [name],
        limit: 1,
      );
      if (rows.isEmpty) {
        throw const AppException(message: 'Role not found');
      }
      final roleName = rows.first['name'] as String;

      final roleKey = roleName.trim().toLowerCase();
      final partyRows = await db.query(
        'Party',
        columns: ['name'],
        where: 'LOWER(role) = ?',
        whereArgs: [roleKey],
      );
      final partyCount = partyRows.length;

      if (partyCount > 0 &&
          options.transferPartiesToRole == null &&
          !options.deleteAssociatedParties) {
        throw AppException(
          message:
              '$partyCount ${partyCount == 1 ? 'party uses' : 'parties use'} this role',
        );
      }

      final now = DateTime.now().toIso8601String();
      final actor =
          await SessionHelper.getUserIdentifierForPermissionsApi() ?? 'local';

      if (partyCount > 0 && options.transferPartiesToRole != null) {
        final target = options.transferPartiesToRole!.trim();
        if (target.isEmpty) {
          throw const AppException(message: 'Choose a role to transfer parties to');
        }
        if (target.toLowerCase() == roleKey) {
          throw const AppException(message: 'Choose a different role to transfer to');
        }
        final targetRows = await db.query(
          'Role',
          where: 'LOWER(name) = ?',
          whereArgs: [target.toLowerCase()],
          limit: 1,
        );
        if (targetRows.isEmpty) {
          throw const AppException(message: 'Transfer target role not found');
        }
        final targetName = targetRows.first['name'] as String;

        await db.transaction((txn) async {
          await txn.update(
            'Party',
            {
              // Match how parties are stored elsewhere (lowercase role).
              'role': targetName.toLowerCase(),
              'modifiedBy': actor,
              'modified': now,
            },
            where: 'LOWER(role) = ?',
            whereArgs: [roleKey],
          );
          final deleted = await txn.delete(
            'Role',
            where: 'name = ?',
            whereArgs: [roleName],
          );
          if (deleted == 0) {
            throw const AppException(message: 'Role could not be deleted');
          }
        });
        return;
      }

      if (partyCount > 0 && options.deleteAssociatedParties) {
        await db.transaction((txn) async {
          for (final row in partyRows) {
            await txn.delete(
              'Party',
              where: 'name = ?',
              whereArgs: [row['name']],
            );
          }
          final deleted = await txn.delete(
            'Role',
            where: 'name = ?',
            whereArgs: [roleName],
          );
          if (deleted == 0) {
            throw const AppException(message: 'Role could not be deleted');
          }
        });
        return;
      }

      final deleted = await db.delete(
        'Role',
        where: 'name = ?',
        whereArgs: [roleName],
      );
      if (deleted == 0) {
        throw const AppException(message: 'Role could not be deleted');
      }
    } catch (e) {
      if (e is AppException) rethrow;
      final message = e.toString();
      if (message.contains('FOREIGN KEY constraint failed')) {
        throw const AppException(
          message:
              'Cannot delete: one or more parties have invoices, payments, or other records. Transfer them to another role instead.',
        );
      }
      throw AppException(message: message);
    }
  }

  RoleItem _rowToItem(Map<String, dynamic> r) {
    final name = r['name'] as String;
    return RoleItem(
      name: name,
      description: r['description'] as String?,
      sortOrder: (r['sort_order'] as num?)?.toInt() ?? 0,
      isSystem: ProtectedPartyRoles.isProtected(name),
      partyCount: (r['party_count'] as num?)?.toInt() ?? 0,
    );
  }
}
