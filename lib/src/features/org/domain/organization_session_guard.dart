import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/helpers/session_helper.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:hotel/src/features/setup/domain/local_books_schema_ensurer.dart';

/// Signs the user out when the active organization database cannot support a session.
abstract final class OrganizationSessionGuard {
  static bool _invalidating = false;

  static bool isInvalidSessionError(Object? error) {
    final message = error?.toString().toLowerCase() ?? '';
    return message.contains('no such table') ||
        message.contains('no employees found') ||
        message.contains('local database is not initialized') ||
        message.contains('complete setup');
  }

  static Future<void> invalidateSessionAndNavigate(BuildContext context) async {
    if (_invalidating) return;
    _invalidating = true;
    try {
      await SessionHelper.clearSessionData();
      await OrgStorage.clear();
      LocalBooksSchemaEnsurer.resetSessionCache();
      await getIt<LocalDb>().resetConnection();
      if (context.mounted) {
        context.router.replaceAll([const OrganizationCodeRoute()]);
      }
    } finally {
      _invalidating = false;
    }
  }
}
