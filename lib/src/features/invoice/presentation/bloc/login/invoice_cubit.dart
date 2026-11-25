import 'package:bloc/bloc.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/invoice/domain/usecases/invoice_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_sales_response_model.dart';

part 'invoice_state.dart';
part 'invoice_cubit.freezed.dart';

/// Appends [nextPage] invoices onto [previous], de-duplicating by [InvoiceItem.invoiceName].
/// Totals and [Pagination] come from [nextPage] (server party-wide aggregates on each response).
InvoiceSalesResponseModel mergeInvoiceSalesResponses(
  InvoiceSalesResponseModel previous,
  InvoiceSalesResponseModel nextPage,
) {
  final prevItems = previous.data ?? [];
  final nextItems = nextPage.data ?? [];
  final seen = <String>{};
  final merged = <InvoiceItem>[];

  void addUnique(List<InvoiceItem> list) {
    for (final i in list) {
      final name = i.invoiceName?.trim();
      if (name == null || name.isEmpty) {
        merged.add(i);
        continue;
      }
      if (seen.add(name)) merged.add(i);
    }
  }

  addUnique(prevItems);
  addUnique(nextItems);

  return InvoiceSalesResponseModel(
    data: merged.isEmpty ? null : merged,
    pagination: nextPage.pagination,
    total_quantity: nextPage.total_quantity,
    total_grand_total: nextPage.total_grand_total,
    total_outstanding_amount: nextPage.total_outstanding_amount,
    total_discount: nextPage.total_discount,
    total_not_submitted: nextPage.total_not_submitted,
    grand_payment_totals: nextPage.grand_payment_totals,
  );
}

@injectable
class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit(this._useCase) : super(const InvoiceState.initial());

  final InvoiceUseCase _useCase;

  /// When [append] is true, merges the new page into the current success payload (no full-screen loading).
  Future<void> invoice({
    required InvoiceRequestParams invoiceRequestParam,
    bool append = false,
  }) async {
    if (!append) {
      emit(const InvoiceState.loading());
    }

    final result = await _useCase.execute(invoiceRequestParam);
    emit(
      result.fold(
        (error) => error.when(
          serverError: (serverError) {
            if (append) {
              return state.maybeWhen(
                success: (inv) => InvoiceState.success(invoiceResponseModel: inv),
                orElse: () => InvoiceState.error(message: serverError),
              );
            }
            return InvoiceState.error(message: serverError);
          },
          noInternet: () {
            if (append) {
              return state.maybeWhen(
                success: (inv) => InvoiceState.success(invoiceResponseModel: inv),
                orElse: () => const InvoiceState.noInternet(),
              );
            }
            return const InvoiceState.noInternet();
          },
        ),
        (data) {
          if (!append) {
            return InvoiceState.success(invoiceResponseModel: data);
          }
          return state.maybeWhen(
            success: (prevApi) {
              final merged = mergeInvoiceSalesResponses(prevApi.data, data.data);
              return InvoiceState.success(
                invoiceResponseModel: ApiResponse(
                  success: data.success,
                  data: merged,
                  message: data.message,
                  code: data.code,
                ),
              );
            },
            orElse: () => InvoiceState.success(invoiceResponseModel: data),
          );
        },
      ),
    );
  }
}
