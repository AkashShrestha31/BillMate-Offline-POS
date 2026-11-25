import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/features/dashboard/data/datasources/server_to_client_remote_data_source.dart';
import 'package:hotel/src/features/dashboard/data/models/response/server_to_client_response_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ServerToClientRemoteDataSource)
class ServerToClientLocalDataSource implements ServerToClientRemoteDataSource {
  @override
  Future<ServerToClientResponseModel> serverToClient() async {
    // Sync from server not available in offline mode
    throw const AppException(message: 'Server sync not available in offline mode');
  }
}
