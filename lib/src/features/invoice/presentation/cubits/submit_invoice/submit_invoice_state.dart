part of 'submit_invoice_cubit.dart';

@freezed
class SubmitInvoiceState with _$SubmitInvoiceState {
  const factory SubmitInvoiceState.initial() = _Initial;
  const factory SubmitInvoiceState.loading() = _Loading;
  const factory SubmitInvoiceState.noInternet() = _NoInternet;
  const factory SubmitInvoiceState.error({required String message}) = _Error;
  const factory SubmitInvoiceState.success({required SubmitInvoiceResponseModel response}) = _Success;
}
