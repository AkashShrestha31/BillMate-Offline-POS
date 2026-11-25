/// Runs [worker] over [items] with a fixed concurrency limit.
Future<void> runWithConcurrency<T>({
  required List<T> items,
  required Future<void> Function(T item, int index) worker,
  int concurrency = 4,
}) async {
  if (items.isEmpty) return;

  var nextIndex = 0;
  Future<void> runWorker() async {
    while (true) {
      final index = nextIndex++;
      if (index >= items.length) return;
      await worker(items[index], index);
    }
  }

  final workers = concurrency.clamp(1, items.length);
  await Future.wait(List.generate(workers, (_) => runWorker()));
}
