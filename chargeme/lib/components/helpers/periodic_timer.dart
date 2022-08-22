import 'dart:async';

class PeriodicTimer {
  static PeriodicTimer shared = PeriodicTimer();

  int remainingTime = 0;
  Timer? _timer;
  bool _connected = false;
  Function? onTick;
  Function? onLastTick;

  String get remainingTimeString {
    final int minutes = remainingTime ~/ 60;
    final int seconds = remainingTime % 60;
    final minutesPart = minutes.toString().length == 1 ? "0$minutes" : minutes.toString();
    final secondsPart = seconds.toString().length == 1 ? "0$seconds" : seconds.toString();
    return "$minutesPart:$secondsPart";
  }

  void run({required Duration duration, Function? onTick, Function? onLastTick}) {
    remainingTime = duration.inSeconds;
    connect(onTick: onTick, onLastTick: onLastTick);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_connected && this.onTick != null) this.onTick!();
      if (remainingTime == 1) {
        remainingTime = 0;
        if (_connected && this.onLastTick != null) this.onLastTick!();
        timer.cancel();
      } else {
        remainingTime--;
      }
    });
  }

  void cancel() {
    _timer?.cancel();
  }

  void connect({Function? onTick, Function? onLastTick}) {
    this.onTick = onTick;
    this.onLastTick = onLastTick;
    _connected = true;
  }

  void disconnect() {
    _connected = false;
  }
}
