import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/dashboard/data/models/client_to_server_request_params.dart';
import 'package:hotel/src/features/dashboard/data/models/client_to_server_response_model.dart';
import 'package:hotel/src/features/dashboard/domain/repositories/client_to_server_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ClientToServerUseCase
    implements
        BaseUseCase<ClientToServerRequestParams, ClientToServerResponseModel> {
  final ClientToServerRepository _repository;

  ClientToServerUseCase(this._repository);

  @override
  Future<Either<AppError, ClientToServerResponseModel>> execute(
          ClientToServerRequestParams param) =>
      _repository.clientToServer(params: param);
}
