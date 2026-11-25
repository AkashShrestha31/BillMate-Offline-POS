import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/services/local/local_db.dart';

/// Checks whether today's sales / purchase activity still needs a nudge.
abstract final class InvoiceActivityReminderStatus {
  static String todayYmd() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  /// True when there is no non-cancelled sales or purchase invoice for today.
  static Future<bool> needsActivityToday() async {
    try {
      final db = getIt<LocalDb>();
      final today = todayYmd();
      final where = 'date LIKE ? AND cancelled = 0';
      final args = <Object>['$today%'];

      final salesCount = await db.count(
        'SalesInvoice',
        where: where,
        whereArgs: args,
      );
      if (salesCount > 0) return false;

      final purchaseCount = await db.count(
        'PurchaseInvoice',
        where: where,
        whereArgs: args,
      );
      return purchaseCount == 0;
    } catch (_) {
      return false;
    }
  }
}
