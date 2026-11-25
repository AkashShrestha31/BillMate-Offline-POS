import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/dashboard/data/models/dashboard_summary_page_request_params.dart';
import 'package:hotel/src/features/dashboard/data/models/dashboard_summary_page_response_model.dart';
import 'package:hotel/src/features/dashboard/domain/usecases/dashboard_summary_page_use_case.dart';
import 'package:injectable/injectable.dart';

part 'dashboard_summary_page_state.dart';
part 'dashboard_summary_page_cubit.freezed.dart';

@injectable
class DashboardSummaryPageCubit extends Cubit<DashboardSummaryPageState> {
  DashboardSummaryPageCubit(this._useCase)
      : super(const DashboardSummaryPageState.initial());

  final DashboardSummaryPageUseCase _useCase;

  Future<void> getDashboardSummaryPage(
      {required DashboardSummaryPageRequestParams params}) async {
    if (isClosed) return;
    emit(const DashboardSummaryPageState.loading());

    final result = await _useCase.execute(params);
    if (isClosed) return;

    emit(result.fold(
        (error) => error.when(
            serverError: (serverError) =>
                DashboardSummaryPageState.error(message: serverError),
            noInternet: () => const DashboardSummaryPageState.noInternet()),
        (data) => DashboardSummaryPageState.success(
            dashboardSummaryPageResponseModel: data)));
  }
}
