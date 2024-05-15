import 'package:riverpod/riverpod.dart';
import 'package:wt_riverpod_test/src/prime_wait_run.dart';
import 'package:wt_riverpod_test/src/riverpod-test-stage.dart';
import 'package:wt_riverpod_test/src/riverpod_setup_test_expect.dart';
import 'package:test/test.dart';

void main() {
  final providerOneProvider = StateProvider((_) => 1);
  final providerTwoProvider = StateProvider((_) => 2);
  final providerThreeProvider = StateProvider((_) => 3);
  final providerFourProvider = StateProvider((_) => 4);
  final providerFiveProvider = StateProvider((_) => 5);

  final SetupFunction defaultSetup = (riverpod) => print('Doing some default setup');

  group('Riverpod Test', () {
    test('Happy days', () async {
      await riverpodSetupTestExpect(
        log: true,
        cannedSetup: defaultSetup,
        overrides: [],
        setup: RiverpodTestStage(
          delay: 100,
          dependencies: [providerOneProvider],
          action: (riverpod, context) {
            print('Setup phase');
            riverpod.read(providerOneProvider.notifier).state = 11;
          },
        ),
        test: RiverpodTestStage(
          delay: 100,
          dependencies: [providerTwoProvider],
          action: (riverpod, context) {
            print('Testing phase');
            expect(riverpod.read(providerOneProvider.notifier).state, 11);
            riverpod.read(providerTwoProvider.notifier).state = 22;
          },
        ),
        expect: RiverpodTestStage(
          delay: 100,
          dependencies: [
            providerOneProvider,
            providerTwoProvider,
            providerThreeProvider,
            providerFourProvider,
            providerFiveProvider,
          ],
          action: (riverpod, context) {
            print('Expect phase');
            expect(riverpod.read(providerOneProvider.notifier).state, 11);
            expect(riverpod.read(providerTwoProvider.notifier).state, 22);
            expect(riverpod.read(providerThreeProvider.notifier).state, 3);
            expect(riverpod.read(providerFourProvider.notifier).state, 4);
            expect(riverpod.read(providerFiveProvider.notifier).state, 5);
            expect(context, isA<Map>());
            Map<dynamic, dynamic> map = context;
            expect(map.length, 5);
          },
        ),
      );
    });
  });
}
