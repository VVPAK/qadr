@Tags(['golden'])
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/core/widgets/floating_nav_bar.dart';
import 'package:qadr/features/learning/presentation/learn_list_screen.dart';

import '../../helpers/golden_test_helpers.dart';

void main() {
  goldenTest(
    'learn_list_screen',
    builder: (_) => LearnListScreen(onNavChanged: (_) {}),
  );
}
