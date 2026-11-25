part of 'delete_invoice_cubit.dart';

@freezed
class DeleteInvoiceState with _$DeleteInvoiceState {
  const factory DeleteInvoiceState.initial() = _Initial;
  const factory DeleteInvoiceState.loading() = _Loading;
  const factory DeleteInvoiceState.noInternet() = _NoInternet;
  const factory DeleteInvoiceState.error({required String message}) = _Error;
  const factory DeleteInvoiceState.success({required DeleteInvoiceResponseModel response}) = _Success;
}
