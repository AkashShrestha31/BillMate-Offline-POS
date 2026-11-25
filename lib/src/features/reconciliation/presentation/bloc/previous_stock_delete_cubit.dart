import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/previous_stock_delete_response_model.dart';
import 'package:hotel/src/features/reconciliation/domain/usecases/previous_stock_delete_use_case.dart';
import 'package:injectable/injectable.dart';

part 'previous_stock_delete_state.dart';
part 'previous_stock_delete_cubit.freezed.dart';

@injectable
class PreviousStockDeleteCubit extends Cubit<PreviousStockDeleteState> {
  PreviousStockDeleteCubit(this._useCase)
      : super(const PreviousStockDeleteState.initial());

  final PreviousStockDeleteUseCase _useCase;

  Future<void> deletePreviousStockByDate({
    required String reportingDate,
  }) async {
    emit(const PreviousStockDeleteState.loading());

    final result = await _useCase.execute(reportingDate: reportingDate);

    emit(
      result.fold(
        (error) => error.when(
          serverError: (serverError) =>
              PreviousStockDeleteState.error(message: serverError),
          noInternet: () => const PreviousStockDeleteState.noInternet(),
        ),
        (data) => PreviousStockDeleteState.success(response: data),
      ),
    );
  }

  void reset() {
    emit(const PreviousStockDeleteState.initial());
  }
}

