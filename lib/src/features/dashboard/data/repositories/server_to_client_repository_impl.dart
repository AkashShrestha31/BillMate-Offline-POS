import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/features/dashboard/data/datasources/server_to_client_remote_data_source.dart';
import 'package:hotel/src/features/dashboard/data/models/response/server_to_client_response_model.dart';
import 'package:hotel/src/features/dashboard/domain/repositories/server_to_client_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ServerToClientRepository)
class ServerToClientRepositoryImpl implements ServerToClientRepository {
  ServerToClientRepositoryImpl(this._dataSource);
  final ServerToClientRemoteDataSource _dataSource;

  @override
  Future<Either<AppError, ServerToClientResponseModel>> serverToClient() async {
    try {
      final response = await _dataSource.serverToClient();
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }
}
