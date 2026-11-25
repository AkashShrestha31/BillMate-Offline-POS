part of 'invoice_purchase_cubit.dart';

@freezed
class InvoicePurchaseState with _$InvoicePurchaseState {
  const factory InvoicePurchaseState.initial() = _Initial;

  const factory InvoicePurchaseState.loading() = _Loading;

  const factory InvoicePurchaseState.noInternet() = _NoInternet;

  const factory InvoicePurchaseState.error({required String message}) = _Error;

  const factory InvoicePurchaseState.success(
      {required ApiResponse<InvoiceSalesResponseModel>
          invoiceResponseModel}) = _Success;
}
