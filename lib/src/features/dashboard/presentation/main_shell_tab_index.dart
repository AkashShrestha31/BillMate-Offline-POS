import 'package:flutter/foundation.dart';

/// Main bottom shell tab index (shared with [PartyDetailsPage], quick actions, etc.).
///
/// 0 Home · 1 Sales · 2 Expenses · 3 Parties · 4 More
final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);

/// Bumped when the user taps the already-selected shell tab.
final ValueNotifier<int> shellTabReselectTick = ValueNotifier<int>(0);

const int kMainShellPartiesTabIndex = 3;
