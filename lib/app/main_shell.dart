import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/widgets/floating_nav_bar.dart';
import '../features/chat/presentation/chat_sheet.dart';
import '../features/prayer/presentation/prayer_screen.dart';
import '../features/qibla/presentation/qibla_screen.dart';
import '../features/quran/presentation/quran_list_screen.dart';
import '../features/tasbih/presentation/dhikr_screen.dart';
import '../features/learning/presentation/learn_list_screen.dart';

import 'theme.dart';

/// Main app shell — manages the 5 top-level sections and the
/// floating navigation bar. A pull handle above the nav (and a
/// generous swipe-up band at the bottom of the screen) reveals
/// the AI chat as a modal bottom sheet.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  NavSection _active = NavSection.prayer;
  late final PageController _pageController = PageController(
    initialPage: _active.index,
  );

  double _dragDy = 0;
  bool _swipeActive = false;
  bool _chatOpen = false;

  static const _bottomEdgeBand = 130.0;
  static const _triggerThreshold = 50.0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavChanged(NavSection section) {
    if (section == _active) return;
    setState(() => _active = section);
    _pageController.jumpToPage(section.index);
  }

  void _onPageChanged(int index) {
    final next = NavSection.values[index];
    if (next != _active) setState(() => _active = next);
  }

  Future<void> _openChat() async {
    if (_chatOpen) return;
    _chatOpen = true;
    await showChatSheet(context);
    if (mounted) _chatOpen = false;
  }

  void _onDragStart() {
    _swipeActive = true;
    _dragDy = 0;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (!_swipeActive) return;
    _dragDy += details.delta.dy;
    if (_dragDy < -_triggerThreshold) {
      _swipeActive = false;
      _openChat();
    }
  }

  void _onDragEnd() {
    _swipeActive = false;
    _dragDy = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            physics: const ClampingScrollPhysics(),
            children: [
              PrayerScreen(onNavChanged: _onNavChanged),
              QiblaScreen(onNavChanged: _onNavChanged),
              QuranListScreen(onNavChanged: _onNavChanged),
              DhikrScreen(onNavChanged: _onNavChanged),
              LearnListScreen(onNavChanged: _onNavChanged),
            ],
          ),

          // Shared floating dock — stays put while pages swipe behind.
          FloatingNavBar(active: _active, onChanged: _onNavChanged),

          // Forgiving swipe-up zone — entire bottom edge below the nav.
          // Translucent so floating-nav taps pass through. Resolves via
          // the gesture arena (tap vs drag) for each touch.
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: _bottomEdgeBand,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onVerticalDragStart: (_) => _onDragStart(),
              onVerticalDragUpdate: _onDragUpdate,
              onVerticalDragEnd: (_) => _onDragEnd(),
              onVerticalDragCancel: _onDragEnd,
            ),
          ),

          // Visible pull-handle above the floating nav.
          Positioned(
            left: 0,
            right: 0,
            bottom: 90,
            child: Center(
              child: _PullHandle(
                onTap: _openChat,
                onDragStart: _onDragStart,
                onDragUpdate: _onDragUpdate,
                onDragEnd: _onDragEnd,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A small glass pill with a horizontal grip line — the visible handle
/// for pulling up the chat sheet.
class _PullHandle extends StatefulWidget {
  final VoidCallback onTap;
  final VoidCallback onDragStart;
  final ValueChanged<DragUpdateDetails> onDragUpdate;
  final VoidCallback onDragEnd;

  const _PullHandle({
    required this.onTap,
    required this.onDragStart,
    required this.onDragUpdate,
    required this.onDragEnd,
  });

  @override
  State<_PullHandle> createState() => _PullHandleState();
}

class _PullHandleState extends State<_PullHandle> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onVerticalDragStart: (_) {
        setState(() => _pressed = true);
        widget.onDragStart();
      },
      onVerticalDragUpdate: widget.onDragUpdate,
      onVerticalDragEnd: (_) {
        setState(() => _pressed = false);
        widget.onDragEnd();
      },
      onVerticalDragCancel: () {
        setState(() => _pressed = false);
        widget.onDragEnd();
      },
      child: Padding(
        // Enlarge hit area beyond the visible pill.
        padding: const EdgeInsets.symmetric(
          horizontal: QadrSpacing.xl,
          vertical: QadrSpacing.sm,
        ),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 140),
          scale: _pressed ? 0.92 : 1.0,
          child: ClipRRect(
            borderRadius: QadrRadius.pillAll,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0x4D140C0C),
                  borderRadius: QadrRadius.pillAll,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.14),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x40000000),
                      blurRadius: 14,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.keyboard_arrow_up_rounded,
                      size: 14,
                      color: Colors.white.withValues(alpha: 0.75),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 34,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.55),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
