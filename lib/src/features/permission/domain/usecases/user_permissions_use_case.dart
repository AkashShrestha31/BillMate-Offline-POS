import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/permission/data/models/request/user_permissions_request_params.dart';
import 'package:hotel/src/features/permission/data/models/response/user_permissions_response_model.dart';
import 'package:hotel/src/features/permission/domain/repositories/user_permissions_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserPermissionsUseCase implements BaseUseCase<UserPermissionsRequestParams, UserPermissionsResponseModel> {
  final UserPermissionsRepository _repository;

  UserPermissionsUseCase(this._repository);

  @override
  Future<Either<AppError, UserPermissionsResponseModel>> execute(UserPermissionsRequestParams param) =>
      _repository.getUserPermissions(param);
}
