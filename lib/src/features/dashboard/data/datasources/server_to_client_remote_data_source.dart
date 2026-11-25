import 'package:dio/dio.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/features/dashboard/data/models/response/server_to_client_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class ServerToClientRemoteDataSource {
  Future<ServerToClientResponseModel> serverToClient();
}

// @LazySingleton(as: ServerToClientRemoteDataSource) — sync feature, not used offline
class ServerToClientRemoteSourceImpl implements ServerToClientRemoteDataSource {
  ServerToClientRemoteSourceImpl(@Named('authenticated') Dio dio) : _dio = dio;

  final Dio _dio;

  @override
  Future<ServerToClientResponseModel> serverToClient() async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.post(
        "${dotenv.env['BASE_URL']}${ApiEndPoints.serverToClient}",
        options: options,
      );

      return ServerToClientResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }
}
