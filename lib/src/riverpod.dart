import 'package:riverpod/riverpod.dart';
import 'package:wt_riverpod_test/src/provider-change-logger.dart';

class Riverpod {
  static ProviderContainer create({
    List<Override> overrides = const [],
    bool log = false,
  }) {
    return ProviderContainer(
      overrides: overrides,
      observers: (log ? [ProviderChangeLogger()] : []),
    );
  }
}
