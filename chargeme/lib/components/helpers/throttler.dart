import 'dart:async';

class Throttler {
  Timer? _timer;
  Future<void> Function()? completion;

  void throttle(Duration delay, Future<void> Function()? completion) {
    _timer?.cancel();
    completion = completion;
    _timer = Timer(delay, () {
      final completionCopy = completion;
      completion = null;
      _timer?.cancel();
      _timer = null;
      if (completionCopy != null) {
        completionCopy();
      }
    });
  }

  void cancel() {
    _timer?.cancel();
    _timer = null;
    completion = null;
  }
}
