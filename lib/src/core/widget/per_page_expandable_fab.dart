// Vendored from flutter_expandable_fab ^2.5.2 with a critical fix:
// [ExpandableFab.location] was a singleton, so multiple keep-alive Scaffolds
// (e.g. sales + purchase tabs) shared one [ScaffoldPrelayoutGeometry] notifier,
// corrupting FAB layout and triggering navigator overlay / GlobalKey issues.
//
// Use one [PerPageExpandableFabLocation] per page and pass it to both
// [Scaffold.floatingActionButtonLocation] and [ExpandableFab.fabLocation].

import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

/// The type of behavior of this widget.
enum ExpandableFabType { fan, up, side }

/// The position options for the FAB on the screen.
enum ExpandableFabPos { right, left, center }

/// Animation Type
enum ExpandableFabAnimation { none, rotate }

/// Style configuration for the overlay displayed behind the Expandable FAB.
@immutable
class ExpandableFabOverlayStyle {
  const ExpandableFabOverlayStyle({this.color, this.blur});

  final Color? color;
  final double? blur;
}

/// The size of the expanded FAB.
enum ExpandableFabSize { small, regular, large }

class FloatingActionButtonBuilder {
  const FloatingActionButtonBuilder({
    required this.size,
    required this.builder,
  });

  final Widget Function(
    BuildContext context,
    VoidCallback? onPressed,
    Animation<double> progress,
  ) builder;

  final double size;
}

class DefaultFloatingActionButtonBuilder extends FloatingActionButtonBuilder {
  DefaultFloatingActionButtonBuilder({
    this.fabSize = ExpandableFabSize.regular,
    this.foregroundColor,
    this.backgroundColor,
    this.shape,
    this.heroTag,
    this.elevation,
    this.child,
  }) : super(
          size: _actualSize(fabSize),
          builder: (BuildContext context, VoidCallback? onPressed, Animation<double> progress) {
            var func = FloatingActionButton.small;
            switch (fabSize) {
              case ExpandableFabSize.large:
                func = FloatingActionButton.large;
                break;
              case ExpandableFabSize.small:
                break;
              default:
                func = FloatingActionButton.new;
            }
            return func.call(
              autofocus: true,
              foregroundColor: foregroundColor,
              backgroundColor: backgroundColor,
              shape: shape,
              heroTag: heroTag,
              elevation: elevation,
              onPressed: onPressed,
              child: child,
            );
          },
        );

  final ExpandableFabSize fabSize;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final ShapeBorder? shape;
  final Object? heroTag;
  final double? elevation;
  final Widget? child;
}

class RotateFloatingActionButtonBuilder extends FloatingActionButtonBuilder {
  RotateFloatingActionButtonBuilder({
    this.fabSize = ExpandableFabSize.regular,
    this.foregroundColor,
    this.backgroundColor,
    this.shape,
    this.heroTag,
    this.elevation,
    this.child,
    this.angle = math.pi / 2,
  }) : super(
          size: _actualSize(fabSize),
          builder: (BuildContext context, VoidCallback? onPressed, Animation<double> progress) {
            return AnimatedBuilder(
              animation: progress,
              builder: (context, _) {
                return Transform.rotate(
                  angle: progress.value * angle,
                  child: DefaultFloatingActionButtonBuilder(
                    foregroundColor: foregroundColor,
                    backgroundColor: backgroundColor,
                    shape: shape,
                    heroTag: heroTag,
                    elevation: elevation,
                    fabSize: fabSize,
                    child: child,
                  ).builder(context, onPressed, progress),
                );
              },
            );
          },
        );

  final ExpandableFabSize fabSize;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final ShapeBorder? shape;
  final Object? heroTag;
  final double? elevation;
  final Widget? child;
  final double angle;
}

double _actualSize(ExpandableFabSize fabSize) {
  switch (fabSize) {
    case ExpandableFabSize.large:
      return 96.0;
    case ExpandableFabSize.small:
      return 40.0;
    default:
      return 56.0;
  }
}

