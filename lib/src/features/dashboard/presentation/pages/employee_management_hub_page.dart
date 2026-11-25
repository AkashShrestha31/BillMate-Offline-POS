import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hotel/src/core/helpers/freemium_navigation.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/features/dashboard/presentation/widgets/more_hub_page_layout.dart';
import 'package:hotel/src/features/employee_management/presentation/pages/attendance_list_page.dart';
import 'package:hotel/src/features/employee_management/presentation/pages/employees_list_page.dart';

class EmployeeManagementHubPage extends StatelessWidget {
  const EmployeeManagementHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MoreHubPage(
      title: context.l10n.employeeManagement,
      children: [
        MoreHubTile(
          icon: Icons.groups_2_outlined,
          title: context.l10n.manageStaff,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => const EmployeesListPage(),
            ),
          ),
        ),
        MoreHubTile(
          icon: Icons.payments_outlined,
          title: context.l10n.payroll,
          onTap: () async {
            if (!await gateFreemiumFeature(context, FreemiumFeature.payroll)) {
              return;
            }
            if (!context.mounted) return;
            await context.router.push(PayrollListRoute());
          },
        ),
        MoreHubTile(
          icon: Icons.event_available_outlined,
          title: context.l10n.attendance,
          onTap: () async {
            if (!await gateFreemiumFeature(
              context,
              FreemiumFeature.attendance,
            )) {
              return;
            }
            if (!context.mounted) return;
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AttendanceListPage()),
            );
          },
        ),
      ],
    );
  }
}
