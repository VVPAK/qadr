import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'scene_background.dart';
import 'floating_nav_bar.dart';

/// Wraps a screen in a full-bleed scene background with a
/// top gradient vignette and a floating navigation bar.
///
/// Children are placed in a Stack over the scene — drop glass
/// cards and content absolutely into the remaining space.
class ScenePage extends StatelessWidget {
  final SceneType scene;
  final NavSection? activeNav;
  final ValueChanged<NavSection>? onNavChanged;
  final List<Widget> children;
  final double topGradientStrength;

  const ScenePage({
    super.key,
    required this.scene,
    this.activeNav,
    this.onNavChanged,
    required this.children,
    this.topGradientStrength = 0.38,
  });

  @override
  Widget build(BuildContext context) {
    final showNav = activeNav != null && onNavChanged != null;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Stack(
        children: [
          // Scene background
          Positioned.fill(child: SceneBackground(scene: scene)),

          // Top gradient vignette (readability for status bar)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 140,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: topGradientStrength),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Children (screen content)
          ...children,

          // Floating nav (hidden on onboarding / single-screen flows)
          if (showNav)
            FloatingNavBar(active: activeNav!, onChanged: onNavChanged!),
        ],
      ),
    );
  }
}

/// A parchment-style page (warm cream background, subtle geometric
/// watermark) — used for Quran reader and Learn article screens
/// where readability of text matters more than visual impact.
class ParchmentPage extends StatelessWidget {
  final NavSection? activeNav;
  final ValueChanged<NavSection>? onNavChanged;
  final List<Widget> children;

  const ParchmentPage({
    super.key,
    this.activeNav,
    this.onNavChanged,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final bg = Theme.of(context).scaffoldBackgroundColor;
    final showNav = activeNav != null && onNavChanged != null;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Theme.of(context).brightness == Brightness.light
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light,
      child: Stack(
        children: [
          // Background
          Positioned.fill(child: ColoredBox(color: bg)),

          // Children
          ...children,

          // Floating nav (hidden on pushed/single-screen flows)
          if (showNav)
            FloatingNavBar(active: activeNav!, onChanged: onNavChanged!),
        ],
      ),
    );
  }
}
