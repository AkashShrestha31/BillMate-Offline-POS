import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/opening/data/models/request/close_register_request.dart';
import 'package:hotel/src/features/opening/data/models/request/cash_movement_request.dart';
import 'package:hotel/src/features/opening/data/models/request/cash_register_query_params.dart';
import 'package:hotel/src/features/opening/data/models/request/open_register_request.dart';
import 'package:hotel/src/features/opening/data/models/response/cash_register_list_response.dart';
import 'package:hotel/src/features/opening/data/models/response/cash_movement_model.dart';
import 'package:hotel/src/features/opening/data/models/response/cash_register_model.dart';

abstract class OpeningRepository {
  Future<Either<AppError, void>> migrate();

  Future<Either<AppError, CashRegisterModel>> openRegister({
    required OpenRegisterRequest request,
  });

  Future<Either<AppError, CashRegisterListResponse>> getRegisters({
    CashRegisterQueryParams? params,
  });

  /// Returns the counter for the given date if any (only one per date).
  Future<Either<AppError, CashRegisterModel?>> getCounterForDate(String shiftDate);

  Future<Either<AppError, CashRegisterModel>> closeRegister({
    required CloseRegisterRequest request,
  });

  Future<Either<AppError, void>> deleteRegister({required int registerId});

  Future<Either<AppError, CashMovementModel>> recordCashMovement({
    required CashMovementRequest request,
  });
}
