import 'package:flutter/material.dart';

enum ScreenOption { success, couldNotCharge, comment, charging, waiting }

class CheckInViewModel extends ChangeNotifier {
  ScreenOption? _screenOption;

  ScreenOption? get screenOption => _screenOption;
  set screenOption(ScreenOption? value) {
    _screenOption = value;
    notifyListeners();
  }
}
