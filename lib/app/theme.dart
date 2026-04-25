import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Design tokens matching the Qadr design system.
/// Warm neutrals (cream/sand/greige) with warm taupe accent.
abstract final class QadrColors {
  // ── Light theme ──
  static const cream = Color(0xFFF4EFE6);
  static const surface = Color(0xFFFAF6EE);
  static const surface2 = Color(0xFFEDE6D8);
  static const line = Color(0x173A2424); // rgba(58,48,36, 0.09)
  static const line2 = Color(0x243A2424); // rgba(58,48,36, 0.14)

  static const text = Color(0xFF2A2420);
  static const textMuted = Color(0xFF6B5F52);
  static const textSoft = Color(0xFF9A8E7F);
  static const textFaint = Color(0xFFB8AC9B);

  static const accent = Color(0xFF8A6E4F);
  static const accentSoft = Color(0xFFB6977A);
  static const accentGhost = Color(0x148A6E4F); // 8% opacity

  static const success = Color(0xFF6E7F5C);
  static const onAccent = Color(0xFFFBF6EC);

  // ── Dark theme ──
  static const darkBg = Color(0xFF1B1714);
  static const darkSurface = Color(0xFF221D19);
  static const darkSurface2 = Color(0xFF2A2420);
  static const darkLine = Color(0x14F0E6D2); // rgba(240,230,210, 0.08)
  static const darkLine2 = Color(0x24F0E6D2); // rgba(240,230,210, 0.14)

  static const darkText = Color(0xFFEFE6D6);
  static const darkTextMuted = Color(0xFFB6A994);
  static const darkTextSoft = Color(0xFF877866);
  static const darkTextFaint = Color(0xFF5B4F43);

  static const darkAccent = Color(0xFFC8A986);
  static const darkAccentSoft = Color(0xFF9A7F60);
  static const darkAccentGhost = Color(0x1AC8A986); // 10% opacity

  static const darkSuccess = Color(0xFF9CAE87);
}

/// Spacing scale — use these instead of raw pixel values.
abstract final class QadrSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 40;

  /// Standard horizontal screen inset.
  static const double screenH = 20;

  /// Standard vertical screen inset.
  static const double screenV = 24;
}

/// Border-radius scale.
abstract final class QadrRadius {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;

  /// Fully-rounded pills — nav bar, chips, buttons.
  static const double pill = 999;

  static BorderRadius get xsAll => BorderRadius.circular(xs);
  static BorderRadius get smAll => BorderRadius.circular(sm);
  static BorderRadius get mdAll => BorderRadius.circular(md);
  static BorderRadius get lgAll => BorderRadius.circular(lg);
  static BorderRadius get xlAll => BorderRadius.circular(xl);
  static BorderRadius get pillAll => BorderRadius.circular(pill);
}

/// Elevation / shadow tokens.
abstract final class QadrShadow {
  /// Subtle card lift.
  static List<BoxShadow> get card => [
    BoxShadow(
      color: QadrColors.text.withValues(alpha: 0.06),
      blurRadius: 12,
      offset: const Offset(0, 2),
    ),
  ];

  /// Floating elements — nav bar, FAB.
  static List<BoxShadow> get float => [
    BoxShadow(
      color: QadrColors.text.withValues(alpha: 0.12),
      blurRadius: 24,
      offset: const Offset(0, 6),
    ),
  ];

  /// Bottom sheet / modal overlay.
  static List<BoxShadow> get overlay => [
    BoxShadow(
      color: QadrColors.text.withValues(alpha: 0.18),
      blurRadius: 40,
      offset: const Offset(0, -4),
    ),
  ];
}

abstract final class QadrTheme {
  static const _fontFamily = 'GeneralSans';

  static TextStyle get _displayFont =>
      GoogleFonts.fraunces(fontWeight: FontWeight.w400);

  static TextStyle get _arabicFont =>
      GoogleFonts.amiri(fontWeight: FontWeight.w400);

  /// Arabic text style for Quran, duas, dhikr.
  static TextStyle arabic({
    double fontSize = 24,
    double height = 2.0,
    Color? color,
  }) {
    return _arabicFont.copyWith(
      fontSize: fontSize,
      height: height,
      color: color,
    );
  }

  /// Display/heading style using Fraunces.
  static TextStyle display({
    double fontSize = 34,
    FontWeight fontWeight = FontWeight.w300,
    FontStyle fontStyle = FontStyle.italic,
    double letterSpacing = -0.02,
    Color? color,
  }) {
    return _displayFont.copyWith(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      color: color,
    );
  }

  /// Numeral style (for countdown, ayah numbers, etc.)
  static TextStyle numeral({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w500,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFeatures: const [FontFeature.tabularFigures()],
      color: color,
    );
  }

  static ThemeData light() {
    final colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: QadrColors.accent,
      onPrimary: QadrColors.onAccent,
      secondary: QadrColors.accentSoft,
      onSecondary: QadrColors.text,
      surface: QadrColors.surface,
      onSurface: QadrColors.text,
      error: const Color(0xFFB3261E),
      onError: Colors.white,
      outline: QadrColors.line2,
      outlineVariant: QadrColors.line,
      surfaceContainerHighest: QadrColors.surface2,
      surfaceContainerLow: QadrColors.cream,
    );
    return _buildTheme(colorScheme);
  }

  static ThemeData dark() {
    final colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: QadrColors.darkAccent,
      onPrimary: QadrColors.darkBg,
      secondary: QadrColors.darkAccentSoft,
      onSecondary: QadrColors.darkText,
      surface: QadrColors.darkSurface,
      onSurface: QadrColors.darkText,
      error: const Color(0xFFF2B8B5),
      onError: const Color(0xFF601410),
      outline: QadrColors.darkLine2,
      outlineVariant: QadrColors.darkLine,
      surfaceContainerHighest: QadrColors.darkSurface2,
      surfaceContainerLow: QadrColors.darkBg,
    );
    return _buildTheme(colorScheme);
  }

  static ThemeData _buildTheme(ColorScheme colorScheme) {
    final isLight = colorScheme.brightness == Brightness.light;

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      fontFamily: _fontFamily,
      scaffoldBackgroundColor: isLight ? QadrColors.cream : QadrColors.darkBg,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        border: OutlineInputBorder(
          borderRadius: QadrRadius.xlAll,
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: QadrSpacing.screenH,
          vertical: 12,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: QadrRadius.lgAll),
        color: colorScheme.surface,
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outline,
        thickness: 1,
        space: 0,
      ),
    );
  }
}
