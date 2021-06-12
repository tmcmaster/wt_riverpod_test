import 'package:riverpod_test/src/sleep.dart';
import 'package:test/test.dart';

void main() {
  group('Testing the millisecond function', () {
    test('Test 2000 milliseconds is 2 minutes.', () {
      final duration = millisecond(2000);
      expect(duration.inSeconds, 2);
    });
    test('Test 60 seconds is a minute', () {
      final duration = second(60);
      expect(duration.inMinutes, 1);
    });
    test('Test 2 minutes is 120 seconds.', () {
      final duration = minute(2);
      expect(duration.inSeconds, 120);
    });
  });
  group('Testing the sleep function.', () {
    test('Test sleeping for 2 seconds.', () async {
      final stopwatch = Stopwatch()..start();
      await sleep(second(1));
      stopwatch.stop();
      expect(stopwatch.elapsed.inSeconds, 1);
    });
  });
}
