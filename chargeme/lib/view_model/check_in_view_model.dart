import 'package:chargeme/model/charging_place/vehicle_type.dart';
import 'package:flutter/material.dart';

enum ScreenOption { success, couldNotCharge, comment, charging, waiting }

class CheckInViewModel extends ChangeNotifier {
  ScreenOption? _screenOption;
  VehicleType? _vehicleType;
  String _comment = "";
  double? _kilowatts;
  Duration? _duration;
  int _selectedStation = 0;
  int _selectedOutlet = 0;

  VehicleType? get vehicleType => _vehicleType;
  set vehicleType(VehicleType? value) {
    _vehicleType = value;
    notifyListeners();
  }

  ScreenOption? get screenOption => _screenOption;
  set screenOption(ScreenOption? value) {
    _screenOption = value;
    if (value == ScreenOption.charging || value == ScreenOption.waiting) _duration = Duration(minutes: 30);
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

  Duration? get duration => _duration;
  set duration(Duration? value) {
    _duration = value;
    notifyListeners();
  }

  void setRoundedDuration(Duration value) {
    final minutes = value.inMinutes;
    final remain = minutes % 10;
    int toAdd;
    if (remain >= 5) {
      toAdd = 10 - remain;
    } else {
      toAdd = -remain;
    }

    final result = Duration(minutes: minutes + toAdd);
    duration = result;
  }

  int get selectedStation => _selectedStation;
  int get selectedOutlet => _selectedOutlet;
  void setOutlet(int station, int outlet) {
    _selectedStation = station;
    _selectedOutlet = outlet;
    notifyListeners();
  }
}
