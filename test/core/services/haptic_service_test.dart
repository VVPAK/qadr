import 'package:fake_async/fake_async.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/core/services/haptic_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('HapticService', () {
    late List<MethodCall> log;

    setUp(() {
      log = [];
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(SystemChannels.platform, (call) async {
            if (call.method.startsWith('HapticFeedback')) log.add(call);
            return null;
          });
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(SystemChannels.platform, null);
    });

    test('lightImpact triggers a single haptic pulse', () async {
      const service = HapticService();
      await service.lightImpact();
      expect(log, hasLength(1));
    });

    test('mediumImpact triggers a single haptic pulse', () async {
      const service = HapticService();
      await service.mediumImpact();
      expect(log, hasLength(1));
    });

    test('heavyImpact triggers a single haptic pulse', () async {
      const service = HapticService();
      await service.heavyImpact();
      expect(log, hasLength(1));
    });

    test('selectionClick triggers a single haptic pulse', () async {
      const service = HapticService();
      await service.selectionClick();
      expect(log, hasLength(1));
    });

    test('warning triggers a single haptic pulse', () async {
      const service = HapticService();
      await service.warning();
      expect(log, hasLength(1));
    });

    test('success fires two haptic pulses with 100ms gap', () {
      fakeAsync((async) {
        const service = HapticService();
        service.success();
        async.elapse(Duration.zero);
        expect(log, hasLength(1));

        async.elapse(const Duration(milliseconds: 100));
        expect(log, hasLength(2));
      });
    });

    test('error fires two haptic pulses with 100ms gap', () {
      fakeAsync((async) {
        const service = HapticService();
        service.error();
        async.elapse(Duration.zero);
        expect(log, hasLength(1));

        async.elapse(const Duration(milliseconds: 100));
        expect(log, hasLength(2));
      });
    });
  });
}
