part of 'dashboard_cubit.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState.initial() = _Initial;
  const factory DashboardState.loading() = _Loading;
  const factory DashboardState.noInternet() = _NoInternet;
  const factory DashboardState.error({required String message}) = _Error;
  const factory DashboardState.loaded({
    required DashboardResponseModel response,
  }) = _Loaded;
  const factory DashboardState.reportLoaded({
    required Map<String, dynamic> reportData,
  }) = _ReportLoaded;
}
