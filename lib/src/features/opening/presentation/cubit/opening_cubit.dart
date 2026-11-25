import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/opening/data/models/request/close_register_request.dart';
import 'package:hotel/src/features/opening/data/models/request/cash_register_query_params.dart';
import 'package:hotel/src/features/opening/data/models/request/open_register_request.dart';
import 'package:hotel/src/features/opening/data/models/response/cash_register_model.dart';
import 'package:hotel/src/features/opening/domain/usecases/close_register_use_case.dart';
import 'package:hotel/src/features/opening/domain/usecases/delete_register_use_case.dart';
import 'package:hotel/src/features/opening/domain/usecases/get_registers_use_case.dart';
import 'package:hotel/src/features/opening/domain/usecases/migrate_cash_register_use_case.dart';
import 'package:hotel/src/features/opening/domain/usecases/open_register_use_case.dart';

part 'opening_state.dart';
part 'opening_cubit.freezed.dart';

class OpeningCubit extends Cubit<OpeningState> {
  OpeningCubit(
    this._openRegisterUseCase,
    this._getRegistersUseCase,
    this._closeRegisterUseCase,
    this._deleteRegisterUseCase,
    this._migrateCashRegisterUseCase,
  ) : super(const OpeningState.initial());

  final OpenRegisterUseCase _openRegisterUseCase;
  final GetRegistersUseCase _getRegistersUseCase;
  final CloseRegisterUseCase _closeRegisterUseCase;
  final DeleteRegisterUseCase _deleteRegisterUseCase;
  final MigrateCashRegisterUseCase _migrateCashRegisterUseCase;

  void getRegisters({CashRegisterQueryParams? params}) async {
    emit(const OpeningState.loading());
    final result = await _getRegistersUseCase(params);
    result.fold(
      (error) => error.when(
        serverError: (message) => emit(OpeningState.error(message: message)),
        noInternet: () => emit(const OpeningState.noInternet()),
      ),
      (response) {
        final list = response.registers ?? (response.register != null ? [response.register!] : <CashRegisterModel>[]);
        emit(OpeningState.registersLoaded(registers: list));
      },
    );
  }

  void openRegister(OpenRegisterRequest request) async {
    emit(const OpeningState.loading());
    final result = await _openRegisterUseCase(request);
    result.fold(
      (error) => error.when(
        serverError: (message) => emit(OpeningState.error(message: message)),
        noInternet: () => emit(const OpeningState.noInternet()),
      ),
      (register) => emit(OpeningState.openSuccess(register: register)),
    );
  }

  void closeRegister(CloseRegisterRequest request) async {
    emit(const OpeningState.loading());
    final result = await _closeRegisterUseCase(request);
    result.fold(
      (error) => error.when(
        serverError: (message) => emit(OpeningState.error(message: message)),
        noInternet: () => emit(const OpeningState.noInternet()),
      ),
      (register) => emit(OpeningState.closeSuccess(register: register)),
    );
  }

  void deleteRegister(int registerId) async {
    emit(const OpeningState.loading());
    final result = await _deleteRegisterUseCase(registerId);
    result.fold(
      (error) => error.when(
        serverError: (message) => emit(OpeningState.error(message: message)),
        noInternet: () => emit(const OpeningState.noInternet()),
      ),
      (_) => emit(const OpeningState.deleteSuccess()),
    );
  }

  void migrate() async {
    emit(const OpeningState.loading());
    final result = await _migrateCashRegisterUseCase();
    result.fold(
      (error) => error.when(
        serverError: (message) => emit(OpeningState.error(message: message)),
        noInternet: () => emit(const OpeningState.noInternet()),
      ),
      (_) => emit(const OpeningState.migrateSuccess(message: 'Migration completed. You can now use the same register name for multiple shifts.')),
    );
  }

  void reset() {
    emit(const OpeningState.initial());
  }
}
