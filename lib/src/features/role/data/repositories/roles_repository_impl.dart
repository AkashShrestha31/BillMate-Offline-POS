import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/features/role/data/datasources/roles_remote_data_source.dart';
import 'package:hotel/src/features/role/data/models/delete_role_options.dart';
import 'package:hotel/src/features/role/data/models/role_item.dart';
import 'package:hotel/src/features/role/data/models/role_request.dart';
import 'package:hotel/src/features/role/domain/repositories/roles_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: RolesRepository)
class RolesRepositoryImpl implements RolesRepository {
  RolesRepositoryImpl(this._dataSource);

  final RolesRemoteDataSource _dataSource;

  Future<Either<AppError, T>> _guard<T>(Future<T> Function() call) async {
    try {
      return right(await call());
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, List<RoleItem>>> getRoles({String? search}) {
    return _guard(() => _dataSource.getRoles(search: search));
  }

  @override
  Future<Either<AppError, RoleItem>> createRole(RoleRequest request) {
    return _guard(() => _dataSource.createRole(request));
  }

  @override
  Future<Either<AppError, RoleItem>> updateRole({
    required String originalName,
    required RoleRequest request,
  }) {
    return _guard(
      () => _dataSource.updateRole(
        originalName: originalName,
        request: request,
      ),
    );
  }

  @override
  Future<Either<AppError, void>> deleteRole(
    String name, {
    DeleteRoleOptions options = const DeleteRoleOptions(),
  }) {
    return _guard(() => _dataSource.deleteRole(name, options: options));
  }
}
