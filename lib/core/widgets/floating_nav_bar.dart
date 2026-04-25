import 'dart:ui';
import 'package:flutter/material.dart';

import '../../app/theme.dart';

/// Navigation section identifiers.
enum NavSection { prayer, qibla, quran, dhikr, learn }

/// Floating glass bottom navigation dock — 5 circular icon buttons
/// in a pill-shaped frosted container. The active section gets a
/// cream-filled circle.
class FloatingNavBar extends StatelessWidget {
  final NavSection active;
  final ValueChanged<NavSection> onChanged;

  const FloatingNavBar({
    super.key,
    required this.active,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 30,
      child: Center(
        child: ClipRRect(
          borderRadius: QadrRadius.pillAll,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0x5C140C0C),
                borderRadius: QadrRadius.pillAll,
                border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x590A0602),
                    blurRadius: 28,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: NavSection.values.map((section) {
                  final isActive = section == active;
                  return GestureDetector(
                    key: ValueKey('nav_${section.name}'),
                    onTap: () => onChanged(section),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 44,
                      height: 44,
                      margin: EdgeInsets.only(
                        right: section != NavSection.learn ? 6 : 0,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isActive
                            ? const Color(0xF2F4EFE6)
                            : Colors.transparent,
                        boxShadow: isActive
                            ? const [
                                BoxShadow(
                                  color: Color(0x33FFFFFF),
                                  blurRadius: 0,
                                  offset: Offset(0, -1),
                                  blurStyle: BlurStyle.inner,
                                ),
                              ]
                            : null,
                      ),
                      child: Icon(
                        _iconFor(section),
                        size: 20,
                        color: isActive
                            ? const Color(0xFF2A2420)
                            : const Color(0xFFF4EFE6),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static IconData _iconFor(NavSection section) {
    return switch (section) {
      NavSection.prayer => Icons.mosque_outlined,
      NavSection.qibla => Icons.explore_outlined,
      NavSection.quran => Icons.menu_book_outlined,
      NavSection.dhikr => Icons.trip_origin,
      NavSection.learn => Icons.auto_stories_outlined,
    };
  }
}
