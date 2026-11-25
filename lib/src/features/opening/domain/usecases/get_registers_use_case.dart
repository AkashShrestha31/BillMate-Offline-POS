import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/opening/data/models/request/cash_register_query_params.dart';
import 'package:hotel/src/features/opening/data/models/response/cash_register_list_response.dart';
import 'package:hotel/src/features/opening/domain/repositories/opening_repository.dart';

class GetRegistersUseCase {
  GetRegistersUseCase(this._repository);

  final OpeningRepository _repository;

  Future<Either<AppError, CashRegisterListResponse>> call([
    CashRegisterQueryParams? params,
  ]) =>
      _repository.getRegisters(params: params);
}
