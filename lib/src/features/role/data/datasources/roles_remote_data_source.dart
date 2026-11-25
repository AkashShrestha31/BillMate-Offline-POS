import 'package:hotel/src/features/role/data/models/delete_role_options.dart';
import 'package:hotel/src/features/role/data/models/role_item.dart';
import 'package:hotel/src/features/role/data/models/role_request.dart';

abstract class RolesRemoteDataSource {
  Future<List<RoleItem>> getRoles({String? search});
  Future<RoleItem> createRole(RoleRequest request);
  Future<RoleItem> updateRole({
    required String originalName,
    required RoleRequest request,
  });
  Future<void> deleteRole(
    String name, {
    DeleteRoleOptions options = const DeleteRoleOptions(),
  });
}