/// Hides a FAB while scrolling down; shows it when scrolling up or at the top.
class ScrollHideFabController {
  final ValueNotifier<bool> hidden = ValueNotifier(false);

  double _lastScrollPixels = 0;

  void updateFromPixels(double pixels, {VoidCallback? onHide}) {
    if (pixels <= 0) {
      _setHidden(false, onHide: onHide);
      _lastScrollPixels = 0;
      return;
    }

    final delta = pixels - _lastScrollPixels;
    if (delta > 8) {
      _setHidden(true, onHide: onHide);
    } else if (delta < -8) {
      _setHidden(false, onHide: onHide);
    }
    _lastScrollPixels = pixels;
  }

  bool handleScrollNotification(
    ScrollNotification notification, {
    VoidCallback? onHide,
  }) {
    if (notification.depth != 0) return false;

    final pixels = notification.metrics.pixels;
    if (pixels <= 0) {
      updateFromPixels(0, onHide: onHide);
      return false;
    }

    if (notification is ScrollUpdateNotification) {
      updateFromPixels(pixels, onHide: onHide);
    }
    return false;
  }

  void _setHidden(bool value, {VoidCallback? onHide}) {
    if (hidden.value == value) return;
    if (value) {
      onHide?.call();
    }
    hidden.value = value;
  }

  void dispose() {
    hidden.dispose();
  }
}

/// Wraps a [floatingActionButton] with slide/fade hide on scroll.
class ScrollHideFab extends StatelessWidget {
  const ScrollHideFab({
    super.key,
    required this.controller,
    required this.child,
    this.duration = const Duration(milliseconds: 250),
  });

  final ScrollHideFabController controller;
  final Widget child;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: controller.hidden,
      builder: (context, hidden, child) {
        return IgnorePointer(
          ignoring: hidden,
          child: AnimatedSlide(
            offset: hidden ? const Offset(0, 1.5) : Offset.zero,
            duration: duration,
            curve: Curves.easeInOut,
            child: AnimatedOpacity(
              opacity: hidden ? 0 : 1,
              duration: duration,
              child: child,
            ),
          ),
        );
      },
      child: child,
    );
  }
}

/// One instance per [Scaffold] that hosts an [ExpandableFab].
class PerPageExpandableFabLocation extends StandardFabLocation {
  PerPageExpandableFabLocation({this.scrollHideEnabled = false});

  /// When false, the FAB stays visible while scrolling (default for main-shell tabs).
  final bool scrollHideEnabled;

  final ValueNotifier<ScaffoldPrelayoutGeometry?> scaffoldGeometry = ValueNotifier(null);
  final ScrollHideFabController scrollHide = ScrollHideFabController();

  ValueNotifier<bool> get fabHidden => scrollHide.hidden;

  /// Hides the FAB while scrolling down; shows it when scrolling up or at the top.
  bool handleScrollNotification(
    ScrollNotification notification, {
    GlobalKey<ExpandableFabState>? fabKey,
  }) {
    if (!scrollHideEnabled) return false;
    return scrollHide.handleScrollNotification(
      notification,
      onHide: () => fabKey?.currentState?.close(),
    );
  }

  void dispose() {
    scaffoldGeometry.dispose();
    scrollHide.dispose();
  }

  @override
  double getOffsetX(
    ScaffoldPrelayoutGeometry scaffoldGeometry,
    double adjustment,
  ) {
    Future.microtask(() {
      this.scaffoldGeometry.value = scaffoldGeometry;
    });
    return 0;
  }

  @override
  double getOffsetY(
    ScaffoldPrelayoutGeometry scaffoldGeometry,
    double adjustment,
  ) {
    return -scaffoldGeometry.snackBarSize.height;
  }
}

