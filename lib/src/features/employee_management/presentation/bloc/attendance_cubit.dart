import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/request/attendance_request_params.dart';
import '../../data/models/request/attendance_update_request_params.dart';
import '../../data/models/response/attendance_list_response_model.dart';
import '../../data/models/response/attendance_model.dart';
import '../../data/models/response/common_success_response_model.dart';
import '../../domain/usecases/get_attendance_use_case.dart';
import '../../domain/usecases/record_attendance_use_case.dart';
import '../../domain/repositories/employee_management_repository.dart';

part 'attendance_state.dart';
part 'attendance_cubit.freezed.dart';

@injectable
class AttendanceCubit extends Cubit<AttendanceState> {
  AttendanceCubit(
    this._getAttendanceUseCase,
    this._recordAttendanceUseCase,
    this._repository,
  ) : super(const AttendanceState.initial());

  final GetAttendanceUseCase _getAttendanceUseCase;
  final RecordAttendanceUseCase _recordAttendanceUseCase;
  final EmployeeManagementRepository _repository;

  void getAttendance({
    int? employeeId,
    String? dateFrom,
    String? dateTo,
    String? attendanceStatus,
  }) async {
    emit(const AttendanceState.loading());

    emit(
      (await _getAttendanceUseCase.execute(
        employeeId: employeeId,
        dateFrom: dateFrom,
        dateTo: dateTo,
        attendanceStatus: attendanceStatus,
      ))
          .fold(
        (error) => error.when(
          serverError: (serverError) => AttendanceState.error(message: serverError),
          noInternet: () => const AttendanceState.noInternet(),
        ),
        (data) => AttendanceState.loaded(response: data),
      ),
    );
  }

  void getAttendanceById(dynamic id) async {
    emit(const AttendanceState.loading());

    emit(
      (await _repository.getAttendanceById(id)).fold(
        (error) => error.when(
          serverError: (serverError) => AttendanceState.error(message: serverError),
          noInternet: () => const AttendanceState.noInternet(),
        ),
        (data) => AttendanceState.attendanceDetail(attendance: data),
      ),
    );
  }

  void recordAttendance({required AttendanceRequestParams params}) async {
    emit(const AttendanceState.submitting());

    emit(
      (await _recordAttendanceUseCase.execute(params: params)).fold(
        (error) => error.when(
          serverError: (serverError) => AttendanceState.error(message: serverError),
          noInternet: () => const AttendanceState.noInternet(),
        ),
        (data) => AttendanceState.submitSuccess(response: data),
      ),
    );
  }

  void updateAttendance({
    required AttendanceUpdateRequestParams params,
  }) async {
    emit(const AttendanceState.submitting());

    emit(
      (await _repository.updateAttendance(params)).fold(
        (error) => error.when(
          serverError: (serverError) => AttendanceState.error(message: serverError),
          noInternet: () => const AttendanceState.noInternet(),
        ),
        (data) => AttendanceState.submitSuccess(response: data),
      ),
    );
  }

  void deleteAttendance(int id) async {
    emit(const AttendanceState.submitting());

    emit(
      (await _repository.deleteAttendance(id)).fold(
        (error) => error.when(
          serverError: (serverError) => AttendanceState.error(message: serverError),
          noInternet: () => const AttendanceState.noInternet(),
        ),
        (data) => AttendanceState.submitSuccess(response: data),
      ),
    );
  }

  void reset() {
    emit(const AttendanceState.initial());
  }
}
