import 'package:riverpod/riverpod.dart';

class ProviderChangeLogger extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase provider, Object? newValue) {
    final value = _getValueAsString(newValue);
    final name = _getProviderAsString(provider);
    print('Provider($name) value has changed: $value');
  }

  String _getProviderAsString(ProviderBase provider) {
    return provider.name ?? provider.runtimeType.toString();
  }

  String _getValueAsString(dynamic value) {
    return (value == null ? '' : (value is List ? 'list(${value.length})' : value.toString()));
  }
}