/// A FloatingActionButton that can show/hide multiple action buttons with animation.
class ExpandableFab extends StatefulWidget {
  ExpandableFab({
    super.key,
    required this.fabLocation,
    this.distance = 100,
    this.duration = const Duration(milliseconds: 250),
    this.fanAngle = 90,
    this.initialOpen = false,
    this.type = ExpandableFabType.fan,
    this.pos = ExpandableFabPos.right,
    this.childrenAnimation = ExpandableFabAnimation.rotate,
    this.closeButtonBuilder,
    this.openButtonBuilder,
    this.childrenOffset = Offset.zero,
    required this.children,
    this.onOpen,
    this.afterOpen,
    this.onClose,
    this.afterClose,
    this.overlayStyle,
    this.openCloseStackAlignment = Alignment.center,
    this.elevation,
    this.margin = const EdgeInsets.all(0),
    this.shellBottomLift,
  });

  final PerPageExpandableFabLocation fabLocation;

  /// When set (main-shell Sales/Expenses tabs), FAB distance from screen bottom.
  final double? shellBottomLift;

  final EdgeInsets margin;
  final double distance;
  final Duration duration;
  final double fanAngle;
  final bool initialOpen;
  final ExpandableFabType type;
  final ExpandableFabPos pos;
  final FloatingActionButtonBuilder? closeButtonBuilder;
  final FloatingActionButtonBuilder? openButtonBuilder;
  final ExpandableFabAnimation childrenAnimation;
  final Offset childrenOffset;
  final List<Widget> children;
  final VoidCallback? onOpen;
  final VoidCallback? afterOpen;
  final VoidCallback? onClose;
  final VoidCallback? afterClose;
  final ExpandableFabOverlayStyle? overlayStyle;
  final Alignment openCloseStackAlignment;
  final double? elevation;

  static ExpandableFabState of(BuildContext context) {
    ExpandableFabState? state;
    if (context is StatefulElement && context.state is ExpandableFabState) {
      state = context.state as ExpandableFabState;
    }
    state = context.findRootAncestorStateOfType<ExpandableFabState>() ?? state;

    assert(() {
      if (state == null) {
        throw FlutterError(
          'ExpandableFab operation requested with a context that does not include a ExpandableFab.',
        );
      }
      return true;
    }());
    return state!;
  }

  @override
  State<ExpandableFab> createState() => ExpandableFabState();
}

class ExpandableFabState extends State<ExpandableFab> with SingleTickerProviderStateMixin {
  final _defaultOpenButtonBuilder = RotateFloatingActionButtonBuilder(
    child: const Icon(Icons.menu),
  );
  final _defaultCloseButtonBuilder = DefaultFloatingActionButtonBuilder(
    fabSize: ExpandableFabSize.small,
    child: const Icon(Icons.close),
  );

  late AnimationController _controller;
  late Animation<double> _expandAnimation;
  late FloatingActionButtonBuilder _openButtonBuilder = _defaultOpenButtonBuilder;
  late FloatingActionButtonBuilder _closeButtonBuilder = _defaultCloseButtonBuilder;

  bool get isOpen => _controller.value > 0.5;

  void toggle() {
    if (_controller.isAnimating) return;
    if (_controller.value == 0.0) {
      widget.onOpen?.call();
      _controller.forward().then((_) {
        widget.afterOpen?.call();
      });
    } else if (_controller.value == 1.0) {
      widget.onClose?.call();
      _controller.reverse().then((_) {
        widget.afterClose?.call();
      });
    }
  }

  void close() {
    if (_controller.value != 0.0) {
      _controller.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: widget.initialOpen ? 1.0 : 0.0,
      duration: widget.duration,
      vsync: this,
    )..addListener(() {
        if (mounted) setState(() {});
      });
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
    if (widget.openButtonBuilder != null) {
      _openButtonBuilder = widget.openButtonBuilder!;
    }
    if (widget.closeButtonBuilder != null) {
      _closeButtonBuilder = widget.closeButtonBuilder!;
    }
  }

