import 'package:flutter_mvvm_boilerplate/core/utils/debouncer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Debouncer', () {
    test('debounces rapid calls', () async {
      final debouncer = Debouncer(milliseconds: 100);
      var callCount = 0;

      // Rapidly call the debouncer
      for (var i = 0; i < 5; i++) {
        debouncer.run(() => callCount++);
      }

      // Should not have executed yet
      expect(callCount, 0);

      // Wait for debounce to complete
      await Future<void>.delayed(const Duration(milliseconds: 150));

      // Should have executed only once
      expect(callCount, 1);

      debouncer.dispose();
    });

    test('executes after delay', () async {
      final debouncer = Debouncer(milliseconds: 50);
      var executed = false;

      debouncer.run(() => executed = true);

      expect(executed, isFalse);

      await Future<void>.delayed(const Duration(milliseconds: 100));

      expect(executed, isTrue);

      debouncer.dispose();
    });

    test('cancels pending action', () async {
      final debouncer = Debouncer(milliseconds: 50);
      var executed = false;

      debouncer.run(() => executed = true);
      debouncer.cancel();

      await Future<void>.delayed(const Duration(milliseconds: 100));

      expect(executed, isFalse);

      debouncer.dispose();
    });

    test('ignores calls after dispose', () async {
      final debouncer = Debouncer(milliseconds: 50);
      var executed = false;

      debouncer.dispose();
      debouncer.run(() => executed = true);

      await Future<void>.delayed(const Duration(milliseconds: 100));

      expect(executed, isFalse);
    });
  });

  group('Throttler', () {
    test('executes first call immediately', () {
      final throttler = Throttler(milliseconds: 100);
      var callCount = 0;

      throttler.run(() => callCount++);

      expect(callCount, 1);

      throttler.dispose();
    });

    test('throttles rapid calls', () async {
      final throttler = Throttler(milliseconds: 100);
      var callCount = 0;

      // Rapidly call the throttler
      for (var i = 0; i < 5; i++) {
        throttler.run(() => callCount++);
      }

      // First call should have executed immediately
      expect(callCount, 1);

      // Wait and call again
      await Future<void>.delayed(const Duration(milliseconds: 150));
      throttler.run(() => callCount++);

      expect(callCount, 2);

      throttler.dispose();
    });

    test('reset allows immediate execution', () {
      final throttler = Throttler(milliseconds: 100);
      var callCount = 0;

      throttler.run(() => callCount++);
      expect(callCount, 1);

      throttler.run(() => callCount++);
      expect(callCount, 1); // Throttled

      throttler.reset();

      throttler.run(() => callCount++);
      expect(callCount, 2); // Allowed after reset

      throttler.dispose();
    });

    test('ignores calls after dispose', () {
      final throttler = Throttler(milliseconds: 100);
      var callCount = 0;

      throttler.dispose();
      throttler.run(() => callCount++);

      expect(callCount, 0);
    });
  });
}
