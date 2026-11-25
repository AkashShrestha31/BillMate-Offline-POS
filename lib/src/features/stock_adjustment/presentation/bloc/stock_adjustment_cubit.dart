import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/stock_adjustment/data/models/request/stock_adjustment_request_params.dart';
import 'package:hotel/src/features/stock_adjustment/data/models/response/stock_adjustment_response_model.dart';
import 'package:hotel/src/features/stock_adjustment/domain/usecases/create_stock_adjustment_use_case.dart';
import 'package:hotel/src/features/stock_adjustment/domain/usecases/get_stock_adjustments_use_case.dart';
import 'package:injectable/injectable.dart';

part 'stock_adjustment_state.dart';
part 'stock_adjustment_cubit.freezed.dart';

@injectable
class StockAdjustmentCubit extends Cubit<StockAdjustmentState> {
  StockAdjustmentCubit(
    this._createUseCase,
    this._getUseCase,
  ) : super(const StockAdjustmentState.initial());

  final CreateStockAdjustmentUseCase _createUseCase;
  final GetStockAdjustmentsUseCase _getUseCase;

  void createStockAdjustment(
      {required StockAdjustmentRequestParams params}) async {
    emit(const StockAdjustmentState.loading());

    emit(
      (await _createUseCase.execute(params)).fold(
        (error) => error.when(
          serverError: (serverError) =>
              StockAdjustmentState.error(message: serverError),
          noInternet: () => const StockAdjustmentState.noInternet(),
        ),
        (data) => StockAdjustmentState.success(itemResponseModel: data),
      ),
    );
  }

  // void getStockAdjustments({
  //   int? page,
  //   int? perPage,
  //   String? sortOrder,
  // }) async {
  //   emit(const StockAdjustmentState.loading());
  //
  //   final params = GetStockAdjustmentsParams(
  //     page: page,
  //     perPage: perPage,
  //     sortOrder: sortOrder,
  //   );
  //
  //   emit(
  //     (await _getUseCase.execute(params)).fold(
  //       (error) => error.when(
  //         serverError: (serverError) => StockAdjustmentState.error(message: serverError),
  //         noInternet: () => const StockAdjustmentState.noInternet(),
  //       ),
  //       (data) => StockAdjustmentState.success(itemResponseModel: data.data),
  //     ),
  //   );
  // }

  void resetState() {
    emit(const StockAdjustmentState.initial());
  }
}
