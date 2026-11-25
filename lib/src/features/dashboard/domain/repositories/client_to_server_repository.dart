import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/dashboard/data/models/client_to_server_request_params.dart';
import 'package:hotel/src/features/dashboard/data/models/client_to_server_response_model.dart';

abstract class ClientToServerRepository {
  Future<Either<AppError, ClientToServerResponseModel>> clientToServer(
      {required ClientToServerRequestParams params});
}
