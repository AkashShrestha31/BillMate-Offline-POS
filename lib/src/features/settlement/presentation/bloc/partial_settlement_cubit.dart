import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/settlement/data/models/request/partial_settlement_request_params.dart';
import 'package:hotel/src/features/settlement/data/models/response/partial_settlement_response_model.dart';
import 'package:hotel/src/features/settlement/domain/usecases/partial_settlement_use_case.dart';
import 'package:injectable/injectable.dart';

part 'partial_settlement_state.dart';
part 'partial_settlement_cubit.freezed.dart';

@injectable
class PartialSettlementCubit extends Cubit<PartialSettlementState> {
  PartialSettlementCubit(this._useCase) : super(const PartialSettlementState.initial());

  final PartialSettlementUseCase _useCase;

  void partialSettlement({required PartialSettlementRequestParams params}) async {
    emit(const PartialSettlementState.loading());
    emit(
      (await _useCase.execute(params)).fold(
        (error) => error.when(
          serverError: (serverError) => PartialSettlementState.error(message: serverError),
          noInternet: () => const PartialSettlementState.noInternet(),
        ),
        (data) => PartialSettlementState.success(responseModel: data),
      ),
    );
  }
}
