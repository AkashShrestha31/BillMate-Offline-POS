import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/order/data/models/request/update_qot_request_params.dart';
import 'package:hotel/src/features/order/domain/repositories/order_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateQotUseCase implements BaseUseCase<UpdateQotRequestParams, Unit> {
  UpdateQotUseCase(this._repository);

  final OrderRepository _repository;

  @override
  Future<Either<AppError, Unit>> execute(UpdateQotRequestParams param) => _repository.updateQot(param);
}
