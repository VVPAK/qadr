import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/widgets/floating_nav_bar.dart';
import '../../../core/widgets/glass_container.dart';
import '../../../core/widgets/scene_background.dart';
import '../../../core/widgets/scene_page.dart';
import '../domain/learning_curriculum.dart';

class LearnListScreen extends StatelessWidget {
  final ValueChanged<NavSection> onNavChanged;
  const LearnListScreen({super.key, required this.onNavChanged});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    // Flatten all lessons from curriculum
    final allLessons = <(String category, Lesson lesson)>[];
    for (final module in learningCurriculum) {
      for (final lesson in module.lessons) {
        allLessons.add((module.titleRu, lesson));
      }
    }

    // Categories from modules
    final categories = learningCurriculum
        .map((m) => (m.titleRu, m.lessons.length))
        .toList();

    return ScenePage(
      scene: SceneType.dune,
      activeNav: NavSection.learn,
      onNavChanged: onNavChanged,
      topGradientStrength: 0.3,
      children: [
        // Title
        Positioned(
          top: topPadding + 10,
          left: 26,
          right: 26,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ЗНАНИЕ',
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 2,
                  color: Color(0xB3F4EFE6),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Библиотека',
                style: QadrTheme.display(
                  fontSize: 34,
                  color: const Color(0xFFF4EFE6),
                ),
              ),
            ],
          ),
        ),

        // Category chips
        Positioned(
          top: topPadding + 116,
          left: 22,
          right: 22,
          child: SizedBox(
            height: 60,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final (name, count) = categories[i];
                return _buildCategoryChip(name, count);
              },
            ),
          ),
        ),

        // Lesson list
        Positioned(
          top: topPadding + 190,
          left: 22,
          right: 22,
          bottom: 100,
          child: GlassContainer(
            borderRadius: 20,
            backgroundOpacity: 0.58,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Text(
                    'РЕКОМЕНДОВАНО',
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: 2,
                      color: Color(0x99F4EFE6),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 14),
                    itemCount: allLessons.length,
                    itemBuilder: (_, i) {
                      final (cat, lesson) = allLessons[i];
                      return _LessonRow(
                        category: cat,
                        lesson: lesson,
                        showBorder: i < allLessons.length - 1,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(String name, int count) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
          decoration: BoxDecoration(
            color: const Color(0x61140C0C),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0x1FFFFFFF)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 13,
                  letterSpacing: -0.1,
                  color: Color(0xFFF4EFE6),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '$count уроков',
                style: const TextStyle(
                  fontSize: 10.5,
                  color: Color(0x99F4EFE6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LessonRow extends StatelessWidget {
  final String category;
  final Lesson lesson;
  final bool showBorder;

  const _LessonRow({
    required this.category,
    required this.lesson,
    required this.showBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: showBorder
          ? const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0x14FFFFFF)),
              ),
            )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                category.toUpperCase(),
                style: const TextStyle(
                  fontSize: 10.5,
                  letterSpacing: 1.5,
                  color: Color(0xFFE4C7A0),
                ),
              ),
              const SizedBox(width: 8),
              const Text('·',
                  style: TextStyle(
                      fontSize: 11, color: Color(0x66F4EFE6))),
              const SizedBox(width: 8),
              Text(
                '${lesson.steps.length} шагов',
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0x8CF4EFE6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            lesson.titleRu,
            style: QadrTheme.display(
              fontSize: 19,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              letterSpacing: -0.01,
              color: const Color(0xFFF4EFE6),
            ).copyWith(height: 1.25),
          ),
          const SizedBox(height: 5),
          Text(
            lesson.descriptionRu,
            style: const TextStyle(
              fontSize: 13,
              height: 1.45,
              color: Color(0xB8F4EFE6),
            ),
          ),
        ],
      ),
    );
  }
}
