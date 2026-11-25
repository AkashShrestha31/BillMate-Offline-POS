import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/features/party/data/models/request/create_party_request.dart';
import 'package:hotel/src/features/party/data/models/request/reconcile_party_request_params.dart';
import 'package:hotel/src/features/party/data/models/response/party_create_response_model.dart';
import 'package:hotel/src/features/party/data/models/response/reconcile_party_response.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/features/party/data/models/request/party_request_params.dart';
import 'package:hotel/src/features/party/data/models/request/update_party_request.dart';
import 'package:hotel/src/features/party/data/models/request/delete_party_request.dart';
import 'package:hotel/src/features/party/data/models/response/party_list_response_model.dart';
import 'package:hotel/src/features/party/data/models/response/party_detail_response_model.dart';
import 'package:hotel/src/features/party/data/models/response/party_update_response_model.dart';
import 'package:hotel/src/features/party/data/models/response/party_delete_response_model.dart';

abstract class PartyRemoteDataSource {
  Future<PartyListResponseModel> getPartyList({
    required PartyRequestParams params,
  });
  Future<PartyCreateResponseModel> createParty({
    required CreatePartyRequest request,
    String? imagePath,
  });
  Future<PartyDetailResponseModel> getPartyDetail({
    required String name,
  });

  Future<PartyUpdateResponseModel> updateParty({
    required UpdatePartyRequest request,
    String? imagePath,
    bool clearPartyImage = false,
  });

  Future<PartyDeleteResponseModel> deleteParty({
    required DeletePartyRequest request,
  });
  Future<ReconcilePartyResponse> reconcileParty({
    required ReconcilePartyRequestParams params,
  });
}

// @LazySingleton(as: PartyRemoteDataSource) — replaced by PartyLocalDataSource
class PartyRemoteDataSourceImpl implements PartyRemoteDataSource {
  PartyRemoteDataSourceImpl(
    @Named('authenticated') Dio dio,
  ) : _dio = dio;

  final Dio _dio;

  static String _multipartFilename(String filePath) {
    final normalized = filePath.replaceAll(r'\', '/');
    final i = normalized.lastIndexOf('/');
    return i >= 0 ? normalized.substring(i + 1) : normalized;
  }

  Future<FormData> _createPartyFormData(
    CreatePartyRequest request,
    String? imagePath,
  ) async {
    final map = Map<String, dynamic>.from(request.toJson())
      ..removeWhere((_, v) => v == null);
    final formData = FormData.fromMap(map);
    final path = imagePath?.trim();
    if (path != null && path.isNotEmpty) {
      final file = File(path);
      if (await file.exists()) {
        formData.files.add(
          MapEntry(
            'image',
            await MultipartFile.fromFile(
              path,
              filename: _multipartFilename(path),
            ),
          ),
        );
      }
    }
    return formData;
  }

  Future<FormData> _updatePartyFormData(
    UpdatePartyRequest request,
    String? imagePath,
  ) async {
    final map = Map<String, dynamic>.from(request.toJson())
      ..removeWhere((_, v) => v == null);
    final formData = FormData.fromMap(map);
    final path = imagePath?.trim();
    if (path != null && path.isNotEmpty) {
      final file = File(path);
      if (await file.exists()) {
        formData.files.add(
          MapEntry(
            'image',
            await MultipartFile.fromFile(
              path,
              filename: _multipartFilename(path),
            ),
          ),
        );
      }
    }
    return formData;
  }

  @override
  Future<PartyListResponseModel> getPartyList({
    required PartyRequestParams params,
  }) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final queryParams = params.toJson()..removeWhere((key, value) => value == null);

      final response = await _dio.get(
        options: options,
        ApiEndPoints.party,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return PartyListResponseModel.fromJson(response.data);
      } else {
        throw const AppException(message: 'Failed to fetch party list');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<PartyCreateResponseModel> createParty({
    required CreatePartyRequest request,
    String? imagePath,
  }) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final hasImage = imagePath != null && imagePath.trim().isNotEmpty;

      final response = await _dio.post(
        options: options,
        ApiEndPoints.party,
        data: hasImage
            ? await _createPartyFormData(request, imagePath)
            : request.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return PartyCreateResponseModel.fromJson(response.data);
      } else {
        throw const AppException(message: 'Failed to create party');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<PartyDetailResponseModel> getPartyDetail({
    required String name,
  }) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        options: options,
        ApiEndPoints.party,
        queryParameters: {'name': name},
      );

      if (response.statusCode == 200) {
        return PartyDetailResponseModel.fromJson(response.data);
      } else {
        throw const AppException(message: 'Failed to fetch party details');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<PartyUpdateResponseModel> updateParty({
    required UpdatePartyRequest request,
    String? imagePath,
    bool clearPartyImage = false,
  }) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final hasImage = imagePath != null && imagePath.trim().isNotEmpty;

      final Object data;
      if (hasImage) {
        data = await _updatePartyFormData(request, imagePath);
      } else if (clearPartyImage) {
        final map = Map<String, dynamic>.from(request.toJson())
          ..removeWhere((_, v) => v == null);
        map['image'] = null;
        data = map;
      } else {
        data = request.toJson();
      }

      final response = await _dio.put(
        options: options,
        ApiEndPoints.party,
        data: data,
      );

      if (response.statusCode == 200) {
        return PartyUpdateResponseModel.fromJson(response.data);
      } else {
        throw const AppException(message: 'Failed to update party');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<PartyDeleteResponseModel> deleteParty({
    required DeletePartyRequest request,
  }) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;

      final response = await _dio.delete(
        options: options,
        ApiEndPoints.party,
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return PartyDeleteResponseModel.fromJson(response.data);
      } else {
        throw const AppException(message: 'Failed to delete party');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<ReconcilePartyResponse> reconcileParty({
    required ReconcilePartyRequestParams params,
  }) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;

      final response = await _dio.post(ApiEndPoints.reconcileParty, data: params.toJson(), options: options);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ReconcilePartyResponse.fromJson(response.data);
      } else {
        throw const AppException(message: 'Failed to reconcile party');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }
}
