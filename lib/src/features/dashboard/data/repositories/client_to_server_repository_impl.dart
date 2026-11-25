import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/features/dashboard/data/datasources/client_to_server_remote_data_source.dart';
import 'package:hotel/src/features/dashboard/data/models/client_to_server_request_params.dart';
import 'package:hotel/src/features/dashboard/data/models/client_to_server_response_model.dart';
import 'package:hotel/src/features/dashboard/domain/repositories/client_to_server_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ClientToServerRepository)
class ClientToServerRepositoryImpl implements ClientToServerRepository {
  ClientToServerRepositoryImpl(this._dataSource);
  final ClientToServerRemoteDataSource _dataSource;

  @override
  Future<Either<AppError, ClientToServerResponseModel>> clientToServer({
    required ClientToServerRequestParams params,
  }) async {
    try {
      final response = await _dataSource.clientToServer(params: params);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }
}
