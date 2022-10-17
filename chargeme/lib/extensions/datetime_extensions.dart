import 'package:chargeme/gen/l10n.dart';
import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  String get dateAndTimeFormat {
    final DateFormat formatter = DateFormat('dd.MM.yyyy, H:m');
    final String formatted = formatter.format(this);
    return formatted; // something like 2013-04-20
  }

  int get remainingMinutesFromNow {
    final now = DateTime.now();
    return ((millisecondsSinceEpoch - now.millisecondsSinceEpoch) ~/ (60 * 1000));
  }

  String get remainingTime {
    final totalRemainingMinutes = remainingMinutesFromNow;
    final remainingHours = totalRemainingMinutes ~/ 60;
    final remainingMinutes = totalRemainingMinutes % 60;
    String result = "";
    if (remainingHours != 0) {
      result += "$remainingHours ${L10n.hoursLowercased.str} ";
    }
    result += "$remainingMinutes ${L10n.minutes.str}";

    return result;
  }
}
