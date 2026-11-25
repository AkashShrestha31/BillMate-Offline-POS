import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/order/data/models/request/update_qot_status_request_params.dart';
import 'package:hotel/src/features/order/domain/repositories/order_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateQotStatusUseCase implements BaseUseCase<UpdateQotStatusRequestParams, Unit> {
  UpdateQotStatusUseCase(this._repository);

  final OrderRepository _repository;

  @override
  Future<Either<AppError, Unit>> execute(UpdateQotStatusRequestParams param) =>
      _repository.updateQotStatus(param);
}
