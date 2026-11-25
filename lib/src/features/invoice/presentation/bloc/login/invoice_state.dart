part of 'invoice_cubit.dart';

@freezed
class InvoiceState with _$InvoiceState {
  const factory InvoiceState.initial() = _Initial;

  const factory InvoiceState.loading() = _Loading;

  const factory InvoiceState.noInternet() = _NoInternet;

  const factory InvoiceState.error({required String message}) = _Error;

  const factory InvoiceState.success(
      {required ApiResponse<InvoiceSalesResponseModel>
          invoiceResponseModel}) = _Success;
}
