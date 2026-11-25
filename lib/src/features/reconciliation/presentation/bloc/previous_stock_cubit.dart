import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/previous_stock_request_params.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/previous_stock_response_model.dart';
import 'package:hotel/src/features/reconciliation/domain/usecases/previous_stock_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/services/response/api_response.dart';

part 'previous_stock_state.dart';
part 'previous_stock_cubit.freezed.dart';

@injectable
class PreviousStockCubit extends Cubit<PreviousStockState> {
  PreviousStockCubit(this._useCase) : super(const PreviousStockState.initial());

  final PreviousStockUseCase _useCase; // Fixed: underscore instead of asterisk

  void getPreviousStock({required PreviousStockRequestParams params}) async {
    // Emit loading state first
    emit(const PreviousStockState.loading());

    // Add a small delay to ensure loading state is visible
    await Future.delayed(const Duration(milliseconds: 100));

    final result =
        await _useCase.execute(params); // Fixed: underscore instead of asterisk

    emit(
      result.fold(
        (error) => error.when(
          serverError: (serverError) =>
              PreviousStockState.error(message: serverError),
          noInternet: () => const PreviousStockState.noInternet(),
        ),
        (data) {
          return PreviousStockState.success(responseModel: data);
        },
      ),
    );
  }

  void reset() {
    emit(const PreviousStockState.initial());
  }
}
