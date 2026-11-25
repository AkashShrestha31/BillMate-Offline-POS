part of 'opening_cubit.dart';

@freezed
class OpeningState with _$OpeningState {
  const factory OpeningState.initial() = _Initial;

  const factory OpeningState.loading() = _Loading;

  const factory OpeningState.registersLoaded({
    required List<CashRegisterModel> registers,
  }) = _RegistersLoaded;

  const factory OpeningState.openSuccess({
    required CashRegisterModel register,
  }) = _OpenSuccess;

  const factory OpeningState.closeSuccess({
    required CashRegisterModel register,
  }) = _CloseSuccess;

  const factory OpeningState.deleteSuccess() = _DeleteSuccess;

  const factory OpeningState.migrateSuccess({required String message}) = _MigrateSuccess;

  const factory OpeningState.error({required String message}) = _Error;

  const factory OpeningState.noInternet() = _NoInternet;
}
