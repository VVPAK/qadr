@Tags(['golden'])
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/features/dua/presentation/dua_list_screen.dart';

import '../../helpers/golden_test_helpers.dart';

void main() {
  goldenTest('dua_list_screen', builder: (_) => const DuaListScreen());
}
