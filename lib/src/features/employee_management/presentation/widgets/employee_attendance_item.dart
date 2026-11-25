import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/widget/employee_profile_avatar.dart';

import '../../../../core/extensions/extensions/extensions.dart';
import '../../data/models/response/employee_model.dart';

class EmployeeAttendanceItem extends StatelessWidget {
  final EmployeeModel employee;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const EmployeeAttendanceItem({
    super.key,
    required this.employee,
    required this.onTap,
    this.onLongPress,
  });

  Color _getStatusColor() {
    switch (employee.employmentStatus.toUpperCase()) {
      case 'ACTIVE':
        return Colors.green;
      case 'INACTIVE':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EmployeeProfileAvatar(
                  profileImage: employee.profileImage,
                  initial: employee.firstName.isNotEmpty ? employee.firstName[0] : '?',
                  radius: 24,
                  backgroundColor: scheme.surfaceContainerHighest,
                  initialStyle: AppFonts.interStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: scheme.onSurface,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        employee.displayName,
                        style: AppFonts.interStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: scheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        employee.position,
                        style: AppFonts.interStyle(
                          fontSize: 13,
                          color: scheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.theme.appTheme.spacing8,
                    vertical: context.theme.appTheme.spacing4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(context.theme.appTheme.spacing4),
                    border: Border.all(
                      color: _getStatusColor().withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    employee.employmentStatus,
                    style: AppFonts.interStyle(
                      color: _getStatusColor(),
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
