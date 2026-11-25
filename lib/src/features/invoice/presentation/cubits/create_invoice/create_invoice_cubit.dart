import 'package:bloc/bloc.dart';
import 'package:hotel/src/features/invoice/data/models/request/create_invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/response/create_invoice_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/invoice/domain/usecases/create_invoice_use_case.dart';
import 'package:injectable/injectable.dart';

part 'create_invoice_state.dart';
part 'create_invoice_cubit.freezed.dart';

@injectable
class CreateInvoiceCubit extends Cubit<CreateInvoiceState> {
  CreateInvoiceCubit(this._useCase) : super(const CreateInvoiceState.initial());

  final CreateInvoiceUseCase _useCase;

  void createInvoice({required CreateInvoiceRequestParams params}) async {
    emit(const CreateInvoiceState.loading());
    emit(
      (await _useCase.execute(params)).fold(
        (error) => error.when(
          serverError: (serverError) => CreateInvoiceState.error(message: serverError),
          noInternet: () => const CreateInvoiceState.noInternet(),
        ),
        (data) => CreateInvoiceState.success(response: data),
      ),
    );
  }

  void reset() {
    emit(const CreateInvoiceState.initial());
  }
}
