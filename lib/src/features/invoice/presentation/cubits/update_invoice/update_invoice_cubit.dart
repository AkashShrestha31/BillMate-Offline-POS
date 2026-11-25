import 'package:bloc/bloc.dart';
import 'package:hotel/src/features/invoice/data/models/request/update_invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_sales_response_model.dart';
import 'package:hotel/src/features/invoice/data/models/response/update_invoice_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/invoice/domain/usecases/update_invoice_use_case.dart';
import 'package:injectable/injectable.dart';

part 'update_invoice_state.dart';
part 'update_invoice_cubit.freezed.dart';

@injectable
class UpdateInvoiceCubit extends Cubit<UpdateInvoiceState> {
  UpdateInvoiceCubit(this._useCase) : super(const UpdateInvoiceState.initial());

  final UpdateInvoiceUseCase _useCase;

  void updateInvoice({required InvoiceItem params}) async {
    emit(const UpdateInvoiceState.loading());
    emit(
      (await _useCase.execute(params)).fold(
        (error) => error.when(
          serverError: (serverError) => UpdateInvoiceState.error(message: serverError),
          noInternet: () => const UpdateInvoiceState.noInternet(),
        ),
        (data) => UpdateInvoiceState.success(response: data),
      ),
    );
  }

  void reset() {
    emit(const UpdateInvoiceState.initial());
  }
}
