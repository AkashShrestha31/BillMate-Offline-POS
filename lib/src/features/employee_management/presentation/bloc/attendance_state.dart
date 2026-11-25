part of 'attendance_cubit.dart';

@freezed
class AttendanceState with _$AttendanceState {
  const factory AttendanceState.initial() = _Initial;
  const factory AttendanceState.loading() = _Loading;
  const factory AttendanceState.submitting() = _Submitting;
  const factory AttendanceState.noInternet() = _NoInternet;
  const factory AttendanceState.error({required String message}) = _Error;
  const factory AttendanceState.loaded({
    required AttendanceListResponseModel response,
  }) = _Loaded;
  const factory AttendanceState.attendanceDetail({
    required AttendanceModel attendance,
  }) = _AttendanceDetail;
  const factory AttendanceState.submitSuccess({
    required CommonSuccessResponseModel response,
  }) = _SubmitSuccess;
}
