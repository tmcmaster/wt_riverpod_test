import 'package:logging/logging.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';
import 'package:wt_riverpod_test/riverpod_test.dart';

void main() {
  Logger.root.level = Level.ALL;

  final providerOneProvider = StateProvider<int>((_) => 1);

  group('Testing the ProviderChangeLogger', () {
    test('Single provider change', () {
      final riverpod = ProviderContainer(observers: [ProviderChangeLogger()]);
      sleep(second(2));
      riverpod.read(providerOneProvider.notifier).update((state) => 2);
      riverpod.read(providerOneProvider.notifier).state = 4;
      sleep(second(2));
    });
  });
}