  @override
  void didUpdateWidget(covariant ExpandableFab oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.duration = widget.duration;
    _openButtonBuilder = widget.openButtonBuilder ?? _defaultOpenButtonBuilder;
    _closeButtonBuilder = widget.closeButtonBuilder ?? _defaultCloseButtonBuilder;
    close();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final location = widget.fabLocation;
    Offset? offset;
    Widget? cache;
    final fabBody = ValueListenableBuilder<ScaffoldPrelayoutGeometry?>(
      valueListenable: location.scaffoldGeometry,
      builder: (context, geometry, child) {
        final ready = geometry != null;

        Offset currentOffset;
        final shellLift = widget.shellBottomLift;
        if (shellLift != null) {
          final edge = geometry?.minInsets ?? MediaQuery.paddingOf(context);
          final double x = widget.pos == ExpandableFabPos.right
              ? kFloatingActionButtonMargin + edge.right
              : widget.pos == ExpandableFabPos.left
                  ? -kFloatingActionButtonMargin - edge.left
                  : 0;
          currentOffset = Offset(x, shellLift);
        } else if (ready) {
          final double x = widget.pos == ExpandableFabPos.right
              ? kFloatingActionButtonMargin + geometry!.minInsets.right
              : widget.pos == ExpandableFabPos.left
                  ? -kFloatingActionButtonMargin - geometry!.minInsets.left
                  : 0;
          final bottomContentHeight =
              geometry!.scaffoldSize.height - geometry!.contentBottom;
          final double y = kFloatingActionButtonMargin +
              math.max(geometry!.minViewPadding.bottom, bottomContentHeight);
          currentOffset = Offset(x, y);
        } else {
          final safe = MediaQuery.paddingOf(context);
          final double x = widget.pos == ExpandableFabPos.right
              ? kFloatingActionButtonMargin + safe.right
              : widget.pos == ExpandableFabPos.left
                  ? -kFloatingActionButtonMargin - safe.left
                  : 0;
          final double y = kFloatingActionButtonMargin + safe.bottom;
          currentOffset = Offset(x, y);
        }

        if (!ready || offset != currentOffset) {
          offset = currentOffset;
          cache = _buildButtons(offset!);
        }

        return Opacity(
          opacity: ready || shellLift != null ? 1 : 0,
          child: _controller.value > 0.0 ? FocusScope(child: cache!) : cache!,
        );
      },
    );

    if (!location.scrollHideEnabled) {
      return fabBody;
    }
    return ScrollHideFab(
      controller: location.scrollHide,
      duration: widget.duration,
      child: fabBody,
    );
  }

