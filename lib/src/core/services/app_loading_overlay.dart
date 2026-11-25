import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/extensions/extensions/theme_extensions.dart';

/// Full-screen loading layer on the **root** [Overlay].
///
/// Uses a single global session and one [OverlayEntry] so we never stack
/// root [Navigator] modal routes (which use internal GlobalKeys on [_Theater]
/// and can assert after rapid show/hide + route pop).
class AppLoadingOverlay {
  AppLoadingOverlay._create(this._context);

  factory AppLoadingOverlay.of(BuildContext context) {
    return AppLoadingOverlay._create(context);
  }

  final BuildContext _context;

  static bool _sessionActive = false;
  static OverlayEntry? _entry;
  static DateTime? _startTime;

  static void _disposeStaleEntry() {
    final entry = _entry;
    if (entry != null) {
      if (entry.mounted) {
        entry.remove();
      }
      _entry = null;
    }
    _sessionActive = false;
    _startTime = null;
  }

  void hide() {
    void attempt([int framesLeft = 10]) {
      final entry = _entry;
      if (entry != null && entry.mounted) {
        entry.remove();
        _entry = null;
        _sessionActive = false;
        _startTime = null;
        return;
      }
      if (_sessionActive && framesLeft > 0) {
        WidgetsBinding.instance.addPostFrameCallback((_) => attempt(framesLeft - 1));
      } else if (_entry == null) {
        _sessionActive = false;
        _startTime = null;
      }
    }

    attempt();
  }

  void show() {
    if (_sessionActive && _entry?.mounted == true) return;

    _disposeStaleEntry();
    _sessionActive = true;

    void attempt([int framesLeft = 10]) {
      final overlay = Overlay.maybeOf(_context, rootOverlay: true);
      if (overlay != null) {
        if (!_sessionActive) return;
        _startTime = DateTime.now();
        unawaited(Future<void>.delayed(const Duration(seconds: 60), () {
          if (_sessionActive &&
              _startTime != null &&
              DateTime.now().difference(_startTime!).inSeconds >= 60) {
            hide();
          }
        }));
        _entry = OverlayEntry(
          builder: (context) => const _FullScreenLoaderOverlay(),
        );
        if (!_sessionActive) {
          _entry = null;
          return;
        }
        overlay.insert(_entry!);
        return;
      }
      if (_sessionActive && framesLeft > 0) {
        WidgetsBinding.instance.addPostFrameCallback((_) => attempt(framesLeft - 1));
      } else {
        _sessionActive = false;
      }
    }

    attempt();
  }

  Future<T> during<T>(Future<T> future) {
    show();
    return future.whenComplete(() => hide());
  }
}

class _FullScreenLoaderOverlay extends StatelessWidget {
  const _FullScreenLoaderOverlay();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        alignment: Alignment.center,
        children: [
          ModalBarrier(
            color: Colors.black54,
            dismissible: false,
          ),
          Container(
            decoration: BoxDecoration(
              color: context.theme.colorScheme.surface,
              borderRadius: allRadiusLarge,
            ),
            padding: symmetricPaddingMedium,
            child: const CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
