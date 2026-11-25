import 'package:auto_route/auto_route.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/features/org/presentation/org_navigation.dart';
import 'package:hotel/src/features/setup/domain/local_setup_service.dart';

/// After onboarding or splash, route to setup or the login gate.
Future<void> navigateAfterOnboarding(StackRouter router) async {
  if (await LocalSetupService.needsSetup()) {
    await router.replace(const LocalSetupRoute());
    return;
  }
  await navigateToLoginGate(router);
}
