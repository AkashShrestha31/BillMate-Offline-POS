import 'package:flutter/material.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/di/injection.dart';
import '../bloc/leave_application_cubit.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

class LeaveApplicationsListPage extends StatelessWidget {
  const LeaveApplicationsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LeaveApplicationCubit>()..getLeaveApplications(),
      child: const _LeaveApplicationsListView(),
    );
  }
}

class _LeaveApplicationsListView extends StatelessWidget {
  const _LeaveApplicationsListView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarIosBackButton(),
        title: Text('Leave Applications'),
      ),
      body: BlocBuilder<LeaveApplicationCubit, LeaveApplicationState>(
        builder: (context, state) {
          return state.when(
            initial: () => Center(child: Text('Loading...')),
            loading: () => Center(child: CircularProgressIndicator()),
            submitting: () => Center(child: CircularProgressIndicator()),
            noInternet: () => Center(child: Text('No internet')),
            error: (message) => Center(child: Text(message)),
            loaded: (response) {
              final applications = response.applications;
              
              if (applications.isEmpty) {
                return Center(child: Text('No leave applications'));
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<LeaveApplicationCubit>().getLeaveApplications();
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: applications.length,
                  itemBuilder: (context, index) {
                    final app = applications[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        title: Text(app.employeeName),
                        subtitle: Text(
                          '${app.leaveTypeName} • ${app.fromDate} to ${app.toDate}',
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(app.status).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            app.status,
                            style: AppFonts.interStyle(
                              color: _getStatusColor(app.status),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            applicationDetail: (_) => const SizedBox(),
            balanceLoaded: (_) => const SizedBox(),
            submitSuccess: (_) => const SizedBox(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Leave form coming soon!')),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'APPROVED':
        return Colors.green;
      case 'PENDING':
        return Colors.orange;
      case 'REJECTED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
