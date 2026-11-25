import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/role/data/models/delete_role_options.dart';
import 'package:hotel/src/features/role/data/models/role_item.dart';
import 'package:hotel/src/features/role/data/models/role_request.dart';

abstract class RolesRepository {
  Future<Either<AppError, List<RoleItem>>> getRoles({String? search});
  Future<Either<AppError, RoleItem>> createRole(RoleRequest request);
  Future<Either<AppError, RoleItem>> updateRole({
    required String originalName,
    required RoleRequest request,
  });
  Future<Either<AppError, void>> deleteRole(
    String name, {
    DeleteRoleOptions options = const DeleteRoleOptions(),
  });
}
