import 'package:riverpod_test/riverpod_test.dart';

void main() async {
  print('Sleep example.');
  await sleep(second(1));
  print('Sleep example completed.');
}
