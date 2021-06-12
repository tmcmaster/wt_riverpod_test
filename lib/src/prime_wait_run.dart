import 'package:riverpod/riverpod.dart';
import 'package:riverpod_test/riverpod_test.dart';

/// read values from some provider dependencies, sleep for a bit, and then call an action.

typedef SetupFunction = dynamic Function(ProviderContainer);
typedef ActionFunction = dynamic Function(ProviderContainer, dynamic);

dynamic primeWaitRun({
  required ProviderContainer riverpod,
  required List<ProviderBase> primeDependencies,
  required ActionFunction action,
  int? pauseMillis,
  int? pauseSeconds,
  Map<dynamic, dynamic> context = const {},
}) async {
  final results = {for (var dep in primeDependencies) dep: riverpod.read(dep)};
  if (pauseMillis != null) await sleep(millisecond(pauseMillis));
  if (pauseSeconds != null) await sleep(second(pauseSeconds));
  return action(riverpod, results);
}
