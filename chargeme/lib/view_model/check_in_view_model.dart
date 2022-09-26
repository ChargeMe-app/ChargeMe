import 'dart:convert';

import 'package:chargeme/components/account_manager/account_manager.dart';
import 'package:chargeme/components/analytics_manager/analytics_manager.dart';
import 'package:chargeme/components/constants/constants.dart';
import 'package:chargeme/model/charging_place/charging_place.dart';
import 'package:chargeme/model/vehicle/vehicle_type.dart';
import 'package:chargeme/components/helpers/ip.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum ScreenOption { success, couldNotCharge, comment, charging, waiting }

class CheckInViewModel extends ChangeNotifier {
  ScreenOption? _screenOption;
  VehicleType? _vehicleType;
  String _comment = "";
  double? _kilowatts;
  Duration? _duration;

  int _selectedStation = 0;
  int _selectedOutlet = 0;

  int get rating {
    switch (_screenOption) {
      case ScreenOption.success:
        return 1;
      case ScreenOption.couldNotCharge:
        return -1;
      case ScreenOption.comment:
        return 0;
      case ScreenOption.charging:
        return 1;
      case ScreenOption.waiting:
        return 0;
      case null:
        return 0;
    }
  }

  String get selectedStationId {
    return place.stations[_selectedStation].id;
  }

  String get selectedOutletId {
    return place.stations[_selectedOutlet].outlets[_selectedOutlet].id;
  }

  ChargingPlace place;
  AnalyticsManager analyticsManager;
  AccountManager accountManager;

  CheckInViewModel({required this.place, required this.analyticsManager, required this.accountManager}) {
    initialSetup();
  }

  Future<void> initialSetup() async {
    final prefs = await SharedPreferences.getInstance();
    vehicleType = VehicleType.values.firstWhere((e) => e.value == prefs.getInt(preferredVehiceTypeKey));
  }

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

  Future<void> sendCheckIn() async {
    if (accountManager.currentAccount == null) {
      return;
    }
    Map<String, dynamic> postBody = {
      "user_id": accountManager.currentAccount!.id,
      "vehicle_type": vehicleType,
      "comment": comment,
      "kilowatts": kilowatts,
      "duration": duration?.inMinutes,
      "station_id": selectedStationId,
      "outlet_id": selectedOutletId,
      "rating": rating
    };
    try {
      final response =
          await http.post(Uri.parse("http://${IP.current}:${IP.port}/v1/checkin"), body: jsonEncode(postBody));
      if (response.statusCode == 200) {}
    } catch (error) {
      analyticsManager.logErrorEvent(error.toString());
    }
  }
}
