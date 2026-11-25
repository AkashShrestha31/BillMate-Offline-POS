import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hotel/src/features/app_lock/domain/app_lock_coordinator.dart';
import 'package:hotel/src/features/app_lock/domain/app_lock_service.dart';
import 'package:hotel/src/features/app_lock/presentation/pages/app_lock_unlock_page.dart';
import 'package:hotel/src/features/app_lock/presentation/widgets/app_pin_keypad_view.dart';
import 'package:hotel/src/features/org/domain/org_switch_coordinator.dart';

/// Blocks app content with a device PIN screen until unlocked.
class AppLockGate extends StatefulWidget {
  const AppLockGate({
    super.key,
    required this.child,
    this.appLockService,
  });

  final Widget child;
  final AppLockService? appLockService;

  @override
  State<AppLockGate> createState() => _AppLockGateState();
}

class _AppLockGateState extends State<AppLockGate> with WidgetsBindingObserver {
  late final AppLockService _service = widget.appLockService ?? AppLockService();

  bool _checkingLock = true;
  bool _lockRequired = false;
  bool _backgroundedSinceUnlock = false;
  bool _unlockedThisForegroundSession = false;
  bool _evaluationScheduled = false;
  bool _pendingForceEvaluation = false;
  bool _evaluationInProgress = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    OrgSwitchCoordinator.notifier.addListener(_onOrgChanged);
    AppLockCoordinator.evaluationTick.addListener(_onLockEvaluationRequested);
    AppLockCoordinator.sessionUnlockTick.addListener(_onSessionUnlocked);
    _scheduleEvaluateLock(force: true);
  }

  @override
  void dispose() {
    AppLockCoordinator.evaluationTick.removeListener(_onLockEvaluationRequested);
    AppLockCoordinator.sessionUnlockTick.removeListener(_onSessionUnlocked);
    OrgSwitchCoordinator.notifier.removeListener(_onOrgChanged);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _onOrgChanged() {
    _unlockedThisForegroundSession = false;
    _lockRequired = false;
    _scheduleEvaluateLock(force: true);
  }

  void _onLockEvaluationRequested() {
    _scheduleEvaluateLock();
  }

  void _onSessionUnlocked() {
    _applyState(() {
      _unlockedThisForegroundSession = true;
      _lockRequired = false;
      _checkingLock = false;
    });
  }

  void _scheduleEvaluateLock({bool force = false}) {
    _pendingForceEvaluation = _pendingForceEvaluation || force;
    if (_evaluationScheduled) return;

    _evaluationScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _evaluationScheduled = false;
      if (!mounted) return;
      final shouldForce = _pendingForceEvaluation;
      _pendingForceEvaluation = false;
      _evaluateLock(force: shouldForce);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        // Only mark background when the app is fully hidden (app switcher,
        // phone lock, home). Ignore [inactive] so control center, notifications,
        // and the system biometric sheet do not re-lock the app.
        _backgroundedSinceUnlock = true;
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.resumed:
        if (!_backgroundedSinceUnlock) break;
        _backgroundedSinceUnlock = false;
        if (!_unlockedThisForegroundSession) break;
        _unlockedThisForegroundSession = false;
        _lockRequired = false;
        _scheduleEvaluateLock(force: true);
    }
  }

  Future<void> _evaluateLock({bool force = false}) async {
    if (!mounted) return;
    if (_evaluationInProgress) return;
    if (_unlockedThisForegroundSession && !force) return;
    if (_lockRequired && !force) return;

    _evaluationInProgress = true;
    final showLoading = !_lockRequired;

    try {
      if (showLoading) {
        _applyState(() => _checkingLock = true);
      }

      final shouldLock = await _service.isLockEnabled();
      if (!mounted) return;

      _applyState(() {
        _checkingLock = false;
        _lockRequired = shouldLock;
      });
      if (shouldLock) _clearRootSnackBars();
    } finally {
      _evaluationInProgress = false;
    }
  }

  void _applyState(VoidCallback update) {
    if (!mounted) return;

    final phase = SchedulerBinding.instance.schedulerPhase;
    if (phase == SchedulerPhase.idle ||
        phase == SchedulerPhase.postFrameCallbacks) {
      setState(update);
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(update);
    });
  }

  void _clearRootSnackBars() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final messenger = ScaffoldMessenger.maybeOf(context);
      messenger?.hideCurrentSnackBar(reason: SnackBarClosedReason.remove);
      messenger?.clearSnackBars();
    });
  }

  void _onUnlocked() {
    setState(() {
      _unlockedThisForegroundSession = true;
      _lockRequired = false;
      _checkingLock = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final shouldObscure =
        !_unlockedThisForegroundSession && (_checkingLock || _lockRequired);

    return Stack(
      fit: StackFit.expand,
      children: [
        widget.child,
        if (shouldObscure)
          Positioned.fill(
            child: _AppLockHost(
              child: _lockRequired && !_checkingLock
                  ? AppLockUnlockPage(
                      key: const ValueKey<String>('device-app-lock'),
                      showBiometric: true,
                      appLockService: _service,
                      onUnlocked: _onUnlocked,
                    )
                  : ColoredBox(
                      color: appPinScaffoldColor(context),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
            ),
          ),
      ],
    );
  }
}

/// Overlay + nested [ScaffoldMessenger] so the lock page does not steal
/// in-flight snackbars from the root messenger (and so Tooltip has an Overlay).
class _AppLockHost extends StatefulWidget {
  const _AppLockHost({required this.child});

  final Widget child;

  @override
  State<_AppLockHost> createState() => _AppLockHostState();
}

class _AppLockHostState extends State<_AppLockHost> {
  late final OverlayEntry _entry = OverlayEntry(
    builder: (context) => ScaffoldMessenger(child: widget.child),
  );

  @override
  void didUpdateWidget(covariant _AppLockHost oldWidget) {
    super.didUpdateWidget(oldWidget);
    _entry.markNeedsBuild();
  }

  @override
  Widget build(BuildContext context) {
    return Overlay(initialEntries: [_entry]);
  }
}
