import 'package:dio/dio.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/features/dashboard/data/models/client_to_server_request_params.dart';
import 'package:hotel/src/features/dashboard/data/models/client_to_server_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class ClientToServerRemoteDataSource {
  Future<ClientToServerResponseModel> clientToServer(
      {required ClientToServerRequestParams params});
}

// @LazySingleton(as: ClientToServerRemoteDataSource) — sync feature, not used offline
class ClientToServerRemoteSourceImpl implements ClientToServerRemoteDataSource {
  ClientToServerRemoteSourceImpl(@Named('authenticated') Dio dio) : _dio = dio;

  final Dio _dio;

  @override
  Future<ClientToServerResponseModel> clientToServer(
      {required ClientToServerRequestParams params}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.post(
        "${dotenv.env['BASE_URL']}${ApiEndPoints.clientToServer}",
        options: options,
        data: params.toJson(),
      );

      if (response.statusCode == 200) {
        return ClientToServerResponseModel.fromJson(response.data);
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }
}
