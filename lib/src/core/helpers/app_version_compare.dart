/// Semantic version helpers (`major.minor.patch`, optional `+build`).
abstract final class AppVersionCompare {
  /// Parses `1.2.3` or `1.2.3+7` into semver `[1, 2, 3]` and build `7` (0 if omitted).
  static ({List<int> semver, int build}) parseFull(String version) {
    final trimmed = version.trim();
    final plus = trimmed.indexOf('+');
    final core = plus >= 0 ? trimmed.substring(0, plus) : trimmed;
    final buildPart = plus >= 0 ? trimmed.substring(plus + 1) : '';
    final build = int.tryParse(buildPart.trim()) ?? 0;

    final parts = core.split('.');
    if (parts.isEmpty) return (semver: [0], build: build);
    final semver = parts.map((p) => int.tryParse(p) ?? 0).toList();
    return (semver: semver, build: build);
  }

  /// Parses `1.2.3` or `1.2.3+7` into `[1, 2, 3]` (build suffix ignored).
  static List<int> parse(String version) => parseFull(version).semver;

  /// Negative if [a] < [b], zero if equal, positive if [a] > [b].
  /// Compares semver first, then build number when semver matches.
  static int compare(String a, String b) {
    final av = parseFull(a);
    final bv = parseFull(b);
    final len = av.semver.length > bv.semver.length
        ? av.semver.length
        : bv.semver.length;
    for (var i = 0; i < len; i++) {
      final ai = i < av.semver.length ? av.semver[i] : 0;
      final bi = i < bv.semver.length ? bv.semver[i] : 0;
      if (ai != bi) return ai.compareTo(bi);
    }
    return av.build.compareTo(bv.build);
  }

  static bool isLessThan(String current, String minimum) =>
      compare(current, minimum) < 0;
}
