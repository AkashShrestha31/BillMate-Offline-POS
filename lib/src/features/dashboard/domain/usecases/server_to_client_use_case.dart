import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/dashboard/data/models/response/server_to_client_response_model.dart';
import 'package:hotel/src/features/dashboard/domain/repositories/server_to_client_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ServerToClientUseCase implements BaseUseCase<void, ServerToClientResponseModel> {
  final ServerToClientRepository _repository;

  ServerToClientUseCase(this._repository);

  @override
  Future<Either<AppError, ServerToClientResponseModel>> execute(void param) =>
      _repository.serverToClient();
}
