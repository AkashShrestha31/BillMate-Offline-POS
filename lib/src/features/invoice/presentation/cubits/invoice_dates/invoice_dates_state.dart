part of 'invoice_dates_cubit.dart';

@freezed
class InvoiceDatesState with _$InvoiceDatesState {
  const factory InvoiceDatesState.initial() = _Initial;
  const factory InvoiceDatesState.loading() = _Loading;
  const factory InvoiceDatesState.noInternet() = _NoInternet;
  const factory InvoiceDatesState.error({required String message}) = _Error;
  const factory InvoiceDatesState.success({
    required InvoiceDatesResponseModel response,
    required String invoiceType,
  }) = _Success;
}
