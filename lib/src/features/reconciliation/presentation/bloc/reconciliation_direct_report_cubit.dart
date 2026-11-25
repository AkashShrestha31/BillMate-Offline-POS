import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/reconciliation_direct_report_request.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/reconciliation_report_response.dart';
import 'package:hotel/src/features/reconciliation/domain/usecases/generate_reconciliation_direct_report_use_case.dart';
import 'package:injectable/injectable.dart';

part 'reconciliation_direct_report_state.dart';
part 'reconciliation_direct_report_cubit.freezed.dart';

@injectable
class ReconciliationDirectReportCubit
    extends Cubit<ReconciliationDirectReportState> {
  ReconciliationDirectReportCubit(this._useCase)
      : super(const ReconciliationDirectReportState.initial());

  final GenerateReconciliationDirectReportUseCase _useCase;

  Future<void> generateDirectReconciliationReport(
      {required ReconciliationDirectReportRequest request}) async {
    emit(const ReconciliationDirectReportState.loading());
    emit((await _useCase.call(request: request)).fold(
        (error) => error.when(
            serverError: (serverError) =>
                ReconciliationDirectReportState.error(message: serverError),
            noInternet: () =>
                const ReconciliationDirectReportState.noInternet()),
        (data) => ReconciliationDirectReportState.success(
            reconciliationDirectReportResponse: data)));
  }

  void resetToInitial() {
    emit(const ReconciliationDirectReportState.initial());
  }
}
