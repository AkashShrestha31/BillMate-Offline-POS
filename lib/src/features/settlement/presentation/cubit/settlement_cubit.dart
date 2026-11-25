import 'package:bloc/bloc.dart';
import 'package:hotel/src/features/settlement/data/models/request/settlement_request_params.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/settlement/domain/usecases/settlement_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/settlement/data/models/response/settlement_response_model.dart';

part 'settlement_state.dart';
part 'settlement_cubit.freezed.dart';

@injectable
class SettlementCubit extends Cubit<SettlementState> {
  SettlementCubit(this._useCase) : super(const SettlementState.initial());

  final SettlementUseCase _useCase;

  void createSettlement({required SettlementRequestParams params}) async {
    emit(const SettlementState.loading());
    emit(
      (await _useCase.execute(params)).fold(
        (error) => error.when(
          serverError: (serverError) =>
              SettlementState.error(message: serverError),
          noInternet: () => const SettlementState.noInternet(),
        ),
        (data) {
          return SettlementState.success(responseModel: data);
        },
      ),
    );
  }

  void reset() {
    emit(const SettlementState.initial());
  }
}
