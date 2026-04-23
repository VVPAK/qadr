import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/app/theme.dart';
import 'package:qadr/l10n/app_localizations.dart';

typedef GoldenWidgetBuilder = Widget Function(Locale locale);

enum GoldenLocale {
  en(Locale('en')),
  ar(Locale('ar')),
  ru(Locale('ru'));

  final Locale locale;
  const GoldenLocale(this.locale);
}

enum GoldenScreen {
  /// iPhone SE 3rd gen — smallest modern device
  small('small', Size(375, 667)),

  /// iPhone 14 / popular mid-range Android
  medium('medium', Size(390, 844)),

  /// iPad 10th gen — tablet baseline
  tablet('tablet', Size(768, 1024));

  final String label;
  final Size logicalSize;
  const GoldenScreen(this.label, this.logicalSize);
}

/// Registers one [testWidgets] per locale × screen combination (9 total by default).
/// Golden files land at `test/goldens/{locale}/{screen}/{name}.png`.
///
/// Every file that calls this function must declare `@Tags(['golden'])` at the
/// top so CI can exclude them with `--exclude-tags golden` (goldens are
/// generated on macOS and not compared on Linux CI).
///
/// The [builder] receives the current [Locale] so widgets that need it
/// (e.g. conditional Arabic text) can react accordingly.
///
/// ```dart
/// goldenTest(
///   'floating_nav_bar',
///   builder: (_) => const FloatingNavBar(active: NavSection.prayer, onChanged: _),
/// );
/// ```
void goldenTest(
  String name, {
  required GoldenWidgetBuilder builder,
  List<GoldenLocale> locales = GoldenLocale.values,
  List<GoldenScreen> screens = GoldenScreen.values,
  List<Override> providerOverrides = const [],
  ThemeMode themeMode = ThemeMode.light,
}) {
  for (final loc in locales) {
    for (final screen in screens) {
      testWidgets('$name · ${loc.name} · ${screen.label}', (tester) async {
        tester.view.devicePixelRatio = 1.0;
        tester.view.physicalSize = screen.logicalSize;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          ProviderScope(
            overrides: providerOverrides,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: loc.locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: QadrTheme.light(),
              darkTheme: QadrTheme.dark(),
              themeMode: themeMode,
              home: builder(loc.locale),
            ),
          ),
        );
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/${loc.name}/${screen.label}/$name.png'),
        );
      });
    }
  }
}
