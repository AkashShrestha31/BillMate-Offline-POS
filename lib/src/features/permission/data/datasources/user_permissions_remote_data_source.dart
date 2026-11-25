import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/features/permission/data/models/request/user_permissions_request_params.dart';
import 'package:hotel/src/features/permission/data/models/response/user_permissions_response_model.dart';
import 'package:injectable/injectable.dart';

abstract class UserPermissionsRemoteDataSource {
  Future<UserPermissionsResponseModel> getUserPermissions(UserPermissionsRequestParams request);
}

// @LazySingleton(as: UserPermissionsRemoteDataSource)
class UserPermissionsRemoteDataSourceImpl implements UserPermissionsRemoteDataSource {
  UserPermissionsRemoteDataSourceImpl(@Named('authenticated') Dio dio) : _dio = dio;

  final Dio _dio;

  @override
  Future<UserPermissionsResponseModel> getUserPermissions(UserPermissionsRequestParams request) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        options: options,
        '${dotenv.env['BASE_URL']}${ApiEndPoints.userPermissions}',
        queryParameters: request.toQueryParams(),
      );
      if (response.statusCode == 200) {
        final raw = response.data;
        if (raw is! Map<String, dynamic>) {
          throw const AppException(message: 'Invalid user permissions response');
        }
        return UserPermissionsResponseModel.fromJson(raw);
      }
      throw const AppException(message: 'Failed to load user permissions');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }
}
