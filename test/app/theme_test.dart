import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/app/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('QadrShadow', () {
    test('card returns non-empty shadow list', () {
      expect(QadrShadow.card, isNotEmpty);
    });

    test('float returns non-empty shadow list', () {
      expect(QadrShadow.float, isNotEmpty);
    });

    test('overlay returns non-empty shadow list', () {
      expect(QadrShadow.overlay, isNotEmpty);
    });
  });

  group('QadrTheme', () {
    test('dark() returns a ThemeData with dark brightness', () {
      final theme = QadrTheme.dark();
      expect(theme, isA<ThemeData>());
      expect(theme.colorScheme.brightness, Brightness.dark);
    });

    test('light() returns a ThemeData with light brightness', () {
      final theme = QadrTheme.light();
      expect(theme.colorScheme.brightness, Brightness.light);
    });

    test('arabic() returns a TextStyle with given fontSize', () {
      final style = QadrTheme.arabic(fontSize: 20);
      expect(style.fontSize, 20);
    });

    test('display() returns a TextStyle with given fontSize', () {
      final style = QadrTheme.display(fontSize: 28);
      expect(style.fontSize, 28);
    });

    test('numeral() returns a TextStyle with given fontSize', () {
      final style = QadrTheme.numeral(fontSize: 18);
      expect(style.fontSize, 18);
    });
  });
}
