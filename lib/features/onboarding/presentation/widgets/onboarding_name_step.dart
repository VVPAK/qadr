import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/providers/preferences_provider.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/scene_background.dart';
import '../../../../core/widgets/scene_page.dart';
import 'onboarding_atoms.dart';

class OnboardingNameStep extends ConsumerStatefulWidget {
  final VoidCallback onNext;

  const OnboardingNameStep({super.key, required this.onNext});

  @override
  ConsumerState<OnboardingNameStep> createState() =>
      _OnboardingNameStepState();
}

class _OnboardingNameStepState extends ConsumerState<OnboardingNameStep>
    with SingleTickerProviderStateMixin {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  late final AnimationController _caret;

  @override
  void initState() {
    super.initState();
    _caret = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
    _controller.addListener(() => setState(() {}));
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Prefill from prefs if the user is returning.
      final prefs = await ref.read(userPreferencesProvider.future);
      if (mounted && (prefs.name ?? '').isNotEmpty) {
        _controller.text = prefs.name!;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _caret.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    final name = _controller.text.trim();
    final prefs = await ref.read(userPreferencesProvider.future);
    prefs.name = name.isEmpty ? null : name;
    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final topPadding = MediaQuery.of(context).padding.top;
    final hasText = _controller.text.isNotEmpty;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.translucent,
      child: ScenePage(
      scene: SceneType.dusk,
      topGradientStrength: 0.42,
      children: [
        // Salam as eyebrow
        Positioned(
          top: topPadding + 72,
          left: 0,
          right: 0,
          child: OnbEyebrow(text: l10n.onboardingNameSalam),
        ),

        // Hero question
        Positioned(
          top: topPadding + 110,
          left: 32,
          right: 32,
          child: OnbHeadline(
            line1: l10n.onboardingNameHeadline1,
            line2: l10n.onboardingNameHeadline2,
          ),
        ),

        // Glass input card
        Positioned(
          top: topPadding + 296,
          left: 28,
          right: 28,
          child: GestureDetector(
            onTap: () => _focusNode.requestFocus(),
            behavior: HitTestBehavior.opaque,
            child: GlassContainer(
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 18),
              borderRadius: 20,
              backgroundOpacity: 0.42,
              borderOpacity: 0.12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.onboardingNameLabel.toUpperCase(),
                    style: TextStyle(
                      color: QadrColors.cream.withValues(alpha: 0.55),
                      fontFamily: 'GeneralSans',
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.76,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    child: Stack(
                      children: [
                        // Real TextField (transparent text so we draw our own).
                        Offstage(
                          offstage: false,
                          child: Opacity(
                            opacity: 0,
                            child: TextField(
                              controller: _controller,
                              focusNode: _focusNode,
                              autofocus: false,
                              textCapitalization: TextCapitalization.words,
                              onSubmitted: (_) => _submit(),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                isDense: true,
                              ),
                              style: QadrTheme.display(
                                fontSize: 34,
                                fontStyle: FontStyle.normal,
                                color: QadrColors.cream,
                              ),
                            ),
                          ),
                        ),

                        // Visible text / placeholder + blinking caret.
                        IgnorePointer(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Text(
                                  hasText
                                      ? _controller.text
                                      : l10n.onboardingNamePlaceholder,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: QadrTheme.display(
                                    fontSize: 34,
                                    fontStyle: FontStyle.normal,
                                    color: hasText
                                        ? QadrColors.cream
                                        : QadrColors.cream
                                            .withValues(alpha: 0.38),
                                  ),
                                ),
                              ),
                              const SizedBox(width: QadrSpacing.xs),
                              AnimatedBuilder(
                                animation: _caret,
                                builder: (_, _) => Opacity(
                                  opacity: _caret.value < 0.5 ? 1 : 0,
                                  child: Container(
                                    width: 2,
                                    height: 32,
                                    margin: const EdgeInsets.only(bottom: QadrSpacing.xs),
                                    color: QadrColors.cream
                                        .withValues(alpha: 0.82),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Container(
                      height: 1,
                      color: QadrColors.cream.withValues(alpha: 0.14),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.onboardingNamePrivacy,
                    style: TextStyle(
                      color: QadrColors.cream.withValues(alpha: 0.6),
                      fontFamily: 'GeneralSans',
                      fontSize: 12.5,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const OnbDots(current: 1),
        OnbCTA(label: l10n.next, onTap: _submit),
      ],
    ),
    );
  }
}
