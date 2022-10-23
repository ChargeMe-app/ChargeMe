import 'dart:async';
import 'dart:math';

abstract class Limitator {
  bool tryExec(Function closure);
}

class LimitatorCount with Limitator {
  int _currentCount = 0;
  int limit;

  LimitatorCount({required this.limit});

  @override
  bool tryExec(Function closure) {
    if (_currentCount >= limit) {
      return false;
    }
    _currentCount++;
    closure();
    return true;
  }
}

class LimitatorCooldown with Limitator {
  Duration baseCooldown;
  int triesWithoutPenalty;
  int currentTries = 0;
  Timer? _timer;
  bool exponential;

  LimitatorCooldown(
      {this.baseCooldown = const Duration(milliseconds: 500), this.triesWithoutPenalty = 0, this.exponential = false});

  @override
  bool tryExec(Function closure) {
    if (_timer != null) {
      return false;
    }
    final penaltyCount = currentTries - triesWithoutPenalty;
    if (penaltyCount > 0) {
      final delay = baseCooldown * (exponential ? pow(penaltyCount, 2) : 1);
      _timer = Timer(delay, () {
        _timer = null;
      });
    }
    closure();
    currentTries += 1;
    return true;
  }
}
