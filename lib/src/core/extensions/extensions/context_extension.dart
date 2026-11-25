import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/helpers/employee_position_status.dart';
import 'package:hotel/src/core/helpers/logged_in_profile_store.dart';
import 'package:hotel/src/core/widget/kii_snackbar.dart';
import 'package:hotel/src/features/employee_management/data/models/response/employee_model.dart';
import 'package:hotel/src/features/employee_management/presentation/bloc/employee_cubit.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';

extension ContextX on BuildContext {
//   ///width and height getter
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

//   ///paddings getter
  EdgeInsets get padding => MediaQuery.of(this).padding;

  EdgeInsets get viewPadding => MediaQuery.of(this).viewPadding;

  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;

  ThemeData get themeData => Theme.of(this);

  ColorScheme get colorScheme => themeData.colorScheme;

  TextTheme get textStyle => themeData.textTheme;

  void showKiiSnackBarSuccess(String message) {
    ScaffoldMessenger.of(this).showSnackBar(KiiSnackBar.success(
      context: this,
      message: message,

    ));
  }

  void showKiiSnackBarError(String message) {
    ScaffoldMessenger.of(this).showSnackBar(KiiSnackBar.error(context: this, message: message));
  }

  void showKiiSnackBarWarning(String message) {
    ScaffoldMessenger.of(this).showSnackBar(KiiSnackBar.warning(context: this, message: message));
  }

  void showKiiSnackBarInfo(String message) {
    ScaffoldMessenger.of(this).showSnackBar(KiiSnackBar.info(context: this, message: message));
  }

  void clearSnackBars() {
    ScaffoldMessenger.of(this).clearSnackBars();
  }

  Future<Options> get authorizedOptions async {
    final orgSlug = await OrgStorage.getOrgSlug();
    return Options(
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if (orgSlug != null && orgSlug.isNotEmpty) 'X-Org-Slug': orgSlug,
      },
    );
  }

  EmployeeState get dashboardState => read<EmployeeCubit>().state;

  // Get only the responseData from DashboardSummaryPageCubit
  EmployeeModel? get employeeData {
    final cached = loggedInProfileStore.employee;
    if (cached != null) return cached;
    final state = read<EmployeeCubit>().state;
    return state.maybeWhen(
      employeeDetail: (responseData) => responseData,
      orElse: () => null,
    );
  }

  /// Full name from [employeeData] when the dashboard has loaded the current user.
  /// Empty if not loaded yet; estimate / print UIs typically show "—" when blank.
  String get loggedInUserFullName {
    final cached = loggedInProfileStore.displayName.trim();
    if (cached.isNotEmpty) return cached;
    return employeeData?.displayName.trim() ?? employeeData?.fullName.trim() ?? '';
  }

  /// Supervisor or Manager — see [isEmployeeSupervisorOrManager].
  bool get isSupervisorOrManager => isEmployeeSupervisorOrManagerFrom(employeeData);
}
