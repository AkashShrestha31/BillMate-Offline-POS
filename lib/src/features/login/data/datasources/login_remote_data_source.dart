import 'package:dio/dio.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/login/data/models/login_request_params.dart';
import 'package:hotel/src/features/login/data/models/login_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class LoginRemoteDataSource {
  Future<ApiResponse<LoginResponseModel>> postLoginToken(
      LoginRequestParams params);
}

// @LazySingleton(as: LoginRemoteDataSource) — local datasource is used for offline-first mode.
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  LoginRemoteDataSourceImpl(@Named('authenticated') Dio dio) : _dio = dio;

  final Dio _dio;

  @override
  Future<ApiResponse<LoginResponseModel>> postLoginToken(
      LoginRequestParams params) async {
    try {
      final response = await _dio.post(
          "${dotenv.env['BASE_URL']}${ApiEndPoints.login}",
          data: params.toJson());
      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        final loginResponse = LoginResponseModel.fromJson(responseData);
        return ApiResponse<LoginResponseModel>(
          data: loginResponse,
          message: "Successfully logged in !!!",
          success: true,
        );
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioError catch (e) {
      throw AppException.fromDioError(e);
    }
  }
}
