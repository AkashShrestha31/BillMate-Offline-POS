import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/previous_stock_details_request_params.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/previous_stock_details_response_model.dart';
import 'package:hotel/src/features/reconciliation/domain/usecases/previous_stock_details_use_case.dart';

part 'previous_stock_details_state.dart';
part 'previous_stock_details_cubit.freezed.dart';

@injectable
class PreviousStockDetailsCubit extends Cubit<PreviousStockDetailsState> {
  PreviousStockDetailsCubit(this._useCase)
      : super(const PreviousStockDetailsState.initial());

  final PreviousStockDetailsUseCase _useCase;

  void getPreviousStockDetails({
    required PreviousStockDetailsRequestParams params,
  }) async {
    emit(const PreviousStockDetailsState.loading());

    emit(
      (await _useCase.execute(params: params)).fold(
        (error) => error.when(
          serverError: (serverError) =>
              PreviousStockDetailsState.error(message: serverError),
          noInternet: () => const PreviousStockDetailsState.noInternet(),
        ),
        (data) => PreviousStockDetailsState.success(response: data),
      ),
    );
  }

  void reset() {
    emit(const PreviousStockDetailsState.initial());
  }
}
