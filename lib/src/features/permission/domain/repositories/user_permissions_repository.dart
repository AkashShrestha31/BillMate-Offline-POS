import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/permission/data/models/request/user_permissions_request_params.dart';
import 'package:hotel/src/features/permission/data/models/response/user_permissions_response_model.dart';

abstract class UserPermissionsRepository {
  Future<Either<AppError, UserPermissionsResponseModel>> getUserPermissions(UserPermissionsRequestParams request);
}
