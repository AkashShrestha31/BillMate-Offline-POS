import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/internet/internet_info.dart';
import 'package:hotel/src/features/file_creation/data/datasources/file_creation_remote_data_source.dart';
import 'package:hotel/src/features/file_creation/data/models/request/file_creation_request_params.dart';
import 'package:hotel/src/features/file_creation/data/models/response/file_creation_details.dart';
import 'package:hotel/src/features/file_creation/domain/repositories/file_creation_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: FileCreationRepository)
class FileCreationRepositoryImpl implements FileCreationRepository {
  FileCreationRepositoryImpl(this._remoteDataSource, this._internetInfo);
  final FileCreationRemoteDataSource _remoteDataSource;
  final InternetInfo _internetInfo;

  @override
  Future<Either<AppError, FileCreationDetails>> getFileCreationDetails(
      {required FileCreationRequestParams params}) async {
    if (await _internetInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getFileCreationDetails(params: params);
        return right(response);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
    } else {
      return left(const AppError.noInternet());
    }
  }
}
