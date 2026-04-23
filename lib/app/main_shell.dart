import 'package:flutter/material.dart';
import '../core/widgets/floating_nav_bar.dart';
import '../features/prayer/presentation/prayer_screen.dart';
import '../features/qibla/presentation/qibla_screen.dart';
import '../features/quran/presentation/quran_list_screen.dart';
import '../features/tasbih/presentation/dhikr_screen.dart';
import '../features/learning/presentation/learn_list_screen.dart';

/// Main app shell — manages the 5 top-level sections and the
/// floating navigation bar. Each section keeps its own state
/// via IndexedStack.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  NavSection _active = NavSection.prayer;

  void _onNavChanged(NavSection section) {
    setState(() => _active = section);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _active.index,
        children: [
          PrayerScreen(onNavChanged: _onNavChanged),
          QiblaScreen(onNavChanged: _onNavChanged),
          QuranListScreen(onNavChanged: _onNavChanged),
          DhikrScreen(onNavChanged: _onNavChanged),
          LearnListScreen(onNavChanged: _onNavChanged),
        ],
      ),
    );
  }
}
