import 'package:riverpod/riverpod.dart';
import 'package:riverpod_test/riverpod_test.dart';
import 'package:riverpod_test/src/prime_wait_run.dart';
import 'package:test/test.dart';

void main() {
  final providerOne = Provider((_) => 1);
  final providerTwo = Provider((_) => 2);
  final providerThree = Provider((_) => 3);
  final providerFour = Provider((_) => 4);
  final providerFive = Provider((_) => 5);

  const DEFAULT_PAUSE = 100;

  group('Testing the primeWaitRun function', () {
    test('Testing with 2 dependencies.', () async {
      await primeWaitRun(
          riverpod: ProviderContainer(),
          primeDependencies: [
            providerOne,
            providerTwo,
          ],
          pauseMillis: DEFAULT_PAUSE,
          action: (riverpod, results) async {
            expect(results.length, 2);
            expect(results[providerOne], 1);
            expect(results[providerTwo], 2);
          });
    });
    test('Testing with no dependencies.', () async {
      await primeWaitRun(
          riverpod: ProviderContainer(),
          primeDependencies: [],
          pauseMillis: DEFAULT_PAUSE,
          action: (riverpod, results) async {
            expect(results.length, 0);
          });
    });
    test('Testing nesting functions.', () async {
      await primeWaitRun(
          riverpod: ProviderContainer(),
          primeDependencies: [
            providerOne,
            providerTwo,
          ],
          pauseMillis: DEFAULT_PAUSE,
          action: (riverpod, results) async {
            expect(results[providerOne], 1);
            expect(results[providerTwo], 2);
            await primeWaitRun(
                riverpod: riverpod,
                primeDependencies: [
                  providerThree,
                  providerFour,
                  providerFive,
                ],
                pauseSeconds: 1,
                action: (riverpod, results) {
                  expect(results[providerThree], 3);
                  expect(results[providerFour], 4);
                  expect(results[providerFive], 5);
                });
          });
    });
  });
}
