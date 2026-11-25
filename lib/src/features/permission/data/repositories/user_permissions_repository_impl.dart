import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/features/permission/data/datasources/user_permissions_remote_data_source.dart';
import 'package:hotel/src/features/permission/data/models/request/user_permissions_request_params.dart';
import 'package:hotel/src/features/permission/data/models/response/user_permissions_response_model.dart';
import 'package:hotel/src/features/permission/domain/repositories/user_permissions_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserPermissionsRepository)
class UserPermissionsRepositoryImpl implements UserPermissionsRepository {
  UserPermissionsRepositoryImpl(this._remoteDataSource);
  final UserPermissionsRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppError, UserPermissionsResponseModel>> getUserPermissions(
    UserPermissionsRequestParams request,
  ) async {
    try {
      final response = await _remoteDataSource.getUserPermissions(request);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }
}
