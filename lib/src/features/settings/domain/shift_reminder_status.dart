import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/features/opening/domain/repositories/opening_repository.dart';

/// Checks whether today's opening / closing still needs attention.
abstract final class ShiftReminderStatus {
  static String todayYmd() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  /// True when no cash register exists for today (opening not done).
  static Future<bool> needsOpeningToday() async {
    final repo = getIt<OpeningRepository>();
    final result = await repo.getCounterForDate(todayYmd());
    return result.fold((_) => true, (register) => register == null);
  }

  /// True when today's register exists and is still open (closing not done).
  static Future<bool> needsClosingToday() async {
    final repo = getIt<OpeningRepository>();
    final result = await repo.getCounterForDate(todayYmd());
    return result.fold(
      (_) => false,
      (register) => register != null && register.status == 'open',
    );
  }
}
