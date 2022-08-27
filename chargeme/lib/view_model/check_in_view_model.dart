import 'package:flutter/material.dart';

enum ScreenOption { success, couldNotCharge, comment, charging, waiting }

class CheckInViewModel extends ChangeNotifier {
  ScreenOption? _screenOption;
  String _comment = "";
  double? _kilowatts;

  ScreenOption? get screenOption => _screenOption;
  set screenOption(ScreenOption? value) {
    _screenOption = value;
    notifyListeners();
  }

  String get comment => _comment;
  set comment(String value) {
    _comment = value;
    notifyListeners();
  }

  double? get kilowatts => _kilowatts;
  set kilowatts(double? value) {
    _kilowatts = value;
    notifyListeners();
  }

  void setKilowatts(String? value) {
    if (value == null || value.isEmpty) {
      kilowatts = null;
      return;
    }
    var doubleFormat = double.parse(value);
    kilowatts = doubleFormat;
  }
}
