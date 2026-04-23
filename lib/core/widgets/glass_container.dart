import 'dart:ui';
import 'package:flutter/material.dart';

/// A glass-morphism container with backdrop blur, semi-transparent
/// background, and subtle border — matching the design's floating cards.
class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double blur;
  final Color? backgroundColor;
  final double backgroundOpacity;
  final double borderOpacity;

  const GlassContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = 20,
    this.blur = 22,
    this.backgroundColor,
    this.backgroundOpacity = 0.55,
    this.borderOpacity = 0.1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: Colors.white.withValues(alpha: borderOpacity),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0A0602).withValues(alpha: 0.35),
            blurRadius: 40,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: const Alignment(-0.5, -0.8),
                end: const Alignment(0.5, 0.8),
                colors: [
                  (backgroundColor ?? const Color(0xFF14120E))
                      .withValues(alpha: backgroundOpacity),
                  (backgroundColor ?? const Color(0xFF1C1612))
                      .withValues(alpha: backgroundOpacity + 0.15),
                ],
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
