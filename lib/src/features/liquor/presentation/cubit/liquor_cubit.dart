import 'package:bloc/bloc.dart';
import 'package:hotel/src/features/liquor/data/models/request/liquor_request_params.dart';
import 'package:hotel/src/features/liquor/data/models/request/liquor_create_request_params.dart';
import 'package:hotel/src/features/liquor/data/models/request/liquor_update_request_params.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/liquor/domain/usecases/delete_liquor_use_case.dart';
import 'package:hotel/src/features/liquor/domain/usecases/liquor_use_case.dart';
import 'package:hotel/src/features/liquor/domain/usecases/create_liquor_use_case.dart';
import 'package:hotel/src/features/liquor/domain/usecases/update_liquor_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/liquor/data/models/response/liquor_response_model.dart';

part 'liquor_state.dart';
part 'liquor_cubit.freezed.dart';

@injectable
class LiquorCubit extends Cubit<LiquorState> {
  LiquorCubit(
    this._liquorUseCase,
    this._createLiquorUseCase,
    this._updateLiquorUseCase,
    this._deleteLiquorUseCase,
  ) : super(const LiquorState.initial());

  final LiquorUseCase _liquorUseCase;
  final CreateLiquorUseCase _createLiquorUseCase;
  final UpdateLiquorUseCase _updateLiquorUseCase;
  final DeleteLiquorUseCase _deleteLiquorUseCase;

  void getLiquorItems({required LiquorRequestParams params}) async {
    emit(const LiquorState.loading());
    emit(
      (await _liquorUseCase.execute(params)).fold(
        (error) => error.when(
          serverError: (serverError) => LiquorState.error(message: serverError),
          noInternet: () => const LiquorState.noInternet(),
        ),
        (data) => LiquorState.success(liquorResponseModel: data),
      ),
    );
  }

  void createLiquorItem({required LiquorCreateRequestParams params}) async {
    emit(const LiquorState.loading());
    emit(
      (await _createLiquorUseCase.execute(params)).fold(
        (error) => error.when(
          serverError: (serverError) => LiquorState.error(message: serverError),
          noInternet: () => const LiquorState.noInternet(),
        ),
        (data) => LiquorState.created(liquorItem: data),
      ),
    );
  }

  void updateLiquorItem({required LiquorUpdateRequestParams params}) async {
    emit(const LiquorState.loading());
    emit(
      (await _updateLiquorUseCase.execute(params)).fold(
        (error) => error.when(
          serverError: (serverError) => LiquorState.error(message: serverError),
          noInternet: () => const LiquorState.noInternet(),
        ),
        (data) => LiquorState.updated(liquorItem: data),
      ),
    );
  }

  void deleteLiquorItem({required int params}) async {
    emit(const LiquorState.loading());
    emit(
      (await _deleteLiquorUseCase.execute(params)).fold(
        (error) => error.when(
          serverError: (serverError) => LiquorState.error(message: serverError),
          noInternet: () => const LiquorState.noInternet(),
        ),
        (data) => LiquorState.deleted(liquorItem: data),
      ),
    );
  }
}
