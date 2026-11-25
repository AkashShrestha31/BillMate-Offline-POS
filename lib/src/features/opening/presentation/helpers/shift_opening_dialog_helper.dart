import 'package:flutter/material.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/navigation/root_navigator.dart';
import 'package:hotel/src/core/helpers/logged_in_profile_store.dart';
import 'package:hotel/src/features/opening/data/models/request/cash_register_query_params.dart';
import 'package:hotel/src/features/opening/domain/repositories/opening_repository.dart';
import 'package:hotel/src/features/opening/presentation/cubit/opening_cubit.dart';
import 'package:hotel/src/features/opening/presentation/widgets/opening_control_sheet.dart';
import 'package:hotel/src/features/settings/domain/invoice_activity_reminder_status.dart';
import 'package:hotel/src/features/settings/domain/shift_reminder_status.dart';
import 'package:hotel/src/features/settings/presentation/widgets/invoice_activity_reminder_prompts.dart';
import 'package:hotel/src/features/settings/presentation/widgets/shift_reminder_prompts.dart';

/// Notification payload values stored on scheduled local notifications.
abstract final class ShiftNotificationPayload {
  static const opening = 'shift_opening';
  static const closing = 'shift_closing';
  static const activity = 'invoice_activity';
}

/// Shows opening / closing sheets when a shift reminder notification is tapped.
class ShiftOpeningDialogHelper {
  ShiftOpeningDialogHelper._();

  static String _employeeEmail() => loggedInProfileStore.employee?.email ?? '';

  static Future<void> handlePayload(String? payload) async {
    if (payload == null || payload.isEmpty) return;

    await Future<void>.delayed(const Duration(milliseconds: 400));

    final context = RootNavigator.context;
    if (context == null || !context.mounted) return;

    switch (payload) {
      case ShiftNotificationPayload.opening:
        if (!await ShiftReminderStatus.needsOpeningToday()) return;
        if (!context.mounted) return;
        await ShiftReminderPrompts.showOpening(context);
      case ShiftNotificationPayload.closing:
        if (!await ShiftReminderStatus.needsClosingToday()) return;
        if (!context.mounted) return;
        await ShiftReminderPrompts.showClosing(context);
      case ShiftNotificationPayload.activity:
        if (!await InvoiceActivityReminderStatus.needsActivityToday()) return;
        if (!context.mounted) return;
        await InvoiceActivityReminderPrompts.show(context);
    }
  }

  static Future<void> showOpenDialog(BuildContext context) async {
    final cubit = getIt<OpeningCubit>();
    final email = _employeeEmail();
    final repo = getIt<OpeningRepository>();

    OpeningControlSheet.show(
      context: context,
      onOpen: cubit.openRegister,
      openedBy: email,
      closedBy: email,
      getCounterForDate: (shiftDate) async {
        final result = await repo.getCounterForDate(shiftDate);
        return result.fold((_) => null, (r) => r);
      },
      onRequestCloseRegister: (existing) {
        OpeningControlSheet.showClose(
          context: context,
          register: existing,
          onClose: cubit.closeRegister,
          closedBy: email,
        );
      },
    );
  }

  static Future<void> showCloseDialog(BuildContext context) async {
    final cubit = getIt<OpeningCubit>();
    final email = _employeeEmail();

    cubit.getRegisters(params: const CashRegisterQueryParams(status: 'open'));

    final state = await cubit.stream.firstWhere(
      (s) => s.maybeWhen(
        registersLoaded: (_) => true,
        error: (_) => true,
        noInternet: () => true,
        orElse: () => false,
      ),
    );

    if (!context.mounted) {
      await cubit.close();
      return;
    }

    await state.maybeWhen(
      registersLoaded: (registers) async {
        final openRegisters = registers.where((r) => r.status == 'open').toList();
        if (openRegisters.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No open register found to close')),
          );
          return;
        }
        OpeningControlSheet.showClose(
          context: context,
          register: openRegisters.first,
          onClose: cubit.closeRegister,
          closedBy: email,
        );
      },
      error: (message) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      },
      noInternet: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No internet connection')),
        );
      },
      orElse: () {},
    );

    await cubit.close();
  }
}
