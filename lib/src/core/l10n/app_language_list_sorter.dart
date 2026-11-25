import 'package:hotel/src/core/l10n/app_language_option.dart';

/// Sorts language options using [tableOrder] from `languages.json`.
///
/// The suggested device language stays first; everything else keeps table order.
List<AppLanguageOption> sortLanguageOptionsByTable({
  required List<AppLanguageOption> options,
  required List<AppLanguageOption> tableOrder,
  String? suggestedCode,
}) {
  if (options.length <= 1) return List<AppLanguageOption>.from(options);

  final suggested = suggestedCode?.trim().toLowerCase();
  final orderIndex = <String, int>{
    for (var i = 0; i < tableOrder.length; i++) tableOrder[i].code: i,
  };

  final sorted = List<AppLanguageOption>.from(options);
  sorted.sort((a, b) {
    if (suggested != null && suggested.isNotEmpty) {
      if (a.code == suggested) return -1;
      if (b.code == suggested) return 1;
    }
    final ai = orderIndex[a.code] ?? tableOrder.length;
    final bi = orderIndex[b.code] ?? tableOrder.length;
    return ai.compareTo(bi);
  });
  return sorted;
}
