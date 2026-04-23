@Tags(['golden'])
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/features/tasbih/presentation/dhikr_screen.dart';

import '../../helpers/golden_test_helpers.dart';

void main() {
  goldenTest(
    'dhikr_screen',
    builder: (_) => DhikrScreen(onNavChanged: (_) {}),
  );
}
