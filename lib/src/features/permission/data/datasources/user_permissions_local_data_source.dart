import 'package:hotel/src/features/permission/data/datasources/user_permissions_remote_data_source.dart';
import 'package:hotel/src/features/permission/data/models/request/user_permissions_request_params.dart';
import 'package:hotel/src/features/permission/data/models/response/user_permissions_response_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserPermissionsRemoteDataSource)
class UserPermissionsLocalDataSource implements UserPermissionsRemoteDataSource {
  @override
  Future<UserPermissionsResponseModel> getUserPermissions(
      UserPermissionsRequestParams request) async {
    // Grant all permissions locally — no server needed
    return UserPermissionsResponseModel(
      success: true,
      userId: request.userId ?? '',
      features: [],
      totalFeatures: 0,
      totalPermissions: 0,
    );
  }
}
