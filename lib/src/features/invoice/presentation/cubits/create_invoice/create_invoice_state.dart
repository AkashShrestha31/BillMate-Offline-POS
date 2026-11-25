part of 'create_invoice_cubit.dart';

@freezed
class CreateInvoiceState with _$CreateInvoiceState {
  const factory CreateInvoiceState.initial() = _Initial;
  const factory CreateInvoiceState.loading() = _Loading;
  const factory CreateInvoiceState.noInternet() = _NoInternet;
  const factory CreateInvoiceState.error({required String message}) = _Error;
  const factory CreateInvoiceState.success({required CreateInvoiceResponseModel response}) = _Success;
}
