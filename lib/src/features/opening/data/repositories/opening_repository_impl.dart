import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/internet/internet_info.dart';
import 'package:hotel/src/features/opening/data/datasources/opening_remote_data_source.dart';
import 'package:hotel/src/features/opening/data/models/request/close_register_request.dart';
import 'package:hotel/src/features/opening/data/models/request/cash_movement_request.dart';
import 'package:hotel/src/features/opening/data/models/request/cash_register_query_params.dart';
import 'package:hotel/src/features/opening/data/models/request/open_register_request.dart';
import 'package:hotel/src/features/opening/data/models/response/cash_register_list_response.dart';
import 'package:hotel/src/features/opening/data/models/response/cash_movement_model.dart';
import 'package:hotel/src/features/opening/data/models/response/cash_register_model.dart';
import 'package:hotel/src/features/opening/domain/repositories/opening_repository.dart';

class OpeningRepositoryImpl implements OpeningRepository {
  OpeningRepositoryImpl(this._remote, this._internetInfo);

  final OpeningRemoteDataSource _remote;
  // Kept for constructor compatibility with generated DI wiring.
  // ignore: unused_field
  final InternetInfo _internetInfo;

  @override
  Future<Either<AppError, void>> migrate() async {
    try {
      await _remote.migrate();
      return right(null);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, CashRegisterModel>> openRegister({
    required OpenRegisterRequest request,
  }) async {
    try {
      final result = await _remote.openRegister(request: request);
      return right(result);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, CashRegisterListResponse>> getRegisters({
    CashRegisterQueryParams? params,
  }) async {
    try {
      final result = await _remote.getRegisters(params: params);
      return right(result);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, CashRegisterModel?>> getCounterForDate(String shiftDate) async {
    try {
      final result = await _remote.getRegisters(
        params: CashRegisterQueryParams(shiftDate: shiftDate),
      );
      final list = result.registers;
      return right(list != null && list.isNotEmpty ? list.first : null);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, CashRegisterModel>> closeRegister({
    required CloseRegisterRequest request,
  }) async {
    try {
      final result = await _remote.closeRegister(request: request);
      return right(result);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, void>> deleteRegister({required int registerId}) async {
    try {
      await _remote.deleteRegister(registerId: registerId);
      return right(null);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, CashMovementModel>> recordCashMovement({
    required CashMovementRequest request,
  }) async {
    try {
      final result = await _remote.recordCashMovement(request: request);
      return right(result);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }
}
