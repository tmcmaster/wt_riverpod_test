import 'package:riverpod/riverpod.dart';
import 'package:riverpod_test/riverpod_test.dart';

class RiverpodTestStage {
  static const PREV_ACTION_RESULT = 'previous-action-result';

  final int delay;
  final List<ProviderBase> dependencies;
  final ActionFunction? action;

  const RiverpodTestStage({
    this.delay = 0,
    this.dependencies = const [],
    this.action,
  });

  Future<Map<dynamic, dynamic>> execute(ProviderContainer riverpod, Map<dynamic, dynamic> context) async {
    final actionResult = (action == null ? null : await action!(riverpod, context));
    return Future.value(actionResult == null ? context : _addResultToContext(context, actionResult));
  }

  Map<dynamic, dynamic> _addResultToContext(Map<dynamic, dynamic> context, dynamic result) {
    return (result is Map ? {...context, ...result} : {...context, PREV_ACTION_RESULT: result});
  }
}
