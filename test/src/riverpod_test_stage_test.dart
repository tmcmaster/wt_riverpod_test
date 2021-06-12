import 'package:riverpod_test/src/riverpod-test-stage.dart';
import 'package:riverpod_test/src/riverpod.dart';
import 'package:test/test.dart';

void main() {
  group('Test RiverpodTestStage', () {
    test('Happy days', () {
      final stepStage = RiverpodTestStage(
        dependencies: [],
        delay: 10,
        action: (riverpod, context) {},
      );
      final context = {};
      final riverpod = Riverpod.create();
      final resultContext = stepStage.execute(riverpod, context);
      expect(resultContext.length, 0);
    });
    test('Test action returns a String', () {
      final result = ':-)';
      final stepStage = RiverpodTestStage(
        dependencies: [],
        delay: 10,
        action: (riverpod, context) {
          return result;
        },
      );
      final context = {
        'a': 'A',
        'b': 'B',
      };
      final riverpod = Riverpod.create();
      final resultContext = stepStage.execute(riverpod, context);
      expect(resultContext.length, 3);
      expect(resultContext.containsKey(RiverpodTestStage.PREV_ACTION_RESULT), isTrue);
      expect(resultContext[RiverpodTestStage.PREV_ACTION_RESULT], result);
      expect(resultContext['a'], 'A');
      expect(resultContext['b'], 'B');
    });

    test('Test action returns a Map', () {
      final result = {
        'b': 'BB',
        'c': 'C',
      };
      final stepStage = RiverpodTestStage(
        dependencies: [],
        delay: 10,
        action: (riverpod, context) {
          return result;
        },
      );
      final context = {
        'a': 'A',
        'b': 'B',
      };
      final riverpod = Riverpod.create();
      final resultContext = stepStage.execute(riverpod, context);
      expect(resultContext.length, 3);
      expect(resultContext['a'], 'A');
      expect(resultContext['b'], 'BB');
      expect(resultContext['c'], 'C');
    });
  });
}
