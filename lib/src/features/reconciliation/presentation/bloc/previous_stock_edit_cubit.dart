import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/previous_stock_bulk_edit_request_params.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/previous_stock_bulk_edit_response_model.dart';
import 'package:hotel/src/features/reconciliation/domain/usecases/previous_stock_edit_use_case.dart';
import 'package:injectable/injectable.dart';

part 'previous_stock_edit_state.dart';
part 'previous_stock_edit_cubit.freezed.dart';

@injectable
class PreviousStockEditCubit extends Cubit<PreviousStockEditState> {
  PreviousStockEditCubit(this._useCase) : super(const PreviousStockEditState.initial());

  final PreviousStockEditUseCase _useCase;

  void bulkEditPreviousStock({
    required PreviousStockBulkEditRequestParams params,
  }) async {
    emit(const PreviousStockEditState.loading());

    emit(
      (await _useCase.execute(params: params)).fold(
        (error) => error.when(
          serverError: (serverError) => PreviousStockEditState.error(message: serverError),
          noInternet: () => const PreviousStockEditState.noInternet(),
        ),
        (data) => PreviousStockEditState.success(response: data),
      ),
    );
  }

  void reset() {
    emit(const PreviousStockEditState.initial());
  }
}
