import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/dashboard/data/models/response/server_to_client_response_model.dart';

abstract class ServerToClientRepository {
  Future<Either<AppError, ServerToClientResponseModel>> serverToClient();
}
