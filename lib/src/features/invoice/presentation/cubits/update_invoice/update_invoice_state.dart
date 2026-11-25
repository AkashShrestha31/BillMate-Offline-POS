part of 'update_invoice_cubit.dart';

@freezed
class UpdateInvoiceState with _$UpdateInvoiceState {
  const factory UpdateInvoiceState.initial() = _Initial;
  const factory UpdateInvoiceState.loading() = _Loading;
  const factory UpdateInvoiceState.noInternet() = _NoInternet;
  const factory UpdateInvoiceState.error({required String message}) = _Error;
  const factory UpdateInvoiceState.success({required UpdateInvoiceResponseModel response}) = _Success;
}
