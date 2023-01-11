import 'dart:convert';

import 'package:chargeme/components/account_manager/account_manager.dart';
import 'package:chargeme/components/analytics_manager/analytics_manager.dart';
import 'package:chargeme/model/charging_place/charging_place.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:chargeme/model/station_marker/station_marker.dart';
import 'package:chargeme/model/vehicle/vehicle_type.dart';
import 'package:chargeme/components/helpers/ip.dart';
import 'package:chargeme/view_model/charging_place_view_model.dart';
import 'package:chargeme/view_model/choose_vehicle_view_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    return place.stations[_selectedStation].outlets[_selectedOutlet].id;
  }

  int get selectedConnectorType {
    return place.stations[_selectedStation].outlets[_selectedOutlet].connectorType.intValue;
  }

  bool get isRepair {
    return place.iconType == IconType.repairFast || place.iconType == IconType.repairStandard;
  }

  ChargingPlace place;
  AnalyticsManager analyticsManager;
  AccountManager accountManager;
  ChooseVehicleViewModel chooseVehicleVM;
  ChargingPlaceViewModel? chargingPlaceVM;

  CheckInViewModel(
      {required this.place,
      required this.analyticsManager,
      required this.accountManager,
      required this.chooseVehicleVM,
      required this.chargingPlaceVM}) {
    initialSetup();
  }

  @override
  void dispose() {
    super.dispose();
    chooseVehicleVM.removeListener(updateVehicleType);
  }

  Future<void> initialSetup() async {
    vehicleType = chooseVehicleVM.chosenVehicle?.type;
    chooseVehicleVM.addListener(updateVehicleType);
  }

  void updateVehicleType() {
    vehicleType = chooseVehicleVM.chosenVehicle?.type;
  }

  VehicleType? get vehicleType => _vehicleType;
  set vehicleType(VehicleType? value) {
    _vehicleType = value;
    notifyListeners();
  }

  ScreenOption? get screenOption => _screenOption;
  set screenOption(ScreenOption? value) {
    _screenOption = value;
    if (value == ScreenOption.charging || value == ScreenOption.waiting) _duration = const Duration(minutes: 30);
    if (value == null) _duration = null;
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
    if (duration == null) {
      sendAsReview();
      return;
    }
    if (accountManager.currentAccount == null) {
      return;
    }
    Map<String, dynamic> postBody = generatePostBody();
    postBody["duration"] = duration?.inMinutes;

    try {
      final response = await http.post(Uri.parse("http://${IP.current}/v1/checkin"), body: jsonEncode(postBody));
      if (response.statusCode == 200) {
        analyticsManager.logEvent("checkin_submitted");
        chargingPlaceVM?.loadPlace(place.id);
      }
    } catch (error) {
      analyticsManager.logErrorEvent(error.toString());
    }
  }

  void sendAsReview() async {
    if (accountManager.currentAccount == null) {
      return;
    }
    Map<String, dynamic> postBody = generatePostBody();

    try {
      final response = await http.post(Uri.parse("http://${IP.current}/v1/review"), body: jsonEncode(postBody));
      if (response.statusCode == 200) {
        analyticsManager.logEvent("review_submitted");
        chargingPlaceVM?.loadPlace(place.id);
      }
    } catch (error) {
      analyticsManager.logErrorEvent(error.toString());
    }
  }

  Map<String, dynamic> generatePostBody() {
    return {
      "user_id": accountManager.currentAccount!.id,
      "user_name": accountManager.currentAccount!.displayName,
      "vehicle_type": vehicleType?.value,
      "comment": comment,
      "kilowatts": kilowatts,
      "station_id": selectedStationId,
      "outlet_id": selectedOutletId,
      "rating": rating,
      "connector_type": selectedConnectorType
    };
  }
}
