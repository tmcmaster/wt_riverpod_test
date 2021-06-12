/// Convenience functions for sleeping for a period of time.

Future<void> sleep(Duration duration) async => Future.delayed(duration);
Duration second(int seconds) => Duration(seconds: seconds);
Duration millisecond(int milliseconds) => Duration(milliseconds: milliseconds);
Duration minute(int minutes) => Duration(minutes: minutes);
