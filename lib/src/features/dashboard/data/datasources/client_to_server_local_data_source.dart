import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/features/dashboard/data/datasources/client_to_server_remote_data_source.dart';
import 'package:hotel/src/features/dashboard/data/models/client_to_server_request_params.dart';
import 'package:hotel/src/features/dashboard/data/models/client_to_server_response_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ClientToServerRemoteDataSource)
class ClientToServerLocalDataSource implements ClientToServerRemoteDataSource {
  @override
  Future<ClientToServerResponseModel> clientToServer({
    required ClientToServerRequestParams params,
  }) async {
    // Sync to server not available in offline mode
    throw const AppException(message: 'Server sync not available in offline mode');
  }
}