  Widget _buildButtons(Offset offset) {
    final blur = widget.overlayStyle?.blur;
    final overlayColor = widget.overlayStyle?.color;
    final adjustedOffset = Offset(
      offset.dx +
          (widget.pos == ExpandableFabPos.left
              ? widget.margin.left
              : widget.pos == ExpandableFabPos.center
                  ? 0
                  : widget.margin.right),
      offset.dy + widget.margin.bottom,
    );
    final Alignment alignment;
    switch (widget.pos) {
      case ExpandableFabPos.left:
        alignment = Alignment.bottomLeft;
        break;
      case ExpandableFabPos.center:
        alignment = Alignment.bottomCenter;
        break;
      default:
        alignment = Alignment.bottomRight;
    }
    return GestureDetector(
      onTap: isOpen ? toggle : null,
      behavior: HitTestBehavior.deferToChild,
      child: Stack(
        alignment: alignment,
        clipBehavior: Clip.none,
        children: [
          if (overlayColor != null)
            IgnorePointer(
              ignoring: !isOpen,
              child: FadeTransition(
                opacity: _expandAnimation,
                child: Container(color: overlayColor),
              ),
            ),
          if (blur != null)
            IgnorePointer(
              ignoring: !isOpen,
              child: AnimatedBuilder(
                animation: _expandAnimation,
                builder: (_, child) {
                  final sigma = _expandAnimation.value * blur;
                  if (sigma < 0.001) return child!;
                  return ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
                      child: child,
                    ),
                  );
                },
                child: Container(color: Colors.transparent),
              ),
            ),
          ..._buildExpandingActionButtons(adjustedOffset),
          Transform.translate(
            offset: -adjustedOffset,
            child: Stack(
              alignment: widget.openCloseStackAlignment,
              children: [
                FadeTransition(
                  opacity: _expandAnimation,
                  child: _closeButtonBuilder.builder(
                    context,
                    toggle,
                    _expandAnimation,
                  ),
                ),
                _buildTapToOpenFab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons(Offset offset) {
    final children = <Widget>[];
    final count = widget.children.length;
    var buttonOffset = 0.0;
    if (_openButtonBuilder.size > _closeButtonBuilder.size) {
      buttonOffset = (_openButtonBuilder.size - _closeButtonBuilder.size) / 2;
    }
    var totalOffset = offset;
    switch (widget.pos) {
      case ExpandableFabPos.left:
        totalOffset += Offset(
          -widget.childrenOffset.dx - buttonOffset,
          widget.childrenOffset.dy + buttonOffset,
        );
        break;
      case ExpandableFabPos.center:
        final screenSize = MediaQuery.sizeOf(context);
        totalOffset = Offset(
          screenSize.width / 2 - _closeButtonBuilder.size / 2,
          offset.dy + buttonOffset,
        );
        break;
      default:
        totalOffset += widget.childrenOffset + Offset(buttonOffset, buttonOffset);
    }
    for (var i = 0; i < count; i++) {
      final double dist;
      double dir;
      switch (widget.type) {
        case ExpandableFabType.fan:
          final half = (90 - widget.fanAngle) / 2;
          if (count > 1) {
            dir = widget.fanAngle / (count - 1) * i + half;
          } else {
            dir = widget.fanAngle + half;
          }
          if (widget.pos == ExpandableFabPos.center) {
            dir += 45;
          }
          dist = widget.distance;
          break;
        case ExpandableFabType.up:
          dir = 90;
          dist = widget.distance * (i + 1);
          break;
        case ExpandableFabType.side:
          dir = 0;
          dist = widget.distance * (i + 1);
          break;
      }
      children.add(
        _ExpandingActionButton(
          directionInDegrees: dir,
          maxDistance: dist,
          progress: _expandAnimation,
          offset: totalOffset,
          fabPos: widget.pos,
          animation: widget.childrenAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    final transformValues = _closeButtonBuilder.size / _openButtonBuilder.size;
    final reverse = ReverseAnimation(_expandAnimation);
    return IgnorePointer(
      ignoring: isOpen,
      child: ScaleTransition(
        scale: Tween(begin: transformValues, end: 1.0).animate(reverse),
        child: FadeTransition(
          opacity: reverse,
          child: _openButtonBuilder.builder(context, toggle, _expandAnimation),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
    required this.fabPos,
    required this.offset,
    required this.animation,
  });
  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Offset offset;
  final ExpandableFabPos fabPos;
  final Widget child;
  final ExpandableFabAnimation animation;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final pos = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: fabPos == ExpandableFabPos.left ? null : offset.dx + pos.dx,
          left: fabPos == ExpandableFabPos.left ? -offset.dx + pos.dx : null,
          bottom: offset.dy + pos.dy,
          child: Transform.rotate(
            angle: animation == ExpandableFabAnimation.rotate ? (1.0 - progress.value) * math.pi / 2 : 0,
            child: IgnorePointer(ignoring: progress.value != 1, child: child),
          ),
        );
      },
      child: FadeTransition(opacity: progress, child: child),
    );
  }
}
