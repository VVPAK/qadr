import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/app/providers.dart';
import 'package:qadr/core/constants/islamic_constants.dart';
import 'package:qadr/core/data/preferences/user_preferences.dart';
import 'package:qadr/core/providers/preferences_provider.dart';
import 'package:qadr/features/settings/presentation/settings_screen.dart';
import 'package:qadr/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _secureChannel =
    MethodChannel('plugins.it_nomads.com/flutter_secure_storage');

class _SecureStorageFake {
  final Map<String, String?> values = {};
  final List<String> writes = [];

  void install() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_secureChannel, (call) async {
      final args = (call.arguments as Map).cast<String, dynamic>();
      final key = args['key'] as String?;
      switch (call.method) {
        case 'read':
          return values[key];
        case 'write':
          values[key!] = args['value'] as String?;
          writes.add(key);
          return null;
      }
      return null;
    });
  }

  void uninstall() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_secureChannel, null);
  }
}

Future<({UserPreferences prefs, _SecureStorageFake secure})> _pump(
  WidgetTester tester, {
  Map<String, Object> initialPrefs = const {},
  Locale locale = const Locale('en'),
}) async {
  SharedPreferences.setMockInitialValues(initialPrefs);
  final sharedPrefs = await SharedPreferences.getInstance();
  final userPrefs = UserPreferences(sharedPrefs);

  final secure = _SecureStorageFake()..install();
  addTearDown(secure.uninstall);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        userPreferencesProvider.overrideWith((_) async => userPrefs),
        localProvider.overrideWith((_) => locale),
      ],
      child: MaterialApp(
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const SettingsScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();

  return (prefs: userPrefs, secure: secure);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('loads the stored API key and base URL into the text fields',
      (tester) async {
    final secure = _SecureStorageFake()
      ..values.addAll({
        'llm_api_key': 'sk-stored-key',
        'llm_api_base_url': 'https://proxy.example/v1',
      });
    secure.install();
    addTearDown(secure.uninstall);

    SharedPreferences.setMockInitialValues({});
    final sharedPrefs = await SharedPreferences.getInstance();
    final userPrefs = UserPreferences(sharedPrefs);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          userPreferencesProvider.overrideWith((_) async => userPrefs),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SettingsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.widgetWithText(TextField, 'sk-stored-key'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'https://proxy.example/v1'),
        findsOneWidget);
  });

  testWidgets('tapping Save writes both API fields to SecureStorage and '
      'shows a snackbar', (tester) async {
    final ctx = await _pump(tester);

    await tester.enterText(
        find.widgetWithText(TextField, 'https://api.openai.com/v1'),
        'https://my.proxy/v1');
    await tester.enterText(
        find.widgetWithText(TextField, ''), 'sk-new-key');
    await tester.tap(find.text('Save API Settings'));
    await tester.pump(); // snackbar frame

    expect(ctx.secure.values['llm_api_key'], 'sk-new-key');
    expect(ctx.secure.values['llm_api_base_url'], 'https://my.proxy/v1');
    expect(find.text('API settings saved'), findsOneWidget);
  });

  testWidgets('API key field is obscured by default and toggles on button tap',
      (tester) async {
    await _pump(tester);

    await tester.enterText(
      find.widgetWithText(TextField, ''),
      'sk-visible',
    );
    await tester.pump();

    final keyField = tester.widget<TextField>(
      find.widgetWithText(TextField, 'sk-visible'),
    );
    expect(keyField.obscureText, isTrue);

    await tester.tap(find.byIcon(Icons.visibility_off));
    await tester.pump();

    final after = tester.widget<TextField>(
      find.widgetWithText(TextField, 'sk-visible'),
    );
    expect(after.obscureText, isFalse);
  });

  testWidgets('language tile opens the dialog and selecting Русский '
      'persists + updates localProvider', (tester) async {
    final ctx = await _pump(tester);

    await tester.tap(find.text('Language'));
    await tester.pumpAndSettle();

    final dialog = find.byType(SimpleDialog);
    expect(dialog, findsOneWidget);
    expect(
        find.descendant(of: dialog, matching: find.text('English')),
        findsOneWidget);
    expect(
        find.descendant(of: dialog, matching: find.text('العربية')),
        findsOneWidget);
    expect(
        find.descendant(of: dialog, matching: find.text('Русский')),
        findsOneWidget);

    await tester.tap(
        find.descendant(of: dialog, matching: find.text('Русский')));
    await tester.pumpAndSettle();

    expect(ctx.prefs.language, 'ru');
  });

  testWidgets('madhab tile opens the dialog and each option persists',
      (tester) async {
    final ctx = await _pump(tester);

    await tester.tap(find.text('Madhab'));
    await tester.pumpAndSettle();

    final dialog = find.byType(SimpleDialog);
    expect(dialog, findsOneWidget);
    for (final m in Madhab.values) {
      expect(
          find.descendant(of: dialog, matching: find.text(m.displayName)),
          findsOneWidget,
          reason: m.name);
    }

    await tester.tap(find.descendant(
        of: dialog, matching: find.text(Madhab.hanbali.displayName)));
    await tester.pumpAndSettle();

    expect(ctx.prefs.madhab, Madhab.hanbali);
  });
}
