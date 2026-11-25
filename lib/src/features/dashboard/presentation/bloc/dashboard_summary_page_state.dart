part of 'dashboard_summary_page_cubit.dart';

@freezed
class DashboardSummaryPageState with _$DashboardSummaryPageState {
  const factory DashboardSummaryPageState.initial() = _Initial;

  const factory DashboardSummaryPageState.loading() = _Loading;

  const factory DashboardSummaryPageState.noInternet() = _NoInternet;

  const factory DashboardSummaryPageState.error({required String message}) =
      _Error;

  const factory DashboardSummaryPageState.success({
    required ApiResponse<DashboardSummaryPageResponseModel>
        dashboardSummaryPageResponseModel,
  }) = _Success;
}
