import 'package:dio/dio.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/features/file_creation/data/models/request/file_creation_request_params.dart';
import 'package:hotel/src/features/file_creation/data/models/response/file_creation_details.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class FileCreationRemoteDataSource {
  Future<FileCreationDetails> getFileCreationDetails({required FileCreationRequestParams params});
}

@LazySingleton(as: FileCreationRemoteDataSource)
class FileCreationRemoteDataSourceImpl implements FileCreationRemoteDataSource {
  FileCreationRemoteDataSourceImpl(@Named('authenticated') Dio dio) : _dio = dio;

  final Dio _dio;

  @override
  Future<FileCreationDetails> getFileCreationDetails({required FileCreationRequestParams params}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.post(
        options: options,
        "${dotenv.env['BASE_URL']}${ApiEndPoints.fileCreationDetails}",
        data: params.toJson(),
      );

      if (response.statusCode == 200) {
        return FileCreationDetails.fromJson(response.data);
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }
}
