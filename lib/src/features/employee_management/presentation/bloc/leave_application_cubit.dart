import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/request/leave_application_request_params.dart';
import '../../data/models/request/leave_approval_request_params.dart';
import '../../data/models/response/leave_applications_list_response_model.dart';
import '../../data/models/response/leave_application_model.dart';
import '../../data/models/response/leave_balance_list_response_model.dart';
import '../../data/models/response/common_success_response_model.dart';
import '../../domain/usecases/get_leave_applications_use_case.dart';
import '../../domain/usecases/submit_leave_application_use_case.dart';
import '../../domain/usecases/approve_reject_leave_use_case.dart';
import '../../domain/usecases/get_leave_balance_use_case.dart';
import '../../domain/repositories/employee_management_repository.dart';

part 'leave_application_state.dart';
part 'leave_application_cubit.freezed.dart';

@injectable
class LeaveApplicationCubit extends Cubit<LeaveApplicationState> {
  LeaveApplicationCubit(
    this._getLeaveApplicationsUseCase,
    this._submitLeaveApplicationUseCase,
    this._approveRejectLeaveUseCase,
    this._getLeaveBalanceUseCase,
    this._repository,
  ) : super(const LeaveApplicationState.initial());

  final GetLeaveApplicationsUseCase _getLeaveApplicationsUseCase;
  final SubmitLeaveApplicationUseCase _submitLeaveApplicationUseCase;
  final ApproveRejectLeaveUseCase _approveRejectLeaveUseCase;
  final GetLeaveBalanceUseCase _getLeaveBalanceUseCase;
  final EmployeeManagementRepository _repository;

  void getLeaveApplications({
    int? employeeId,
    String? status,
    int? leaveTypeId,
    String? dateFrom,
    String? dateTo,
  }) async {
    emit(const LeaveApplicationState.loading());

    emit(
      (await _getLeaveApplicationsUseCase.execute(
        employeeId: employeeId,
        status: status,
        leaveTypeId: leaveTypeId,
        dateFrom: dateFrom,
        dateTo: dateTo,
      ))
          .fold(
        (error) => error.when(
          serverError: (serverError) =>
              LeaveApplicationState.error(message: serverError),
          noInternet: () => const LeaveApplicationState.noInternet(),
        ),
        (data) => LeaveApplicationState.loaded(response: data),
      ),
    );
  }

  void getLeaveApplicationById(int id) async {
    emit(const LeaveApplicationState.loading());

    emit(
      (await _repository.getLeaveApplicationById(id)).fold(
        (error) => error.when(
          serverError: (serverError) =>
              LeaveApplicationState.error(message: serverError),
          noInternet: () => const LeaveApplicationState.noInternet(),
        ),
        (data) => LeaveApplicationState.applicationDetail(application: data),
      ),
    );
  }

  void submitLeaveApplication({
    required LeaveApplicationRequestParams params,
  }) async {
    emit(const LeaveApplicationState.submitting());

    emit(
      (await _submitLeaveApplicationUseCase.execute(params: params)).fold(
        (error) => error.when(
          serverError: (serverError) =>
              LeaveApplicationState.error(message: serverError),
          noInternet: () => const LeaveApplicationState.noInternet(),
        ),
        (data) => LeaveApplicationState.submitSuccess(response: data),
      ),
    );
  }

  void updateLeaveApplication({
    required int id,
    required LeaveApplicationRequestParams params,
  }) async {
    emit(const LeaveApplicationState.submitting());

    emit(
      (await _repository.updateLeaveApplication(id, params)).fold(
        (error) => error.when(
          serverError: (serverError) =>
              LeaveApplicationState.error(message: serverError),
          noInternet: () => const LeaveApplicationState.noInternet(),
        ),
        (data) => LeaveApplicationState.submitSuccess(response: data),
      ),
    );
  }

  void approveRejectLeave({
    required int id,
    required LeaveApprovalRequestParams params,
  }) async {
    emit(const LeaveApplicationState.submitting());

    emit(
      (await _approveRejectLeaveUseCase.execute(id: id, params: params)).fold(
        (error) => error.when(
          serverError: (serverError) =>
              LeaveApplicationState.error(message: serverError),
          noInternet: () => const LeaveApplicationState.noInternet(),
        ),
        (data) => LeaveApplicationState.submitSuccess(response: data),
      ),
    );
  }

  void cancelLeaveApplication(int id) async {
    emit(const LeaveApplicationState.submitting());

    emit(
      (await _repository.cancelLeaveApplication(id)).fold(
        (error) => error.when(
          serverError: (serverError) =>
              LeaveApplicationState.error(message: serverError),
          noInternet: () => const LeaveApplicationState.noInternet(),
        ),
        (data) => LeaveApplicationState.submitSuccess(response: data),
      ),
    );
  }

  void getLeaveBalance({
    int? employeeId,
    int? year,
    int? leaveTypeId,
  }) async {
    emit(const LeaveApplicationState.loading());

    emit(
      (await _getLeaveBalanceUseCase.execute(
        employeeId: employeeId,
        year: year,
        leaveTypeId: leaveTypeId,
      ))
          .fold(
        (error) => error.when(
          serverError: (serverError) =>
              LeaveApplicationState.error(message: serverError),
          noInternet: () => const LeaveApplicationState.noInternet(),
        ),
        (data) => LeaveApplicationState.balanceLoaded(response: data),
      ),
    );
  }

  void reset() {
    emit(const LeaveApplicationState.initial());
  }
}
