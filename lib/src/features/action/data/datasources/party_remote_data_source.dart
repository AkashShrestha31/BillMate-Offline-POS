import 'package:dio/dio.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/action/data/models/request/party_request_params.dart';
import 'package:hotel/src/features/action/data/models/request/create_party_request.dart';
import 'package:hotel/src/features/action/data/models/request/party_update_request_params.dart';
import 'package:hotel/src/features/action/data/models/request/update_party_request.dart';
import 'package:hotel/src/features/action/data/models/response/party_response_model.dart';
import 'package:hotel/src/features/action/data/models/response/party_update_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class PartyRemoteDataSource {
  Future<ApiResponse<PartyResponseModel>> getParties(
      {required PartyRequestParams params});
  Future<ApiResponse<PartyResponseModel>> getPartyById({required String id});
  Future<ApiResponse<PartyResponseModel>> createParty(
      {required CreatePartyRequest request});
  Future<ApiResponse<PartyUpdateResponseModel>> updateParty(
      {required PartyUpdateRequestParams request});
  Future<ApiResponse<void>> deleteParty({required String id});
}

// @LazySingleton(as: PartyRemoteDataSource) — replaced by PartyLocalDataSource
class PartyRemoteSourceImpl implements PartyRemoteDataSource {
  PartyRemoteSourceImpl(@Named('authenticated') Dio dio) : _dio = dio;

  final Dio _dio;

  @override
  Future<ApiResponse<PartyResponseModel>> getParties(
      {required PartyRequestParams params}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        options: options,
        "${dotenv.env['BASE_URL']}${ApiEndPoints.party}",
        queryParameters: params.toQueryParams(),
      );
      if (response.statusCode == 200) {
        final body = Map<String, dynamic>.from(response.data as Map);
        // List API often returns only `{ success, data: [...] }` without `pagination`.
        if (body['pagination'] == null && body['data'] is List) {
          final list = body['data'] as List<dynamic>;
          final page = params.page ?? 1;
          final per = params.perPage ?? 20;
          final hasMore = list.length >= per;
          body['pagination'] = <String, dynamic>{
            'current_page': page,
            'per_page': per,
            'total_pages': hasMore ? page + 1 : page,
            'total_rows': list.length,
          };
        }
        return ApiResponse(
          data: PartyResponseModel.fromJson(body),
          message: 'Parties fetched successfully',
          success: true,
        );
      } else {
        throw const AppException(message: 'Failed to fetch parties');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<ApiResponse<PartyResponseModel>> getPartyById(
      {required String id}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        options: options,
        "${dotenv.env['BASE_URL']}${ApiEndPoints.party}/$id",
      );
      if (response.statusCode == 200) {
        return ApiResponse(
          data: PartyResponseModel.fromJson(response.data),
          message: 'Party fetched successfully',
          success: true,
        );
      } else {
        throw const AppException(message: 'Failed to fetch party');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<ApiResponse<PartyResponseModel>> createParty(
      {required CreatePartyRequest request}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.post(
        options: options,
        "${dotenv.env['BASE_URL']}${ApiEndPoints.party}",
        data: request.toJson(),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return ApiResponse(
          data: PartyResponseModel.fromJson(response.data),
          message: 'Party created successfully',
          success: true,
        );
      } else {
        throw const AppException(message: 'Failed to create party');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<ApiResponse<PartyUpdateResponseModel>> updateParty(
      {required PartyUpdateRequestParams request}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.put(
        options: options,
        "${dotenv.env['BASE_URL']}${ApiEndPoints.updateParty}",
        data: request.toJson(),
      );
      if (response.statusCode == 200) {
        return ApiResponse(
          data: PartyUpdateResponseModel.fromJson(response.data),
          message: 'Party updated successfully',
          success: true,
        );
      } else {
        throw const AppException(message: 'Failed to update party');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<ApiResponse<void>> deleteParty({required String id}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.delete(
        options: options,
        "${dotenv.env['BASE_URL']}${ApiEndPoints.party}/$id",
      );
      if (response.statusCode == 200 || response.statusCode == 204) {
        return ApiResponse(
          data: null,
          message: 'Party deleted successfully',
          success: true,
        );
      } else {
        throw const AppException(message: 'Failed to delete party');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }
}
