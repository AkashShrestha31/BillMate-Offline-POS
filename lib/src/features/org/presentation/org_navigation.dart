import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:hotel/src/features/org/presentation/widgets/organization_picker_bottom_sheet.dart';

/// Pre-auth flow: organization code screen (if needed) then login.
Future<void> navigateToLoginGate(StackRouter router) async {
  if (await OrgStorage.hasOrgSlug()) {
    await router.replace(const LoginRoute());
  } else {
    await router.replace(const OrganizationCodeRoute());
  }
}

Future<bool> changeOrganization(BuildContext context) async {
  return showOrganizationPickerBottomSheet(
    context,
    source: OrganizationPickerSource.login,
  );
}
