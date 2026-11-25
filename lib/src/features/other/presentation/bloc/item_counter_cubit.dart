import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/other/data/models/item_counter_request_params.dart';
import 'package:hotel/src/features/other/data/models/item_counter_response_model.dart';
import 'package:hotel/src/features/other/domain/usecases/item_counter_use_case.dart';
import 'package:injectable/injectable.dart';

part 'item_counter_state.dart';
part 'item_counter_cubit.freezed.dart';

@injectable
class ItemCounterCubit extends Cubit<ItemCounterState> {
  ItemCounterCubit(this._useCase) : super(const ItemCounterState.initial());

  final ItemCounterUseCase _useCase;

  Future<void> getItemCounter(
      {required ItemCounterRequestParams params}) async {
    emit(const ItemCounterState.loading());
    emit((await _useCase.execute(params)).fold(
        (error) => error.when(
            serverError: (serverError) =>
                ItemCounterState.error(message: serverError),
            noInternet: () => const ItemCounterState.noInternet()),
        (data) => ItemCounterState.success(itemCounterResponseModel: data)));
  }
}
