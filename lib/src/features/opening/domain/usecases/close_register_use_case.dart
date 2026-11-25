import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/opening/data/models/request/close_register_request.dart';
import 'package:hotel/src/features/opening/data/models/response/cash_register_model.dart';
import 'package:hotel/src/features/opening/domain/repositories/opening_repository.dart';

class CloseRegisterUseCase {
  CloseRegisterUseCase(this._repository);

  final OpeningRepository _repository;

  Future<Either<AppError, CashRegisterModel>> call(CloseRegisterRequest request) =>
      _repository.closeRegister(request: request);
}
