import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  String get dateAndTimeFormat {
    final DateFormat formatter = DateFormat('dd.MM.yyyy, H:m');
    final String formatted = formatter.format(this);
    return formatted; // something like 2013-04-20
  }
}
