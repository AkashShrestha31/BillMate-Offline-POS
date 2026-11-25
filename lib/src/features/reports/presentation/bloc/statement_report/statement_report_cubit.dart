import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/services/billing/freemium_gate_service.dart';
import 'package:hotel/src/features/reports/data/models/request/statement_report_request.dart';
import 'package:hotel/src/features/reports/data/models/response/statement_report_response.dart';
import 'package:hotel/src/features/reports/domain/usecases/get_statement_report_use_case.dart';
import 'package:injectable/injectable.dart';

part 'statement_report_state.dart';
part 'statement_report_cubit.freezed.dart';

@injectable
class StatementReportCubit extends Cubit<StatementReportState> {
  StatementReportCubit(this._useCase) : super(const StatementReportState.initial());

  final GetStatementReportUseCase _useCase;

  Future<void> load(StatementReportRequest request) async {
    try {
      await getIt<FreemiumGateService>().assertCan(FreemiumFeature.reportStatement);
    } on AppException catch (e) {
      emit(StatementReportState.error(message: e.message));
      return;
    }
    emit(const StatementReportState.loading());
    emit(
      (await _useCase.execute(request)).fold(
        (error) => error.when(
          serverError: (message) => StatementReportState.error(message: message),
          noInternet: () => const StatementReportState.noInternet(),
        ),
        (data) => StatementReportState.success(response: data),
      ),
    );
  }

  void resetToInitial() {
    emit(const StatementReportState.initial());
  }
}
