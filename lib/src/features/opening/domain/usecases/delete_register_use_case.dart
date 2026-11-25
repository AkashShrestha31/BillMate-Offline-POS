import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/opening/domain/repositories/opening_repository.dart';

class DeleteRegisterUseCase {
  DeleteRegisterUseCase(this._repository);

  final OpeningRepository _repository;

  Future<Either<AppError, void>> call(int registerId) =>
      _repository.deleteRegister(registerId: registerId);
}
