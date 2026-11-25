import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/response/dashboard_response_model.dart';
import '../../domain/usecases/get_dashboard_use_case.dart';
import '../../domain/repositories/employee_management_repository.dart';

part 'dashboard_state.dart';
part 'dashboard_cubit.freezed.dart';

@injectable
class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(this._getDashboardUseCase, this._repository)
      : super(const DashboardState.initial());

  final GetDashboardUseCase _getDashboardUseCase;
  final EmployeeManagementRepository _repository;

  void getDashboard() async {
    emit(const DashboardState.loading());

    emit(
      (await _getDashboardUseCase.execute()).fold(
        (error) => error.when(
          serverError: (serverError) =>
              DashboardState.error(message: serverError),
          noInternet: () => const DashboardState.noInternet(),
        ),
        (data) => DashboardState.loaded(response: data),
      ),
    );
  }

  void getReport({
    required String reportType,
    String? dateFrom,
    String? dateTo,
    String? department,
    int? employeeId,
  }) async {
    emit(const DashboardState.loading());

    emit(
      (await _repository.getReport(
        reportType: reportType,
        dateFrom: dateFrom,
        dateTo: dateTo,
        department: department,
        employeeId: employeeId,
      ))
          .fold(
        (error) => error.when(
          serverError: (serverError) =>
              DashboardState.error(message: serverError),
          noInternet: () => const DashboardState.noInternet(),
        ),
        (data) => DashboardState.reportLoaded(reportData: data),
      ),
    );
  }

  void reset() {
    emit(const DashboardState.initial());
  }
}
