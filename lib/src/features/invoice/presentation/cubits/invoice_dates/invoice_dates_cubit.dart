import 'package:bloc/bloc.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_dates_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_dates_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/invoice/domain/usecases/invoice_dates_use_case.dart';
import 'package:injectable/injectable.dart';

part 'invoice_dates_state.dart';
part 'invoice_dates_cubit.freezed.dart';

@injectable
class InvoiceDatesCubit extends Cubit<InvoiceDatesState> {
  InvoiceDatesCubit(this._useCase) : super(const InvoiceDatesState.initial());

  final InvoiceDatesUseCase _useCase;

  void getInvoiceDates({required InvoiceDatesRequestParams params}) async {
    emit(const InvoiceDatesState.loading());
    emit(
      (await _useCase.execute(params)).fold(
        (error) => error.when(
          serverError: (serverError) => InvoiceDatesState.error(message: serverError),
          noInternet: () => const InvoiceDatesState.noInternet(),
        ),
        (data) => InvoiceDatesState.success(
              response: data,
              invoiceType: params.invoiceType ?? '',
            ),
      ),
    );
  }

  void reset() {
    emit(const InvoiceDatesState.initial());
  }
}
